#!/usr/bin/env bash
#
#  This program will check the usage of directory. The default dir. is /home/$USER.
#  
#
#  Leon ---	First Release.
#  
#
#set -x
PWDPATH=$PWD 
DEFAULTDIR=$HOME
# Check the arguments
INPUTDIR=$1

case $# in
     2)
         echo "Usage: $0 <scan directory> || Only run $0 which will scan your Home Default PATH: $HOME"
         exit
         ;;
esac 

if [ "$INPUTDIR" != "" ]
then
    directory=$INPUTDIR
else
    directory=$DEFAULTDIR
fi

# Check that the directory to be scanned exists
if [ ! -d $directory ]
then
   echo "$directory directory not found - exiting..."
   echo "Usage: $0 <scan directory> || Only run $0 which will scan your Home Default PATH: $HOME"
   exit 0
fi 

cd $directory
echo "========================== Disk usage ======================================"
echo -e "The scanning source directory: \e[1;42m$directory\e[0m"
echo " "
echo "*********************** Disk partition usage *******************************"
df -mh .
#du -kh .
echo " "
echo "--------------------- The 20 largest subfolders(KB) ------------------------"
du -akS . | sort -nrk 1 | head -n 20
echo " "
echo "--------------------- The 30 largest files (MB)-----------------------------"

find . -type f ! -path  "./.snapshot/*" -exec du -m {} \; | sort -nrk 1 | head -n 30 
echo " "
# find . -type f -ls | sort -nrk 1 | head -n 20 //find . -type f -name "*.sh" ! -path ./tools?*
#find ~/ -type f -exec du -k --exclude "./.snapshot/*" {} \; | sort -nrk 1 | head -n 30
echo -e "\n\e[1;32m==========================  ^_^ Done ^_^ ==========================\e[0m\n"

cd $PWDPATH
exit 0
