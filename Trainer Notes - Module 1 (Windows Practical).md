# Trainer Notes | Module 1 (Windows Practical)

**Reference File:** `Practical Guide - Module 1.md`  
**Audience:** New Linux learners using Windows  
**Total Duration:** 60 to 90 minutes  
**Delivery Mode:** Instructor-led with live demo + learner follow-along

## Trainer Outcomes
By the end of this practical session, learners should be able to:
- Start Docker Desktop and run a Linux container sandbox.
- Verify Linux kernel and shell basics.
- Explain case sensitivity and Linux command feedback behavior.
- Generate SSH key pairs on Windows and identify private/public keys.

## Suggested Session Timeline
1. Orientation and setup expectations: 5 to 10 minutes
2. Pre-Lab Docker installation check: 10 to 15 minutes
3. Lab 1 Sandbox setup: 10 to 15 minutes
4. Lab 2 System fundamentals: 10 minutes
5. Lab 3 Server mindset drills: 10 to 15 minutes
6. Lab 4 SSH key generation: 10 to 15 minutes
7. Wrap-up and Q&A: 5 minutes

## Instructor Runbook

### 1. Orientation and Ground Rules (5 to 10 min)
Talking points:
- Learners are safe to make mistakes inside the Docker sandbox.
- Differentiate terminal contexts early:
- `PS C:\Users\...` means Windows PowerShell.
- `root@...:/#` means Linux container shell.
- Ask learners to run commands one-by-one, not in large pasted blocks.

Quick instructor check:
- Confirm everyone can open PowerShell or Windows Terminal.

### 2. Pre-Lab Docker Installation Check (10 to 15 min)
Learner action:
```bash
docker --version
```

Expected outcome:
- A version line appears, for example `Docker version 28.x.x`.

If learners fail here:
- Docker not installed or not started.
- Ask learner to open Docker Desktop and wait for whale icon to become steady.
- Restart terminal after Docker starts.

### 3. Lab 1 Sandbox Setup (10 to 15 min)
Learner action:
```bash
docker run -it --name ebright-practice ubuntu bash
```

Expected outcome:
- Prompt changes from Windows style to Linux style:
- From `PS C:\Users\...`
- To `root@<container-id>:/#`

Reinforcement prompt:
- Ask: "Are we in Windows or Linux now? How do you know?"

Common issue:
- `Conflict. The container name ... is already in use.`

Fix:
```bash
docker start -ai ebright-practice
```

### 4. Lab 2 System Fundamentals (10 min)
Learner action:
```bash
uname -sr
echo $SHELL
```

Expected outcome:
- `uname -sr` returns Linux kernel name/version.
- `echo $SHELL` returns `/bin/bash`.

Teaching cue:
- Kernel = engine that controls resources.
- Shell = interpreter that converts user commands into actions.

### 5. Lab 3 Server Mindset Drills (10 to 15 min)
Learner action:
```bash
touch ebright.txt
touch Ebright.txt
ls
mkdir backups
ls
```

Expected outcome:
- Both `ebright.txt` and `Ebright.txt` exist separately.
- `backups` directory appears.
- `mkdir backups` usually gives no success message.

Teaching cue:
- Linux is case-sensitive.
- Silence after a command often means success.

Intervention tip:
- If `mkdir: cannot create directory 'backups': File exists`, explain idempotency and proceed.

### 6. Lab 4 SSH Key Generation on Windows (10 to 15 min)
Important:
- Learners must open a new Windows PowerShell window for this step.
- Do not run inside Linux container shell.

Learner action:
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@ebright.edu.my"
cd $HOME\.ssh
dir
```

Expected outcome:
- Keypair files appear:
- `id_rsa` (private key)
- `id_rsa.pub` (public key)

Security emphasis:
- Never share `id_rsa`.
- `id_rsa.pub` is safe to upload to server.

### 7. Wrap-Up and Exit (5 min)
Learner action:
```bash
exit
docker start -ai ebright-practice
docker rm -f ebright-practice
```

Trainer note:
- Explain the difference between restart and remove.
- Restart keeps previous lab state.
- Remove deletes the sandbox completely.

## Live Monitoring Checklist for Trainer
- Learner can identify terminal context correctly.
- Learner sees Linux prompt after container launch.
- Learner can run and explain `uname -sr` and `echo $SHELL`.
- Learner confirms case-sensitive filename behavior.
- Learner successfully generates SSH keys and identifies both files.

## Fast Troubleshooting Card (Instructor Use)
1. Docker command not recognized
- Ensure Docker Desktop is installed and fully started.
- Reopen terminal.

2. WSL 2 requirement error
- Enable/install WSL 2.
- Reboot and reopen Docker Desktop.

3. Existing container name conflict
- Use `docker start -ai ebright-practice`.

4. SSH command not found
- Use latest Windows 10/11 with OpenSSH Client feature enabled.

5. Learner ran SSH keygen inside container
- Stop and rerun in Windows PowerShell.

## Optional Extension (If Time Allows)
- Show learners how to display public key content:
```bash
type $HOME\.ssh\id_rsa.pub
```
- Explain this is the value typically copied into server `authorized_keys`.
