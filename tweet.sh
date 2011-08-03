#!/bin/bash
source /home/syntaxin/.bashrc
cd /home/syntaxin/qwantz-corpus/
rvm use 1.8.7@qwantz
ruby tweet.rb
ruby rand.rb
