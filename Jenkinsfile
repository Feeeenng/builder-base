podTemplate(label: 'node-pod',  containers: [
 containerTemplate(
         name: 'base',
         image: 'feeeng/builder-base',
         ttyEnabled: true,
         command: 'cat'
     ),
 containerTemplate(
         name: 'jnlp',
         image: 'registry.cn-hangzhou.aliyuncs.com/google-containers/jnlp-slave:alpine',
         args: '${computer.jnlpmac} ${computer.name}',
         command: ''
     )
]
,volumes: [
     /*persistentVolumeClaim(mountPath: '/home/jenkins', claimName: 'jenkins', readOnly: false),*/
     hostPathVolume(hostPath: '/root/work/jenkins', mountPath: '/home/jenkins'),
     hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock'),
])
{
 node ('base-pod') {
    stage(' build and tag images'){
        containers('base')
         sh '''docker build -t feeeng/builder-base . '''
    }
    stage('docker push '){
        containers('base'){
        sh 'docker push feeeng/builder-base'
        }
    }

    /*
        stage('update language images'){
            steps{
                build job:'../builder-maven/master', wait:false
                build job:'../builder-nodejs/master', wait: false

             }

        }
    */
}
}