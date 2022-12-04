echo "export USE_GKE_GCLOUD_AUTH_PLUGIN=True" >> /etc/profile
  sudo yum install -y google-cloud-sdk-gke-gcloud-auth-plugin
  sudo yum install -y kubectl
  sudo yum install -y bash-completion
  source <(kubectl completion bash)
  echo "gcloud container clusters get-credentials $${cluster_name} --zone $${cluster_zone} --project $${project} > /dev/null 2>&1" >> /etc/profile
  echo "source <(kubectl completion bash)" >> ~/.bashrc 
  sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
  sudo yum install -y yum-utils
  sudo yum-config-manager \
      —add-repo \
       https://download.docker.com/linux/centos/docker-ce.repo

  sudo yum -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
  systemctl enable —now docker
  sudo usermod -a -G docker gmlxo4409