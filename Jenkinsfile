/*
 withCredentials([usernamePassword(credentialsId: '<service_princial>', passwordVariable: 'AZURE_CLIENT_SECRET', usernameVariable: 'AZURE_CLIENT_ID')]) {
       sh '''
          az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID
          az account set -s $AZURE_SUBSCRIPTION_ID
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
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'Jenkins',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                              ), 
                string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
                sh '''      
                az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET -t ARM__TENANT_ID
                az account set -s $AZURE_SUBSCRIPTION_ID
                '''
                           }
                    }
             }
        }

        // stage('Terraform Validate'){
            
        //     steps {
        //             ansiColor('xterm') {
        //             withCredentials([azureServicePrincipal(
        //             credentialsId: 'Jenkins',
        //             subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
        //             clientIdVariable: 'ARM_CLIENT_ID',
        //             clientSecretVariable: 'ARM_CLIENT_SECRET',
        //             tenantIdVariable: 'ARM_TENANT_ID'
        //         ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
                        
        //                 sh """
                                
        //                 terraform validate
        //                 """
        //                    }
        //             }
        //      }
        // }

        // stage('Terraform Plan'){
        //     steps {

        //             ansiColor('xterm') {
        //             withCredentials([azureServicePrincipal(
        //             credentialsId: 'Jenkins',
        //             subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
        //             clientIdVariable: 'ARM_CLIENT_ID',
        //             clientSecretVariable: 'ARM_CLIENT_SECRET',
        //             tenantIdVariable: 'ARM_TENANT_ID'
        //         ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
                        
        //                 sh """
                        
        //                 echo "Creating Terraform Plan"
        //                 terraform plan -var "client_id=$ARM_CLIENT_ID" -var "client_secret=$ARM_CLIENT_SECRET" -var "subscription_id=$ARM_SUBSCRIPTION_ID" -var "tenant_id=$ARM_TENANT_ID"
        //                 """
        //                 }
        //         }
        //     }
        // }

        // stage('Waiting for Approval'){
        //     steps {
        //         timeout(time: 10, unit: 'MINUTES') {
        //             input (message: "Deploy the infrastructure?")
        //         }
        //     }
        
        // }
    

        // stage('Terraform Apply'){
        //     steps {
        //             ansiColor('xterm') {
        //             withCredentials([azureServicePrincipal(
        //             credentialsId: 'Jenkins',
        //             subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
        //             clientIdVariable: 'ARM_CLIENT_ID',
        //             clientSecretVariable: 'ARM_CLIENT_SECRET',
        //             tenantIdVariable: 'ARM_TENANT_ID'
        //         ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {

        //                 sh """
        //                 echo "Applying the plan"
        //                 terraform apply -auto-approve -var "client_id=$ARM_CLIENT_ID" -var "client_secret=$ARM_CLIENT_SECRET" -var "subscription_id=$ARM_SUBSCRIPTION_ID" -var "tenant_id=$ARM_TENANT_ID"
        //                 """
        //                         }
        //         }
        //     }
        // }

    }
}

