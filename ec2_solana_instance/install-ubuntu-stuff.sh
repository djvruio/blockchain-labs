#!/bin/bash
# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

#install updates and essential packages
apt-get update -y
apt-get install -y pkg-config
apt-get install -y build-essential
apt-get install -y libudev-dev libssl-dev
apt-get install -y libssl-dev

# install git
echo "Installing git"
apt-get install git-all -y
echo $(git --version)

# install nvm
echo "Downloading nvm script installer"
if curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash; then
    source ~/.nvm/nvm.sh
    echo $(nvm --version)
else
    echo "Something wrong with nvm"
fi

# install nodejs and npm
nvm install node
echo $(node -e "console.log('Running Node.js ' + process.version)")
echo $(npm version)

# install solana
if sh -c "$(curl -sSfL https://release.solana.com/stable/install)"; then
    source ~/.profile
    echo $(solana --version)
else
    echo "Something wrong with solana"
fi

# install rust
if curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; then
    source $HOME/.cargo/env
    echo $(rustc --version)
else
    echo "Something wrong with Rust"
fi

# install npm and yarn
npm i -g corepack
echo $(yarn --version)

# cloning hello world solana
git clone https://github.com/solana-labs/example-helloworld.git

# Notes: for modify code
# sudo chown -R ubuntu example-helloworld/
# sudo chown -R root example-helloworld/
# https://www.youtube.com/watch?v=DwdRm18NaC8
# https://dev.to/turupawn/tu-primer-programa-en-solana-b19