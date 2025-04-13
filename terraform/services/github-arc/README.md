# Instructions:
https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/quickstart-for-actions-runner-controller

# Important:
1 - "You can authenticate Actions Runner Controller (ARC) to the GitHub API by using a GitHub App or by using a personal access token (classic)."

Follow the instructions from the page below to create a GitHub App at the Organization level:

https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/authenticating-to-the-github-api#deploying-using-personal-access-token-classic-authentication

2 - You must configure your GH Fine-grained Token in order to be able to pull the docker image.
```
provider "helm" {
  ...
  registry {
    url = "oci://ghcr.io/actions/..."
    password = "github_pat_ ..."
    username = "USERNAME"
  }
}
```
