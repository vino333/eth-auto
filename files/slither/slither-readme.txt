

Welcome to Slither!

In order to use Slither check:
1. Copy the smart contracts repository to this machine.
2. Create working dir and init a truffle project: 'mkdir <working-dir-name>; cd <working-dir-name>; truffle init'.
3. For each end-contract (non-abstract):
	a. Flatten the contract using: 'truffle-flattener input/file/path.sol > output/file/path.sol'.
	b. Clean the output by removing redundant SDPX and version specifiers (all except the first once).
	c. Adjust solc version if needed:
		1. Check the version specified in the code.
		2. install solc version: 'solc-select install <wanted-version>'.
		3. assign solc version: 'solc-select use <wanted-version>'.
	d. Run Slither check: 'slither output/file/path.sol > slither/result/path.txt'
4. Study the result file/s (if not understood you can always use the links attached to each finding).
5. Clean and explain the result file/s:
	a. Remove False-Positives.
	b. Remove old/non-relevant findings.
	c. clean and explain remaining findings.


Example exist in '~/slither/example'.

In order to run it:
run 'slither ~/slither/example/ERC20_Flattened.sol' > slither/result/path.txt.
In order to read the test-contract, open: ~/slither/example/ERC20_Flattened.sol.



