resource "helm_release" "robot-shop" {
  name       = "robot-shop"
  create_namespace = true
  namespace  = "robot-shop"
  repository = "https://konoha-23.github.io/konoha-roboshop/"
  chart      = "robot-shop"
  timeout = 360

  values = [
    "${file("robo-values.yml")}"
  ]
}

resource "kubernetes_storage_class" "robotshop-redis-sc" {
  metadata {
    name = "robotshop-redis-sc"
  }
  storage_provisioner = "ebs.csi.aws.com"
  reclaim_policy      = "Retain"
  volume_binding_mode = "Immediate"
  parameters = {
    type = "gp2"
  }
}
