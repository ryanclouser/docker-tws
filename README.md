TWS
===

[![Donate with Bitcoin](https://en.cryptobadges.io/badge/micro/12BMo7nBeBhDGDGagwqSRPAv3fkQi8nCfq)](https://en.cryptobadges.io/donate/12BMo7nBeBhDGDGagwqSRPAv3fkQi8nCfq)
[![Donate with Ethereum](https://en.cryptobadges.io/badge/micro/0xd163fdde358f9000A4E9290f23B84DFb6E9190D3)](https://en.cryptobadges.io/donate/0xd163fdde358f9000A4E9290f23B84DFb6E9190D3)
[![Donate with Litecoin](https://en.cryptobadges.io/badge/micro/LVSmZByqa6Cp1BFwgqeUyMjKmpfHP23ApR)](https://en.cryptobadges.io/donate/LVSmZByqa6Cp1BFwgqeUyMjKmpfHP23ApR)

Creates a completely self-contained Docker container of Trader Workstation. Exposes a VNC service on port 5900 and 7496/7497 for the IB API.

Usage
---

1. `git clone git@github.com:ryanclouser/docker-tws.git`
1. `cd docker-tws`
1. Configure Trader Workstation on a local system.
   - Copy `jts.ini` to the cloned repository folder.
   - Copy `tws.xml` from your profile folder into the cloned repository folder (it's inside the very long folder name). This contains your account settings (like enabling/disabling read-only mode).
1. Edit `Dockerfile` and change the `PROFILE` variable to the name of your profile.
1. Edit the VNC resolution and password in `Dockerfile` if needed.
1. `docker build -t tws .`
1. `docker run -d --rm --name tws -e ARGS="username=IB_USERNAME password=IB_PASSWORD" -p 5900:5900 -p 7496:7496 -p 7497:7497 tws`

If paper trading, a 'return' keystroke will be sent after 60s to skip the warning dialog.