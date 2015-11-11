#!/bin/bash
base_dir=$HOME

##############################################################################################################

f_banner(){
	echo
	echo "
	  _   _ ___ ___           __ 
 	 / \ |_) |   |  |\/| | | (_  
 	 \_/ |   |  _|_ |  | |_| __) 
                             
	by roobixx & Parameter Security"
	echo
	echo
}

##############################################################################################################

f_error(){
echo
echo -e "\e[1;31m$medium\e[0m"
echo
echo -e "\e[1;31m                  *** Invalid choice or entry. ***\e[0m"
echo
echo -e "\e[1;31m$medium\e[0m"
sleep 2
f_main
}

##############################################################################################################

f_basic(){
clear
f_banner
echo "Updating Repos..."
apt-get update >/dev/null 2>&1
echo
echo "Updating Packages..."
apt-get dist-upgrade --assuume-yes >/dev/null 2>&1
echo 
echo "Installing Required Tools..."
apt-get install git firefox xauth xorg nmap openvpn --assume-yes >/dev/null 2>&1
echo
echo "Default Installation Complete..."
sleep 5
f_main
}

##############################################################################################################

f_tools(){
clear
f_banner

echo -e "\e[1;34mTools\e[0m"
echo "1. EyeWitness"
echo "2. Nessus Parser"
echo "3. Return to Menu"
echo
echo -n "Choice: "
read choice

case $choice in
	1) f_eyewitness;;
	2) f_nessusparser;;
	3) f_main;;
	*) f_error;;
esac

f_main
}

##############################################################################################################

f_eyewitness(){
clear
f_banner

echo "Checking if EyeWitness is installed..."
echo
if [ -d "/opt/EyeWitness" ]
	then echo "EyeWitness is already installed"
		 echo
		 echo "Returning to menu..."
		 sleep 3
		 f_main
fi
echo "Install EyeWitness..."
echo
cd /opt
git clone https://github.com/ChrisTruncer/EyeWitness.git
cd EyeWitness/setup
echo "Running Setup Now..."
./setup.sh >/dev/nul 2>&1
cd ..
echo "Creating Symlink..."
ln -s /opt/EyeWitness/EyeWitness.py /bin/EyeWitness
cd $base_dir
if [ -e "/bin/EyeWitness" ]
	then echo "Symlink successfully created"
fi
	echo "Error creating link"
f_main	
}

##############################################################################################################

f_nessusparser(){
clear
f_banner
echo "Checking if Nessus Parser is installed..."
echo
if [ -e "/bin/nessusparser" ]
	then echo "Nessus Parser is already installed"
		 echo
		 echo "Returning to menu..."
		 f_main
fi
cd /opt
git clone https://github.com/roobixx/nessus-parser.git
cd nessus-parser
sudo bash setup.sh
f_main
}

##############################################################################################################
f_main(){
clear
f_banner

if [ ! -d $base_dir/data ]; then
     mkdir -p $base_dir/data
fi

echo -e "\e[1;34mInstall\e[0m"
echo "1.  Basic Install"
echo "2.  Install Tools"
echo "3.  Install the Works"
echo
echo -e "\e[1;34mAudit\e[0m"
echo "4.  NMAP"
echo "5.  MSFConsole"
echo "7.  EyeWitness"
echo
echo -e "\e[1;34mReporting\e[0m"
echo "8.  Convert NMAP to HTML Report"
echo "9.  Export Nessus"
echo "10. Nessus Parser Report"
echo
echo -e "\e[1;34mMISC\e[0m"
echo "14. Update Optimus"
echo "0. Exit"
echo
echo -n "Choice: "
read choice

case $choice in
     1) f_basic;;
     2) f_tools;;
     3) f_salesforce;;
     4) f_generateTargetList;;
     5) f_cidr;;
     6) f_list;;
     7) f_single;;
     8) f_multitabs;;
     9) f_nikto;;
     10) f_ssl;;
     14) /opt/discover/update.sh && exit;;
     0) clear && exit;;
     *) f_error;;
esac
}

##############################################################################################################

while true; do f_main; done
