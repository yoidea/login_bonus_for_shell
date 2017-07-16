# login_bonus_for_shell
毎日シェルにログインするモチベーションを維持するために、シェルにソーシャルゲームのようなログインボーナスを与える機能を追加する。

## 動作環境
Python3またはPython2のインストールされたMac、Linuxで動作する。.bash_profileが利用できる環境であればWindowsでも動作するだろう。

## デモ
### ログイン時
シェルにログインしたときに通算、連続、当日のログイン回数が表示される。
```bash
*---*---*---* ログインボーナス *---*---*---*
継続は力なり！毎日ログインしましょう
 +   通算 < 1 > 日目
 +   連続 < 1 > 日目
 +   本日 < 1 > 回目
*---*---*---*---*---*--*---*---*---*---*---*
```
### 特定回数回ログイン時
特定の回数ログインしたときには、お祝いのメッセージが表示される。
```bash
*---*---*---* ログインボーナス *---*---*---*
継続は力なり！毎日ログインしましょう
 +   通算 < 1 > 日目
 +   連続 < 1 > 日目
 +   本日 < 5 > 回目
*---*---*---*---*---*--*---*---*---*---*---*
🎉おめでとうございます🎉
本日5回目のログインです！
```

## インストール
### install.shを使う
```bash
sh install.sh
```
としてインストール完了。

### 手動でインストールする
#### Python3系の場合
任意の名前のディレクトリ(例: ~/LBFS)を作成して、そのなかに、
- logger.py
- message.json
- eventlist.json
をコピーする。
```bash
vi ~/.bash_profile
```
として.bash_profileに以下を追加してインストール完了
```bash
cd ~/LBFS
python logger.py
cd ~/
```
#### Python2系の場合
任意の名前のディレクトリ(例: ~/LBFS)を作成して、そのなかに、
- logger_for_python2.py
- message.json
- eventlist.json
をコピーする。
```bash
vi ~/.bash_profile
```
として.bash_profileに以下を追加してインストール完了
```bash
cd ~/LBFS
python logger_for_python2.py
cd ~/
```

## 設定
### 祝いの言葉を変更
eventlist.json内にお祝いの条件とメッセージが保存されている。
```json
{
    "events": [
        {
            "condition": "continuous",
            "value": 3,
            "message": "🎉おめでとうございます🎉\n連続3日目のログインです！"
        },
```
### 定型文を変更
message.json内に定型文が保存されている。
eventlist.json内にお祝いの条件とメッセージが保存されている。
```json
{
    "head": "*---*---*---* ログインボーナス *---*---*---*\n継続は力なり！毎日ログインしましょう",
    "total": {
        "info": " +   通算 <",
        "unit": "> 日目"
    },
    "continuous": {
        "info": " +   連続 <",
        "unit": "> 日目"
    },
    "today": {
        "info": " +   本日 <",
        "unit": "> 回目"
    },
    "foot": "*---*---*---*---*---*--*---*---*---*---*---*"
}
```
