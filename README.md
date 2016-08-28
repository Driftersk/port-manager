# port-manager
A simple port forwarding manager for Mikrotik routers.

# Features:
* Add new rules
* Removing rules
* Changing existing rules (ip, port, type, comment)
* All changes are made via AJAX

This project uses pear2/net_routeros to access Mikrotik API.

# To set up this app:
* Install required libs
* Change settings in core/config.php
* Generate new password in passwordcreator/index.php

#### When changing IPs, ports, port types or comment, you need to press enter to change the value on the router.

# Screens
![login screen](https://raw.githubusercontent.com/Driftersk/port-manager/master/docs/imgs/login.png)

![maintenance](https://raw.githubusercontent.com/Driftersk/port-manager/master/docs/imgs/maintenance.png)
