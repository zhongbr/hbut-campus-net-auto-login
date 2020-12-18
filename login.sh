#!/bin/bash
time=$(date "+%Y-%m-%d %H:%M:%S")
echo "---------------------login-log-time-["$time"]------------------------"
wlan_userip_url='http://123.123.123.123';
resp=$(curl -s --connect-timeout 2 ${wlan_userip_url});
if [ -n "$resp" ] && [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ]
then
	echo "当前未认证。"
	query_string=$(echo $resp|grep -Eo "wlanuserip=([0-9a-z&=\-]*?)");
	#echo $query_string;
	#获取cookie
	headers=$(curl -Is "http://172.31.0.2/eportal/index.jsp?"${query_string}"");
	cookie=$(echo $headers|grep -Eo "JSESSIONID=[a-zA-Z0-9;]+");
	#发送登录请求
	login_url='http://172.31.0.2/eportal/InterFace.do?method=login';
	login_resp=$(curl -s -b"EPORTAL_COOKIE_DOMAIN=false; EPORTAL_COOKIE_OPERATORPWD=;"$cookie"" -d "userId="$1"&password="$2"&service="$3"&operatorPwd=&operatorUserId=&validcode&passwordEncrypt=false" --data-urlencode "queryString="$query_string"" -X POST $login_url);
	success=$(echo $login_resp|grep -o success);
	if [[ -n "$success" ]]
	then
		echo '认证成功';
		curl -s "https://sc.ftqq.com/SCU116664Tbab39aa6411e162e0000db90958dcc605f7ac77f2d1e8.send?text=%E7%BD%91%E8%B7%AF%E4%B8%AD%E6%96%AD%E4%BA%86%E4%B8%80%E4%B8%8B%E4%B8%8B%EF%BC%8C%E8%87%AA%E5%8A%A8%E6%81%A2%E5%A4%8D%E6%88%90%E5%8A%9F%EF%BC%81"
	else
		echo "认证失败，"$login_resp|grep -Eo "\"message\":\".*?\","|grep -Eo ":\".*?\""|grep -Eo "\".*?\""|grep -Eo "[^\"]+";
	fi
else
	if [[ -z "$1" ]]
	then
		echo "缺少参数:userid, login [userId], [password], [service]";
	elif [[ -z "$2" ]]
	then
		echo "缺少参数:password, login [userId], [password], [service]";
	elif [[ -z "$3" ]]
	then
		echo "缺少参数:service, login [userId], [password], [service]";
	else	
		echo '你没有连接三网合一的校园网，或者你的网络已经认证过了';
	fi
fi
