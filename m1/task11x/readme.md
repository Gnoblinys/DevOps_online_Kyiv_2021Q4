# Terraform

Install to Linux
```

#!/bin/bash

sudo apt update && sudo apt install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update && sudo apt install terraform

terraform -help

```

Initializing provider plugins
```
terraform init
```

Terraform used the selected providers to generate the following execution plan
```
terraform plan
```

Start build environment
```
terraform apply
```
