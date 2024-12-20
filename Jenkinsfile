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
        stage('Test solutions') {
            steps{
                script{
                    parallel getChangedExercise().collectEntries {exercise ->
                        [
                            (exercise): {
                                stage('testing ${exercise}'){
                                    sh "cd ./${exercise}"
                                    sh "busted"
                                }
                                
                                stage('submitting ${exercise}'){
                                    sh "exercism submit ${exercise}.lua"
                                }
                            }
                        ]
                        
                    }
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

@NonCPS
List<String> getChangedExercise() {
    return getChangedFilesList().collect {it.tokenize("/")[0]}.unique(false)
}
