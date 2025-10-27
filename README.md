# 🚀 Blue/Green Deployment with Nginx (DevOps Intern Stage 2 Task)

## 📘 Overview
This project demonstrates a **Blue/Green Deployment** setup using **Docker Compose** and **Nginx** as a reverse proxy with **automatic failover**.  
It deploys two identical Node.js services (`blue` and `green`) behind Nginx.  

The setup supports:
- Automatic failover between Blue and Green using Nginx upstreams.
- Manual toggling of active pool via environment variable `ACTIVE_POOL`.
- Health checks, retries, and header forwarding.
- Fully parameterized configuration through a `.env` file.

---

## ⚙️ Project Structure
