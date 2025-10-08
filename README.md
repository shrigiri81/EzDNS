<div style="text-align: center;">

![EzDNS Banner](https://raw.githubusercontent.com/shrigiri81/EzDNS/refs/heads/main/assets/logo/EzDNS_Banner.png)

</div>

[![GitHub Release](https://img.shields.io/github/v/release/shrigiri81/EzDNS?style=for-the-badge)](https://github.com/shrigiri81/EzDNS/releases/latest/download/EzDNS.ps1)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/shrigiri81/EzDNS/total?style=for-the-badge)
[![Static Badge](https://img.shields.io/badge/-%40shrigiri81-white?style=for-the-badge&logo=x&label=Follow&labelColor=black&color=grey&link=https%3A%2F%2Fx.com%2Fshrigiri81)](https://x.com/shrigiri81)
[![Static Badge](https://img.shields.io/badge/Join-Build_Bytes-white?style=for-the-badge&logo=telegram&logoColor=white&logoSize=auto&labelColor=blue&color=87CEEB&link=https%3A%2F%2Ft.me%2Fbuildbytes)](https://t.me/buildbytes)


<h1 style="text-align: center;">EzDNS - Change DNS Easy Pesy</h1>

EzDNS is a powershell script which makes changing DNS servers to different providers easy and convenient.

Traditionally this wasn't a convenient task. Copy pasting DNS server addresses into windows settings or control panel. And when you want to go to default, windows deletes all those values to pasted earlier.

But not now, EzDNS makes it easy to do all this. Just 2 steps! And Voila! You're done with no worries.

## ⚡ Features

- Choose from different DNS providers
- Includes recommended DNS providers*
- Sets DNS system-wide
- View current DNS configuration

### 🎯 Future Features
- Add more DNS Resolver types from providers
- Custom DNS provider
- To request a features, create an issue.


## 🧩 Screenshot

![Windows-Terminal-vr-Kpvt-Of-BH.png](https://raw.githubusercontent.com/shrigiri81/EzDNS/refs/heads/main/assets/screenshots/Windows-Terminal-vr-Kpvt-Of-BH.png)

## 💡 Usage

EzDNS must be run in Admin mode as changing DNS is a system-wide operation. To achieve this, run Powershell as an administrator. Here are some instructions:

1. Start menu Method:
- Right-click on the start menu.
- Choose "Windows PowerShell (Admin)" (for Windows 10) or "Terminal (Admin)" (for Windows 11).

2. Search and Launch Method:
- Press the Windows key or goto search icon/bar on taskbar.
- Type "PowerShell" or "Terminal" (for Windows 11).
- Press `Ctrl + Shift + Enter` or Right-click and choose "Run as administrator" to launch it with administrator privileges.


### Launch Command
```ps1
irm "https://github.com/shrigiri81/EzDNS/releases/latest/download/EzDNS.ps1" | iex
```

### OR

You can download the file from releases. To run the script:
- right click on the file 
- click `run with powershell`


If you have Issues, create an [issue](https://github.com/shrigiri81/EzDNS/issues/new/choose).

## 💖 Support

Your support means a lot, drop a ⭐ on this repo.
Follow for cool stuffs!

## Acknowledgements

All of the recommended DNS Providers are taken from Privacy Guides. Kudos to them!
Check them out if you're interested in privacy.

[Privacy Guides](https://www.privacyguides.org/)

[DNS Resolvers - Privacy Guides](https://www.privacyguides.org/en/dns/)

## License

[MIT](https://choosealicense.com/licenses/mit/)