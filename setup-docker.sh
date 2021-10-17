# OS requirements

# To install Docker Engine, you need the 64-bit version of one of these Ubuntu versions:

#     Ubuntu Hirsute 21.04
#     Ubuntu Focal 20.04 (LTS)
#     Ubuntu Bionic 18.04 (LTS)

# Docker Engine is supported on x86_64 (or amd64), armhf, arm64, and s390x architectures.

if [[ "$(whoami)" != "root" ]]; then
    echo "$0 is not running as root. Try using sudo."
    exit 1
fi

# remove old versions
apt-get remove docker docker-engine docker.io containerd runc

# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
apt-get update

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository.
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the apt package index, and install the latest version of Docker Engine and containerd,
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

# Install stable release of Docker Compose:
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the binary:
chmod +x /usr/local/bin/docker-compose