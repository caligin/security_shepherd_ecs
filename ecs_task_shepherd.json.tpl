[
    {
      "volumesFrom": [],
      "memory": 300,
      "extraHosts": null,
      "dnsServers": null,
      "disableNetworking": null,
      "dnsSearchDomains": null,
      "portMappings": [],
      "hostname": null,
      "essential": true,
      "entryPoint": null,
      "mountPoints": [],
      "name": "shepherd_database",
      "ulimits": null,
      "dockerSecurityOptions": null,
      "environment": [
        {
          "name": "MYSQL_ROOT_PASSWORD",
          "value": "${mysql_root_password}"
        }
      ],
      "links": null,
      "workingDirectory": null,
      "readonlyRootFilesystem": null,
      "image": "${shepherd_database_image}",
      "command": null,
      "user": null,
      "dockerLabels": null,
      "logConfiguration": null,
      "cpu": 1,
      "privileged": null,
      "memoryReservation": null
    },
    {
      "volumesFrom": [],
      "memory": 1024,
      "extraHosts": null,
      "dnsServers": null,
      "disableNetworking": null,
      "dnsSearchDomains": null,
      "portMappings": [],
      "hostname": null,
      "essential": true,
      "entryPoint": null,
      "mountPoints": [],
      "name": "shepherd_app",
      "ulimits": null,
      "dockerSecurityOptions": null,
      "environment": [],
      "links": [
        "shepherd_database:mysql"
      ],
      "workingDirectory": null,
      "readonlyRootFilesystem": null,
      "image": "${shepherd_app_image}",
      "command": null,
      "user": null,
      "dockerLabels": null,
      "logConfiguration": null,
      "cpu": 1,
      "privileged": null,
      "memoryReservation": null
    },
    {
      "volumesFrom": [],
      "memory": 100,
      "extraHosts": null,
      "dnsServers": null,
      "disableNetworking": null,
      "dnsSearchDomains": null,
      "portMappings": [
        {
          "hostPort": 2222,
          "containerPort": 22,
          "protocol": "tcp"
        }
      ],
      "hostname": null,
      "essential": true,
      "entryPoint": null,
      "mountPoints": [],
      "name": "shepherd_bastion",
      "ulimits": null,
      "dockerSecurityOptions": null,
      "environment": [],
      "links": [
        "shepherd_app:shepherd.local"
      ],
      "workingDirectory": null,
      "readonlyRootFilesystem": null,
      "image": "${shepherd_bastion_image}",
      "command": null,
      "user": null,
      "dockerLabels": null,
      "logConfiguration": null,
      "cpu": 1,
      "privileged": null,
      "memoryReservation": null
    }
  ]
