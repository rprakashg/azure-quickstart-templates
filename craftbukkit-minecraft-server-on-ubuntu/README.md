# Install Craftbukkit minecraft server on ubuntu virtual machine using a custom script extension

<a href="https://azuredeploy.net/" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

This template creates a craftbukkit minecraft server on Ubuntu virtual machine and sets up
minecraft user passed via template parameter as operator. Template also deploys a storage account,
Virtual Network, Public IP and a Network Interface.

Custom script uses buildtools.jar to build craftbukkit minecraft server. Craftbukkit servers are highly customizable
and allows the operator to install plugins and other customizations to make multiplayer gaming lot more fun than
vanila minecraft server.

Common Minecraft server properties as well as craftbukkit specific properties can be
set during deployment. Once the deployment is successfully completet you can connect to the DNS address of the
Virtual Machine to list of Servers within Minecraft, after the server is added you should be able to connect
to it from minecraft.

Below are the parameters that the template expects

| Name   | Description    |
|:--- |:---|
| siteName  | Name of the Web App. |
| hostingPlanName  | Name for hosting plan  |
| siteLocation  | Site Location   |
| sku  | SKU ("Free", "Shared", "Basic", "Standard") |
| workerSize | Worker Size( 0=Small, 1=Medium, 2=Large ) |