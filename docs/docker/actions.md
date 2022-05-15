# GitHub Actions and Docker

[GitHub Actions](https://github.com/features/actions?gclid=EAIaIQobChMI6JzCw9bf9wIVhD-tBh11sQ42EAAYASABEgKxrvD_BwE){target=_blank} is a feature that allows automation and execution of workflows invoved in the development of your software and code. Read more on GitHub Actions at the [offical GitHub Docs page](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions).

Actions can also be used to create and manage your Docker Images. 

Here you will learn how to can create Actions which build and then push images from GitHub to a Docker Registry of your choice. 

---

### Prerequisites

- A [GitHub](https://github.com/){target=_blank} account
- A [Docker](https://hub.docker.com/){target=_blank} account

## Setting up a Git Repository with Actions for Docker

??? Info "CI/CD Terminology"

    * **:material-infinity: continuous integration** builds, tests, and automatically accepts changes to code in a repository 
    * **:material-infinity: continuous delivery** delivers code changes to production-ready environments
    *  **:material-infinity: continuous deployment** does just that, it deploys changes to the code
    * **:material-pipe: CI pipeline** compiles code, tests it, and makes sure all of your changes work. It should run whenever there is a change (push) to the repository
  
    * **:material-pipe: CD pipeline** goes one step further and deploys new code into production.

    We are focusing on GitHub, but there are other platforms which you can explore for building and pushing containers to registries

    These include [GitLab Runners]() 

    Other types of Continuous Integration are used on code repositories to ensure that code stays functional. 

### Create a GitHub Repository

Navigate to your GitHub Account and select **New**;

![Actions_01](../assets/docker/Actions_01.png)


??? Tip ":material-github: Creating README, LICENSE, & .gitignore"

    When you create your new git repository you are asked to create a `README`, a `LICENCE`, and a `.gitignore` file.

    Go ahead and create all three of these, as they are useful and fundamental to making your repository reproducible. 

    README -- we want to use the README to help future-us when we revisit this repository. Make sure to include detailed instructions 

    LICENSE -- pick a license which is useful for your specific software use case.

    `.gitignore` -- use a file which will keep docker project files isolated
      
    ??? info ":material-docker: `.gitignore` example"

        ```
            # Docker project generated files to ignore
            #  if you want to ignore files created by your editor/tools,
            #  please consider a global .gitignore https://help.github.com/articles/ignoring-files
            .vagrant*
            bin
            docker/docker
            .*.swp
            a.out
            *.orig
            build_src
            .flymake*
            .idea
            .DS_Store
            docs/_build
            docs/_static
            docs/_templates
            .gopath/
            .dotcloud
            *.test
            bundles/
            .hg/
            .git/
            vendor/pkg/
            pyenv
            Vagrantfile
        ```

In the repository, create two nested folders required for a Docker Actions project:

- A `.github/workflows` folder: containing required necessary `yml` files that build the containers through GitHub;

In the workflows folder, we're going to add a `.yml` 

In the main repository, along with the `README` and `LICENCE` file, create another folder called `/docker`

In the `/docker` folder we're going to put the `Dockerfile` file necessary to build the image.

### Link your GitHub and Docker accounts

Ensure you can access [Docker Hub](https://hub.docker.com/) from any workflows you create:

1. Add your Docker ID as a secret to GitHub. Navigate to your GitHub repository and click **Settings > Secrets > New secret**.

![Actions_03](../assets/docker/Actions_03.png)

2\. Create a new secret with the name `DOCKER_HUB_USERNAME` and your Docker ID as value.
3\. On DockerHub, create a new Personal Access Token (PAT). To create a new token, go to [Docker Hub Settings](https://hub.docker.com/settings/security) and then click **New Access Token**. Name it, and copy the newly generated PAT.

??? Tip
    Name your Docker Hub Access token the same name as your GitHub repository, it will help with keeping track which GitHub repository is related to which Docker image.

![Actions_04](../assets/docker/Actions_04.png)


4. On GitHub, return to your repository secrets, and add the PAT as a secret with the name `DOCKER_HUB_ACCESS_TOKEN`.

![Actions_05](../assets/docker/Actions_05.png)


---

## Setting up a GitHub Action Workflow

Now that you have connected your GitHub repository with your Docker account, you are ready to add the necessary files to your repo.

!!! Note
        In this example, we will use the existing Docker image Alpine.

1\. In your GitHub repository, create a file and name in `Dockerfile`; In the first line of your `Dockerfile` paste:

```
FROM alpine:3.14
```

2\. Click the `Actions` tab and in the search bar, search for `docker`. Select the `docker image workflow` (as shown in the image below)

!!! Note
        This will create the `.github/workflows` repository and necessary `yml` file required for the GitHub actions.

![Actions_06](../assets/docker/Actions_06.png)

3\. You will be prompted to the `docker-image.yml` file; paste the following code, and `commit` your changes.

```
name: Docker Image Small Alpine

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:

  build:

    runs-on: ubuntu-latest

    steps:
      -
        name: Checkout 
        uses: actions/checkout@v2
      -
        name: Login to Docker Hub
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKER_HUB_USERNAME }}
          password: ${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}
      -
        name: Build and push
        uses: docker/build-push-action@v2
        with:
          context: .
          file: ./Dockerfile
          push: true
          tags: ${{ secrets.DOCKER_HUB_USERNAME }}/simplewhale:latest
```
4\. Upon committing and pushing your changes, you can check your Workflows under the Actions tab on GitHub.

!!! Note
        Github will show you when a workflow is building:
        - An orange dot next to your commit count means that the workflow is running;
        - A crossed red circle means that your workflow has failed;
        - A green check means your workflow ran successfully.

![Actions_07](../assets/docker/Actions_07.png)

5\. Navigate to your Docker Hub to see your GitHub Actions generated Docker image.

![Actions_08](../assets/docker/Actions_08.png)

![Actions_09](../assets/docker/Actions_09.png)


## Setting up your own

[:material-github: GitHub Actions Runner](https://github.com/actions/runner){target=_blank}

[:material-file-document-outline: Self-hosted Actions Runner Docs](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners){target=_blank}

[:material-gitlab: GitLab Runner](https://docs.gitlab.com/runner/install/){target=_blank}