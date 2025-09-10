---

## ✅ **Common Lab Setup (Install tools)**

Run these commands to install all required tools:

```bash
sudo apt update
sudo apt install netcat-openbsd iptables iproute2 inetutils-tools iperf3 traceroute tcpdump -y
```

Tools explained:

* ✅ `nc` – basic TCP/UDP communication
* ✅ `iptables` – control packet flow (firewall)
* ✅ `ss` – socket statistics
* ✅ `telnet` – test TCP connections
* ✅ `iperf3` – performance testing for TCP/UDP
* ✅ `traceroute` – trace network path
* ✅ `tcpdump` – capture packets

---

## ✅ **Scenario 1 – TCP Connection Refused**

### **Story**

You are trying to test connectivity using `telnet` to port 12345, but the connection is refused. This could be due to no listener or other issues.

---

### **Breaking commands**

Stop the listener:

```bash
pkill -f "nc -l -p 12345"
```

---

### **Troubleshooting steps**

1. Check if the listener process is running:

   ```bash
   ps aux | grep "nc -l -p 12345"
   ```

2. Check listening sockets using `ss`:

   ```bash
   sudo ss -tuln | grep 12345
   ```

3. Test connection using `telnet`:

   ```bash
   telnet localhost 12345
   ```

4. Check `iptables` rules blocking traffic:

   ```bash
   sudo iptables -L -n
   ```

---

### **Fix commands**

Start the listener again:

```bash
nc -l -p 12345 (This will be running in one separate tab to run the port all the time for testing all these scenarios so please check once if even after fixing your solution does not work)
```

Test connection again with `telnet`:

```bash
telnet localhost 12345
```

---

## ✅ **Scenario 2 – TCP Firewall Blocking**

### **Story**

You have a running TCP listener on port 12345, but connections are timing out. The firewall might be blocking traffic.

---

### **Breaking commands**

Block the port using `iptables`:

```bash
sudo iptables -A INPUT -p tcp --dport 12345 -j DROP
```

---

### **Troubleshooting steps**

1. Check open ports with `ss`:

   ```bash
   sudo ss -tuln | grep 12345
   ```

2. Check firewall rules:

   ```bash
   sudo iptables -L -n
   ```

3. Test connection using `telnet`:

   ```bash
   telnet localhost 12345
   ```

4. Capture traffic using `tcpdump` in another terminal:

   ```bash
   sudo tcpdump -i lo port 12345
   ```

---

### **Fix commands**

Remove the firewall rule blocking TCP traffic:

```bash
sudo iptables -D INPUT -p tcp --dport 12345 -j DROP
```

Test with `telnet` again.

---

## ✅ **Scenario 3 – UDP Packet Loss and Performance Issues**

### **Story**

You are using `iperf3` to test UDP bandwidth on port 5201, but packets are being lost or throughput is low.

---

### **Breaking commands**

Block UDP traffic using `iptables`:

```bash
sudo iptables -A INPUT -p udp --dport 5201 -j DROP
```

Or simulate packet loss by adding random dropping:

```bash
sudo tc qdisc add dev lo root netem loss 30%
```

---

### **Troubleshooting steps**

1. Start UDP server with `iperf3`:

   ```bash
   iperf3 -s -p 5201
   ```

2. Run client test in another terminal:

   ```bash
   iperf3 -c 127.0.0.1 -p 5201 -u -b 10M
   ```

3. Check firewall rules:

   ```bash
   sudo iptables -L -n
   ```

4. Monitor with `tcpdump`:

   ```bash
   sudo tcpdump -i lo udp port 5201
   ```

5. Trace route using `traceroute` (though on localhost it’s trivial):

   ```bash
   traceroute 127.0.0.1
   ```

---

### **Fix commands**

1. Remove firewall rule blocking UDP:

   ```bash
   sudo iptables -D INPUT -p udp --dport 5201 -j DROP
   ```

2. Clear packet loss simulation:

   ```bash
   sudo tc qdisc del dev lo root netem
   ```

3. Test again with `iperf3`:

   ```bash
   iperf3 -c 127.0.0.1 -p 5201 -u -b 10M
   ```

---

## ✅ Summary Table (With More Tools)

| Scenario    | Issue                          | Break Commands                                                                 | Troubleshooting Commands                         | Fix Commands                                                        |
| ----------- | ------------------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------------------------- |
| TCP Refused | Listener not running           | `pkill -f "nc -l -p 12345"`                                                    | `ps aux`, `ss`, `telnet`, `iptables -L`          | `nc -l -p 12345`, `telnet`                                          |
| TCP Blocked | Firewall dropping packets      | `iptables -A INPUT -p tcp --dport 12345 -j DROP`                               | `ss`, `iptables -L`, `telnet`, `tcpdump`         | `iptables -D INPUT -p tcp --dport 12345 -j DROP`                    |
| UDP Loss    | Packet drops / poor throughput | `iptables -A INPUT -p udp --dport 5201 -j DROP` or `tc qdisc add ... loss 30%` | `iperf3`, `iptables -L`, `tcpdump`, `traceroute` | `iptables -D INPUT -p udp --dport 5201 -j DROP`, `tc qdisc del ...` |

---

