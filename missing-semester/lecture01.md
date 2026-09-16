# Lecture 1 · 课程概览与 Shell

- 讲义：[https://missing-semester-cn.github.io/2020/course-shell/](https://missing-semester-cn.github.io/2020/course-shell/)
- 环境：（例：Xubuntu 虚拟机 / bash）
- 日期：2026/9/16

说明：在虚拟机终端里做题，把用过的命令和看到的结果填进「命令」「结果」。开放题写你试了什么即可。跳过的题在「结果」里写原因。

---

## 1. 确认 shell 是 bash 或 zsh

题目：本课需要类 Unix shell（Bash / ZSH）。Windows 不要用 cmd 或 PowerShell。用 `echo $SHELL` 查看。

**命令：**

```bash
echo $SHELL
```

**结果：**

/bin/bash

---

## 2. 在 `/tmp` 下新建名为 `missing` 的文件夹

**命令：**

```bash
cd /tmp
mkdir missing
```

**结果：**

drwxrwxr-x 2 ustc ustc 4096 9月 16 22:15 missing

---

## 3. 用 `man` 查看 `touch` 的手册

**命令：**

```bash
man touch
```

**结果：**（用一句话写下 `touch` 是干什么的）

change file timestamps（修改文件时间戳）

---



## 4. 用 `touch` 在 `missing` 里新建文件 `semester`

**命令：**

```bash
touch missing/semester
```

前提是missing文件夹已存在，否则会报错

**结果：**

-rw-rw-r-- 1 ustc ustc 0 9 月 16 22:25 semester

---



## 5. 把下面两行写入 `semester`

```
#!/bin/sh
curl --head --silent https://missing.csail.mit.edu
```

提示：第一行里 `#` 是注释、`!` 在双引号里也有特殊含义，用单引号更省事。

**命令：**

```bash
echo '#!/bin/sh' > semester
echo 'curl --head --silent https://missing.csail.mit.edu' >> semester
```

**结果：**（可用 `cat` 确认文件内容） 

#!/bin/sh 

curl --head --silent [https://missing.csail.mit.edu](https://missing.csail.mit.edu)

---



## 6. 尝试执行该文件

题目：在 shell 里输入该脚本的路径（`./semester`）并回车。若不能执行，用 `ls` 看原因。

**命令：**

```bash
chmod +x semester
./semester
```

**结果：**（能执行还是不能？`ls` 看到了什么？）

若直接执行`./semester`则输出没有权限，`ls -l`会看到`-rw-rw-r--`，需先加上可执行权限

---



## 7. 查看 `chmod` 的手册

**命令：**

```bash
man chmod
```

**结果：**（用一句话写下 `chmod` 是干什么的）

change file mode bits（修改文件的模式位）

---



## 8. 用 `chmod` 让 `./semester` 能执行

题目：不要用 `sh semester` 来跑。shell 怎么知道这个文件要用 `sh` 解析？（提示：shebang）

**命令：**

```bash
chmod +x semester
./semester
```

**结果：**（需提前安装curl`sudo apt install curl`）

```
HTTP/2 200
server: GitHub.com
content-type: text/html; charset=utf-8
last-modified: Tue, 08 Sep 2026 00:46:24 GMT
access-control-allow-origin: *
etag: "6a9f5ae0-39da"
expires: Wed, 16 Sep 2026 08:43:27 GMT
cache-control: max-age=600
x-proxy-cache: MISS
x-github-request-id: F160:1014C7:2B0716:2D40DB:6AAA5457
x-github-edge-region: japaneast
accept-ranges: bytes
age: 0
date: Wed, 16 Sep 2026 14:56:06 GMT
via: 1.1 varnish
x-served-by: cache-nrt-rjtf7700061-NRT
x-cache: HIT
x-cache-hits: 0
x-timer: S1789570567.679443,VS0,VE171
vary: Accept-Encoding
x-fastly-request-id: 3bea0947e494bc51309ce6abd7ae81cb5b35193e
content-length: 14810
```

**shell 如何知道用 sh 解析：**

当用 `./脚本名` 这种方式运行文件时，告诉操作系统内核：要用哪个解释器来执行这份脚本。

- `#!` = shebang 标记
- `/bin/sh` = 指定的解释器程序

---



## 9. 把 `semester` 输出里的最后更改日期写入主目录的 `last-modified.txt`

题目：使用 `|` 和 `>`。

**命令：**

```bash
./semester | grep last-modified | cut -d':' -f2 > ~/last-modified.txt
```

**结果：**（`cat ~/last-modified.txt` 看到了什么）

Tue, 08 Sep 2026 00

---



## 10. 从 `/sys` 读取笔记本电量，或台式机 CPU 温度

题目：macOS 没有 sysfs 可跳过。虚拟机里若没有对应文件，写清你查了哪些路径、为什么跳过。

**命令：**

```bash
cat /sys/class/power_supply/BAT0/capacity
```

**结果：**

100

---



## 本讲小结（选填，几句话）

- 新学会的命令：
  - 用`touch`在文件夹里新建文件
  - 用`chmod`修改权限
  - `#!`为shebang 标记
  - `cut -d':' -f2`以冒号分隔取后面内容
- 仍然不清楚的：
  - `cut`的其他用法
  - 怎么快速找到查看笔记本电量的目录

