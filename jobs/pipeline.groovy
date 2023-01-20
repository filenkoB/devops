pipelineJob('devops/develop-pipeline') {
    displayName('develop-pipeline')

    triggers {
        githubPush()
        upstream('devops/seedJobs')
    }

    parameters{
        gitParameter{
            name('GIT_BRANCH')
            defaultValue('develop')
            type('Branch')
            branch('')
            branchFilter('origin/(.*)')
            tagFilter('')
            sortMode('ASCENDING_SMART')
            selectedValue('NONE')
            useRepository('')
            quickFilterEnabled(true)
        }
    }
    definition {
        cpsScm {
            scm {
                github('filenkoB/homepage', '${GIT_BRANCH}', 'https')
            }
            scriptPath('Jenkinsfile')
        }
    }
}
