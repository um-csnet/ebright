# Trainer Notes | Module 2 (Windows Practical)

**Reference File:** `Practical Guide - Module 2.md`  
**Audience:** New Linux learners using Windows with prior completion of Module 1  
**Total Duration:** 60 to 75 minutes  
**Delivery Mode:** Instructor-led with live demo + learner follow-along

## Trainer Outcomes
By the end of this practical session, learners should be able to:
- Re-enter the Linux sandbox from Windows terminal correctly.
- Navigate key Linux filesystem paths (`/`, `/etc`, `/var/log`) and explain their purpose.
- Use built-in help (`man`, `--help`) to self-learn commands.
- Build Ebright departmental folders under `/opt/ebright_data`.
- Perform core file operations (`touch`, `cp`, `mv`, `ls -R`) confidently.
- Read logs, create a simple text file with Nano, and archive a folder with `tar`.
- Apply basic permission hardening using `groupadd`, `useradd`, `chmod`, and `chown`.
- Create a basic automation heartbeat with `crontab` and verify output.

## Suggested Session Timeline
1. Orientation and context reset: 5 minutes
2. Lab 0 Re-enter sandbox: 5 to 8 minutes
3. Lab 1 Filesystem navigation: 8 to 10 minutes
4. Lab 2 Help and identity: 8 minutes
5. Lab 3 Filesystem operations: 10 to 12 minutes
6. Lab 4 Content and archive tasks: 10 minutes
7. Lab 5 Users and permissions: 10 to 12 minutes
8. Lab 6 Productivity and scheduling: 8 to 10 minutes
9. Wrap-up and Q&A: 5 minutes

## Instructor Runbook

### 1. Orientation and Context Reset (5 min)
Talking points:
- This module builds administration discipline after Module 1 fundamentals.
- Learners must identify terminal context before typing commands.
- Commands in this module run inside Linux container prompt, not PowerShell.

Quick instructor check:
- Ask all learners to show prompt and explain whether they are in Windows or Linux.

### 2. Lab 0: Re-entering the Sandbox (5 to 8 min)
Learner action (Windows terminal):
```bash
docker start -ai ebright-practice
```

Expected outcome:
- Prompt changes to Linux container style (`root@...:/#`).

Quick verification:
```bash
pwd
```

Intervention tip:
- If container not found, verify Module 1 completion and recover with instructor-assisted setup.

### 3. Lab 1: Navigating the Filesystem (8 to 10 min)
Learner action:
```bash
cd /
ls
cd /etc
cd /var/log
pwd
```

Expected outcome:
- Learners can reach `/var/log` and identify directory roles.

Teaching cues:
- `/etc` is configuration-centric.
- `/var/log` holds service and system logs.

### 4. Lab 2: Help and Identity (8 min)
Learner action:
```bash
whoami
pwd
man ls
mkdir --help
```

Expected outcome:
- `whoami` shows `root` in default sandbox flow.
- Learner exits manual page with `q`.

Teaching cue:
- Build habit: use `man` and `--help` before searching online.

### 5. Lab 3: Filesystem Operations (10 to 12 min)
Learner action:
```bash
mkdir -p /opt/ebright_data/finance /opt/ebright_data/teachers /opt/ebright_data/hq_admin
touch /opt/ebright_data/finance/report_january.txt
ls -l /opt/ebright_data/finance
cp /opt/ebright_data/finance/report_january.txt /opt/ebright_data/teachers/
mv /opt/ebright_data/finance/report_january.txt /opt/ebright_data/finance/archive_january.txt
ls -R /opt/ebright_data
```

Expected outcome:
- Folder structure exists and files are placed correctly.
- Learners understand `cp` vs `mv` behavior.

### 6. Lab 4: Content Exploration and Archiving (10 min)
Learner action:
```bash
cat /etc/motd
tail -n 5 /var/log/alternatives.log
nano /opt/ebright_data/welcome.txt
tar -cvf finance_backup.tar /opt/ebright_data/finance
ls -lh finance_backup.tar
```

Expected outcome:
- Learner can edit and save file in Nano.
- Archive file is created in current working directory.

Nano reminder:
- Save: `Ctrl+O`, then `Enter`
- Exit: `Ctrl+X`

### 7. Lab 5: Security Logic (10 to 12 min)
Learner action:
```bash
groupadd finance
useradd -m sarah_admin
ls -ld /home/sarah_admin
chmod 770 /opt/ebright_data/finance
chown root:finance /opt/ebright_data/finance
ls -ld /opt/ebright_data/finance
id sarah_admin
```

Expected outcome:
- `finance` folder shows `drwxrwx---`.
- Group ownership is `finance`.

Teaching cue:
- Permission model should match data sensitivity, not convenience.

### 8. Lab 6: Productivity and Scheduling (8 to 10 min)
Learner action:
```bash
ls /etc | grep network
history > my_commands.txt
tail -n 5 my_commands.txt
crontab -e
```

Cron line to add:
```bash
* * * * * date >> /tmp/heartbeat.txt
```

Verification after 1 to 2 minutes:
```bash
tail -n 5 /tmp/heartbeat.txt
```

Expected outcome:
- New timestamps appear every minute.

### 9. Wrap-Up and Exit (5 min)
Learner action:
```bash
pwd
ls -R /opt/ebright_data
exit
```

Trainer note:
- Reinforce that structure, permissions, and repeatable checks are core admin habits.

## Live Monitoring Checklist for Trainer
- Learner can re-enter sandbox without confusion.
- Learner correctly identifies `/etc` and `/var/log` purposes.
- Learner demonstrates at least one `man` and one `--help` usage.
- `/opt/ebright_data` structure matches module objective.
- Learner can explain difference between `cp` and `mv`.
- Finance folder permission and ownership are configured correctly.
- Cron heartbeat file receives new timestamps.

## Fast Troubleshooting Card (Instructor Use)
1. `docker start -ai ebright-practice` fails
- Verify container exists: `docker ps -a` from Windows terminal.
- If missing, recreate using Module 1 setup.

2. `man` command not found
- Install manually in container if needed: `apt update && apt install -y man-db`.

3. `groupadd` or `useradd` already exists
- This is acceptable in repeat labs.
- Verify with `getent group finance` or `id sarah_admin`.

4. `chmod/chown` returns no visible output
- Remind learners this is usually success in Linux.
- Confirm with `ls -ld /opt/ebright_data/finance`.

5. `crontab -e` editor confusion
- Choose Nano when prompted.
- Re-open with `crontab -e` and re-check syntax.

6. Heartbeat file not updating
- Wait at least one full minute.
- Check cron entry exists: `crontab -l`.
- Verify file path `/tmp/heartbeat.txt`.

7. Learner executes Windows commands in Linux shell
- Pause and re-anchor terminal context before continuing.

## Optional Extension (If Time Allows)
- Ask learners to create a second protected folder (for example `hq_admin`) with stricter permissions and explain why.
- Ask learners to generate a simple evidence report:
```bash
{
  date
  id sarah_admin
  ls -ld /opt/ebright_data/finance
} > /opt/ebright_data/hq_admin/module2-evidence.txt
```
