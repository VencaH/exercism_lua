pipeline {
    agent any


    stages {
        stage('Git Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }
        stage('Get changes'){
            steps{
                script{

                    List<String> changes = getChangedFilesList()
                    println ("Changed file list: " + changes)
                }
            }
        }
    }
}

@NonCPS
List<String> getChangedFilesList(){
    def changedFiles = []
    for ( changeLogSet in currentBuild.changeSets){
        for (entry in changeLogSet.getItems()){
            changedFiles.addAll(entry.affectedPaths)
        }
    }
    return changedFiles
}
