module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.10.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.25"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # We will rely only on the cluster security group created by the EKS service
  create_cluster_security_group = false
  create_node_security_group    = false

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    attach_cluster_primary_security_group = true
    #Disabling and using externally provided security groups
    create_security_group = false
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"
      instance_types = ["t2.medium"]
      # terraform resource "kubernetes_validating_webhook_configuration" "example" {
      # metadata {
      #   name = "test.terraform.io"
      # }

      # webhook {
      #   name = "test.terraform.io"
      #   admission_review_versions = ["v1", "v1beta1"]

      #   client_config {
      #     service {
      #       namespace = "example-namespace"
      #       name      = "example-service"
      #     }
      #   }

      #   rule {
      #     api_groups   = ["apps"]
      #     api_versions = ["v1"]
      #     operations   = ["CREATE"]
      #     resources    = ["deployments"]
      #     scope        = "Namespaced"
      #   }

      #   side_effects = "None"
      # }
      # }
      min_size     = 3
      max_size     = 5
      desired_size = 3

      pre_bootstrap_user_data = <<-EOT
      echo 'forty-two'
      EOT

      vpc_security_group_ids = [
        aws_security_group.node_group_one.id
      ]
    }
  }
    tags = {
    Terraform = "true"
    Environment = "test"
  }
}
