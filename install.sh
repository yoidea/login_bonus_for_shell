#!/bin/sh
cd `dirname $0`
if [ -d ~/.login_bonus_for_shell ]; then
	echo "再インストールしますか？ (Y / n)"
	read ans
	if [ $ans == Y ]; then
		rm -rf ~/.login_bonus_for_shell
		echo "旧ファイルを削除しました"
		mkdir ~/.login_bonus_for_shell
		cp ./* ~/.login_bonus_for_shell
		echo "ファイルをコピーしました"
	else
		echo "インストールを中断しました"
		exit 1
	fi
else
	echo "インストールを開始します"
	mkdir ~/.login_bonus_for_shell
	cp ./* ~/.login_bonus_for_shell
	echo "ファイルをコピーしました"
fi
if [ -f ~/.bash_profile ]; then
	echo ".bash_profileが見つかりました"
else
	touch ~/.bash_profile
	echo ".bash_profileを作成しました"
fi
check=`grep -ci "cd ~/.login_bonus_for_shell" ~/.bash_profile`
if [ $check -eq 0 ]; then
	ver=`python -V 2>&1 | cut -c 8`
	if [ $? -eq 127 ]; then
		echo "Python3またはPython2が必要です"
		rm -rf ~/.login_bonus_for_shell
		echo "インストールを中断しました"
		exit 1
	fi
	dec=`expr "$ver" = "3"`
	if [ $dec -eq 1 ]; then
		echo "Python3を確認しました"
		echo "cd ~/.login_bonus_for_shell" >> ~/.bash_profile
		echo "python logger.py" >> ~/.bash_profile
	fi
	dec=`expr "$ver" = "2"`
	if [ $dec -eq 1 ]; then
		echo "Python2を確認しました"
		echo "cd ~/.login_bonus_for_shell" >> ~/.bash_profile
		echo "python logger_for_python2.py" >> ~/.bash_profile
	fi
	echo "cd ~/" >> ~/.bash_profile
	echo ".bash_profileを変更しました"
	echo "インストール完了"
	exit 0
else
	echo "再インストール完了"
	exit 0
fi