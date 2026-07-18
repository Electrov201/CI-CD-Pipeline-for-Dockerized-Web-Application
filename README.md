<div align="center">

# 🚀 Automated CI/CD Pipeline for Dockerized Web App on AWS EC2

**A modern, automated continuous deployment pipeline building Dockerized Nginx applications via GitHub Actions and deploying directly to an AWS EC2 instance.**

[![CI/CD Pipeline](https://github.com/Electrov201/CI-CD-Pipeline-for-Dockerized-Web-Application/actions/workflows/deploy.yml/badge.svg)](https://github.com/Electrov201/CI-CD-Pipeline-for-Dockerized-Web-Application/actions/workflows/deploy.yml)
[![Docker](https://img.shields.io/badge/Docker-20.10+-2496ED?style=flat-square&logo=docker&logoColor=white)](https://www.docker.com/)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-Automation-2088FF?style=flat-square&logo=github-actions&logoColor=white)](https://github.com/features/actions)
[![AWS EC2](https://img.shields.io/badge/AWS-EC2-FF9900?style=flat-square&logo=amazonaws&logoColor=white)](https://aws.amazon.com/ec2/)
[![Nginx](https://img.shields.io/badge/Nginx-Alpine-009639?style=flat-square&logo=nginx&logoColor=white)](https://nginx.org/)
[![License](https://img.shields.io/badge/License-MIT-4c1?style=flat-square)](LICENSE)

</div>

---

## 👋 Hello & Welcome!

I built this project to practice real-world **DevOps and cloud deployment workflows**. Whenever code is pushed to this repository, GitHub Actions automatically builds a custom **Docker** container, uploads it to the **GitHub Container Registry (GHCR)**, connects to an **AWS EC2 server** securely over SSH, deploys the updated container using **Docker Compose**, and verifies that the web page is running!

---

## 🏗️ How the Automated Pipeline Works

```
 ┌──────────────────────┐          ┌──────────────────────┐          ┌──────────────────────┐
 │  Developer Push code │ ───────► │    GitHub Actions    │ ───────► │  GitHub Registry     │
 │  to main branch      │          │  (Builds Container)  │          │  (Stores Image)      │
 └──────────────────────┘          └──────────┬───────────┘          └──────────┬───────────┘
                                              │                                 │
                                     SSH Deploy Trigger                Docker Compose Pull
                                              │                                 │
                                              ▼                                 ▼
                                   ┌────────────────────────────────────────────────────┐
                                   │                  AWS EC2 Server                    │
                                   │  Pulls new image ──► Restarts Container ──► Verify │
                                   └────────────────────────────────────────────────────┘
```

1. **Continuous Integration (Build & Push)**: On every push to `main`, a GitHub Actions runner builds the lightweight Nginx Docker image and pushes it to `ghcr.io` (GitHub Container Registry).
2. **Continuous Deployment (SSH & Deploy)**: Once the build finishes, the workflow SSHes into the AWS EC2 instance, pulls the latest code and container image, and starts the container cleanly with `docker compose`.
3. **Automated Health Check**: Finally, a post-deployment script (`health-check.sh`) checks the `/health` endpoint to confirm the web server is returning HTTP `200 OK`.

---

## 🧰 Tech Stack & Tools

| Category | Technology | Why I Used It |
| :--- | :--- | :--- |
| **Cloud Hosting** | **AWS EC2 (Ubuntu 24.04)** | Reliable, industry-standard cloud server hosting |
| **Containerization** | **Docker & Docker Compose** | Ensures consistent environments from local laptop to production |
| **Automation** | **GitHub Actions** | Automated CI/CD pipeline running on every code push |
| **Image Storage** | **GitHub Container Registry (GHCR)** | Secure container registry seamlessly integrated with GitHub |
| **Web Server** | **Nginx (Alpine)** | Fast, ultra-lightweight web server serving frontend assets |
| **Scripting** | **Bash (`deploy.sh` & `health-check.sh`)** | Clean scripts automating server tasks and health polling |

---

## ⚡ Quick Guide: Setting Up on AWS EC2

If you want to set up this exact pipeline on your own AWS account, follow these simple steps:

### 1️⃣ Launch an EC2 Server
1. Go to **AWS Console → EC2 → Launch Instance** and select **Ubuntu Server 24.04 LTS** (`t2.micro`).
2. Create or select an **SSH Key Pair (`.pem` file)** and save it safely on your computer.
3. In your **Security Group**, open these two inbound ports:
   - **Port 22 (SSH)** — For terminal access and GitHub Actions deployments.
   - **Port 80 (HTTP)** — For accessing your web application in the browser.

### 2️⃣ Clone the Repository on Your Server
Connect to your new EC2 instance via terminal and clone the repository:

```bash
# Connect to your server using your private key
ssh -i your-key.pem ubuntu@<YOUR_EC2_PUBLIC_IP>

# Install Git if not present
sudo apt-get update && sudo apt-get install -y git

# Clone the repository
git clone https://github.com/Electrov201/CI-CD-Pipeline-for-Dockerized-Web-Application.git
cd CI-CD-Pipeline-for-Dockerized-Web-Application
```

### 3️⃣ Configure GitHub Repository Secrets
Go to your GitHub repository -> **Settings -> Secrets and variables -> Actions -> New repository secret**, and add these three secrets:

| Secret Name | Description | Example |
| :--- | :--- | :--- |
| `EC2_HOST` | Your EC2 instance's Public IPv4 address | `54.210.123.45` |
| `EC2_USER` | Ubuntu default username | `ubuntu` |
| `EC2_SSH_KEY` | Exact contents of your `.pem` private key file | `-----BEGIN RSA PRIVATE KEY-----...` |

### 4️⃣ Watch it Deploy!
Push any change to the `main` branch or trigger the workflow manually from the **Actions** tab on GitHub. Once completed, open your browser and visit:

👉 **`http://<YOUR_EC2_PUBLIC_IP>`**

---

## 💻 Running & Testing Locally on Your PC

Want to run and test the application on your own laptop before deploying to AWS?

```bash
# 1. Clone the repository
git clone https://github.com/Electrov201/CI-CD-Pipeline-for-Dockerized-Web-Application.git
cd CI-CD-Pipeline-for-Dockerized-Web-Application

# 2. Start the local development server using Docker Compose
docker compose -f docker-compose.dev.yml up --build -d

# 3. Open your browser and go to:
# 👉 http://localhost:8080
```

To stop the local server anytime, run:
```bash
docker compose -f docker-compose.dev.yml down
```

---

## 🧠 What I Learned Building This Project

- ✅ **Containerization Basics**: Packaging web servers and HTML/CSS assets inside clean, reproducible Docker containers (`FROM nginx:alpine`).
- ✅ **Automated CI/CD**: Building multi-job workflows in GitHub Actions (`build-and-push` → `deploy`) and safely passing environment variables and SSH secrets.
- ✅ **Cloud Server Management**: Provisioning AWS EC2 instances, setting up security groups (`Port 80` & `22`), and writing automation scripts for zero-downtime container updates.
- ✅ **Health Monitoring**: Implementing dedicated endpoints (`/health`) and automated retry loops to verify server stability after deployments.

---

<div align="center">

**⭐ If you found this project helpful or interesting, feel free to give it a star!**

Built with passion using **GitHub Actions**, **Docker**, and **AWS EC2**.

</div>
