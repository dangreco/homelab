setup:
    sh scripts/ensure_key.sh

tf-init:
    terraform -chdir=terraform init

tf-plan:
    terraform -chdir=terraform plan

tf-apply:
    terraform -chdir=terraform apply

tf-destroy:
    terraform -chdir=terraform destroy

deploy:
    just tf-init
    just tf-plan
    just tf-apply

ping:
    ansible -o all -m ping