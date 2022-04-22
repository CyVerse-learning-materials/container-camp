# GitHub Actions and Docker

**Actions** is a feature of [GitHub](https://github.com/) that allows the automation and execution of workflows invoved in the development of your software and code. Read more on GitHub Actions at the [offical GitHub Docs page](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions).

GitHub Actions can also be used to create and manage your own Docker Images and Containers. Here we will learn how we can create a Docker Imange through GitHub Actions.

In this example we are going to creat a small GitHub repository that will create and push your Docker Image.

---

## Setting up a Docker Project

A Docker project on GitHub requires 2 folders:

- a `.github/workflows` folder: containing required necessary `yml` files that build the containers through GitHub;
- a `Dockerfile`: file necessary to build containers.

### Prerequisites

- A [GitHub](https://github.com/) account;
- A [Docker](https://www.docker.com/) account.

### Creating your Docker Repository on GitHub

To create a GitHub Repository:
1. Navigate to your GitHub Account and select **New**;
2. Give your repository a unique name;
3. Click **Create Repository**.

Navigate to your new Repository. Either use the `clone` your repository to your own machine (suggested), or work directly within GitHub.

### Linking your GitHub and Docker accounts

Ensure you can access [Docker Hub](https://hub.docker.com/) from any workflows you create:

1. Add your Docker ID as a secret to GitHub. Navigate to your GitHub repository and click **Settings > Secrets > New secret**.
2. Create a new secret with the name `DOCKER_HUB_USERNAME` and your Docker ID as value.
3. Create a new Personal Access Token (PAT). To create a new token, go to [Docker Hub Settings](https://hub.docker.com/settings/security) and then click **New Access Token**.

---

## Setting up a GitHub Action Workflow

1. Create the folder path `.github/workflows`

### Workflow Optimization

--

## Tagging and Pull Requests