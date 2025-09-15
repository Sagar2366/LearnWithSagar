### ✅ **Network Access Layer (Layer 2 – Data Link / Layer 1 – Physical treated in theory)**

---

## 📘 **Challenge: Network Access Layer – Observation & Troubleshooting Scenarios**

### **Lab Setup**

* One Ubuntu VM with `tcpdump`, `ethtool`, `ip`, `iwconfig`, and other network tools installed.
* VM connected through Ethernet or Wi-Fi (depending on host configuration).
* No IP or routing changes required.
* Scenarios are about observing errors, interpreting hardware or link-layer information, and diagnosing issues.

---

### ✅ **Scenario 1 – Frequent Packet Drops at the Interface**

**Story:**
Your application’s network performance is erratic. Even though higher layers are configured correctly, packets are being dropped at the link layer. You suspect the issue is with the interface itself.

**Problem symptoms:**

* High retransmissions at TCP level.
* `ping` shows occasional packet loss.
* But routes and IP settings are correct.

#### 🔥 Breaking state (you don't need to apply this, it's for learning):

* Cable loosely connected, or interference in Wi-Fi.
* Duplex mismatch or interface error.

#### ✅ **Troubleshooting steps**

```bash
# Check the interface statistics
ip -s link show eth0

# Or using ethtool for detailed interface information
sudo ethtool -S eth0

# Check for errors, dropped packets, collisions, etc.
```

Look for fields like:

* `rx_errors`
* `tx_errors`
* `rx_dropped`
* `tx_dropped`
* `collisions` (if using Ethernet)

#### ✅ **Fix steps**

* If using Wi-Fi, move closer to the router.
* If using Ethernet, replug the cable securely.
* Use `ethtool` to check and adjust duplex settings if necessary:

```bash
sudo ethtool -s eth0 speed 100 duplex full autoneg off
```

* Restart the network interface if needed:

```bash
sudo ip link set eth0 down
sudo ip link set eth0 up
```

---

### ✅ **Scenario 2 – Interface Down Due to Power Saving**

**Story:**
The network interface intermittently goes down without apparent reason. Wi-Fi connection drops, or Ethernet disconnects. You suspect that power-saving settings are disabling the interface.

**Problem symptoms:**

* `ip link` shows interface down.
* The issue occurs after idle periods.

#### 🔥 Breaking state (theoretical):

* Power-saving mode enabled.
* Driver automatically suspends the interface.

#### ✅ **Troubleshooting steps**

```bash
# Show interface status
ip link show wlan0

# Check wireless settings and power management
iwconfig wlan0

# Or check using ethtool
sudo ethtool wlan0 | grep Wake-on
```

Look for `Power Management: on`.

#### ✅ **Fix steps**

```bash
# Disable power saving temporarily
sudo iwconfig wlan0 power off

# Or for Ethernet
sudo ethtool -s eth0 wol d
```

Make it persistent by configuring network manager or system settings.

---

### ✅ **Scenario 3 – Incorrect MTU Causing Fragmentation**

**Story:**
Your connection is slow and applications time out when transferring large files. TCP retransmissions are seen, but IP addresses and routes are fine. MTU mismatch is suspected at the link layer.

**Problem symptoms:**

* `ping` with large packets shows fragmentation or fails.
* File transfers stall intermittently.

#### 🔥 Breaking state (theoretical):

* MTU size set too high or too low.
* VPN, tunnel interfaces, or misconfigured settings.

#### ✅ **Troubleshooting steps**

```bash
# Check MTU settings
ip link show eth0

# Test packet size with ping
ping -M do -s 1472 8.8.8.8
```

If the packet fails, MTU may be too large.

#### ✅ **Fix steps**

```bash
# Set correct MTU size
sudo ip link set eth0 mtu 1400
```

Verify again with `ping`.

---

## 📦 Summary

| Scenario                  | Cause               | Symptoms                     | Commands for Diagnosis           | Commands for Fix                          |
| ------------------------- | ------------------- | ---------------------------- | -------------------------------- | ----------------------------------------- |
| Packet drops at interface | Cable/duplex errors | High errors, retransmissions | `ip -s link`, `ethtool -S`       | Reconnect, adjust duplex, reset interface |
| Interface down            | Power saving mode   | Interface disappears         | `ip link`, `iwconfig`, `ethtool` | Disable power management                  |
| MTU mismatch              | Wrong MTU size      | Fragmentation, timeouts      | `ip link`, `ping -M do`          | Adjust MTU size                           |

---
