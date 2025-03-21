# Git Push and Remote Pull Script 🚀

This script automates the process of pushing commits, then pulling them via SSH on a remote machine. It handles the following steps in sequence:

1. 📤 Pushes your current branch (or a specified branch) to the remote Git repository
2. 🔐 SSHs into your remote machine
3. 🔄 Performs a `git fetch` and `git reset --hard` to update the remote repository

**Note:** ⚠️ This script does not pull (even though it's called "gitpushremotepull" ), it only pushes and updates the remote repository. All changes on the remote machine are lost. Use with caution!

## 📋 Prerequisites

- 🛠️ Git installed and configured on both local and remote machines
- 📁 Existing Git repository with properly configured remotes on both local and remote directories
- 🔑 SSH access to the remote machine

**Note:** ⚠️ This script is designed for quick updates of existing repositories. It does not clone repositories or perform initial setup.

## 🔧 Setup

### 1. Configure your .env file 📝

Create a `.env` file in your git repository with the following content:

```
# SSH credentials
SSH_USER=your_username
SSH_HOST=your.remote.machine.com  # e.g., 192.168.1.100 or example.com
# The full path to the git repository on the remote machine
REMOTE_PATH=/path/to/git/repository
```

You can copy and edit the included `.env.example` file, but make sure to remove the `.example` extension and place it in the root of your git repository.

```bash
cp .env.example .env
# Then edit the .env file with your preferred text editor
```

**Note:** ⚠️ Make sure to add the `.env` file to your `.gitignore` to prevent accidentally committing sensitive credentials to your repository.

### 2. Make the script executable ✨

```bash
chmod +x gitpushremotepull.sh
```

## 🚀 Usage

### Using the local script:

```bash
./gitpushremotepull.sh [branch_name]
```

### Using the global command (after setting up the symbolic link):

```bash
gitpushremotepull [branch_name]
```

If you don't specify a branch name, the script will use your current branch.

## 🌎 OPTIONAL:Making it Available Globally on macOS

To use this script as a command from anywhere on your Mac:

### 1. Create a bin directory in your home folder (if it doesn't exist) 📂

```bash
mkdir -p ~/bin
```

### 2. Create a symbolic link to your script 🔗

```bash
ln -s "/full/path/to/gitpushremotepull.sh" ~/bin/gitpushremotepull
```

Replace `/full/path/to/gitpushremotepull.sh` with the absolute path to your script. If you're in the script's directory, you can use:

```bash
ln -s "$(pwd)/gitpushremotepull.sh" ~/bin/gitpushremotepull
```

### 3. Add ~/bin to your PATH (if not already there) 🛣️

For Zsh (default shell on newer macOS):

```bash
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

For Bash (older macOS versions):

```bash
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```
