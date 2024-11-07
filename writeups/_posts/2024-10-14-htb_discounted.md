---
layout: post
---

![](/assets/imgs/2024-10-14-htb-discounted-title-card.png)

## Background

Discounted is a very easy difficulty linux box that demonstrates flaws with HTTP requests. It requires a solid understanding of intercepting and manipulating POST requests using tools like Burp Suite. Overall it was a fairly simple box for me since I spent a lot of time learning how to use Burp while studying for the CBBH exam.

## Enumeration

nmap:

```bash
┌──(bonta㉿lor)-[~]
└─$ nmap -sC -sV -p- --min-rate 10000 10.129.228.190
Starting Nmap 7.94SVN ( https://nmap.org ) at 2024-10-14 00:09 EDT
Nmap scan report for 10.129.228.190
Host is up (0.064s latency).
Not shown: 65533 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.4p1 Debian 5+deb11u1 (protocol 2.0)
| ssh-hostkey: 
|   3072 57:69:ed:8e:f3:bd:5d:2c:c4:5c:90:6d:4a:42:a0:4b (RSA)
|   256 a6:ed:2d:0d:3d:55:41:89:bd:ae:9c:50:6e:13:0a:f6 (ECDSA)
|_  256 f0:e1:87:6c:d8:21:ca:ca:f2:e1:0b:fc:0d:cf:3b:62 (ED25519)
80/tcp open  http    nginx 1.18.0
| http-cookie-flags: 
|   /: 
|     PHPSESSID: 
|_      httponly flag not set
|_http-title: BeautyStylers
|_http-server-header: nginx/1.18.0
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 15.79 seconds
```

I visit the http website and see there is a clear task to obtain the flag.

![](/assets/imgs/2024-10-14-htb-discounted-image-1.png)

After adding Face Powder to my cart I visit the cart page and notice I can use the discount code *BEAUTYFRIDAY* from the home page for 20% off.

![](/assets/imgs/2024-10-14-htb-discounted-image-2.png)

I open up burp and start intercepting any requests the cart page sends.

After some digging I find that adding or removing the quantity of items in my cart sends a post request and inside is some unusual data called *recalc_discount*.

![](/assets/imgs/2024-10-14-htb-discounted-image-3.png)

I assume the value of 1 means enabled so I change it to a 0 and send the request.

Sure enough the discount is not recalculated when the value is 0.

![](/assets/imgs/2024-10-14-htb-discounted-image-4.png)

## Exploitation

With this information I am able to exploit the discount by calculating how many items I need for the discount to = the cost of 1 item.

With 5 items in my cart, the discount = $20.00 and I can intercept the post request to disable the *recalc_discount* data.

![](/assets/imgs/2024-10-14-htb-discounted-image-5.png)

![](/assets/imgs/2024-10-14-htb-discounted-image-6.png)

After removing 4 items I am presented with a total cost of $0.00, and after checking out I obtain the flag.

![](/assets/imgs/2024-10-14-htb-discounted-image-7.png)

![](/assets/imgs/2024-10-14-htb-discounted-image-8.png)

pce,\
bonta
