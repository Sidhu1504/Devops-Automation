#!/bin/bash

terraform apply -auto-approve

IP=$(terraform output -raw instance_ip)

echo "[webserver]" > /root/Automation/Ansible/inventory.ini
echo "$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/sidhu.pem" >> /root/Automation/Ansible/inventory.ini

echo "Inventory file created successfully!"
echo "use this in browser to see website http://$IP | After running ansible playbook"
