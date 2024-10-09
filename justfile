setup:
    sh scripts/ensure_key.sh
    ansible-galaxy collection install -r ansible/collections/requirements.yml

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

    echo "Sleeping for 180s..."
    sleep 180

    ansible-playbook ansible/k3s/playbooks/bootstrap/set-hostname.yml
    ansible-playbook ansible/k3s/playbooks/bootstrap/install-k3s.yml --ask-vault-pass

ping:
    ansible -o all -m ping