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

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
conn = None
try:
    print('Echo server started') if VERBOSE else None
    print('binding to port %d' % (PORT,)) if VERBOSE else None
    s.bind(('', PORT))
    print('listening for connection') if VERBOSE else None
    s.listen(1)
    conn, addr = s.accept()
    print('connection from %s' % (addr,)) if VERBOSE else None
    data = conn.recv(1024)
    if VERBOSE:
        print('received [%s]' % (data,))
    else:
        print('%s' % (data.decode('utf-8'),))
    time.sleep(1)
    print('Echoing [%s] to sender' % (data,)) if VERBOSE else None
    conn.sendall(data)
    print('Echo server done') if VERBOSE else None
except Exception as e:
    print('Error [%s]' % (e,))
    exit(1)
finally:
    conn.close() if conn is not None else None
    s.close() if s is not None else None
    print('Echo server, all connections closed') if VERBOSE else None
    exit(0)
