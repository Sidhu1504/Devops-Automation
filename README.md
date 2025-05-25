# 🚀 DevOps Automation: AWS EC2 with Terraform & Ansible

This project automates the creation, configuration, and deployment of a web server on an AWS EC2 instance using **Terraform**, **Ansible**, and a custom **Shell Script**. The deployed website pulls its code from GitHub.

---

## 📌 Overview

This project demonstrates end-to-end DevOps automation:

- 🏗️ **Terraform** provisions infrastructure on AWS (EC2, Security Groups, etc.).
- ⚙️ **Ansible** configures the server (Apache installation, Git setup, website deployment).
- 💡 A **custom shell script** automates Terraform apply, extracts the public IP, and generates the Ansible inventory.
- 🌐 Website code is pulled from GitHub and served on the EC2 instance using Apache2.

---

## 🧰 Tools & Technologies

| Tool         | Purpose                                         |
|--------------|-------------------------------------------------|
| **Terraform**| Infrastructure provisioning (AWS EC2)           |
| **Ansible**  | Configuration management and deployment         |
| **Shell Script** | Automation of Terraform and inventory setup |
| **AWS EC2**  | Cloud server to host the website                |
| **Apache2**  | Web server to serve the website                 |
| **GitHub**   | Website code repository                         |
| **Ubuntu**   | Operating System for EC2                        |

---

## 🖼️ Architecture Diagram

```plaintext
+---------------------+
|   Local Machine     |
| (Terraform & Script)|
+----------+----------+
           |
           | terraform apply
           v
+----------------------------+
|        AWS Cloud           |
| +------------------------+ |
| |     EC2 Instance       | |
| |  (Ubuntu + Apache2)    | |
| +------------------------+ |
|        ^        ^          |
|        |        |          |
|   SSH / SCP     |          |
|     (Ansible)   |          |
|        |        | git clone|
|        v        v          |
| +------------------------+ |
| |  GitHub Repo (Website) | |
| +------------------------+ |
+----------------------------+
           |
           v
  Access site via: http://<EC2-IP>
````

---

## 🗂️ Project Structure

```
Devops-Automation/
├── terraform/
│   ├── main.tf         # EC2 provisioning
│   ├── variables.tf    # Input variables
│   ├── outputs.tf      # Output public IP
│   └── provider.tf     # AWS provider setup
├── ansible/
│   ├── inventory.ini    # Dynamic inventory created by script
│   └── playbook.yml     # Configuration & deployment
├── run.sh               # Automation shell script
└── README.md
```

---

## ⚙️ Shell Script: `run.sh`

To streamline the process, a shell script (`run.sh`) is included to:

* Run `terraform apply` with `-auto-approve`
* Extract the EC2 instance public IP
* Automatically generate the Ansible inventory file with connection details

### ✅ Script Content

```bash
#!/bin/bash

terraform apply -auto-approve

IP=$(terraform output -raw instance_ip)

echo "[webserver]" > /root/Automation/Ansible/inventory.ini
echo "$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/sidhu.pem" >> /root/Automation/Ansible/inventory.ini

echo "Inventory file created successfully!"
echo "Use this in browser to see website: http://$IP | After running ansible playbook"
```

> Make sure the private key file path (`sidhu.pem`) and inventory file path match your system setup.

---

## 🛠️ Prerequisites

* ✅ AWS account & credentials configured
* ✅ Terraform installed
* ✅ Ansible installed
* ✅ SSH key pair created (used by Terraform and Ansible)
* ✅ Git installed

---

## 🚀 How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/Sidhu1504/Devops-Automation.git
cd Devops-Automation
```

### 2. Run the Shell Script

Navigate to the `terraform/` directory and execute the automation script:

```bash
cd terraform
chmod +x ../run.sh
../run.sh
```

* This will provision the EC2 instance, generate the inventory file, and display the public IP to access after deployment.

### 3. Run Ansible Playbook

```bash
cd ../ansible
ansible-playbook -i inventory.ini playbook.yml
```

---

## 🌍 Access Your Website

After Ansible finishes deployment, open your browser:

```
http://<EC2_PUBLIC_IP>
```

Your website should now be live! 🎉

---

## 💻 Website Source Code

The website code is automatically pulled from GitHub. You can modify the GitHub repo link in the Ansible playbook (`playbook.yml`) to use your own project.

---

## 🧹 Clean Up Resources

To avoid unnecessary AWS costs:

```bash
cd terraform
terraform destroy
```

---

## 🙏 Acknowledgments

Thanks to my mentor **Ashutosh Bhakre Sir** for their continuous support and guidance during this DevOps learning journey.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

```

```
