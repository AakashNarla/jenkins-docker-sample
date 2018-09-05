node{
   stage('SCM Checkout'){
       checkout SCM
   }
   stage('Build Docker Image'){
     sh 'docker build -t aakash/my-app:2.0.0 .'
   }   
}