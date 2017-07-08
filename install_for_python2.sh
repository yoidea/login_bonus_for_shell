#!/bin/sh
cd `dirname $0`
if [ -d ~/.login_bonus_for_shell ]; then
	echo "再インストールしますか？ (Y / n)"
	read ans
	if [ $ans == Y ] ; then
		rm -rf ~/.login_bonus_for_shell
		mkdir ~/.login_bonus_for_shell
		cp ./* ~/.login_bonus_for_shell
	else
		echo "インストールを中断しました"
		exit 1
	fi
else
	mkdir ~/.login_bonus_for_shell
	cp ./* ~/.login_bonus_for_shell
fi
check=`grep -ci "cd ~/.login_bonus_for_shell" ~/.bash_profile`
if [ $check -eq 0 ] ; then
	echo "cd ~/.login_bonus_for_shell" >> ~/.bash_profile
	echo "logger_for_python2.py" >> ~/.bash_profile
	echo "cd ~/" >> ~/.bash_profile
	echo "インストール完了"
	exit 0
else
	echo "再インストール完了"
	exit 0
fi