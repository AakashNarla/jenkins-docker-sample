provider "kubernetes" {}

#resource "kubernetes_namespace" "jenkins_namespace" {
 # metadata {
 #   name = "${var.namespace}"
 # }
#}
resource "kubernetes_secret" "unkey" {
  metadata {
    name = "unkey"
    #namespace = "${kubernetes_namespace.jenkins_namespace.metadata.0.name}"
  }

  data {
    username = "${file("${path.module}/username")}"
  }
}

resource "kubernetes_secret" "pwdkey" {
  metadata {
    name = "pwdkey"
    #namespace = "${kubernetes_namespace.jenkins_namespace.metadata.0.name}"
  }

  data {
    password = "${file("${path.module}/password")}"
  }
}
resource "kubernetes_replication_controller" "jenkins" {
  metadata {
    name = "jenkins"
    labels {
      App = "jenkins"
    }
    #namespace = "${kubernetes_namespace.jenkins_namespace.metadata.0.name}"
  }
  
  spec {
    selector {
      App = "jenkins"
    }
    replicas = 1
    template {
      container {
        image = "aakashn/myjenkins:latest"
        name  = "jenkins"
        image_pull_policy = "IfNotPresent"

        env {
          name = "JAVA_OPTS"
          value = "-Djenkins.install.runSetupWizard=false"
        }
        
        port {
          container_port = 8080
          name = "http-port"
        }
        port {
          container_port = 50000
          name = "jnlp-port"
        }

        volume_mount {
          name = "docker-sock"
          mount_path = "/var/run/docker.sock"
        }
        volume_mount {
          name = "jenkins-home"
          mount_path = "/var/jenkins_home"
        }
        volume_mount {
          name = "unkeyvol"
          mount_path = "/tmp/unkey"
          read_only = true
        }
        volume_mount {
          name = "pwdkeyvol"
          mount_path = "/tmp/pwdkey"
          read_only = true
        }
      }

      volume {
        name = "docker-sock"
        host_path {
          path = "/var/run/docker.sock"
        }
      }
      volume {
        name = "jenkins-home"
        empty_dir = {}
      }
      volume {
        name = "unkeyvol"
        secret {
          secret_name = "unkey"
        }
      }
      volume {
        name = "pwdkeyvol"
        secret {
          secret_name = "pwdkey"
        }
      }
    }
  }
}

resource "kubernetes_service" "jenkins" {
  metadata {
    name      = "jenkins"
    #namespace = "${kubernetes_namespace.jenkins_namespace.metadata.0.name}"
  }

  spec {
    selector {
      App = "${kubernetes_replication_controller.jenkins.metadata.0.labels.App}"
    }

    session_affinity = "None"

    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "jenkins-discovery" {
  metadata {
    name      = "jenkins-discovery"
    #namespace = "${kubernetes_namespace.jenkins_namespace.metadata.0.name}"
  }

  spec {
    selector {
      App = "${kubernetes_replication_controller.jenkins.metadata.0.labels.App}"
    }

    port {
      port        = 50000
      target_port = 50000
    }
  }
}

output "lb_ip" {
  value = "${kubernetes_service.jenkins.load_balancer_ingress.0.ip}"
}
