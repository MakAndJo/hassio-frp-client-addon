![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield] ![Supports armhf Architecture][armhf-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports i386 Architecture][i386-shield]

# FRP Client for Home Assistant OS

[FRP Client](https://github.com/fatedier/frp) for Home Assistant OS can be used to set up a reverse proxy with an FRP server.

FRP can be used to expose home assistant to global network over NAT:

1. Install FRP server on a remote server with public IP.
2. Then connect FRP client to it.
3. On remote server you are be able to access your home assistant through `remote_port`. (ensure `ufw` allows that ports)

This addon is able to do the configuration of Home Assistant automatically.

## Installation

- Go to Settings -> Add-ons -> Add-on Store (bottom right)
- Click Repositories (top right)
- Add the current repository `https://github.com/MakAndJo/hassio-frp-client-addon`
- Wait and refresh the Add-on Store page, then you can see one new add-on `Frp Client`, click it and install

- Add the configurations shown as below in your `configurations.yaml` with File Editor addon

```
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 0.0.0.0/0
```

It's better to modify the `0.0.0.0/0` to your proxy server IP

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
