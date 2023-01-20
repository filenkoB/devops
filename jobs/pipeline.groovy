pipelineJob('devops/develop-pipeline') {
    displayName('develop-pipeline')

    triggers {
        githubPush()
    }
    definition {
        cpsScm {
            scm {
                github('filenkoB/homepage', 'develop', 'https')
            }
            scriptPath('Jenkinsfile')
        }
    }
}
