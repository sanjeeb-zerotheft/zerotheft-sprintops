### Deployment Runbook

# EC2 Platform Deployment Runbook

## Prerequisites
- EC2 instance with Ubuntu 22.04+
- Docker 24.0+ & Docker Compose
- Ports: 80,443,3001-3004,6379,5672,15672,3322,9497,8080 open
- Domain: dev.zerotheft.com with Route 53 hosted zone

## Deployment Steps

### 1. Connect to EC2 Instance
```bash
ssh -i key.pem ubuntu@<EC2_IP>
```
### 2. Clone Repository
```bash
git clone https://github.com/safeskool-org/zerotheft
```
### 3. Start Docker Services
```bash
docker-compose -f docker-compose.prod.yaml up -d
```
### 4. Verify Containers Running
```bash
docker ps
```
### 5. Inject Environment Variables
#### Auth Service

#### Audit Service

#### Billing Service

#### Notification Service


### 6. Restart Services
```bash
docker-compose -f docker-compose.prod.yaml restart

### 7. Configure NGINX
```bash
sudo cp nginx/zerotheft-conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/zerotheft-conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```
### 8. Obtain SSL Certificates
```bash
sudo certbot --nginx -d auth.dev.zerotheft.com
sudo certbot --nginx -d audit.dev.zerotheft.com
sudo certbot --nginx -d notification.dev.zerotheft.com
sudo certbot --nginx -d billing.dev.zerotheft.com
sudo certbot --nginx -d keycloak.dev.zerotheft.com
```
### 9. Verify Deployment
```bash
curl -I https://auth.dev.zerotheft.com/health
curl -I https://audit.dev.zerotheft.com/health
curl -I https://notification.dev.zerotheft.com/health
curl -I https://billing.dev.zerotheft.com/health
curl -I https://keycloak.dev.zerotheft.com
```