#!/bin/bash
fpg () { flutter pub get; }

cd sixteen_puzzle
fpg
cd ../app
fpg
