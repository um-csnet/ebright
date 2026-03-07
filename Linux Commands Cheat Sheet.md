# Linux Commands Cheat Sheet

This cheat sheet consolidates commands used across Practical Modules 1 to 3.

## 1) Basic Navigation and Identity

| Command | What it does |
| --- | --- |
| `pwd` | Shows current directory |
| `cd /` | Goes to root directory |
| `cd /etc` | Goes to config directory |
| `cd /var/log` | Goes to log directory |
| `whoami` | Shows current user |
| `hostnamectl` | Shows host/system identity |
| `uname -sr` | Shows Linux kernel name and version |
| `echo $SHELL` | Shows current shell |
| `ls` | Lists files/folders |
| `ls -l` | Lists with details |
| `ls -ld <path>` | Shows directory metadata only |
| `ls -R <path>` | Recursive listing |
| `ls -lh <file>` | Human-readable file size listing |

## 2) Help and Learning Commands

| Command | What it does |
| --- | --- |
| `man ls` | Opens manual page for `ls` |
| `mkdir --help` | Shows quick help for `mkdir` |

## 3) Files and Directories

| Command | What it does |
| --- | --- |
| `mkdir backups` | Creates a directory |
| `mkdir -p /opt/ebright_data/finance /opt/ebright_data/teachers /opt/ebright_data/hq_admin` | Creates nested directories safely |
| `touch ebright.txt` | Creates empty file |
| `touch Ebright.txt` | Creates another file (case-sensitive) |
| `touch /opt/ebright_data/finance/report_january.txt` | Creates file in target folder |
| `cp <src> <dst>` | Copies files |
| `mv <src> <dst>` | Moves/renames files |
| `cat /etc/motd` | Prints file content |
| `tail -n 5 <file>` | Shows last 5 lines |
| `tail -n 30 <file>` | Shows last 30 lines |
| `tail -f <file>` | Follows file updates live |
| `nano <file>` | Opens Nano text editor |
| `tar -cvf finance_backup.tar /opt/ebright_data/finance` | Creates tar archive |
| `tree /opt/ebright_data` | Displays directory tree |
| `echo "Please follow access policy for finance data." >> /opt/ebright_data/welcome.txt` | Appends text to file |

## 4) Users, Groups, and Permissions

| Command | What it does |
| --- | --- |
| `groupadd finance` | Creates group |
| `useradd -m sarah_admin` | Creates user with home directory |
| `id sarah_admin` | Shows user/group identity |
| `chown root:finance /opt/ebright_data/finance` | Changes ownership |
| `chmod 770 /opt/ebright_data/finance` | Sets directory permissions |

## 5) Search, Pipes, and History

| Command | What it does |
| --- | --- |
| `ls /etc | grep network` | Filters output with grep |
| `history` | Shows command history |
| `history > my_commands.txt` | Saves history to file |
| `history | grep -E "chmod|chown|groupadd|useradd"` | Searches history with regex |
| `grep -iE "error|fail|denied" /var/log/nginx/error.log | tail -n 20` | Finds error patterns in logs |
| `grep -i "failed" /var/log/auth.log | tail -n 20` | Finds failed auth attempts |

## 6) Scheduling and Services

| Command | What it does |
| --- | --- |
| `crontab -e` | Edits user cron jobs |
| `crontab -l` | Lists user cron jobs |
| `* * * * * date >> /tmp/heartbeat.txt` | Cron line to append heartbeat every minute |
| `service cron start` | Starts cron service (container environments) |

## 7) System Health and Monitoring

| Command | What it does |
| --- | --- |
| `df -h` | Disk usage |
| `free -m` | Memory usage |
| `uptime` | System uptime and load |
| `top` | Real-time process monitor |

## 8) Time, Network, and DNS

| Command | What it does |
| --- | --- |
| `timedatectl set-timezone Asia/Kuala_Lumpur` | Sets timezone |
| `ip a` | Shows network interfaces/IPs |
| `ping -c 3 google.com` | Connectivity test |
| `nslookup google.com` | DNS lookup |
| `dig portal.ebright.edu.my +short` | Short DNS answer |
| `dig portal.ebright.edu.my` | Full DNS response |
| `nslookup portal.ebright.edu.my` | DNS lookup for training domain |

## 9) Nginx Operations

| Command | What it does |
| --- | --- |
| `sudo systemctl status nginx --no-pager` | Checks Nginx service status |
| `sudo apt update` | Updates package index |
| `sudo apt install -y nginx` | Installs Nginx |
| `sudo nginx -t` | Tests Nginx config syntax |
| `sudo systemctl reload nginx` | Reloads Nginx gracefully |
| `sudo systemctl enable nginx` | Enables Nginx on boot |
| `curl -I http://localhost` | Checks HTTP headers/availability |

## 10) Firewall (UFW)

| Command | What it does |
| --- | --- |
| `sudo ufw allow 22` | Allows SSH |
| `sudo ufw allow 80` | Allows HTTP |
| `sudo ufw allow 443` | Allows HTTPS |
| `sudo ufw default deny incoming` | Default deny inbound |
| `sudo ufw default allow outgoing` | Default allow outbound |
| `sudo ufw enable` | Enables firewall |
| `sudo ufw status numbered` | Shows numbered rules |
| `sudo ufw delete <rule-number>` | Deletes rule by number |

## 11) Safe Maintenance / Continuity

| Command | What it does |
| --- | --- |
| `sudo shutdown -h +5 "Scheduled Maintenance - Module 3 Practical"` | Schedules shutdown |
| `sudo shutdown -c` | Cancels scheduled shutdown |

## 12) SSH and Keys

| Command | What it does |
| --- | --- |
| `ssh-keygen -t rsa -b 4096 -C "your_email@ebright.edu.my"` | Generates SSH key pair |
| `cd $HOME\.ssh` | Goes to Windows SSH key folder |
| `dir` | Lists files in Windows terminal |
| `type $HOME\.ssh\id_rsa.pub` | Prints public key |
| `ssh trainee@localhost -p 2222` | SSH into training container |
| `mkdir -p ~/.ssh` | Creates SSH folder in Linux account |
| `chmod 700 ~/.ssh` | Secures `.ssh` folder |
| `nano ~/.ssh/authorized_keys` | Edits authorized keys |
| `chmod 600 ~/.ssh/authorized_keys` | Secures authorized keys file |
| `exit` | Exits current shell/session |

## 13) Git Workflow Commands

| Command | What it does |
| --- | --- |
| `git clone https://github.com/um-csnet/ebright.git` | Clones repository |
| `git clone [URL] html` | Clones deployment repo into `html` |
| `git status` | Shows working tree status |
| `git rev-parse --short HEAD` | Shows short commit hash |
| `git branch` | Lists branches |
| `git checkout -b feature/training-update` | Creates and switches branch |
| `git checkout main` | Switches to main branch |
| `git merge --no-ff feature/training-update` | Merges feature branch |
| `git log --oneline -n 5` | Shows recent commits |
| `git pull` | Pulls latest updates |

## 14) Docker and Docker Compose

| Command | What it does |
| --- | --- |
| `docker --version` | Checks Docker version |
| `docker compose version` | Checks Compose version |
| `docker run -it --name ebright-practice ubuntu bash` | Starts Linux sandbox container |
| `docker start -ai ebright-practice` | Re-enters existing sandbox |
| `docker rm -f ebright-practice` | Force-removes container |
| `docker compose -f asset/module1/docker-compose.yml up -d --build` | Builds and starts Module 1 service |
| `docker compose -f asset/module1/docker-compose.yml ps` | Checks Module 1 service status |
| `docker compose -f asset/module1/docker-compose.yml stop` | Stops Module 1 service |
| `docker compose -f asset/module1/docker-compose.yml start` | Starts Module 1 service |
| `docker compose -f asset/module1/docker-compose.yml down` | Removes Module 1 resources |
| `docker compose -f asset/module3/docker-compose.yml up -d` | Starts Module 3 stack |
| `docker compose -f asset/module3/docker-compose.yml ps` | Checks Module 3 stack status |
| `docker compose -f asset/module3/docker-compose.yml logs nginx --tail=40` | Nginx logs in Module 3 stack |
| `docker compose -f asset/module3/docker-compose.yml logs db --tail=40` | DB logs in Module 3 stack |
| `docker compose -f asset/module3/docker-compose.yml logs cache --tail=40` | Cache logs in Module 3 stack |
| `docker compose -f asset/module3/docker-compose.yml --profile tools up -d` | Starts optional toolbox profile |
| `docker compose -f asset/module3/docker-compose.yml restart nginx` | Restarts nginx service in stack |
| `docker compose -f asset/module3/docker-compose.yml down` | Stops and removes Module 3 stack |
| `docker compose -f asset/module3/docker-compose.yml down -v` | Removes stack and volumes |
| `docker exec -it ebright-m3-postgres psql -U ebright -d ebright -c "SELECT now();"` | Runs PostgreSQL test query |
| `docker exec -it ebright-m3-redis redis-cli ping` | Tests Redis connectivity |
| `docker exec -it ebright-m3-toolbox sh -c "dig nginx +short; nc -zv db 5432; nc -zv cache 6379"` | Internal DNS and port checks |

## 15) Docker Image Deployment Flow (Module 3)

| Command | What it does |
| --- | --- |
| `cd asset/module3/deploy` | Goes to image build context |
| `docker build -t docker.io/ebright-training/module3-portal:latest .` | Builds deployment image |
| `docker images | grep module3-portal` | Verifies built image |
| `docker login` | Authenticates to registry |
| `docker push docker.io/ebright-training/module3-portal:latest` | Pushes image to registry |
| `docker pull docker.io/ebright-training/module3-portal:latest` | Pulls image on deployment side |
| `docker run -d --name ebright-portal -p 8888:80 docker.io/ebright-training/module3-portal:latest` | Runs portal container |
| `docker ps | grep ebright-portal` | Verifies running container |
| `curl -I http://localhost:8888` | Verifies container endpoint |
| `curl http://localhost:8888 | head -n 5` | Reads first lines of response |
| `docker save -o module3-portal-latest.tar docker.io/ebright-training/module3-portal:latest` | Exports image to tar |
| `scp module3-portal-latest.tar user@SERVER_IP:/tmp/` | Transfers image tar to server |
| `docker load -i /tmp/module3-portal-latest.tar` | Imports image tar on server |
| `docker stop ebright-portal` | Stops portal container |
| `docker rm ebright-portal` | Removes portal container |

## 16) Setup and Recovery Utilities Used in Troubleshooting

| Command | What it does |
| --- | --- |
| `wsl --update` | Updates WSL on Windows |
| `apt update && apt install tree -y` | Installs `tree` |
| `apt update && apt install man-db -y` | Installs manual pages |
| `apt update && apt install dnsutils -y` | Installs DNS tools |
| `apt update && apt install cron -y` | Installs cron |
| `sudo apt install -y nginx git ufw dnsutils` | Installs server tooling for Module 3 |

## Quick Safety Notes

- Run Linux commands in Linux prompt (`root@...:/#`) and Windows commands in PowerShell (`PS C:\Users\...`).
- Run one command at a time and verify output before moving on.
- For service changes, use safe sequence: baseline check -> config test -> reload -> verification.
- For firewall changes, allow SSH (`22`) before enabling UFW.
