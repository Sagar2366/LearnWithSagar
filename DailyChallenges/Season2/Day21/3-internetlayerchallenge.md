
---

# ✅ **Internet/Network Layer – Observational Lab Guide**

This lab is designed to help you practice **network troubleshooting and diagnosis** without making any configuration changes. Everything is based on **observing the current state of the network** using standard Linux commands.

You will practice analyzing interfaces, checking connectivity, and monitoring open connections—all on a single VM, without modifying IP addresses, routes, or firewall rules.

---

## 📘 **Pre-requisites**

1. **Operating System**: Ubuntu or similar Linux distribution.
2. **Tools required** (install if missing):

   ```bash
   sudo apt update
   sudo apt install iproute2 net-tools iputils-ping traceroute -y
   ```
3. Ensure your network interface is connected and the system is online.
4. All tasks below **do not change any network configuration**. They only read and analyze the current state.

---

## ✅ **Scenario 1 – Identify Network Interfaces and Their Status**

### 📖 **Story**

You are asked to gather details about the network interfaces on your system. You need to find which interfaces are active, their IP addresses, and if there are any errors—all without changing anything.

### ➤ **Tasks**

1. **List all interfaces and their IP addresses**:

   ```bash
   ip addr show
   ```

2. **Check link status (UP or DOWN)**:

   ```bash
   ip link show
   ```

3. **View network statistics**:

   ```bash
   netstat -i
   ```

4. **Optional** – See MAC addresses and scope:

   ```bash
   ip addr show
   ```

### ✅ **What to observe**

* Available interfaces like `lo`, `eth0`, `enp0s3`, etc.
* Which interfaces are `UP` or `DOWN`.
* IP addresses assigned (IPv4 or IPv6).
* Errors, dropped packets, or collisions in statistics.
* Whether the interface is connected to the network.

---

## ✅ **Scenario 2 – Check Connectivity Without Changing Anything**

### 📖 **Story**

You are troubleshooting connectivity issues and need to check if your system can reach other devices or the internet. You will only observe the behavior of network packets without altering any settings.

### ➤ **Tasks**

1. **Find the default gateway**:

   ```bash
   ip route show
   ```

   Look for a line starting with `default via`.

2. **Ping the default gateway to check local connectivity**:

   ```bash
   ping -c 3 <gateway_ip>
   ```

   Replace `<gateway_ip>` with the value from the previous command.

3. **Ping an external IP (like Google’s DNS server)**:

   ```bash
   ping -c 3 8.8.8.8
   ```

4. **Ping a domain name to test DNS resolution**:

   ```bash
   ping -c 3 google.com
   ```

5. **Trace the route to an external IP**:

   ```bash
   traceroute 8.8.8.8
   ```

### ✅ **What to observe**

* Whether packets are being sent and replies are received.
* If the route reaches external destinations or fails at some hop.
* If DNS resolution is working or failing.
* Round-trip times and network latency.
* Where the network drops occur.

---

## ✅ **Scenario 3 – Observe Open Network Connections and Traffic**

### 📖 **Story**

You need to analyze which services are open and which connections are currently active on the system. This helps you understand how your system communicates with others without making any changes.

### ➤ **Tasks**

1. **List all active TCP and UDP connections**:

   ```bash
   netstat -tunlp
   ```

   or

   ```bash
   ss -tunlp
   ```

2. **View protocol-specific statistics**:

   ```bash
   netstat -s
   ```

3. **Check ARP cache to see devices in the local network**:

   ```bash
   arp -n
   ```

4. **Optional – Look for unusual or unexpected open ports**:
   Review the output of `netstat -tunlp` or `ss -tunlp`.

### ✅ **What to observe**

* Which ports are open and listening for connections.
* The protocols in use (TCP, UDP).
* The destination addresses of active connections.
* Errors, retransmissions, or unusual patterns in network traffic.
* Local devices interacting via the ARP table.

---

## 📌 **Practice Questions**

1. How many network interfaces does your system have? Which ones are active?
2. Does your interface have a proper IP address? Is it linked to the correct network?
3. Can you reach the local gateway? How many packets are lost if any?
4. Is DNS resolution working? What output do you get when you ping a domain name?
5. How many listening services are open on your machine? Do you recognize all of them?
6. What devices are visible in the ARP table? Do you see any unusual entries?
7. Does traceroute complete or stop at some point? Where is it getting stuck?

---

## ✅ **Summary Table**

| Scenario               | Purpose                           | Commands                                              | Observations                                            |
| ---------------------- | --------------------------------- | ----------------------------------------------------- | ------------------------------------------------------- |
| 1. Network Interfaces  | Identify interfaces and status    | `ip addr show`, `ip link show`, `netstat -i`          | IPs, link state, errors, dropped packets                |
| 2. Connectivity Checks | Diagnose reachability and routing | `ip route`, `ping`, `traceroute`                      | Gateway reachability, external connectivity, DNS issues |
| 3. Open Connections    | Analyze open ports and traffic    | `netstat -tunlp`, `ss -tunlp`, `netstat -s`, `arp -n` | Active connections, protocols, errors, neighbors        |

---

## ✅ **Conclusion**

This lab gives you a hands-on approach to diagnosing network problems without touching any configuration files or making changes. All tasks focus on observing, analyzing, and interpreting the current state of the network on a single VM. It’s an excellent way to build troubleshooting skills safely and effectively.

Let me know if you want sample outputs, explanations for interpreting results, or additional diagnostic scenarios!
