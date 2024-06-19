# Virtual Private Networks(VPNs):

A Virtual Private Network (VPN) essentially allows for the creation of a private network that acts as a dedicated tunnel within another public network (i.e the Internet). Accessed via various authentication protocols, like [[IPsec]]. Typically tun0 or tap0 are used to as the [[Network-Interface]]. 

## States

| State       | Description                                                                                                                                                 |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ESTABLISHED | The socket has an established connection.                                                                                                                   |
| SYN_SENT    | The socket is actively attempting to establish a connection.                                                                                                |
| SYN_RECV    | A connection request has been received from the network.                                                                                                    |
| FIN_WAIT1   | The socket is closed, and the connection is shutting down.                                                                                                  |
| FIN_WAIT2   | Connection is closed, and the socket is waiting for a shutdown from the remote end.                                                                         |
| TIME_WAIT   | The socket is waiting after close to handle packets still in the network.                                                                                   |
| CLOSED      | The socket is not being used.                                                                                                                               |
| CLOSE_WAIT  | The remote end has shut down, waiting for the socket to close.                                                                                              |
| LAST_ACK    | The remote end has shut down, and the socket is closed. Waiting for acknowledgement.                                                                        |
| LISTEN      | The socket is listening for incoming connections. Such sockets are not included in the output unless you specify the --listening (-l) or --all (-a) option. |
| CLOSING     | Both sockets are shut down but we still don't have all our data sent.                                                                                       |
| UNKNOWN     | The state of the socket is unknown.                                                                                                                         |
