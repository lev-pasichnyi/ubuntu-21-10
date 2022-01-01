#!/bin/bash
# This script will bootstrap Ubuntu with DevOps related tools

##################################################################################
# Specify software versions by passing values to the named parameters below, e.g.:
# ./bootstrap-ubuntu-devops.sh --terraform 1.0.9

terraform=${terraform:-1.0.10}
terragrunt=${terragrunt:-0.35.8}
packer=${packer:-1.7.8}
vault=${vault:-1.8.5}

while [ $# -gt 0 ]; do
  if [[ $1 == *"--"* ]]; then
    param="${1/--/}"
    declare $param="$2"
    # echo $1 $2 // Optional to see the parameter:value result
  fi
  shift
done
##################################################################################

echo " Installing curl git "
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt -y update
sudo apt -y install curl git

echo " Installing powershell "
wget https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/powershell-lts_7.2.1-1.deb_amd64.deb
sudo dpkg -i powershell-lts_7.2.1-1.deb_amd64.deb
sudo apt-get install -f

echo "Installing Node.js 16..."
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

echo "Installing Java 11..."
sudo apt install openjdk-11-jdk -y

echo "Installing Ansible..."
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt -y update
sudo apt -y install ansible

echo "Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -f awscliv2.zip
rm -rf ./aws

echo "Installing kubectl..."
sudo apt update && sudo apt install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
if grep -Fxq "deb https://apt.kubernetes.io/ kubernetes-xenial main" /etc/apt/sources.list.d/kubernetes.list
then
  echo "Not adding kubectl repo because it is already present"
else
  echo "Adding kubectl repo..."
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
fi
sudo apt update -y
sudo apt install -y kubectl

echo "Installing the latest Helm..."
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm ./get_helm.sh

echo "Installing Terraform ${terraform}..."
curl -o terraform.zip https://releases.hashicorp.com/terraform/${terraform}/terraform_${terraform}_linux_amd64.zip
unzip terraform.zip
sudo mv terraform /usr/local/bin/terraform
rm terraform.zip

echo "Installing Packer ${packer}..."
curl -o packer.zip https://releases.hashicorp.com/packer/${packer}/packer_${packer}_linux_amd64.zip
unzip packer.zip
sudo mv packer /usr/local/bin/packer
rm packer.zip

echo "Installing Terragrunt..."
curl -o terragrunt -L https://github.com/gruntwork-io/terragrunt/releases/download/v${terragrunt}/terragrunt_linux_amd64
sudo mv terragrunt /usr/local/bin/terragrunt

echo "Installing Vault ${vault}..."
curl -o vault.zip https://releases.hashicorp.com/vault/${vault}/vault_${vault}_linux_amd64.zip
unzip vault.zip
sudo mv vault /usr/local/bin/vault
rm vault.zip

echo "Installing Postman..."
sudo snap install postman

echo "Cleaning up after bootstrapping..."
sudo apt -y autoremove
sudo apt -y clean
