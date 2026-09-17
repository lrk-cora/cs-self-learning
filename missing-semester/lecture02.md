# Lecture 2 · Shell 工具和脚本

- 讲义：[https://missing-semester-cn.github.io/2020/shell-tools/](https://missing-semester-cn.github.io/2020/shell-tools/)
- 环境：（例：Xubuntu 虚拟机 / bash）
- 日期：2026/9/17

说明：在虚拟机终端里做题，把用过的命令和看到的结果填进「命令」「结果」。开放题写你试了什么即可。自己写的脚本可以放在本目录，并在对应题里写上文件名。

---

## 1. 用 `ls` 完成下列显示方式

题目：先读 `man ls`，再用 `ls` 做到：

- 列出所有文件（包括隐藏文件）
- 文件大小用人类可读格式（例如 `454M` 而不是一长串数字）
- 按最近修改时间排序
- 输出带颜色

典型输出类似：

```
 -rw-r--r--   1 user group 1.1M Jan 14 09:53 baz
 drwxr-xr-x   5 user group  160 Jan 14 09:53 .
 -rw-r--r--   1 user group  514 Jan 14 06:42 bar
 -rw-r--r--   1 user group 106M Jan 13 12:12 foo
 drwx------+ 47 user group 1.5K Jan 12 18:08 ..
```

提示：一条 `ls` 可以带多个选项。

**命令：**

```bash
ls -a
ls -lh
ls -t
ls --color=auto
```

**结果：**（贴几行输出即可）

`-h`一般需要和`l`连用，`t`也和其连用会比较方便看

---



## 2. 编写 bash 函数 `marco` 和 `polo`

题目：执行 `marco` 时，把当前工作目录存下来；之后无论在哪个目录，执行 `polo` 都 `cd` 回刚才 `marco` 的位置。

为了方便调试，代码可以写在单独文件 `marco.sh` 里，用 `source marco.sh`（重新）加载函数。

建议：脚本放在 `missing-semester/marco.sh`。

**命令：**（加载函数，以及你测试 `marco` / `polo` 的步骤）

```bash
source marco.sh
source polo.sh
marco
cd /etc
polo
```

**结果：**（写清：在哪执行了 `marco`，后来去了哪，`polo` 之后 `pwd` 是什么）

在`/home/ustc`执行`marco`，然后去`etc`，执行完`polo`后回到`/home/ustc`

---



## 3. 循环运行脚本直到它出错，并记下输出

题目：下面这段脚本很少出错。写一个 bash 脚本反复运行它，直到失败；把它的标准输出和标准错误都记到文件里，最后把这些内容打印出来。加分：报告失败前共运行了多少次。

```bash
#!/usr/bin/env bash

n=$(( RANDOM % 100 ))

if [[ n -eq 42 ]]; then
   echo "Something went wrong"
   >&2 echo "The error was using magic numbers"
   exit 1
fi

echo "Everything went according to plan"
```

提示：

- 先把上面保存成一个文件（例如 `rare-fail.sh`），再写另一个脚本去循环调用它。
- `[[ n -eq 42 ]]` 是讲义里的原文；若几乎从不失败，想想 `n` 要不要写成 `$n`。
- 同时捕获 stdout 和 stderr，可以用 `>` 和 `2>&1`。

**命令：**

新建一个test.sh脚本

```bash
#!/usr/bin/env bash
count=0
logfile="output.log"
# 先清空旧日志，防止上次运行残留内容
> "$logfile"

while true; do
    count=$((count + 1))
    ./random_script.sh >> "$logfile" 2>&1
    ret=$?
    if [ $ret -ne 0 ]; then
        echo "脚本失败！一共运行了 $count 次"
        echo "===== 全部日志内容 ====="
        cat "$logfile"
        break
    fi
done
```

再运行

```
chmod +x random_script.sh test.sh
./test.sh
```

**结果：**（失败时文件里有什么；若做了加分项，写运行次数）

给的脚本中`n`要改成`$n`
运行次数为10次

---



## 4. 递归查找所有 HTML 文件并打成 zip

题目：写一条命令，递归找出某文件夹里所有 HTML 文件，压缩成 zip。文件名里有空格时也要能正确工作。

提示：管道把标准输出接到标准输入；`tar` / `zip` 这类命令往往要从**参数**读文件名，这时用 `xargs`。注意 `xargs` 的 `-d`（处理空格文件名）。你用的是 Linux 虚拟机，一般走 GNU `find` / `xargs` 即可，不必管 macOS 那一段。

**命令：**

```bash
find . -name '*.html' -print0 | xargs -0 zip html_files.zip
```

**结果：**（zip 文件名、里面有哪些 html；若自己造了带空格的测试文件，写一下）

---



## 5. （进阶）递归找出最近修改的文件

题目：写一条命令或脚本，递归查找文件夹里最近修改的文件。更通用：按最近修改时间列出文件。

做不出可在「结果」里写跳过，或写你试过但没完成的命令。

**命令：**

```bash
find . -type f -print0 | xargs -0 ls -lt
```

**结果：**

---



## 本讲小结（选填，几句话）

- 新学会的命令：
  - `>&2`和`2>&1`把前面命令的输出重定向到标准错误，把标准错误重定向到标准输出
  - `-print0 | xargs -0`安全处理文件名包含空格、换行、特殊符号的文件
- 仍然不清楚的：
  - `xargs`的其他用法

