// # Set the Azure Service Principal credentials
// environment {
//   ARM_CLIENT_ID = "<SPN-Client-ID>"
//   ARM_CLIENT_SECRET = "<SPN-Client-Secret>"
//   ARM_SUBSCRIPTION_ID = "<Azure-Subscription-ID>"
//   ARM_TENANT_ID = "<Azure-Tenant-ID>"
// }

# Install the Azure Terraform plugin
pipeline {
  agent any
  tools {
       terraform 'terraform'
    }
  environment {
    ARM_CLIENT_ID = credentials('Jenkins')['ARM_CLIENT_ID']
    ARM_CLIENT_SECRET = credentials('Jenkins')['ARM_CLIENT_SECRET']
    ARM_SUBSCRIPTION_ID = credentials('Jenkins')['ARM_SUBS_ID']
    ARM_TENANT_ID = credentials('Jenkins')['ARM_TENANT_ID']
    ARM_ACCESS_KEY= credentials('access_key')['ARM_ACCESS_KEY']
  }
  stages {
    stage('Install Azure Terraform Plugin') {
      steps {
        sh 'az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET -t $ARM_TENANT_ID'
        sh 'az account set -s $ARM_SUBSCRIPTION_ID' 
        sh 'terraform init'
      }
    }
  }
}

# Run Terraform plan
pipeline {
  agent any
  tools {
       terraform 'terraform'
    }
  stages {
    stage('Run Terraform Plan') {
      steps {
       // sh 'terraform plan -var '
       sh 'terraform plan -var "client_id=$ARM_CLIENT_ID" -var "client_secret=$ARM_CLIENT_SECRET" -var "subscription_id=$ARM_SUBSCRIPTION_ID" -var "tenant_id=$ARM_TENANT_ID"'
      }
    }
  }
}

# Apply Terraform changes
pipeline {
  agent any
  tools {
       terraform 'terraform'
    }
  stages {
    stage('Apply Terraform Changes') {
      steps {
        //sh 'terraform apply -auto-approve' 
        sh 'terraform plan -var "client_id=$ARM_CLIENT_ID" -var "client_secret=$ARM_CLIENT_SECRET" -var "subscription_id=$ARM_SUBSCRIPTION_ID" -var "tenant_id=$ARM_TENANT_ID" --auto-approve '
      }
    }
  }
}