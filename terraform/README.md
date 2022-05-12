# Full Node BSC

spins up a geth full node for binance smart chain using teraform

### required environment variables

```bash
export TF_VAR_AWS_ACCESS_KEY=""
export TF_VAR_AWS_SECRET_KEY=""
export TF_VAR_SSH_PASSWORD=""
export TF_REGION=""
```

also uses ssh keys (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`)

### usage

start the instance

```bash
terraform init && terraform apply
terraform show | grep public_ip
ssh -i ~/.ssh/id_rsa ubuntu@<public_ip>
```

```bash
git clone https://github.com/ethereum/go-ethereum
```
