#!/bin/bash

echidna_dir=$(dirname $0)

cp helpers/echidna-test.py .
cp helpers/echidna-test .

python3 echidna-test.py $@

rm echidna-test.py
rm echidna-test
