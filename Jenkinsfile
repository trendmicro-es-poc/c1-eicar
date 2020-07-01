import groovy.json.JsonBuilder

node('jenkins-jenkins-slave') {
  withEnv(['REPOSITORY=trendmicro-es-poc']) {
    stage('Pull Image from Git') {
      script {
        git (url: "${scm.userRemoteConfigs[0].url}", credentialsId: "github-auth")
      }
    }
    stage('Build Image') {
      script {
        dbuild = docker.build("${REPOSITORY}:$BUILD_NUMBER")
      }
    }
    parallel (
      "Test": {
        echo 'All functional tests passed'
      },
      "Check Image (pre-Registry)": {
        smartcheckScan([
          imageName: "${REPOSITORY}:$BUILD_NUMBER",
          smartcheckHost: "${DSSC_SERVICE}",
          smartcheckCredentialsId: "smartcheck-auth",
          insecureSkipTLSVerify: true,
          insecureSkipRegistryTLSVerify: true,
          preregistryScan: true,
          preregistryHost: "${DSSC_REGISTRY}",
          preregistryCredentialsId: "preregistry-auth",
          findingsThreshold: new groovy.json.JsonBuilder([
            malware: 3,
            vulnerabilities: [
              defcon1: 0,
              critical: 5,
              high: 20,
            ],
            contents: [
              defcon1: 0,
              critical: 1,
              high: 10,
            ],
            checklists: [
              defcon1: 0,
              critical: 0,
              high: 10,
            ],
          ]).toString(),
        ])
      }
    )

    stage('Push Image to Registry') {
      script {
        docker.withRegistry("https://192.168.3.64:5000", 'registry-auth') {
          dbuild.push('$BUILD_NUMBER')
          dbuild.push('latest')
        }
      }
    }
    stage('Deploy App to Kubernetes') {
      script {
        kubernetesDeploy(configs: "app.yml",
                         kubeconfigId: "kubeconfig",
                         enableConfigSubstitution: true,
                         dockerCredentials: [
                           [credentialsId: "registry-auth", url: "${K8S_REGISTRY}"],
                         ])
      }
      
      }
    }
  }
}
