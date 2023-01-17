pipelineJob('devops/pipeline-job') {
    displayName('devops-pipeline')
    parameters{
        gitParameter{
            name('GIT_BRANCH')
            defaultValue('develop')
            type('PT_BRANCH_TAG')
            branch('')
            branchFilter('origin/(.)')
            tagFilter('')
            sortMode('DESCENDING_SMART')
            selectedValue('NONE')
            useRepository('')
            quickFilterEnabled(true)
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