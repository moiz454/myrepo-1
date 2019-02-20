resource "random_shuffle" "instance_subnets" {
  input = ["${var.PrivateSubnetIDs}"]
}

resource "aws_instance" "app" {
  count                  = 2
  vpc_security_group_ids = ["${var.InstanceSecGroupID}"]
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${random_shuffle.instance_subnets.result[count.index]}"
  key_name               = "${var.key_name}"

  root_block_device {
    volume_size = 40
  }

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False /usr/local/bin/ansible-playbook -u ${var.ssh_user} --private-key ~/.ssh/jenkins.pem -i '${self.private_ip},' '../../ansible/site.yml'"
  }

  tags {
    "Name" = "${var.appName}-${var.environment}-${count.index + 1}"
  }
}

resource "aws_elb" "app" {
  name            = "${var.appName}-elb"
  subnets         = ["${var.PublicSubnetIDs}"]
  security_groups = ["${var.ELBSecGroupID}"]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 3
    target              = "TCP:8080"
    interval            = 5
  }

  instances                   = ["${aws_instance.app.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.appName}-elb"
  }
}

output "ELB_endpoint" {
  value = "${aws_elb.app.dns_name}"
}
