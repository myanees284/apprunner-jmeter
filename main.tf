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
  region = "us-east-2"
}

resource "aws_apprunner_service" "test111" {
  service_name = "test111"

  source_configuration {
    authentication_configuration {
      connection_arn = "arn:aws:apprunner:us-east-2:692388825507:connection/test-1/817353c94304440ca09d4f054ed931dc"
    }

    code_repository {
      code_configuration {
        code_configuration_values {
          build_command = "chmod +x run_test.sh"
          port          = "80"
          runtime       = "CORRETTO_11"
          start_command = "./run_test.sh my_test"
        }
        configuration_source = "API"
      }
      repository_url = "https://github.com/myanees284/apprunner-jmeter"
      source_code_version {
        type  = "BRANCH"
        value = "main"
      }
    }
  }

 instance_configuration {
            instance_role_arn = "arn:aws:iam::692388825507:role/apprunner_role"
        }
  tags = {
    Name = "super-service"
  }
}