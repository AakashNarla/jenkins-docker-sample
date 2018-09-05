node {
    def app

    stage('Clone repository') {
      checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("aakash/demo-app")
    }

    
}