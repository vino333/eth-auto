

Welcome to Echidna!

In order to use Echidna fuzzing:
1.  Copy the smart contracts repository to this machine.
2.  Create working dir and init a truffle project: 'mkdir <working-dir-name>; cd <working-dir-name>; truffle init'.
3.  Choose end-contract (=non-abstract) to test:
4.  Flatten the contract using: 'truffle-flattener input/file/path.sol > output/file/path.sol'.
5.  Clean the output by removing redundant SDPX and version specifiers (all except the first ones).
6.  Adjust solc version if needed:
	a. Check the version specified in the code.
	b. install solc version: 'solc-select install <wanted-version>'.
	c. assign solc version: 'solc-select use <wanted-version>'.
7.  Edit the flattened output file to create the fuzzing test:
	a. Create <test-contract> that inherent from the tested contract (at the bottom of the file). 
	b. Create a zero-parameters constructor for <test-contract>.
	c. Write boolean public invariants in <test-contract> (prefixed with 'echidna_').
8.  Edit the ~/echidna/config.yaml file if needed:
	a. SeqLen (transactions in sequence).
	b. TestLimit (number of testing sequences).
	c. Blacklist/whitelist public functions to fuzz.
	d. Pre-define deployer/senders addresses.
	e. Solc parameters.
	f. More things if needed...
9.  Move to echidna testing dir: 'cd ~/echidna'.
10. Run echidna fuzzing test: './echidna-test output/file/path.sol --config config.yaml --contract <test-contract>'
11. Study the results and if there are failures verify you understand the bug/s (sometimes it will just be issue in the test itself - design or implementation).
12. Add the found bugs to your final report


Example exist in '~/echidna/example'.

In order to run it:
1. 'cd ~/echidna'.
2. run './echidna-test example/ERC20_Fuzzing_Ready.sol --contract Token_Fuzzing'.
In order to read the test-contract, open: ~/echidna/example/ERC20_Fuzzing_Ready.sol.



