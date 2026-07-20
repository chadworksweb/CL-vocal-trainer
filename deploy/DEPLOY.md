# Deploy -- vt.chadlewine.com

CL Vocal Trainer is a standalone static PWA served at **vt.chadlewine.com** from a
small `nginx:alpine` container (`vt-static`) on the le-projects-01 droplet
(`138.197.111.66`), reverse-proxied by the shared `le-nginx`. Its own container,
its own deploy, independent of the chadlewine Next app.

```
visitor -> Cloudflare (proxied, Full strict) -> le-nginx (TLS, vt.chadlewine.conf)
        -> vt-static:80 (nginx:alpine serving /home/deploy/vocal-trainer/html)
```

## First-time setup

1. **DNS (Cloudflare):** add `vt` A record -> `138.197.111.66`, **Proxied** (orange).

2. **Container + files on the droplet:**
   ```
   ssh root@138.197.111.66
   install -d -o deploy -g deploy /home/deploy/vocal-trainer/html
   # place docker-compose.yml + nginx-default.conf in /home/deploy/vocal-trainer/
   # push app files into html/ (from local): bash deploy/deploy.sh
   cd /home/deploy/vocal-trainer && docker compose up -d
   ```

3. **le-nginx vhost (two-phase, so the reload never references a missing cert):**
   ```
   # phase A: install an 80-only version first (ACME + redirect), reload
   cp deploy/vt.chadlewine.conf /root/proxy/nginx/conf.d/   # 443 block temporarily removed
   docker exec le-nginx nginx -t && docker exec le-nginx nginx -s reload
   # issue the cert via the shared certbot webroot
   docker run --rm \
     -v rising-compass_certbot-certs:/etc/letsencrypt \
     -v rising-compass_certbot-webroot:/var/www/certbot \
     certbot/certbot certonly --webroot -w /var/www/certbot \
     --cert-name vt.chadlewine.com -d vt.chadlewine.com \
     --non-interactive --agree-tos -m chadlewine@gmail.com
   # phase B: install the full vhost (80 + 443), reload
   cp deploy/vt.chadlewine.conf /root/proxy/nginx/conf.d/
   docker exec le-nginx nginx -t && docker exec le-nginx nginx -s reload
   ```
   Cloudflare exempts `/.well-known/acme-challenge/` from Always Use HTTPS, so
   HTTP-01 validation works through the orange cloud. Keep Cloudflare SSL/TLS on
   **Full (strict)** (origin has a valid LE cert).

## Routine updates

`bash deploy/deploy.sh` -- scps the app files into the bind-mounted `html/`. nginx
serves from disk per request, so changes are live immediately, no restart.

## Files

- `docker-compose.yml` -- the vt-static container (bind-mounts `./html`, joins le-proxy).
- `nginx-default.conf` -- the container's server block (manifest MIME, sw.js no-cache).
- `vt.chadlewine.conf` -- the le-nginx vhost (TLS + proxy to vt-static).
- `deploy.sh` -- push app files to the droplet.
