---

## ✅ **Common Pre-requisites**

1. Use **Ubuntu** or a similar Linux system.
2. Install required tools (if not already installed):

   ```bash
   sudo apt update
   sudo apt install iproute2 net-tools iputils-ping traceroute -y
   ```
3. All commands below **only read or observe**, no changes to network settings are required.

---

## ✅ **Scenario 1 – Identifying Network Interfaces and Their Status**

### 📖 **Story**

You need to gather details about the network interfaces available on your machine. Without modifying anything, you should understand which interfaces are active, their IP addresses, and link status.

### ➤ **Tasks**

1. List all interfaces:

   ```bash
   ip addr show
   ```

2. Check interface statuses:

   ```bash
   ip link show
   ```

3. View network statistics:

   ```bash
   netstat -i
   ```

4. Understand the interface's role:

   * Is it connected?
   * Does it have a valid IP?
   * Is it loopback or external?

### ✅ **What to observe**

* Interfaces like `lo`, `eth0`, `enp0s3` etc.
* Link state: UP or DOWN
* IP addresses assigned
* Errors or dropped packets in statistics

---

## ✅ **Scenario 2 – Checking Connectivity Without Changing Anything**

### 📖 **Story**

You want to diagnose if the system can reach other devices or the internet, purely by observing how the network behaves without altering any settings.

### ➤ **Tasks**

1. Ping your default gateway:

   ```bash
   ip route show
   # Find the gateway, e.g., 192.168.1.1
   ping -c 3 192.168.1.1
   ```

2. Ping an external IP like Google’s DNS:

   ```bash
   ping -c 3 8.8.8.8
   ```

3. Ping a domain name to test DNS resolution:

   ```bash
   ping -c 3 google.com
   ```

4. Trace the route to an external IP:

   ```bash
   traceroute 8.8.8.8
   ```

### ✅ **What to observe**

* Are ICMP packets being sent and received?
* Does the route show multiple hops or get stuck?
* Is DNS resolution working?

No changes are made; this is purely diagnostic.

---

## ✅ **Scenario 3 – Observing Open Network Connections**

### 📖 **Story**

You want to check what network connections are currently open or listening on the system without making any changes.

### ➤ **Tasks**

1. Check active connections:

   ```bash
   netstat -tunlp
   ```

   *(Shows TCP/UDP connections, listening ports, and associated processes.)*

2. Alternatively, using `ss`:

   ```bash
   ss -tunlp
   ```

3. See statistics per protocol:

   ```bash
   netstat -s
   ```

4. View ARP cache:

   ```bash
   arp -n
   ```

### ✅ **What to observe**

* Which ports are open and services listening
* Established connections and where they connect to
* Number of retransmissions, errors, and packet statistics
* Known devices on the local network (via ARP)

This is pure observation—no configurations are changed.

---

## ✅ **Summary Table**

| Scenario               | Purpose                                     | Commands                                              | Observations                                     |
| ---------------------- | ------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------ |
| 1. Network Interfaces  | Understand interfaces and their state       | `ip addr show`, `ip link show`, `netstat -i`          | Interface names, UP/DOWN status, IPs, errors     |
| 2. Connectivity Checks | Diagnose reachability and routing           | `ping`, `traceroute`, `ip route show`                 | Packet loss, route hops, DNS resolution          |
| 3. Open Connections    | Analyze existing connections and statistics | `netstat -tunlp`, `ss -tunlp`, `netstat -s`, `arp -n` | Listening ports, active connections, ARP entries |

---
