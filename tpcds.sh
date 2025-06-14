#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

MYCMD="tpcds.sh"
MYVAR="tpcds_variables.sh"
##################################################################################################################################################
# Functions
##################################################################################################################################################
check_variables()
{
	new_variable="0"

	### Make sure variables file is available
	if [ ! -f "$PWD/$MYVAR" ]; then
		touch $PWD/$MYVAR
		new_variable=$(($new_variable + 1))
	fi
	local count=$(grep "REPO=" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "REPO=\"TPC-DS\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	local count=$(grep "REPO_URL=" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "REPO_URL=\"https://github.com/NAndreyA/TPC-DS.git\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	local count=$(grep "ADMIN_USER=" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "ADMIN_USER=\"gpadmin\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	local count=$(grep "INSTALL_DIR=" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "INSTALL_DIR=\"/repo_tpcds\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	local count=$(grep "EXPLAIN_ANALYZE=" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "EXPLAIN_ANALYZE=\"false\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	local count=$(grep "RANDOM_DISTRIBUTION=" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RANDOM_DISTRIBUTION=\"false\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	local count=$(grep "MULTI_USER_COUNT" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "MULTI_USER_COUNT=\"0\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	local count=$(grep "GEN_DATA_SCALE" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "GEN_DATA_SCALE=\"1\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	local count=$(grep "SINGLE_USER_ITERATIONS" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "SINGLE_USER_ITERATIONS=\"0\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	#00
	local count=$(grep "RUN_COMPILE_TPCDS" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RUN_COMPILE_TPCDS=\"false\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	#01
	local count=$(grep "RUN_GEN_DATA" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RUN_GEN_DATA=\"false\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	#02
	local count=$(grep "RUN_INIT" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RUN_INIT=\"true\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	#03
	local count=$(grep "RUN_DDL" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RUN_DDL=\"true\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	#04
	local count=$(grep "RUN_LOAD" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RUN_LOAD=\"true\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	#05
	local count=$(grep "RUN_SQL" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RUN_SQL=\"false\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	#06
	local count=$(grep "RUN_SINGLE_USER_REPORT" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RUN_SINGLE_USER_REPORT=\"false\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	#07
	local count=$(grep "RUN_MULTI_USER" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RUN_MULTI_USER=\"false\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	#08
	local count=$(grep "RUN_MULTI_USER_REPORT" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RUN_MULTI_USER_REPORT=\"false\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
	#09
	local count=$(grep "RUN_SCORE" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "RUN_SCORE=\"false\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
 	#10
	#local count=$(grep "NAME_OS" $MYVAR | wc -l)
	#if [ "$count" -eq "0" ]; then
	#	echo "NAME_OS=\"RED OS\"" >> $MYVAR
	#	new_variable=$(($new_variable + 1))
	#fi
   	#11
	local count=$(grep "TYPE_ORIENTATION" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "TYPE_ORIENTATION=\"row\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
  	#12
	local count=$(grep "TYPE_COMPRESS" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "TYPE_COMPRESS=\"null\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
   	#13
	local count=$(grep "LEVEL_COMPRESS" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
		echo "LEVEL_COMPRESS=\"1\"" >> $MYVAR
		new_variable=$(($new_variable + 1))
	fi
 	#14
	local count=$(grep "COMMENTS:" $MYVAR | wc -l)
	if [ "$count" -eq "0" ]; then
 		echo "############################################################################" >> $MYVAR
		echo "#COMMENTS:" >> $MYVAR
  		echo "############################################################################" >> $MYVAR
  		echo "#TYPE_ORIENTATION -> heap || row || column" >> $MYVAR
    		echo "#TYPE_COMPRESS -> null || zlib || rle_type || zstd || quicklz" >> $MYVAR
      		echo "#LEVEL_COMPRESS -> null || value from 1 to 9" >> $MYVAR
		echo "############################################################################" >> $MYVAR
		#new_variable=$(($new_variable + 1))
	fi

	if [ "$new_variable" -gt "0" ]; then
		echo "There are new variables in the tpcds_variables.sh file.  Please review to ensure the values are correct and then re-run this script."
    		echo "############################################################################"
    		echo "TYPE ORIENTATION -> heap || row || column"
      		echo "############################################################################"
    		echo "TYPE COMPRESS -> null || zlib || rle_type || zstd || quicklz"
      		echo "############################################################################"
		exit 1
	fi
	echo "############################################################################"
	echo "Sourcing $MYVAR"
	echo "############################################################################"
	echo ""
	source $MYVAR
}

check_user()
{
	### Make sure root is executing the script. ###
	echo "############################################################################"
	echo "Make sure root is executing this script."
	echo "############################################################################"
	echo ""
	local WHOAMI=`whoami`
	if [ "$WHOAMI" != "root" ]; then
		echo "Script must be executed as root!"
		exit 1
	fi
}

#check_os()
#{
#	### Check name OS ###
#	echo "############################################################################"
#	echo "Check name OS"
#	echo "############################################################################"
#	echo ""
#	local NAMEOS=`. /etc/os-release; echo "$NAME"`
#	if [ "$NAMEOS" != "$NAME_OS" ]; then
#		echo "CURRENT OS = "$NAMEOS"!!!"
# #		echo "EDIT tpcds_variables.sh, NAME_OS=\""$NAMEOS"\""
#		exit 1
#	fi
#}

check_orientation()
{
	### Check type orientation ###
	echo "############################################################################"
	echo "Check type orientation"
	echo "############################################################################"
	echo ""
	#local NAMEOS=`. /etc/os-release; echo "$NAME"`
	#if [ "$TYPE_ORIENTATION" != "row" ]; then
 	#TYPE1="row"
  	#TYPE2="column"
   	#TYPE3="null"
    	#TYPE4="heap"
	#if [[ "$TYPE_ORIENTATION" != "$TYPE1" || "$TYPE_ORIENTATION" != "$TYPE2" || "$TYPE_ORIENTATION" != "$TYPE3" || "$TYPE_ORIENTATION" != "$TYPE4" ]]; then
	if [[ "$TYPE_ORIENTATION" == "row" ]]; then
 		echo "CORRECT VALUE"
   	elif [[ "$TYPE_ORIENTATION" == "column" ]]; then
  		echo "CORRECT VALUE"
	elif [[ "$TYPE_ORIENTATION" == "heap" ]]; then
    		echo "CORRECT VALUE"
      	else
    		echo "INCORRECT VALUE"
  		echo "Correct value: || row || column || heap ||"
 		echo "EDIT tpcds_variables.sh"
		exit 1
	fi
}

yum_installs()
{
	### Install and Update Demos ###
	echo "############################################################################"
	echo "Install git, gcc, and bc with yum."
	echo "############################################################################"
	echo ""
	# Install git and gcc if not found
	local YUM_INSTALLED=$(yum --help 2> /dev/null | wc -l)
	local CURL_INSTALLED=$(gcc --help 2> /dev/null | wc -l)
	local GIT_INSTALLED=$(git --help 2> /dev/null | wc -l)
	local BC_INSTALLED=$(bc --help 2> /dev/null | wc -l)

	if [ "$YUM_INSTALLED" -gt "0" ]; then
		if [ "$CURL_INSTALLED" -eq "0" ]; then
			yum -y install gcc
		fi
		if [ "$GIT_INSTALLED" -eq "0" ]; then
			yum -y install git
		fi
		if [ "$BC_INSTALLED" -eq "0" ]; then
			yum -y install bc
		fi
	else
		if [ "$CURL_INSTALLED" -eq "0" ]; then
			echo "gcc not installed and yum not found to install it."
			echo "Please install gcc and try again."
			exit 1
		fi
		if [ "$GIT_INSTALLED" -eq "0" ]; then
			echo "git not installed and yum not found to install it."
			echo "Please install git and try again."
			exit 1
		fi
		if [ "$BC_INSTALLED" -eq "0" ]; then
			echo "bc not installed and yum not found to install it."
			echo "Please install bc and try again."
			exit 1
		fi
	fi
	echo ""
}

repo_init()
{
	### Install repo ###
	echo "############################################################################"
	echo "Install the github repository."
	echo "############################################################################"
	echo ""

	internet_down="0"
	for j in $(curl google.com 2>&1 | grep "Couldn't resolve host"); do
		internet_down="1"
	done

	if [ ! -d $INSTALL_DIR ]; then
		if [ "$internet_down" -eq "1" ]; then
			echo "Unable to continue because repo hasn't been downloaded and Internet is not available."
			exit 1
		else
			echo ""
			echo "Creating install dir"
			echo "-------------------------------------------------------------------------"
			mkdir $INSTALL_DIR
			chown $ADMIN_USER $INSTALL_DIR
		fi
	fi

	if [ ! -d $INSTALL_DIR/$REPO ]; then
		if [ "$internet_down" -eq "1" ]; then
			echo "Unable to continue because repo hasn't been downloaded and Internet is not available."
			exit 1
		else
			echo ""
			echo "Creating $REPO directory"
			echo "-------------------------------------------------------------------------"
			mkdir $INSTALL_DIR/$REPO
			chown $ADMIN_USER $INSTALL_DIR/$REPO
			su -c "cd $INSTALL_DIR; GIT_SSL_NO_VERIFY=true; git clone --depth=1 $REPO_URL" $ADMIN_USER
		fi
	else
		if [ "$internet_down" -eq "0" ]; then
			git config --global user.email "$ADMIN_USER@$HOSTNAME"
			git config --global user.name "$ADMIN_USER"
			su -c "cd $INSTALL_DIR/$REPO; GIT_SSL_NO_VERIFY=true; git fetch --all; git reset --hard origin/master" $ADMIN_USER
		fi
	fi
}

script_check()
{
	### Make sure the repo doesn't have a newer version of this script. ###
	echo "############################################################################"
	echo "Make sure this script is up to date."
	echo "############################################################################"
	echo ""
	# Must be executed after the repo has been pulled
	local d=`diff $PWD/$MYCMD $INSTALL_DIR/$REPO/$MYCMD | wc -l`

	if [ "$d" -eq "0" ]; then
		echo "$MYCMD script is up to date so continuing to TPC-DS."
		echo ""
	else
		echo "$MYCMD script is NOT up to date."
		echo ""
		cp $INSTALL_DIR/$REPO/$MYCMD $PWD/$MYCMD
		echo "After this script completes, restart the $MYCMD with this command:"
		echo "./$MYCMD"
		exit 1
	fi

}

echo_variables()
{
	echo "############################################################################"
	echo "REPO: $REPO"
	echo "REPO_URL: $REPO_URL"
	echo "ADMIN_USER: $ADMIN_USER"
	echo "INSTALL_DIR: $INSTALL_DIR"
	echo "MULTI_USER_COUNT: $MULTI_USER_COUNT"
 	echo "RUN_OS: $NAME_OS"
	echo "############################################################################"
	echo ""
}

##################################################################################################################################################
# Body
##################################################################################################################################################

check_user
check_variables
#check_os
check_orientation
yum_installs
repo_init
script_check
echo_variables

su -l $ADMIN_USER -c "cd \"$INSTALL_DIR/$REPO\"; ./rollout.sh $GEN_DATA_SCALE $EXPLAIN_ANALYZE $RANDOM_DISTRIBUTION $MULTI_USER_COUNT $RUN_COMPILE_TPCDS $RUN_GEN_DATA $RUN_INIT $RUN_DDL $RUN_LOAD $RUN_SQL $RUN_SINGLE_USER_REPORT $RUN_MULTI_USER $RUN_MULTI_USER_REPORT $RUN_SCORE $SINGLE_USER_ITERATIONS $TYPE_ORIENTATION $TYPE_COMPRESS $LEVEL_COMPRESS"
