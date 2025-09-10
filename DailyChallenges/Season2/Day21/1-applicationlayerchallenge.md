---

# **Application Layer Lab – 3 Scenarios**

## **Lab Setup (Prerequisites)**

On your VM:

```bash
# Update packages
sudo apt update

# Install Nginx
sudo apt install nginx -y

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Install curl and net-tools for troubleshooting
sudo apt install curl net-tools telnet -y

# Optional: Install nano for editing
sudo apt install nano -y
```

Create a simple HTML page:

```bash
echo "<html><body><h1>Home Page</h1></body></html>" | sudo tee /var/www/html/index.html
```

Test:

```bash
curl http://localhost
```

Expected: `<html><body><h1>Home Page</h1></body></html>`

---

# **Scenario 1 – API returns HTML instead of JSON**

**Story:**
Users report that `http://localhost/api` should return JSON but returns HTML.

### **Break the app**

```bash
vi /etc/nginx/conf.d/bad-api.conf
paste the below
server {
    listen 80;
    server_name localhost;

    location /api {
        default_type text/html;
        return 200 "<html>Not JSON</html>";
    }
}
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl reload nginx

```

Check:

```bash
curl -i http://localhost/api
```

Output: HTML instead of JSON

### **Troubleshooting**

* Check Nginx config:

```bash
sudo nginx -t
cat /etc/nginx/conf.d/bad-api.conf
```

* Check logs:

```bash
sudo tail -n 10 /var/log/nginx/error.log
sudo tail -n 10 /var/log/nginx/access.log
```

### **Fix**

```bash
sudo nano /etc/nginx/conf.d/bad-api.conf
```

Update:

```
location /api {
    default_type application/json;
    return 200 '{"status":"ok"}';
}
```

Reload Nginx:

```bash
sudo systemctl reload nginx
```

Test:

```bash
curl http://localhost/api
```

Expected output: `{"status":"ok"}` ✅

---

# **Scenario 2 – Nginx port blocked (cannot access web page)**

**Story:**
Users report that `http://localhost` is not reachable. Ping works, but HTTP fails.

### **Break the app**

Stop Nginx (simulate service down):

```bash
sudo systemctl stop nginx
```

Test:

```bash
curl http://localhost
```

Output: `Failed to connect`

### **Troubleshooting**

* Check if Nginx is running:

```bash
sudo systemctl status nginx
```

* Check listening ports:

```bash
sudo ss -tlnp | grep nginx
```

* Test connectivity via telnet:

```bash
telnet localhost 80
```

If telnet fails → service down

### **Fix**

Restart Nginx:

```bash
sudo systemctl start nginx
```

Check:

```bash
curl http://localhost
```

Expected: `<html><body><h1>Home Page</h1></body></html>` ✅

---

# **Scenario 3 – Wrong HTTP method (POST not allowed)**

**Story:**
A script sends `POST` to `/submit`, but Nginx returns 405 Method Not Allowed.

### **Break the app**

```bash
# Create /submit endpoint without POST
vi /etc/nginx/conf.d/api.conf
paste below content
server {
    listen 80;
    server_name localhost;

    location /api {
        default_type application/json;
        return 200 '{"status":"ok"}';
    }

    location /submit {
        if ($request_method !~ ^(GET)$ ) {
            return 405 "Method Not Allowed";
        }
        return 200 "GET only";
    }
}

sudo systemctl reload nginx
```

Test:

```bash
curl -X POST http://localhost/submit -i
```

Output: `405 Method Not Allowed`

### **Troubleshooting**

* Check Nginx config:

```bash
cat /etc/nginx/conf.d/api.conf
```

* Check logs:

```bash
sudo tail -n 10 /var/log/nginx/error.log
```

* Test GET method:

```bash
curl http://localhost/submit
```

If GET works → method restriction problem

### **Fix**

Allow POST in config:

```bash
sudo nano /etc/nginx/conf.d/submit.conf
```

Update:

```
location /submit {
    if ($request_method !~ ^(GET|POST)$ ) {
        return 405;
    }
    return 200 "POST and GET allowed";
}
```

Reload Nginx:

```bash
sudo systemctl reload nginx
```

Test:

```bash
curl -X POST http://localhost/submit
```

Output: `POST and GET allowed` ✅

---

# **Summary Table**

| Scenario                              | Break Command                        | Troubleshooting Tools                    | Fix Command                                          |
| ------------------------------------- | ------------------------------------ | ---------------------------------------- | ---------------------------------------------------- |
| API returns HTML instead of JSON      | `tee /etc/nginx/conf.d/bad-api.conf` | `nginx -t`, `curl -i`, logs              | Update `default_type application/json`, reload Nginx |
| Web page not reachable (port blocked) | `systemctl stop nginx`               | `systemctl status`, `ss -tlnp`, `telnet` | `systemctl start nginx`                              |
| Wrong HTTP method                     | `tee /etc/nginx/conf.d/submit.conf`  | `curl -X POST`, logs, check config       | Allow POST in Nginx config, reload                   |

---
