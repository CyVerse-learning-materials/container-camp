If you maintain your own cyberinfrastructure and are pulling many containers per day, you may consider hosting your own registry.

### :material-docker: Docker Registry Server

Setting up your own Docker Registry Server 

[Registry deployment documentation](https://docs.docker.com/registry/deploying/){target=_blank}

### :material-lighthouse-on: Harbor

[Harbor](https://goharbor.io/){target=_blank} is for managing container registries with Kubernetes

CyVerse manages their own public/private Harbor server for their Discovery Environment. You can authenticate to it using your CyVerse user account.

[https://harbor.cyverse.org](){target=_blank}

CyVerse featured Docker containers in the Discovery Environment are cached on our Harbor, using a combination of GitHub Actions.

[https://github.com/cyverse-vice](){target=_blank} 