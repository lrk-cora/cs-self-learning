# Lecture 5 · 命令行环境

- 讲义：[https://missing-semester-cn.github.io/2020/command-line/](https://missing-semester-cn.github.io/2020/command-line/)
- 环境：（例：Xubuntu 虚拟机 / bash）
- 日期：2026/9/19

说明：在虚拟机终端里做题，把用过的命令和看到的结果填进「命令」「结果」。本讲作业可以减量：**任务控制前两问建议做**；tmux、别名、配置文件仓库、SSH 整套可以跳过，在「结果」里写「跳过」即可。

---

## 任务控制

### 1. 后台运行 `sleep`，用 `pgrep` / `pkill` 结束它

题目：在终端执行 `sleep 10000`，用 `Ctrl-Z` 放到后台，再用 `bg` 让它继续跑。然后用 `pgrep` 查 pid、用 `pkill` 结束进程，不要手打 pid。（提示：`-af`）

**命令：**

```bash
sleep 10000
C^Z
bg
pgrep -af sleep
pkill -f sleep
```

**结果：**

[1]+ 已终止  sleep 10000

`-af`：同时打印PID和完整命令行，匹配完整命令字符串

`pkill`没有`-a`参数

---



### 2. 等一个后台任务结束再执行下一条

题目：用 `sleep 60 &` 作为先跑的程序，再用 `wait`，等它结束后执行 `ls`。

**命令：**

```bash
sleep 60 &
wait #或者wait $!，只等待上一个进程结束，更好
ls
```

**结果：**

---



### 3. 编写函数 `pidwait`（可跳过）

题目：`wait` 只能等当前 shell 的子进程。`kill` 成功时退出码为 0；`kill -0` 不发信号，但进程不存在时返回非 0。写一个 bash 函数 `pidwait`，接收一个 pid，一直等到该进程结束。用 `sleep` 避免空转占满 CPU。

**命令：**

```bash

```

**结果：**

---



## 终端多路复用（可跳过）



### 4. 完成 tmux 教程并自定义

题目：完成讲义中的 tmux 教程，并按文档学习如何自定义 tmux。

**命令：**

```bash

```

**结果：**

---



## 别名（可跳过）



### 5. 创建别名 `dc`

题目：把 `cd` 误打成 `dc` 时也能正确执行。

**命令：**

```bash

```

**结果：**

---



### 6. 给最常用的十条命令做别名

题目：先执行（Bash）：

```bash
history | awk '{$1="";print substr($0,2)}' | sort | uniq -c | sort -n | tail -n 10
```

再给这些命令创建别名。ZSH 把 `history` 换成 `history 1`。

**命令：**

```bash

```

**结果：**

---



## 配置文件（可跳过）

题目：讲义要求单独建配置仓库、写安装脚本、在新虚拟机上测试、把现有配置迁进去并发到 GitHub。阶段 0 已有 `cs-self-learning`，不必另做一套。若跳过，下面统一写原因即可。

### 7. 为配置文件新建文件夹并做版本控制

**命令：**

```bash

```

**结果：**

---



### 8. 加入至少一个配置文件（例如改 `$PS1`）

**命令：**

```bash

```

**结果：**

---



### 9. 做一种新机器上快速安装配置的方法

题目：最简单是脚本里对每个文件 `ln -s`，也可以用专用工具。

**命令：**

```bash

```

**结果：**

---



### 10. 在新虚拟机上测试该安装脚本

**结果：**

---



### 11. 把现有配置文件迁进该仓库并发布到 GitHub

**结果：**

---



## 远端设备（可跳过）

说明：需要能 SSH 进一台 Linux（你已有虚拟机）。**不要轻易改** `/etc/ssh/sshd_config`（关密码登录、关 root），改完可能连不回去。现阶段建议整节跳过；以后真连服务器再做。

### 12. 查看或生成 SSH 密钥

题目：看 `~/.ssh/` 里是否已有密钥对。没有则：

```bash
ssh-keygen -o -a 100 -t ed25519
```

建议给密钥设密码，并用 `ssh-agent`。

**命令：**

```bash

```

**结果：**

---



### 13. 在 `~/.ssh/config` 里加入 Host vm

```
Host vm
    User username_goes_here
    HostName ip_goes_here
    IdentityFile ~/.ssh/id_ed25519
    LocalForward 9999 localhost:8888
```

把用户名和 IP 换成你的虚拟机。

**命令：**

```bash

```

**结果：**

---



### 14. 用 `ssh-copy-id vm` 把公钥拷到虚拟机

**命令：**

```bash

```

**结果：**

---



### 15. 端口转发访问虚拟机上的网页

题目：虚拟机里 `python3 -m http.server 8888`，本机浏览器打开 `http://localhost:9999`。

**命令：**

```bash

```

**结果：**

---



### 16. 修改 sshd 配置：禁用密码登录和 root 登录（不建议现在做）

题目：`sudo vim /etc/ssh/sshd_config`，改 `PasswordAuthentication`、`PermitRootLogin`，然后 `sudo service sshd restart`。

**结果：**

---



### 17. （附加）安装 `mosh` 并测试断网后能否恢复

**结果：**

---



### 18. （附加）`ssh` 的 `-N`、`-f`：后台端口转发的命令是什么？

**结果：**

---



## 本讲小结（选填，几句话）

- 新学会的命令：
  - `pgrep`和`pkill`和`-af` 
  - `wait` 
- 跳过了哪些、原因：不方便操作或是有一定风险
- 仍然不清楚的：

