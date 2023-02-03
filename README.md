# eth-auto
Ethereum Tools - Automated Intallation:<br><br>

Scripts for installation of Ethereum tools on linux system.<br>
Verified on clean Ubuntu-20.04 (including Azure VMs) - only git is required (;<br>
Scripts must run with sudo.<br>

To install basic Ethereum tools, run general/base-eth-install.sh<br>
This will:<br>
- Update "apt"<br>
- Install "python3"<br>
- Install "pip3"<br>
- Install "curl"<br>
- Install "node-18"<br>
- Install "truffle"<br>
- Install "truffle-flattener"<br>
- Install "solc-select"<br>
- Clone "openzeppelin-contracts"<br>
- Clone "openzeppelin-contracts-upgradeable"<br>

To install Ethereum security tools:<br>
- Smartcheck -> run security/smartcheck-install.sh<br>
- Slither -> run security/slither-install.sh<br>
- Echidna -> security/echidna-install.sh<br>

Please note that installing each of this tools will also run base-eth-install as it contain many of it's requirements.<br>
Also, Echidna installation will run slither-install, since it's one of it's requirements too.<br>

