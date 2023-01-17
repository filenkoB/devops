pipelineJob('devops/pipeline-job') {
    displayName('devops-pipeline')
    parameters{
        gitParameter{
            name('GIT_BRANCH')
            defaultValue('develop')
            type('PT_BRANCH_TAG')
        }
    }
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        github('filenkoB/Kanbanizer')
                    }
                    branches('${GIT_BRANCH}')
                }
            }
            scriptPath('Jenkinsfile')
        }
    }
}