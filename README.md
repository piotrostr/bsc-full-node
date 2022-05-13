# Help Ethereum be more secure and decentralized and set up a light node in 5 minutes

## requirements

Environment variables:

- `TF_VAR_AWS_ACCESS_KEY`
- `TF_VAR_AWS_SECRET_KEY`
- `TF_VAR_SSH_PASSWORD`
- `TF_VAR_REGION`

Dependencies:

- aws-cli
- terraform
- ansible
- jq (for parsing json)
- ssh keys (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`)

## usage

- Get an ip address alocated and append to ansible hosts,
  export the address to environment

```bash
git clone https://github.com/piotrostr/eth-mainnet-light-node
aws ec2 allocate-address > /etc/allocated-address
export NODE_IP=$(cat /etc/allocated-address | jq -r ".PublicIp")
export TF_VAR_ALLOCATION_ID=$(cat /etc/allocated-address | jq -r ".AllocationId")
echo $NODE_IP >> /etc/ansible/hosts
```

in case one would prefer to maintain the same address, the setting of the `NODE_IP`
and `TF_VAR_ALLOCATION_ID` variables can be appended to ~/.profile or ~/.bashrc

- Start and setup the instance

```bash
cd ./terraform && terraform init && terraform apply
cd ../
ansible-playbook ansible/main.yml
ssh ubuntu@$NODE_IP
```

- Choose a node and run, either a light node

```bash
geth --syncmode light --http
```

or a full node

```bash
geth --http
```

- After the geth node synchronizes with the mainnet it can accept requests

```bash
curl http://$NODE_IP:8545/
```

## cleanup

Destroy the resources

```bash
cd ./terraform
terraform destroy
```

Cleanup after the ip address

```
aws ec2 release-address --allocation-id $TF_VAR_ALLOCATION_ID
rm /etc/allocated-address
```

and dont forget to remove the host `$(echo $NODE_IP)` from `/etc/ansible/hosts`

## License

[MIT](https://github.com/piotrostr/bsc-full-node/blob/main/LICENSE)
