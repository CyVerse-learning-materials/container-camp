# Creating Terraform Templates on OpenStack

[Jetstream-2 Terraform Documentation](https://docs.jetstream-cloud.org/general/terraform/){target=_blank}

??? Info "Basic Operations"

    Setting up your server

    The basic setup is as follows:

    1. `git clone` a repository with a terraform plan, e.g. 

    2. `cd` into the repository

    3. Download your Jetstream-2 or other OpenStack Cloud `openrc` file into the repo 

        Go to [https://js2.jetstream-cloud.org/project/](https://js2.jetstream-cloud.org/project/){target=_blank}

    4. Run `source openrc.sh` in a CLI 

    5. Initalize Terraform with `terraform init`

    6. See what changes Terraform wants to make to your infrastructure with `terraform plan`

    7. Apply the changes with `terraform apply`

