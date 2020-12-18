# hbut-campus-net-auto-login
湖北工业大学三网合一网页认证自动登录脚本

此脚本可以用于登录湖北工业大学三网合一的web认证，可以作为路由器或者自己电脑的开机启动脚本，以达到自动认证校园网的目的。

![三网合一认证的截图](https://tva1.sinaimg.cn/large/0081Kckwgy1gls3fo350bj31as0u07hg.jpg)

使用方法如下：

```shell
bash login.sh [username] [password] [ISP]
```

其中方括号内是：

- [username] 宽带账号，一般是你的学号
- [password] 宽带密码，一般是你身份证号后六位
- [ISP] 办理宽带的运营商，请按照如下填写
  - 中国移动：YD
  - 中国联通：LT
  - 中国电信：DX
  - 湖北工业大学校园网：default

例如宽带账号是123456789，密码是666666的移动宽带命令如下

```bash
bash login.sh 123456789 666666 YD
```

