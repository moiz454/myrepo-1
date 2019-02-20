## Standalone Tomcat Deployment with Java

- Requires Ansible 1.2 or newer
- Expects CentOS/RHEL 6.x hosts

These playbooks deploy
* Tomcat Application Server version 8
* Java version 8

Then run the playbook, like this:

	ansible-playbook -u <userName> --private-key <privateKeyPath> -i '<IP_ADDRESS>,' 'site.yml

When the playbook run completes, you should be able to see the Tomcat
Application Server running on the ports you chose, on the target machines.
