# Full Node BSC

## goal

spins up a geth full node for binance smart chain using teraform and ansible

### requirements

env vars:

```bash
export TF_VAR_AWS_ACCESS_KEY=""
export TF_VAR_AWS_SECRET_KEY=""
export TF_VAR_SSH_PASSWORD=""  # to be used on logins without ssh keypair
export TF_VAR_REGION=""
```

- aws-cli
- terraform
- ansible
- jq (for parsing json)

ssh keys (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`)

### setup

get an ip address alocated and append to ansible hosts, export the address to env

```bash
aws ec2 allocate-address > /etc/allocated-address
export BSC_NODE_IP=$(cat /etc/allocated-address | jq -r ".PublicIp")
export TF_VAR_ALLOCATION_ID=$(cat /etc/allocated-address | jq -r ".AllocationId")
echo $BSC_NODE_IP >> /etc/ansible/hosts
```

in case one would prefer to maintain the same address, the setting of the `BSC_NODE_IP`
and `TF_VAR_ALLOCATION_ID` variables can be appended to ~/.profile or ~/.bashrc

### usage

start the instance

```bash
terraform init && terraform apply
ssh -i ~/.ssh/id_rsa ubuntu@$BSC_NODE_IP
```

```bash
git clone https://github.com/ethereum/go-ethereum
```
