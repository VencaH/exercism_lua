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
                    List<String> exercises = getChangedExercise()
                    println ("Changed exercises: " + exercises)
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
                                    sh "cd ./${exercise} && busted ."
                                }
                                
                                stage('submitting ${exercise}'){
                                    sh "exercism submit ${exercise}/${exercise}.lua"
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
    return getChangedFilesList()
        .findAll {item -> item.contains('/') && item.contains('.lua')} // make sure that only lua file in exercise subfolders are checked
        .collect {it.tokenize("/")[0]}
        .unique(false)
}
