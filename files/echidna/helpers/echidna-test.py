
import sys
import subprocess
import base64
import requests
import time


class FormatException(Exception):
    pass


class NotSupportedYet(Exception):
    pass


class NotCliConfiguration(Exception):
    pass


class BrokenLink(Exception):
    pass


CONFIG_FLAG = "--config"
RUN_ECHIDNA = "echidna-test"
if subprocess.getoutput("command -v echidna-test") == "":
    RUN_ECHIDNA = "./" + RUN_ECHIDNA  # add ./ at the beginning


def strip_and_unquot(string):
    return string.strip().strip("\"").strip("\'")


def clean_and_split(multi):
    args = multi.strip().strip("[").strip("]").strip("\"").strip("\'")
    if len(args) == 0:
        return list()

    args_list = args.split(",")
    cleaned_args = []
    for arg in args_list:
        cleaned_args.append(arg.strip().strip("\"").strip("\'"))

    return cleaned_args


def convert_text(key, text):
    value = strip_and_unquot(text)
    if value == "null":
        return str()
    return key + " " + strip_and_unquot(text)


def convert_boolean_default_false(key, boolean):
    return key if boolean.strip() == "true" else str()


def convert_integer(key, integer):
    return key + " " + strip_and_unquot(integer)


def convert_multi_args(key, args):
    cleaned_args = clean_and_split(args)

    return_string = ""
    for arg in cleaned_args:
        if arg.startswith("--"):
            arg += "="
        else:
            arg += " "

        return_string += arg
    return key + " \"" + return_string + "\""


def convert_multi_text(key, text):
    return_string = ""
    for value in clean_and_split(text):
        return_string += key + " " + value + " "
    return return_string


convert_param_functions = {
    "--format": convert_text,  # FORMAT
    "--corpus-dir": convert_text,  # PATH
    "--test-mode": convert_text,  # ARG
    "--multi-abi": convert_boolean_default_false,
    "--test-limit": convert_integer,  # INTEGER
    "--shrink-limit": convert_integer,  # INTEGER
    "--seq-len": convert_integer,  # INTEGER
    "--contract-addr": convert_text,  # ADDRESS
    "--deployer": convert_text,  # ADDRESS]
    "--sender": convert_multi_text,  # ADDRESS
    "--seed": convert_integer,  # SEED
    "--crytic-args": convert_multi_args,  # ARGS
    "--solc-args": convert_multi_args  # ARGS
}


def edit_config_key(key):
    edited_key = "--" + "".join([x if not x.isupper() else "-" + x.lower() for x in key])
    return edited_key


def edit_config_values(values):
    starts_with_left_square_brackets = values.startswith("[")
    ends_with_right_square_brackets = values.endswith("]")

    if starts_with_left_square_brackets != ends_with_right_square_brackets:
        raise FormatException("Array structure isn't consistent")

    # starts and ends are equal, no need to check both
    if not starts_with_left_square_brackets:  # single value
        edited_values = [values.strip("\'").strip("\"")]
    else:  # multiple values
        splitted_values = values.strip("[").strip("]").split("\"")
        if len(splitted_values) > 1:  # values separated with: "
            for value in splitted_values:
                if value.strip() == "," or value.strip() == "":
                    splitted_values.remove(value)
        else:
            splitted_values = [values]

        edited_values = []
        for value in splitted_values:
            edited_values.append(value.strip())

    return edited_values


def get_config_cli(line, echidna_test_default_output, cli_args):
    line_splitted = line.split(":")

    if not len(line_splitted) == 2 or len(line_splitted[0]) == 0 or len(line_splitted[1]) == 0:
        raise FormatException("Both key and value should have value")

    edited_key = edit_config_key(line_splitted[0].strip())

    if edited_key not in echidna_test_default_output:
        raise NotCliConfiguration()  # pure cli isn't possible for that key
    if edited_key in cli_args:
        return
    try:
        key_value_string = convert_param_functions[edited_key](edited_key, line_splitted[1].strip())
    except KeyError:
        raise NotSupportedYet("Not supported yet, key: " + edited_key)
    return key_value_string


def clean_lines(lines):
    cleaned_lines = list()
    for line in lines:
        if "#" in line:
            line = line[0:line.index("#")]  # remove comments
            line = "".join(line.split())  # clean whitespaces
        if line != "":
            if ":" not in line:
                raise FormatException("does not support multi-line configurations")
            cleaned_lines.append(line)
    return cleaned_lines


def get_echidna_defaults_as_lines():
    url = 'https://api.github.com/repos/crytic/echidna/contents/tests/solidity/basic/default.yaml'
    req = requests.get(url)
    if req.status_code == requests.codes.ok:
        # convert to bytes for decoding and back to string for cleanup and split-lines
        return clean_lines(base64.decodebytes(str.encode(req.json()['content'])).decode("utf-8").splitlines())
    else:
        raise BrokenLink("Echidna default config file")


def convert_args(config_file_name, cli_args):
    """Return cli args if pure cli possible, else return config file"""
    # get echidna default config file from github
    default_config = get_echidna_defaults_as_lines()

    # get echidna cli possible args
    echidna_output = subprocess.getoutput(RUN_ECHIDNA)

    with open("./" + config_file_name) as config_file:
        lines = config_file.read().splitlines()

    return [get_config_cli(line, echidna_output, cli_args) for line in clean_lines(lines) if line not in default_config]


def get_config_file_name_and_cli_args_list(args):
    config_argument_index = args.index(CONFIG_FLAG)
    config_file_name = args[config_argument_index + 1]
    args.remove(CONFIG_FLAG)
    args.remove(config_file_name)

    return config_file_name, args


def create_echidna_command_from_args(args):
    try:
        config_file_name, cli_args = get_config_file_name_and_cli_args_list(args[:])
        try:
            args = cli_args + [arg for arg in convert_args(config_file_name, cli_args) if arg is not None]
        except NotCliConfiguration:
            print("Pure cli isn't supported for the provided configurations - continue with config file")
            pass  # just for keeping args untouched
    except ValueError:
        pass  # just for keeping args untouched

    return " ".join([RUN_ECHIDNA] + args)


if __name__ == "__main__":
    script_args = sys.argv[1:]
    echidna_run_command = create_echidna_command_from_args(script_args)
    print("Command generated:\n" + echidna_run_command + "\nExecuting...")
    time.sleep(1)
    subprocess.Popen(echidna_run_command, shell=True).communicate()[0]
