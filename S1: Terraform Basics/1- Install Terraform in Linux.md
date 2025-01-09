# Terraform/Ubuntu.
## Ubuntu
### Ensure that your system is up to date and you have installed the gnupg, software-properties-common, and curl packages installed.
```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

### Install the HashiCorp GPG key.
```
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```

### Add the official HashiCorp repository to your system
```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```

### Download the package information from HashiCorp.
```
sudo apt update
```

### Install Terraform from the new repository.
```
sudo apt-get install terraform
```
![image](https://github.com/user-attachments/assets/90e40e9e-0b7c-425d-84ce-861a277a8caf)

## AWS CLI.
![image](https://github.com/user-attachments/assets/36d42e2c-8d9d-433e-94e7-05a62a367330)
