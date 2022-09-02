terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.AWS_REGION
}

resource "aws_apprunner_service" "test111" {
  service_name = var.SERVICE_NAME

  source_configuration {
    authentication_configuration {
      connection_arn = var.GITHUB_CONNECTIONS
    }

    code_repository {
      code_configuration {
        code_configuration_values {
          build_command = "chmod +x ${var.SHELL_FILE}"
          port          = var.APPRUNNER_PORT
          runtime       = var.APPRUNNER_RUNTIME
          start_command = "./${var.SHELL_FILE} ${var.JMX_File} ${var.S3BUCKET_NAME}"
        }
        configuration_source = "API"
      }

      repository_url = var.REPO
      source_code_version {
        type  = "BRANCH"
        value = "main"
      }

    }
  }

  instance_configuration {
    instance_role_arn = var.S3_ROLE
  }
  health_check_configuration {
    healthy_threshold   = "1"
    unhealthy_threshold = "1"
  }
  tags = {
    Name = var.SERVICE_NAME
  }
}