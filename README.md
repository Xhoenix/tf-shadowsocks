# tf-shadowsocks
## Deploy Shadowsocks server to GCP using Terraform

First of all, a full blown tutorial on this can accessed on my blog via [this link](https://blog.jitendrapatro.me/deploying-a-shadowsocks-server-to-gcp-using-terraform/). If you want a quicker way and you already meet the prerequisites, then follow along with this README.

### Prerequisites
1. A Google Cloud account.
2. A GCP project with billing enabled.
3. A service account for Terraform with enough privileges to deploy resources or use other authentication methods for authenticating terraform cli. You can learn about more authentication mechanisms via [this link](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication). 
4. gcloud CLI installed.
5. Terraform cli installed.

### First set your billing enabled project for Terraform cli
`export TF_VAR_project="<your-project-name>"`

**Note:-** The above environment variable is necessary and must be set up before doing anything else.

### Next, enable Google Compute Engine API for the project
`gcloud services enable compute.googleapis.com`


### Create ssh keys in the default location, i.e ~/.ssh
`ssh-keygen -t rsa -b 4096`

**Note:-** I recommend setting a password for the ssh keys.

![image](https://user-images.githubusercontent.com/86168235/175831005-f6edca06-d039-43a3-ae48-cfb5d37c1ba7.png)

### Clone this repo and init Terraform
`git clone https://github.com/GenialHacker/tf-shadowsocks.git`

`cd tf-shadowsocks`

`terraform init`


![image](https://user-images.githubusercontent.com/86168235/175831346-8f7ea36e-2c78-4945-b181-5e377627337c.png)

### Check the config format and Validate config
`terraform fmt`

`terraform validate`

![image](https://user-images.githubusercontent.com/86168235/175831549-12a27b1c-701a-46e3-8da7-40c01edb5746.png)

### Plan and apply changes to deploy Shadowsocks server to GCP
First, check whether the correct project is set up or not.

`echo $TF_VAR_project`

Next, apply the configuration to deploy Shadowsocks server.

`terraform apply`

![image](https://user-images.githubusercontent.com/86168235/175832801-cfdb2d2c-7233-4fa6-a8d6-59fa158a8cc6.png)

When the deployment of server finishes, you'll be provided the IP address and the password for shadowsocks proxy server which would be hidden. To show the password use the following command:-
`terraform output sss_password`

### Install Shadowsocks client on Linux
`apt update && apt install shadowsocks-libev`

### Disable shadowsocks server enabled by default
`systemctl stop shadowsocks-libev`

`systemctl disable shadowsocks-libev`

### Create a custom configuration from the original Shadowsocks configuration.
`cp /etc/shadowsocks-libev/config.json /etc/shadowsocks-libev/gcp.json`


Next, edit `/etc/shadowsocks-libev/gcp.json` and populate it something like this.
````
{
    "server":"your-ss-server-ip-address-from-above",
    "mode":"tcp_and_udp",
    "local_address":"127.0.0.1",
    "server_port":8888,
    "local_port":1080,
    "password":"your-password-from-terrafrom-output-above",
    "timeout":86400,
    "method":"chacha20-ietf-poly1305"
}
````
![image](https://user-images.githubusercontent.com/86168235/175832752-09fb6c03-2823-44a6-b48b-c15b2d73aa52.png)


### Restart your Shadowsocks client and test your proxy
`systemctl restart shadowsocks-libev-local@gcp.service`

`curl --proxy socks5://127.0.0.1:1080 https://ifconfig.me`

If the above command shows your Shadowsocks server IP, then your proxy is fully setup!
