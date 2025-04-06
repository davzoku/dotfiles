#!/bin/bash
# curl -fsSL https://raw.githubusercontent.com/davzoku/dotfiles/main/android/termux_setup.sh | bash -s -- <repository-url>

# Check if a repository URL was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <repository-url>"
  exit 1
fi

REPO_URL="$1"
REPO_NAME=$(basename "$REPO_URL" .git)

pkg update -y && pkg upgrade -y

# Set up storage permissions
termux-setup-storage

pkg install -y git gh

git config --global user.name "davzoku"
git config --global user.email "walterteng.kw@gmail.com"

cd ~/storage/downloads || { echo "Downloads directory not found"; exit 1; }

mkdir -p notes && cd notes

# Clone the repository if it hasn't been cloned already
if [ ! -d "$REPO_NAME" ]; then
  git clone "$REPO_URL"
fi

# Mark the cloned repository as safe for Git operations
git config --global --add safe.directory "$HOME/storage/downloads/notes/$REPO_NAME"

# mkdir -p "$HOME/.shortcuts"

cat << EOF > "$HOME/.shortcuts/gitpull.sh"
#!/bin/bash
cd /data/data/com.termux/files/home/storage/downloads/notes/$REPO_NAME || { echo "Repository directory not found."; exit 1; }
echo "Discarding any local changes..."
git fetch --all
git reset --hard HEAD
git clean -fd
echo "Pulling latest updates..."
git pull
EOF