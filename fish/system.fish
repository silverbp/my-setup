alias whats-my-ip "wget http://ipinfo.io/ip -qO -"
alias watch-ip 'watch -d -n 2 -d sudo nmap -Pn -p'
alias clear-dns-cache 'sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'