# port-manager
A simple port forwarding manager for Mikrotik routers.

# Thought
- - -
I recently purchased a Mikrotik router and I wanted to set some port forwarding rules. It really is not that hard, but just one simple thing (like changing port number) can take a long time. You need to download their application, find router ip and login credentials, find right tab in the menu and then search through a list of all forwarding rules. In my case for each port I have 2 rules, so I need to change both. For this reason I created simple management app. You just simply go to webpage and add/modify/remove what you need.
- - -
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

# Explanation

App is located inside private network (same as the router). This app can be accessed from outside, but router can be accessed only from local network. Router is never accessed directly.

Simple schema:
### user <-> port-manager <-> router

User does not have full access to the router. User can add/modify rules which have specific comment format. Inside routers memory theese rules have following format:
* `PORTS:MAIN:comment`  - for main forwarding rule
* `PORTS:HAIRPIN:comment` - for accessing this rule from local network

There can other rules which does not follow this comment pattern, but they won't be shown. (Useful for hiding unwanted rules.)

# Screens
![login screen](https://raw.githubusercontent.com/Driftersk/port-manager/master/docs/imgs/login.png)

![maintenance](https://raw.githubusercontent.com/Driftersk/port-manager/master/docs/imgs/maintenance.png)
