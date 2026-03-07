# Trainer Notes | Module 3 (Operations Practical)

**Reference File:** `Practical Guide - Module 3.md`  
**Audience:** Beginner to intermediate learners who completed Modules 1 and 2  
**Total Duration:** 75 to 90 minutes  
**Delivery Mode:** Instructor-led with scenario-based live demo + guided operations drill

## Trainer Outcomes
By the end of this practical session, learners should be able to:
- Run a safe pre-change routine with snapshot/readiness documentation.
- Collect and interpret baseline server health signals (disk, memory, load, CPU/process pressure).
- Use logs to identify likely causes before applying fixes.
- Validate Nginx configuration safely before reload.
- Execute a Git-style deployment routine (`status` -> `pull` -> verify).
- Explain image-based deployment flow (build/push on developer side, pull/run on server side).
- Validate DNS and explain temporary resolver differences.
- Apply core UFW hardening while preserving SSH access.
- Schedule and cancel maintenance shutdown safely.
- Operate and verify the Module 3 Docker Compose mini-stack.

## Suggested Session Timeline
1. Orientation and safety briefing: 5 minutes
2. Lab 0 Pre-flight checks: 5 minutes
3. Lab 1 Snapshot discipline: 8 to 10 minutes
4. Lab 2 Diagnostics baseline: 10 to 12 minutes
5. Lab 3 Log investigation: 12 to 15 minutes
6. Lab 4 Nginx safe operations: 12 to 15 minutes
7. Lab 5 Deployment workflows (Git and image): 12 to 15 minutes
8. Labs 6 to 8 DNS, firewall, continuity drills: 20 to 25 minutes
9. Lab 9 Compose stack extra lab: 20 to 25 minutes (or assign as extension)
10. Wrap-up and incident recap: 5 minutes

## Instructor Runbook

### 1. Orientation and Safety Briefing (5 min)
Talking points:
- Module 3 simulates production thinking: evidence first, changes second.
- Keep one stable SSH session open during firewall actions.
- Never skip pre-change snapshot/readiness checklist.

Environment reminder:
- Full outcomes require Ubuntu VPS/VM with `systemd` support.
- Minimal containers may not support `systemctl`, `ufw`, or shutdown behavior.

### 2. Lab 0: Session Pre-Flight (5 min)
Learner action:
```bash
whoami
hostnamectl
pwd
sudo systemctl status nginx --no-pager
```

Expected outcome:
- Learners can state host identity and Nginx state (`active`, `inactive`, or `failed`).

### 3. Lab 1: Infrastructure Safety (8 to 10 min)
Learner action:
```bash
mkdir -p ~/ebright-ops
cat << 'EOF' > ~/ebright-ops/prechange-checklist.txt
Change Window: Module 3 Practical
Snapshot Status: CREATED (record snapshot ID from cloud console)
Service Baseline: nginx status captured
Rollback Owner: <name>
Post-Change Verification: portal page, nginx status, firewall status
EOF
cat ~/ebright-ops/prechange-checklist.txt
```

Expected outcome:
- Learner has a documented rollback-ready pre-change note.

Teaching cue:
- Documentation quality is part of operational quality.

### 4. Lab 2: Diagnostics Baseline (10 to 12 min)
Learner action:
```bash
df -h
free -m
uptime
top
```

Expected outcome:
- Learner identifies high-usage filesystem and top CPU process.
- Learner exits `top` with `q`.

### 5. Lab 3: Log Investigation (12 to 15 min)
Learner action:
```bash
sudo tail -n 30 /var/log/nginx/error.log
sudo grep -iE "error|fail|denied" /var/log/nginx/error.log | tail -n 20
sudo grep -i "failed" /var/log/auth.log | tail -n 20
```

Optional follow mode demo:
```bash
sudo tail -f /var/log/nginx/error.log
```

Expected outcome:
- Learner can cite one timestamped line that supports a diagnosis.

### 6. Lab 4: Nginx Safe Operations (12 to 15 min)
Learner action:
```bash
sudo apt update
sudo apt install -y nginx
sudo nginx -t
sudo systemctl reload nginx
sudo systemctl enable nginx
sudo systemctl status nginx --no-pager
```

Expected outcome:
- Config test passes before reload.
- Nginx is running and enabled.

Teaching cue:
- `nginx -t` is mandatory before service reloads in real operations.

### 7. Lab 5: Deployment Workflows (12 to 15 min)
Git pull flow (server concept):
```bash
sudo mkdir -p /var/www
sudo chown $USER:$USER /var/www
cd /var/www
git clone [URL] html
cd /var/www/html
git status
git log --oneline -n 5
git pull
sudo systemctl status nginx --no-pager
curl -I http://localhost
```

Image flow highlight (developer -> registry -> server):
```bash
cd asset/module3/deploy
docker build -t docker.io/ebright-training/module3-portal:latest .
docker login
docker push docker.io/ebright-training/module3-portal:latest
docker pull docker.io/ebright-training/module3-portal:latest
docker run -d --name ebright-portal -p 8888:80 docker.io/ebright-training/module3-portal:latest
curl -I http://localhost:8888
```

Expected outcome:
- Learner can explain why server-side image deployment does not require `git pull`.

### 8. Labs 6 to 8: DNS, Firewall, Continuity (20 to 25 min)
DNS checks:
```bash
dig portal.ebright.edu.my +short
nslookup portal.ebright.edu.my
```

Firewall sequence:
```bash
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo ufw status numbered
```

Continuity drill:
```bash
sudo shutdown -h +5 "Scheduled Maintenance - Module 3 Practical"
sudo shutdown -c
```

Expected outcome:
- SSH remains reachable.
- Learner can show allowed ports and default deny inbound policy.
- Learner confirms shutdown cancellation.

### 9. Lab 9: Compose Stack Extra Lab (20 to 25 min)
Learner action:
```bash
docker compose -f asset/module3/docker-compose.yml up -d
docker compose -f asset/module3/docker-compose.yml ps
curl -I http://localhost:8080
curl http://localhost:8080/healthz
docker compose -f asset/module3/docker-compose.yml logs nginx --tail=40
docker exec -it ebright-m3-postgres psql -U ebright -d ebright -c "SELECT now();"
docker exec -it ebright-m3-redis redis-cli ping
docker compose -f asset/module3/docker-compose.yml down
```

Expected outcome:
- Services start, endpoints respond, and db/cache probes succeed.

### 10. Wrap-Up and Incident Recap (5 min)
Mini incident recap steps:
```bash
df -h
free -m
uptime
sudo systemctl status nginx --no-pager
sudo tail -n 40 /var/log/nginx/error.log
sudo nginx -t
sudo systemctl reload nginx
curl -I http://localhost
```

Trainer note:
- Require learners to state one evidence-based hypothesis and one verification command.

## Live Monitoring Checklist for Trainer
- Learner completes pre-change checklist note before major changes.
- Learner can read and interpret at least one system baseline metric.
- Learner uses log evidence to guide actions.
- Learner tests Nginx config before reload.
- Learner explains safe deployment sequence and verification points.
- Learner applies UFW without losing SSH.
- Learner demonstrates shutdown schedule and cancellation.
- Learner validates Compose stack services and key endpoints.

## Fast Troubleshooting Card (Instructor Use)
1. `systemctl` reports no systemd
- Move learner to Ubuntu VM/VPS environment.

2. `ufw` or `dig` not found
- Install packages:
```bash
sudo apt update
sudo apt install -y ufw dnsutils
```

3. `git pull` blocked by local changes
- Use `git status` first.
- Resolve with team policy (commit/stash/reset strategy).

4. Nginx reload fails
- Run `sudo nginx -t` and fix reported file/line before retry.

5. Firewall change disrupts access
- Recover through cloud console, re-allow SSH (`ufw allow 22`), then review rules.

6. Compose stack starts but endpoint fails
- Check service states and logs:
```bash
docker compose -f asset/module3/docker-compose.yml ps
docker compose -f asset/module3/docker-compose.yml logs nginx --tail=80
```

7. Docker push denied
- Confirm registry login and image tag format matches account permissions.

## Optional Extension (If Time Allows)
- Ask learners to produce a timestamped operations report:
```bash
mkdir -p ~/ebright-ops/reports
{
  date
  echo "--- Disk ---"
  df -h
  echo "--- Memory ---"
  free -m
  echo "--- Load ---"
  uptime
  echo "--- Firewall ---"
  sudo ufw status
} > ~/ebright-ops/reports/module3-ops-$(date +%F-%H%M).txt
ls -lh ~/ebright-ops/reports
```
- Ask learners to explain what they would verify immediately after a rollback.
