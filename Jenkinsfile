node {
    environment {
        APP_NAME = "SampleNodeJs"
        STAGING = "Staging"
        PRODUCTION = "Production"
    }
 
    stage('Checkout') {
        // Checkout our application source code
        git url: 'https://github.com/bradking1329/JenkinsBankApp.git'
    }

    stage('Build') {
        // Lets build our docker image
        dir ('sample-bank-app-service') {
            def app = docker.build("sample-bankapp-service:${BUILD_NUMBER}")
        }
    }
    
    stage('CleanStaging') {
        // The cleanup script makes sure no previous docker staging containers run
        dir ('sample-bank-app-service') {
            sh "python3 cleanup.py SampleOnlineBankStaging"
        }
    }
    
    stage('DeployStaging') {
        // Lets deploy the previously build container
        def app = docker.image("sample-bankapp-service:${BUILD_NUMBER}")
        app.run("--network mynetwork --name SampleOnlineBankStaging -p 3000:3000 " +
                "-e 'DT_CLUSTER_ID=SampleOnlineBankStaging' " + 
                "-e 'DT_TAGS=Environment=Staging Service=Sample-NodeJs-Service' " +
                "-e 'DT_CUSTOM_PROP=ENVIRONMENT=Staging JOB_NAME=${JOB_NAME} " + 
                    "BUILD_TAG=${BUILD_TAG} BUILD_NUMBER=${BUIlD_NUMBER}'")

        dir ('dynatrace-scripts') {
            // push a deployment event on the host with the tag JenkinsInstance created using automatic tagging rule
            sh './pushdeployment.sh HOST CONTEXTLESS JenkinsInstance ACM_Security_Group ' +
               '${BUILD_TAG} ${BUILD_NUMBER} ${JOB_NAME} ' + 
               'Jenkins ${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT}'
            
            // now I push one on the actual service (it has the tags from our rules)
            sh './pushdeployment.sh SERVICE CONTEXTLESS DockerService SampleOnlineBankStaging ' + 
               '${BUILD_TAG} ${BUILD_NUMBER} ${JOB_NAME} ' + 
               'Jenkins ${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT}'
            
            // Create a sample synthetic monitor so as to check the UI functionlity
            sh './synthetic-monitor.sh Staging '+  '${JOB_NAME} ${BUILD_NUMBER}' + ' 3000'
            
            // Create a sample dashboard for the staging stage
            sh './create-dashboard.sh Staging '+  '${JOB_NAME} ${BUILD_NUMBER}' + ' DockerService SampleOnlineBankStaging'
        }
    }
    
    stage('Testing') {
        // lets push an event to dynatrace that indicates that we START a load test
        dir ('dynatrace-scripts') {
            sh './pushevent.sh SERVICE CONTEXTLESS DockerService SampleOnlineBankStaging ' +
               '"STARTING Load Test" ${JOB_NAME} "Starting a Load Test as part of the Testing stage"' + 
               ' ${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT}'
        }
        
        // lets run some test scripts
        dir ('sample-bank-app-service-tests') {
            // start load test - simulating traffic for Staging enviornment on port 3000 

            sh "rm -f stagingloadtest.log stagingloadtestcontrol.txt"
            sh "python3 smoke-test.py 3000 200 ${BUILD_NUMBER} stagingloadtest.log ${PUBLIC_IP} SampleOnlineBankStaging"
            archiveArtifacts artifacts: 'stagingloadtest.log', fingerprint: true
        }

        // lets push an event to dynatrace that indicates that we STOP a load test
        dir ('dynatrace-scripts') {
            sh './pushevent.sh SERVICE CONTEXTLESS DockerService SampleOnlineBankStaging '+
               '"STOPPING Load Test" ${JOB_NAME} "Stopping a Load Test as part of the Testing stage" '+
               '${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT}'
        }

        // lets push an event to dynatrace that indicates that we START a sanity test
        dir ('dynatrace-scripts') {
            sh './pushevent.sh SERVICE CONTEXTLESS DockerService SampleOnlineBankStaging ' +
               '"STARTING Sanity-Test" ${JOB_NAME} "Starting Sanity-test of the Testing stage"' + 
               ' ${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT}'
        }
        
        // lets run some test scripts
        dir ('sample-bank-app-service-tests') {
            // start load test - simulating traffic for Staging enviornment on port 3000 

            sh "rm -f stagingloadtest.log stagingloadtestcontrol.txt"
            sh "python3 sanity-test.py 3000 10 ${BUILD_NUMBER} stagingsanitytest.log ${PUBLIC_IP} SampleOnlineBankStaging"
            archiveArtifacts artifacts: 'stagingsanitytest.log', fingerprint: true
        }

        // lets push an event to dynatrace that indicates that we STOP a load test
        dir ('dynatrace-scripts') {
            sh './pushevent.sh SERVICE CONTEXTLESS DockerService SampleOnlineBankStaging '+
               '"STOPPING Sanity Test" ${JOB_NAME} "Stopping Sanity-test of the Testing stage" '+
               '${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT}'
        }
    }
    
    stage('ValidateStaging') {
        // lets see if Dynatrace AI found problems -> if so - we can stop the pipeline!
        dir ('dynatrace-scripts') {
            DYNATRACE_PROBLEM_COUNT = sh 'python3 checkforproblems.py ${DT_URL} ${DT_TOKEN} DockerService:SampleOnlineBankStaging'
            echo "Dynatrace Problems Found: ${DYNATRACE_PROBLEM_COUNT}"
        }
        
        // now lets generate a report using our CLI and lets generate some direct links back to dynatrace
        dir ('dynatrace-scripts') {
            sh 'python3 make_api_call.py ${DT_URL} ${DT_TOKEN} DockerService:SampleOnlineBankStaging '+
                        'service.responsetime'
            sh 'mv Test_report.csv Test_report_staging.csv'
            archiveArtifacts artifacts: 'Test_report_staging.csv', fingerprint: true
        }
    }
    
    stage('DeployProduction') {
        // first we clean production
        dir ('sample-bank-app-service') {
            sh "python3 cleanup.py SampleOnlineBankProduction"
        }

        // now we deploy the new container
        def app = docker.image("sample-bankapp-service:${BUILD_NUMBER}")
        app.run("--network mynetwork --name SampleOnlineBankProduction -p 3010:3000 "+
                "-e 'DT_CLUSTER_ID=SampleOnlineBankProduction' "+
                "-e 'DT_TAGS=Environment=Production Service=Sample-NodeJs-Service' "+
                "-e 'DT_CUSTOM_PROP=ENVIRONMENT=Production JOB_NAME=${JOB_NAME} "+
                    "BUILD_TAG=${BUILD_TAG} BUILD_NUMBER=${BUIlD_NUMBER}'")

        dir ('dynatrace-scripts') {
            // push a deployment event on the host with the tag JenkinsInstance:ANZ_ACM_Security_Group
            sh './pushdeployment.sh HOST CONTEXTLESS JenkinsInstance ANZ_ACM_Security_Group '+
               '${BUILD_TAG} ${BUILD_NUMBER} ${JOB_NAME} Jenkins '+
               '${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT}'
            
            // now I push one on the actual service (it has the tags from our rules)
            sh './pushdeployment.sh SERVICE CONTEXTLESS DockerService SampleOnlineBankProduction '+
               '${BUILD_TAG} ${BUILD_NUMBER} ${JOB_NAME} Jenkins '+
               '${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT}'

            // Create a sample synthetic monitor so as to check the UI functionlity
           sh './synthetic-monitor.sh Production '+  '${JOB_NAME} ${BUILD_NUMBER}' + ' 3010'
            
          // Create a sample dashboard for the staging stage
          sh './create-dashboard.sh Production '+  '${JOB_NAME} ${BUILD_NUMBER}' + ' DockerService SampleOnlineBankProduction'    
            
        }        
    }    
    
    stage('WarmUpProduction') {
        // lets push an event to dynatrace that indicates that we START a load test
        dir ('dynatrace-scripts') {
            sh './pushevent.sh SERVICE CONTEXTLESS DockerService SampleOnlineBankProduction '+
               '"STARTING Load Test" ${JOB_NAME} "Starting a Load Test to warm up new prod deployment" '+
               '${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT}'
        }
        
        // lets run some test scripts
        dir ('sample-bank-app-service-tests') {
            // start load test and run for 120 seconds - simulating traffic for Production enviornment on port 3010 
            sh "rm -f productionloadtest.log productionloadtestcontrol.txt"
            sh "python3 smoke-test.py 3010 10 ${BUILD_NUMBER} productionloadtest.log ${PUBLIC_IP} SampleOnlineBankProduction "
            archiveArtifacts artifacts: 'productionloadtest.log', fingerprint: true
        }

        // lets push an event to dynatrace that indicates that we STOP a load test
        dir ('dynatrace-scripts') {
            sh './pushevent.sh SERVICE CONTEXTLESS DockerService SampleOnlineBankProduction '+
               '"STOPPING Load Test" ${JOB_NAME} "Stopping a Load Test as part of the Production warm up phase" '+
               '${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT}'
        }
    }
    
    stage('ValidateProduction') {
        dir ('dynatrace-scripts') {
            DYNATRACE_PROBLEM_COUNT = sh (script: './checkforproblems.sh', returnStatus : true)
            echo "Dynatrace Problems Found: ${DYNATRACE_PROBLEM_COUNT}"
        }
        
        // now lets generate a report using our CLI and lets generate some direct links back to dynatrace
        dir ('dynatrace-scripts') {
            sh 'python3 make_api_call.py ${DT_URL} ${DT_TOKEN} DockerService:SampleOnlineBankProduction '+
                        'service.responsetime'
            sh 'mv Test_report.csv Test_report_prod.csv'
            archiveArtifacts artifacts: 'Test_report_prod.csv', fingerprint: true
        }
    }    
}
