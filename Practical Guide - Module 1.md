# Practical Guide | Module 1: Introduction, Fundamentals & Remote Access (Windows Edition)

**Objective:** To install Docker, establish a safe practice environment (The Sandbox), and configure secure, key-based access to the Ebright infrastructure.

**Target Audience:** First-time learners with little or no Linux experience.

**Estimated Time:** 60 to 90 minutes.

## Before You Start (Beginner Checklist)
Use this checklist before running any command.

- You are using Windows 10/11 with administrator access.
- You have a stable internet connection.
- You can open PowerShell or Windows Terminal.
- Virtualization is enabled in BIOS/UEFI (required by Docker Desktop).
- You have at least 8 GB RAM recommended for smoother Docker usage.

If virtualization is disabled, Docker may fail to start.

## How to Use This Guide
- Copy one command at a time.
- Press Enter after each command.
- Read the Verification or Expected result before moving on.
- If your output is different, check the Troubleshooting section at the end.

Command format in this guide:
- Commands shown in code blocks are typed exactly as-is.
- Do not type the `$` symbol (we do not use it here).
- Linux commands must be run inside the Docker Linux prompt.
- Windows commands must be run in PowerShell/Terminal on Windows.

## Pre-Lab: Installing Docker Desktop from the Internet
Before we can start the training, we must install the Docker "Engine" on your Windows computer.

### Step 1: Download the Installer
1. Open your web browser and go to `https://www.docker.com/products/docker-desktop`.
2. Click the large button labeled **Download for Windows**.
3. Save the `.exe` file to your Downloads folder.

### Step 2: Run the Installation
1. Double-click the downloaded `Docker Desktop Installer.exe`.
2. When prompted, ensure the option **Use WSL 2 instead of Hyper-V** is checked (this is much faster and more modern).
3. Follow the remaining on-screen instructions.
4. Once installation is complete, click **Close and restart** (your computer will need to reboot).

### Step 3: First Launch
1. After your computer restarts, search for **Docker Desktop** in the Start Menu and open it.
2. Accept the Docker Subscription Service Agreement.
3. Wait for the engine to start (the whale icon in the bottom-right corner will stop moving).

Quick check in PowerShell:

```bash
docker --version
```

**Expected result:** You should see a Docker version number, for example `Docker version 28.x.x`.

## Lab 1: The Sandbox Setup (Docker on Windows)
Before touching Ebright's live servers, we use Docker to create a disposable Linux environment on your computer where mistakes carry no risk.

### Task 1.1: Preparing Docker
1. Look at your System Tray (bottom-right icons near the clock).
2. Ensure the Docker whale icon is visible and not animated (indicating it is running).
3. If it is not running, search for **Docker Desktop** in the Start Menu and launch it.

### Task 1.2: Launching the Linux Environment
1. Right-click the Start button and select **Windows PowerShell** or **Terminal**.
2. Type the following command exactly and press Enter:

```bash
docker run -it --name ebright-practice ubuntu bash
```

**Verification:** Your command prompt should change from `PS C:\Users\...` to something like `root@a1b2c3d4e5f6:/#`.

**Note:** You are now successfully inside a Linux server.

If Docker asks to pull the image, wait until it completes. This is normal for first run.

Checkpoint:
- You can type `pwd` and get a Linux-style path like `/`.

## Lab 2: Verifying System Fundamentals
Inside your new Linux window, confirm the Engine (Kernel) and the Translator (Shell) you are using.

### Task 2.1: Identify the Kernel
Type this command inside the Linux prompt:

```bash
uname -sr
```

**What this is:** This shows you the core version of the Linux operating system.

### Task 2.2: Identify the Shell
Type this command to see which language the terminal is speaking:

```bash
echo $SHELL
```

**Expected result:** `/bin/bash` (the most popular shell for administrators).

Checkpoint:
- If `uname -sr` returns something like `Linux 6.x.x`, kernel check is successful.
- If `echo $SHELL` returns `/bin/bash`, shell check is successful.

## Lab 3: The Server Mindset Drills
Practice the core Linux rules that differ from Windows.

### Task 3.1: Case Sensitivity Test
In Windows, `MyFile` and `myfile` are the same. In Linux, they are different.

Create two different files:

```bash
touch ebright.txt
touch Ebright.txt
```

List them to verify:

```bash
ls
```

**Observation:** You will see both files listed separately.

### Task 3.2: The No Feedback Rule
Create a folder for backups:

```bash
mkdir backups
```

**Observation:** Notice the terminal just moves to a new line. In Linux, no news is good news. If the command did not show an error, it worked.

Checkpoint:
- Run `ls` again and confirm you can see `backups`, `ebright.txt`, and `Ebright.txt`.

## Lab 4: Remote Access (SSH Key Generation)
Establish secure, password-less entry into the Ebright VPS. Do this on your Windows machine, not inside the Linux container.

### Task 4.1: Generating Your Keys in Windows
1. Open a new PowerShell window (do not use the one where Linux is running).
2. Type the following command:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@ebright.edu.my"
```

3. When asked where to save the key, press Enter to accept the default location.
4. When asked for a passphrase, leave it blank for convenience or enter one for maximum security.

### Task 4.2: Identifying Your Keys
Navigate to your SSH directory (Windows):
- `C:\Users\YourName\.ssh\`

Identify the two files:
- `id_rsa`: Private key. Never share this. It is your physical key.
- `id_rsa.pub`: Public key. This is the lock we will place on the Ebright server.

Useful Windows commands to verify:

```bash
cd $HOME\.ssh
dir
```

Checkpoint:
- You can see both `id_rsa` and `id_rsa.pub` in the file list.

## Lab Summary and Cleanup
- To exit the Sandbox: `exit`
- To restart the Sandbox later: `docker start -ai ebright-practice`
- To remove the Sandbox entirely: `docker rm -f ebright-practice`

## Troubleshooting (Common Beginner Issues)
1. `docker: command not found` in PowerShell.
- Cause: Docker Desktop is not installed correctly or terminal was opened before installation finished.
- Fix: Close terminal, reopen PowerShell, run `docker --version` again.

2. Docker Desktop says WSL 2 is required.
- Cause: WSL is not enabled.
- Fix: Install/enable WSL 2, restart Windows, then reopen Docker Desktop.

3. `docker run` fails because container name already exists.
- Cause: `ebright-practice` already exists from previous run.
- Fix: Use `docker start -ai ebright-practice` instead, or remove old container with `docker rm -f ebright-practice`.

4. `Permission denied (publickey)` during future SSH login.
- Cause: Wrong public key on server or wrong private key used locally.
- Fix: Recheck your `id_rsa.pub` content and ensure it was added to the server user's `authorized_keys`.

5. Confusion between Windows and Linux terminals.
- Rule: If your prompt starts with `root@...:/#`, you are in Linux container.
- Rule: If your prompt starts with `PS C:\Users\...`, you are in Windows PowerShell.

## Completion Checklist
- Docker Desktop installed and running.
- Linux sandbox created successfully.
- Kernel and shell verified.
- Case sensitivity and no-feedback rules practiced.
- SSH key pair generated and identified.
