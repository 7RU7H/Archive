# Nginx


, don't forget to check `.bak` or `.backup`

## Hardening

[Change the NGINX user](https://fedingo.com/how-to-change-nginx-user/)
```bash
sudo vim /etc/nginx/nginx.conf
# Change the user to www-data from root/ubuntu
user root; 
# restart the NGINX Server
sudo service nginx restart
# OR
sudo systemctl restart nginx
```

## References

[Change the NGINX user](https://fedingo.com/how-to-change-nginx-user/)