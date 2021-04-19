# Third task

In the .github folder we can find two files with diffrenet purposes.

## 1) pull_request_template.md

The pull_request_template.md is being used for creating a template that should be filled by developer during Pull Request creation.
This kind of template is widely used to provide an information about the change that will be merged.
Document should contain:

- a short description to have a high level overview of the change
- detailed description of the changes (especially when that change is big and/or influces many different areas)
- a link to JIRA, Defects reporting system, etc.
- description of the changes
- when Pull Request is created for feature branch - the box for confirmation that given feature should be included into master can also be provided
- when cherry picked also info should be provided in Pull Request
- The impact analysis: what kind of a change that is and how big impact does it have (the impact influcences the severity of verfication process and tests)

## Provided example of PR template

Basically follows the proper convention of creating Pull Request templates. Most of the data is being provided (not all of them in a detailed way). From my perspective some of things could be improved here (i.e. taking into consideration some of the additional information I mentioned in the previous point)
In the case of the provided example we have a field that holds info about the given change that is asked for the merge. There is a marking place for describing the type of the change, link to the JIRA story/epic, link to the documentation to the Confluence page (here I would be a little bit in doubt if every single change would be documented every time - it would be nice but without enforcing this policy it can be hard). I can also see the field for the breaking change (I find it a little bit overdone cause every major release should be somehow a breaking change).

## Additional things

Collecting data from Pull Request gives also a very insight of the development process. Data can be retrived and used for managment purposes creating reports in i.e. PowerBI.

## 2) CI/CD pipeline

The example that has been given represnts a valid YAML definition of CI/CD pipeline for GitHub Actions. I should mention here that I am not working with GitHub Actions on daily basis. I am familiar with Azure DevOps environment in which I am mainting and developing new pipelines etc. It is also worth to mention that the structure of the YAML definition does not look that much different than what it is on Azure DevOps.
This exact pipeline is triggered for every pull request for development and main branches and is reponsible for building image and pushing it to GitHub Container Registry.
As the first info we get an actual environment that we are using and in this case it is the ubuntu-latest.
The first step of the job is to checkout the repository under $GITHUB_WORKSPACE so the workflow can access it. It can be also easily read in the documentation that this action fetches only a single commit as a default which in this case is.
Then crazy-max/ghaction-docker-meta@v1 action is being used to extract the metadata like tags, labels for a Docker. In this case we can tag the actual image ghcr.io/awesomecompany/mlflow.
Proceeding steps for Set up QEMU for installing QEMU static binaries - used to run builders for architectures other than the host - and Set up Docker Buildx - docker/setup-buildx action configures buildx, which is a Docker CLI plugin that provides enhanced build capabilities.
Then we have a step for logging to GitHub Container Registry called ghcr.io using the username and Personal Access Token (PAT).
Final step builds and pushes the docker image using build-push action using the tags that were defined in the Docker meta step with ghaction-docker-meta action.
