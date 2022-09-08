

Welcome to SmartCheck!

In order to use SmartCheck:
1. Copy the smart contracts repository to this machine.
2. Create working dir and init a truffle project: 'mkdir <working-dir-name>; cd <working-dir-name>; truffle init'.
3. For each end-contract (non-abstract):
	a. Flatten the contract using: 'truffle-flattener input/file/path.sol > output/file/path.sol'.
	b. Clean the output by removing redundant SDPX and version specifiers (all except the first once).
	c. Run SmartCheck: 'smartcheck -p output/file/path.sol > smartcheck/result/path.txt'
4. ignore many errors at the beginning of the output.
5. Study the result file/s (if not understood you can check the code/title of each finding in cmartcheck github repository).
6. Clean the result file/s:
	a. Remove False-Positives.
	b. Remove old/non-relevant findings.
	c. Put similar issues together.
	d. prettify and explain remaining findings.


Example exist in '~/smartcheck/example'.

In order to run it:
run 'smartcheck -p ~/smartcheck/example/ERC20_Flattened.sol' > slither/result/path.txt.
In order to read the test-contract, open: ~/smartcheck/example/ERC20_Flattened.sol.




