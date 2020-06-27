import socket
import os
import time

bat_dir = "/tmp/BAT0/"
power_file = "POWER"
charging_file = "CHARGING"
try:
    if not os.path.exists(bat_dir):
        os.mkdir(bat_dir)
        print("Created BAT0 dir")
except Exception as e:
    print("Failed to create BAT0 dir ", e)

host = 'localhost'
port = 8931

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    s.bind((host, port))
except socket.error as e:
    print(str(e))

s.listen(5)

while True:
    conn, addr = s.accept()
    print('connected to: '+addr[0]+":"+str(addr[1]))

    while True:
        data = conn.recv(1024)
        if not data:
            break
        print("received data: ", data)
        x = data.decode().split(",")
        with open(bat_dir+power_file, 'w') as f:
            f.write(str(int(float(x[0])*100)))
            f.close()
        with open(bat_dir+charging_file, 'w') as f:
            f.write(x[1])
            f.close()
        conn.send(b'1')

    conn.close()
