# 🧰 Windows PowerShell Fixes by @tihloh

A collection of lightweight PowerShell scripts that resolve common **Windows 10/11** network-related issues such as **shared printer errors** and **guest access limitations**. These scripts are safe, quick, and easily executable using one-liner commands.

---

## 📜 Available Fixes

### 🖨️ 1. Fix Shared Printer Connection Error (`0x0000011b`)

**File:** `fixsharedprinter.ps1`  
**Issue:** After recent Windows updates, connecting to a shared printer on the network may fail with the error code `0x0000011b`.

**Cause:** Microsoft enforced stricter RPC authentication for network printers, breaking older or non-domain shared printing.

**Fix:** This script disables the enforcement by modifying specific registry keys.

#### 🔧 How to Use

1. Open PowerShell as **Administrator**.
2. Run the following command:

```powershell
irm https://raw.githubusercontent.com/tihloh/winscripts/main/fixsharedprinter.ps1 | iex
```

### 🔓 2. Enable Guest Access for Network Shares

**File:** `enable-guestaccess.ps1`  
**Issue:** Accessing shared folders from other devices on the local network fails or asks for credentials, even when they previously worked without login.

**Cause:** Windows 10 and 11 have **guest access to SMB shares disabled by default** as part of newer security policies. This affects access to devices like NAS, Samba shares, or non-Windows SMB hosts.

**Fix:** This script re-enables guest access by editing the registry and group policy settings to allow anonymous access to shares.

#### 🔧 How to Use

1. Open **PowerShell as Administrator**.
2. Run the following one-liner command:

```powershell
irm https://raw.githubusercontent.com/tihloh/winscripts/main/enable-guestaccess.ps1 | iex
```


### 📁 3. Show Standard Folders Under "This PC"

**File:** `show-thispc-folders.ps1`  
**Issue:** Newer Windows 11 versions no longer show the standard **Desktop, Documents, Downloads, Music, Pictures, and Videos** folders under **This PC** by default.

**Fix:** This script restores those six folders under **This PC** by recreating their Explorer namespace entries and refreshing File Explorer.

#### 🔧 How to Use

1. Open **PowerShell as Administrator**.
2. Run:

```powershell
irm https://raw.githubusercontent.com/tihloh/winscripts/main/show-thispc-folders.ps1 | iex
```
