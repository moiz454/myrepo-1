module "hello-world" {
  source = "../modules/backend"

  appName            = "hello-world"
  ami                = "${var.ami}"
  aws_region         = "${var.aws_region}"
  instance_type      = "${var.instance_type_micro}"
  key_name           = "${var.key_name}"
  ssh_user           = "${var.ssh_user}"
  vpc_net_block      = "${var.vpc_net_block}"
  environment        = "${var.environment}"
  PublicSubnetIDs    = "${module.vpc.PublicSubnetIDs}"
  PrivateSubnetIDs   = "${module.vpc.PrivateSubnetIDs}"
  InstanceSecGroupID = "${module.vpc.InstanceSecGroupID}"
  ELBSecGroupID      = "${module.vpc.ELBSecGroupID}"
}
