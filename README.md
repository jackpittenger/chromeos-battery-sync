# chromeos-battery-sync
This repo contains everything needed to send battery information from ChromeOS to your Crostini container. It also contains a polybar file with adaptive battery icons based on the charge and if it is plugged in.

## Images
 *Battery up and running with a look at the minimizable app.*
 ![App](https://raw.githubusercontent.com/realSaddy/chromeos-battery-sync/master/images/app.png) 
 *Charging icon.*
 ![Charging](https://raw.githubusercontent.com/realSaddy/chromeos-battery-sync/master/images/charging.png) 
 *View when the application is not running and there is no battery information stored.*
 ![NoBattery](https://raw.githubusercontent.com/realSaddy/chromeos-battery-sync/master/images/no_battery.png) 

## Installation

#### 1 - Packing the application
Pack the `app/` directory in chrome://extensions, and drag & drop the crx output. Note that if you only load the extension it will be wiped each time you restart.

#### 2 - Socket server
Copy the `socket_server/` directory to `/opt/`. The socket server receives incoming communication from the app. You should create a systemd file (`/lib/systemd/system/batterysocket.service`) with the following text:
```
[Unit]
Description=Battery Socket, by realSaddy

[Service]
ExecStart=/usr/bin/python3 /opt/socket_server/main.py
Restart=on-failure

[Install]
WantedBy=default.target
```
This should handle everything cleanly. In the event you need to restart the server, you can do `sudo systemctl restart batterysocket`. Now, after a restart, you can launch the i3wm Battery application and the data should be written to `/tmp/BAT0/POWER` and `/tmp/BAT0/CHARGING`.

#### 3 - Polybar support
*NOTE: Requires font-awesome*

Copy the `.scripts/` directory to a place of your choosing, and add the following into your polybar configuration file:
```
[module/custombattery]
type = custom/script
exec = /home/saddy/.scripts/polybar_battery.sh
tail = true
```
You can then include it in your top bar (I chose the right side). After a restart, you should be able to launch your i3 container & application and the battery will be dispalyed correctly.

## Limitations
ChromeOS alarms have a minimum of one minute, so battery information can only be updated once per minute, including when a charger is plugged in. If anyone has a solution to this, feel free to create a pull request :).

## Contributors
Created by [@realSaddy](https://github.com/realSaddy)
