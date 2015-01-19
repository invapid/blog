#!/bin/bash

###############
facedancer(){
###############
aptitude install -y gcc-msp430

# populate FACEDANCER_ROOT variable
echo 'export FACEDANCER_ROOT=~/tools/goodfet' > ~/.bashrc
source ~/.bashrc

# add user to dialout group
sudo adduser $USER dialout
su - $USER # to let you access dialout group files

# clone goodfet
mkdir -p ~/tools ; cd ~/tools
git clone https://github.com/travisgoodspeed/goodfet goodfet

# compile facedancer
cd $FACEDANCER_ROOT/firmware
board=goodfet41 make clean all 

# flash facedancer
# http://int3.cc/blogs/news/8217777-flashing-the-facedancer21
# board=facedancer21 $FACEDANCER_ROOT/client/goodfet.bsl --dumpinfo > info.txt  
board=facedancer21 $FACEDANCER_ROOT/client/goodfet.bsl --fromweb

# goodfet.monitor (python script)
$FACEDANCER_ROOT/client/goodfet.monitor info
}

facedancer # fire it off
