# chromeos-battery-sync
Code for sending ChromeOS battery data over a socket using a ChromeOS app to Crostini. Support for Polybar


```
[Unit]
Description=Battery Socket, by realSaddy

[Service]
ExecStart=/usr/bin/python3 /opt/socket_server/main.py
Restart=on-failure

[Install]
WantedBy=default.target
```

```
[module/custombattery]
type = custom/script
exec = /home/saddy/.scripts/polybar_battery.sh
tail = true
```
