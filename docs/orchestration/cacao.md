## Log into CACAO (JS2)

To start, you will need an Xsede user account and have access to a project.

Go to [Jetstream-2 CACAO](https://js2.cyverse.org/){target=_blank} to log in with your Xsede account. You will be prompted to allow Jetstream 2 to authenticate with Globus.

![](assets/atmosphere/js2_globus.png)

### Add your Credential

Next, you will need to add cloud computing credentials. For now, the only option is Jetstream 2, but in the future, other providers like Google and AWS will be supported.

Click on Credentials on the lefthand menu bar. From the Credentials page, click the "+ Add Credential" button and select "Cloud Credential". Select Jetstream 2 and the project you would like to add. These correspond to Jetstream 2 projects you have access to.

![](assets/atmosphere/js2_new_credential.png)

Once your credential is added, it should show up on the Credentials page.


### Start a Deployment

Next, we will start a deployment onto Jetstream 2.

Click on the [:material-rocket-launch: Deployments](https://js2.cyverse.org/deployments) tab on the lefthand menu bar. You will see your cloud providers and projects, and if you have multiple providers or projects, you can select them here. You should have Jetstream 2 and a project selected.

Next, click the "+ Add Deployment" button. You will see several options for default templates to launch VMs, containers, or whole clusters. We will use the first template to launch a single VM.

![](assets/atmosphere/js2_template.png)

You will then name the deployment, select the number of instances and size of instances. For now, stick with the default Featured-AlmaLinux8 image and 1 instance of m3.tiny. You can name it whatever you want.

### Access Deployment

Once you have submitted your deployment, you can see it on the Deployments page. It will be in the "Starting" status for a few minutes. Once it is running, you can click on it to see details about it and to access it.

![](assets/atmosphere/js2_running.png)

From here, you can click on the icons on the right to access a Web Shell or a Web Desktop (for certain images). You can also pause, shelve, or delete the deployment from here. Try opening the Web Shell, which will bring you to a command line inside your running VM.