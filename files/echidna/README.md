This folder should be copied to your home page, together with some additional tools and bin files.<br>

The "echidna-test" executable is in the helpers folder.<br>
In order to run it directly you can always use this bin file.<br>

But, this repository offers the echidna-test.sh too, which is a wrapper that improves echidna output:<br>
Echidna itself contain some kind of a bug, and if it runs with a config file, the progress bar will not be shown.<br>
The "helpers/echidna-test.py" will try to run it without config file if possible, depanding of which configuration you'll use.<br>
You can run echidna regularly using "echidna.sh" and include a configuration file - exactly how you would run echidna, and it will work.<br>
