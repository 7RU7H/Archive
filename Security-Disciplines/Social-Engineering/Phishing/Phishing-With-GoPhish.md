# Phishing With GoPhish

## Make a Sending Profile

## Landing Page - Looks like the below:
<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <title>ACME IT SUPPORT - Admin Panel</title>  
    <style>        body { font-family: "Ubuntu", monospace; text-align: center }  
        div.login-form { margin:auto; width:300px; border:1px solid #ececec; padding:10px;text-align: left;font-size:13px;}  
        div.login-form div input { margin-bottom:7px;}  
        div.login-form input { width:280px;}  
        div.login-form div:last-child { text-align: center; }  
        div.login-form div:last-child input { width:100px;}  
    </style>  
</head>  
<body>  
    <h2>ACME IT SUPPORT</h2>  
    <h3>Admin Panel</h3>  
    <form method="post">  
        <div class="login-form">  
            <div>Username:</div>  
            <div><input name="username"></div>  
            <div>Password:</div>  
            <div><input type="password" name="password"></div>  
            <div><input type="submit" value="Login"></div>  
        </div>    </form></body>  
</html>

```html
<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <title>ACME IT SUPPORT - Admin Panel</title>  
    <style>        body { font-family: "Ubuntu", monospace; text-align: center }  
        div.login-form { margin:auto; width:300px; border:1px solid #ececec; padding:10px;text-align: left;font-size:13px;}  
        div.login-form div input { margin-bottom:7px;}  
        div.login-form input { width:280px;}  
        div.login-form div:last-child { text-align: center; }  
        div.login-form div:last-child input { width:100px;}  
    </style>  
</head>  
<body>  
    <h2>ACME IT SUPPORT</h2>  
    <h3>Admin Panel</h3>  
    <form method="post">  
        <div class="login-form">  
            <div>Username:</div>  
            <div><input name="username"></div>  
            <div>Password:</div>  
            <div><input type="password" name="password"></div>  
            <div><input type="submit" value="Login"></div>  
        </div>    </form></body>  
</html>
```

Making sure you click for:
- Capture Submitted Data
- Capture Passwords

## Email Templates 

`Temaplate -> Click Source (if required to insert HTML) -> Click Link Button -> Choose a Display text, Protocol (to other) and set the URL:`  the url must be: `{{.URL}}` so that it is actual sends the reader to the spoof landing page.

## Users and Groups

Insert all the data from some tool like [[theHarvester]] or [[Recon-ng]]

## Campaign
Start new campaign with templating and URL set to controlled domain or IP, enjoy the results

## References

[THM Red Team Phishing Room](https://tryhackme.com/room/phishingyl)