import socket
import sys
import time

"""
This is a super simple TCP port pinging script.
It connects to a specified host and port, and sends a message to the server.
The whole thing is very basic and used only very standard python libraries

When verbose is set to false, it only prints the message being sent to the server
"""

# Passed as integer, but used as boolean
VERBOSE = bool(int(sys.argv[1]) if len(sys.argv) > 1 else True)
PORT = int(sys.argv[2] if len(sys.argv) > 2 else 3142)
HOST = str(sys.argv[3] if len(sys.argv) > 3 else "localhost")
MSG = str(sys.argv[4] if len(sys.argv) > 4 else "Hello World!")

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    print('Ping server started', flush=True) if VERBOSE else None
    print('connecting to [%s] on [port] %d' %
          (HOST, PORT,), flush=True) if VERBOSE else None
    s.connect((HOST, PORT))
    if VERBOSE:
        print('sending [%s] to server' % (MSG,), flush=True)
    else:
        print('[send - %s]' % (MSG,), flush=True)
    s.sendall(MSG.encode('utf-8'))
    print('Ping server done', flush=True) if VERBOSE else None
    reply = s.recv(1024).decode('utf-8')
    print('[%s]' % (reply,), flush=True)
except Exception as e:
    print('Error [%s] from [%s]' % (e,s.gethostname()), flush=True)
    exit(1)
finally:
    s.close()
    print('Ping server, all connections closed',
          flush=True) if VERBOSE else None
    exit(0)