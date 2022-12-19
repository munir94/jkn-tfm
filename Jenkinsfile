/*
 withCredentials([usernamePassword(credentialsId: '<service_princial>', passwordVariable: 'AZURE_CLIENT_SECRET', usernameVariable: 'AZURE_CLIENT_ID')]) {
       sh '''
          az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID
          az account set -s $AZURE_SUBSCRIPTION_ID

          azureCLI commands: [[exportVariablesString: '', script: 'az group create -n MyResourceGroup --location northeurope'], [exportVariablesString: '/publicIpAddress|PUBLIC_IP', script: 'az vm create -n MyLinuxVM -g MyResourceGroup --image UbuntuLTS --data-disk-sizes-gb 10 20']], principalCredentialId: '<credential_id>
*/


pipeline{
    agent any 
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }
    environment {
        TF_HOME = tool('terraform')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
    }
    stages {
    
        stage('Terraform Init'){
            
                 steps {
    
    withCredentials([azureServicePrincipal(credentialsId: 'CPE-Jenkins',
                                    subscriptionIdVariable: 'SUBS_ID',
                                    clientIdVariable: 'CLIENT_ID',
                                    clientSecretVariable: 'CLIENT_SECRET',
                                    tenantIdVariable: 'TENANT_ID')]) {
    sh 'az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET -t $TENANT_ID'
    sh 'az account set --subscription $SUBS_ID'
    sh 'terraform init '
}
}
        }

        stage('Terraform Validate'){
            
                         steps {
    
    withCredentials([azureServicePrincipal(credentialsId: 'CPE-Jenkins',
                                    subscriptionIdVariable: 'SUBS_ID',
                                    clientIdVariable: 'CLIENT_ID',
                                    clientSecretVariable: 'CLIENT_SECRET',
                                    tenantIdVariable: 'TENANT_ID')]) {
   
    sh 'terraform validate'
}
}
        }

        stage('Terraform Plan'){
                          steps {
    
    withCredentials([azureServicePrincipal(credentialsId: 'CPE-Jenkins',
                                    subscriptionIdVariable: 'SUBS_ID',
                                    clientIdVariable: 'CLIENT_ID',
                                    clientSecretVariable: 'CLIENT_SECRET',
                                    tenantIdVariable: 'TENANT_ID')]) {
  
    sh 'terraform plan -var "client_id=$CLIENT_ID" -var "client_secret=$CLIENT_SECRET" -var "subscription_id=$SUBS_ID" -var "tenant_id=$TENANT_ID"'
    //sh 'terraform plan'
}
}
        }

        stage('Waiting for Approval'){
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input (message: "Deploy the infrastructure?")
                }
            }
        
        }
    

        stage('Terraform Apply'){
                                  steps {
    
    withCredentials([azureServicePrincipal(credentialsId: 'CPE-Jenkins',
                                    subscriptionIdVariable: 'SUBS_ID',
                                    clientIdVariable: 'CLIENT_ID',
                                    clientSecretVariable: 'CLIENT_SECRET',
                                    tenantIdVariable: 'TENANT_ID')]) {
  
    sh 'terraform apply -var "client_id=$CLIENT_ID" -var "client_secret=$CLIENT_SECRET" -var "subscription_id=$SUBS_ID" -var "tenant_id=$TENANT_ID" --auto-approve'
    //sh 'terraform apply'
}
}
        }

    }
}

