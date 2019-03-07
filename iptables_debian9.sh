iptables -F
iptables -X
iptables -Z
#配置，禁止进，允许出，允许回环网卡
iptables -P INPUT DROP
iptables -A OUTPUT -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
#允许ping
iptables -A INPUT -p icmp -j ACCEPT
#允许ssh
iptables -A INPUT -p tcp --dport 50022 -j ACCEPT
#ShadowsocksR端口
iptables -A INPUT -p udp -m state --state NEW -m udp --dport 51086 -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 51086 -j ACCEPT
#Ocserv端口
iptables -A INPUT -p udp -m state --state NEW -m udp --dport 50443 -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 50443 -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.199.0/24 -o venet0 -j MASQUERADE
iptables -A FORWARD -s 192.168.199.0/24 -j ACCEPT
# 允许已建立的或相关连的通行
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#禁止其他未允许的规则访问
iptables -A INPUT -j REJECT
#保存配置
iptables-save