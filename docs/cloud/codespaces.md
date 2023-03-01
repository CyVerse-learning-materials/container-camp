# GitHub :octicons-codespaces-16: CodeSpaces

For this workshop, we are working in GitHub [:octicons-codespaces-16: CodeSpaces](https://docs.github.com/en/codespaces){target=_blank}. You will be given access to an organization where CodeSpaces have been enabled for the duration of the workshop. 

??? Question "What is a 'Development Environment'?"

    A development environment or "dev environment" for short, is a place where software can be written and tested without impacting users or "production environments" as part of the software lifecycle.
    
    Containers-within-containers are another way to think about this paradigm. We create a containerized Integrated Development Environment (IDE) container which has all of our favorite software development tools and visual software (e.g., :material-microsoft-visual-studio-code: VSCode) where we can write our program and try out new package installations.
    
    **Terminology:**
    
    ***:material-dev-to: Development Environment***: Environment for development tasks such as designing, programming, debugging, etc.

    ***:material-test-tube-empty: Test Environment***: an environment with the same configuration as the "production environment" where testing can be done without interrupting the main service, also called Q/A or "Quality Assurance Environment". 
    
    ***:material-test-tube: Staging Environment***: Where the work from testing is merged into the built system before public release. 
    
    ***:octicons-verified-16: Production Environment***: The environment where users interact with the now-public tools. 
    
[:simple-github: GitHub :octicons-codespaces-24: CodeSpaces](https://github.com/features/codespaces){target=_blank} provides you with a fully featured Dev Environment running on [:simple-microsoftazure: Microsoft Azure](https://azure.microsoft.com/en-us){target=_blank}. 

You have been granted access to [GitHub Education](https://education.github.com/){target=_blank}, and can use CodeSpaces and [:octicons-copilot-24: CoPilot](https://github.com/features/copilot){target=_blank} during the workshop.

:octicons-codespaces-24: CodeSpace links with your GitHub account for a seamless experience working on code in a Git repository.

:octicons-copilot-24: CoPilot is an AI programmer assistant that can help you write code using comments as prompts.

??? Question "How can you get your own educational GitHub & CodeSpaces?"

    You can gain access to discounted GitHub CodeSpaces by enrolling your GitHub account with [GitHub Education](https://education.github.com/){target=_blank} and then applying the [educator discount](https://education.github.com/discount_requests/teacher_application){target=_blank} to your organizations and repos.
    
    Not interested in using GitHub based dev environments? Check out [GitPod](https://www.gitpod.io/){target=_blank} or [GitLub Education](https://about.gitlab.com/solutions/education/){target=_blank} and [Developer Environments](https://docs.gitlab.com/runner/development/){target=_blank}

??? Question "How do I use CoPilot?"

    [Install and enable CoPilot on your VSCode](https://docs.github.com/en/codespaces/codespaces-reference/using-github-copilot-in-github-codespaces){target=_blank} (locally, logging into GitHub, or remotely in CodeSpace).
    
    Try adding a comment to the top of a file, like your new `Dockerfile`, wait a few seconds 
    
    ```
    # Create a Dockerfile which uses an Ubuntu 22.04 featured base image, 
    FROM ubuntu:22.04

    # then install Python 3.10 and pip,
    RUN apt-get update \
    && apt-get install -y python3.10 python3-pip

    #  and give it an ENTRYPOINT to run Python 3.10
    ENTRYPOINT [ "python3.10" ]
    ```

## Starting a CodeSpace

When a GitHub Organization and Repository have CodeSpaces enabled you will see a "Code" button above the README.md

![codespace_1](../assets/cloud/codespaces/codespace_1.png){width="300"}

Click on the "Code" button and start a new CodeSpace

![codespace_2](../assets/cloud/codespaces/codespace_2.png){width="300"}

Select the size of the CodeSpace you want (2-4 cores and 4GB to 8GB of RAM should be plenty for today)

![codespace_3](../assets/cloud/codespaces/codespace_3.png){width="300"}

Click "Create CodeSpace"

You will be taken to a loading screen, and after a few moments (<2 minutes) your browser will change to a VS Code instance in your browser.

![codespace_4](../assets/cloud/codespaces/codespace_4.png){width="500"}

Notice, the GitHub repository where you initiated the CodeSpace is set as the working directory of the EXPLORER :material-file-document-multiple: in the upper left side of VS Code interface. You're in your Git repo, and are able to work with Python, Docker, Node, or any one of many featured developer tools. Further, you can install any tools you like!

![codespace_5](../assets/cloud/codespaces/codespace_5.png){width="600"}
