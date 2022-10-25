# eth-auto
Ethereum Tools - Automated Intallation:<br><br>

Scripts for installation of Ethereum tools on linux system.<br>
Verified on clean Ubuntu-20.04 (including Azure VMs) - only git is required (;<br>
Scripts must run with sudo.<br>

To install basic Ethereum tools, run general/base-eth-install.sh
This will:
Update "apt"
Install "python3"
Install "pip3"
Install "curl"
Install "node-18"
Install "truffle"
Install "truffle-flattener"
Install "solc-select"
Clone "openzeppelin-contracts"
Clone "openzeppelin-contracts-upgradeable"

To install Ethereum security tools:
Smartcheck -> run security/smartcheck-install.sh
Slither -> run security/slither-install.sh
Echidna -> security/echidna-install.sh

Please note that installing each of this tools will also run base-eth-install as it contain many of it's requirements.
Also, Echidna installation will call slither-install too, since it's one of it's requirements too.

