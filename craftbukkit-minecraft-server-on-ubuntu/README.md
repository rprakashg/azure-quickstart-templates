# Install Craftbukkit minecraft server on ubuntu virtual machine using a custom script extension

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Frprakashg%2Fazure-quickstart-templates%2Fmaster%2Fcraftbukkit-minecraft-server-on-ubuntu%2Fazuredeploy.json" target="_blank">
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
| location | Location where the resources will be deployed |
| minecraftUser | Your Minecraft user name |
| adminUsername  | Username for the Virtual Machines  |
| adminPassword  | Password for the Virtual Machine  |
| dnsNameForPublicIP  | Unique DNS Name for the Public IP used to access the Virtual Machine. |
| difficulty  | 0 - Peaceful, 1 - Easy, 2 - Normal, 3 - Hard |
| level-name | Name of the Minecraft world which will be created |
| gamemode | 0 - Survival, 1 - Creative, 2 - Adventure, 3 - Spectator |
| white-list | Only ops and whitelisted players can connect when true |
| enable-command-block | Allow command blocks to be created |
| spawn-monsters | Enable monster spawning |
| generate-structures | Generates villages, temples etc. |
| level-seed | Add a seed for your world |