# KASM Workspaces


[Standalone KASM Docker containers - Docker](https://hub.docker.com/u/kasmweb) 



Helpful Video [Kasm Workspaces - Installation](https://www.youtube.com/watch?v=BYJ0M04cD18)
1. Installation: https://kasmweb.com/docs/latest/install.html
```bash
cd /tmp
curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.15.0.06fdc8.tar.gz
tar -xf kasm_release_1.15.0.06fdc8.tar.gz
sudo bash kasm_release/install.sh
# Specify a specific port:
sudo bash kasm_release/install.sh -L 8443
```
2. Replacement certificate: https://kasmweb.com/docs/latest/how_to/certificates.html

3. Change the default Administrator Password

4. Administrator Configuration

https://kasmweb.com/docs/latest/admin_guide.html



[Uninstall](https://www.kasmweb.com/docs/latest/install/uninstall.html) as root
```bash
/opt/kasm/current/bin/stop
docker rm -f $(sudo docker container ls -qa --filter="label=kasm.kasmid")
export KASM_UID=$(id kasm -u)
export KASM_GID=$(id kasm -g)
docker compose -f /opt/kasm/current/docker/docker-compose.yaml rm
docker network rm kasm_default_network
docker volume rm kasm_db_1.15.0
docker rmi redis:5-alpine
docker rmi postgres:9.5-alpine
docker rmi kasmweb/nginx:latest
docker rmi kasmweb/share:1.15.0
docker rmi kasmweb/agent:1.15.0
docker rmi kasmweb/manager:1.15.0
docker rmi kasmweb/api:1.15.0
rm -rf /opt/kasm/
deluser kasm_db
deluser kasm
```
## References

[Kasm Workspaces - Installation](https://www.youtube.com/watch?v=BYJ0M04cD18)
[Kasm Installation Documentation](https://kasmweb.com/docs/latest/install.html)
[Kasm Replacement certificate Documentation](https://kasmweb.com/docs/latest/how_to/certificates.html)
[Uninstall](https://www.kasmweb.com/docs/latest/install/uninstall.html) 
[Standalone KASM Docker containers - Docker](https://hub.docker.com/u/kasmweb) 