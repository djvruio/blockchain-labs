#!/bin/bash
# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install git
yum update -y
yum install git -y
echo $(git --version)

# install nvm
echo "downloading nvm script installer"
if curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash; then
    source ~/.nvm/nvm.sh
    echo $(nvm --version)
else
    echo "something wrong with nvm"
fi

# install nodejs and npm
nvm install node
echo $(node -e "console.log('Running Node.js ' + process.version)")
npm install -g npm@latest
echo $(npm version)

# install solana
if sh -c "$(curl -sSfL https://release.solana.com/stable/install)"; then
    export PATH="/home/ec2-user/.local/share/solana/install/active_release/bin:$PATH"
    echo $(solana --version)
else
    echo "something wrong with solana"
fi

# install rust
if curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; then
    source $HOME/.cargo/env
    echo $(rustc --version)
else
    echo "something wrong with rust"
fi

# install yarn
npm i -g corepack
echo $(yarn --version)

# instalar cross para compilar
# cargo install cross
#  cross build --target aarch64-unknown-linux-gnu

# instalar docker
# sudo yum install docker
#sudo systemctl enable docker.service
#sudo systemctl start docker.service
#sudo systemctl status docker.service
#docker version
# https://docs.docker.com/engine/install/linux-postinstall/
# resize del EBS de la instancia de 8GB a 16GB

#compile glibc 2.27
# KONZO https://www.linuxquestions.org/questions/linux-newbie-8/how-do-i-configure-glibc-in-a-separate-build-folder-447521/