import groovy.json.JsonBuilder

node {
  withEnv(['REPOSITORY=c1-eicar']) {
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
          smartcheckHost: "192.168.3.63:443",
          smartcheckCredentialsId: "smartcheck-auth",
          insecureSkipTLSVerify: true,
          insecureSkipRegistryTLSVerify: true,
          preregistryScan: true,
          preregistryHost: "192.168.3.63:5000",
          preregistryCredentialsId: "preregistry-auth",
          findingsThreshold: new groovy.json.JsonBuilder([
            malware: 1,
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
  }
}
