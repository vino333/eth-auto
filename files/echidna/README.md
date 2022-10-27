This folder should be copied to your home page, together with some additional tools and bin files.

The "echidna-test" executable is in the helpers folder.
In order to run it directly you can always use this bin file.
But, this repository offers the echidna-test.sh too, which is a wrapper that improves echidna output:
Echidna itself contain some kind of a bug, and if it runs with a config file, the progress bar will not be shown.
The "helpers/echidna-test.py" will try to run it without config file if possible, depanding of which configuration you'll use.
You can run echidna regularly using "echidna.sh" and include a configuration file - exactly how you would run echidna, and it will work.
