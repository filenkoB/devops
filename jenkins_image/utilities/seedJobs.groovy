freeStyleJob('devops/seedJobs') {
    label('built-in')
    displayName('Seed Jobs')
    logRotator {
        numToKeep(5)
        artifactNumToKeep(1)
    }
    triggers {
        hudsonStartupTrigger {
            quietPeriod('10')
            runOnChoice('ON_CONNECT')
            label('built-in')
            nodeParameterName('')
        }
        githubPush()
    }
    parameters {
        gitParameter {
            name('BRANCH')
            defaultValue('main')
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
    scm {
        github('filenkoB/devops', '${BRANCH}', 'https')
    }
    steps {
        dsl {
            external('jobs/*.groovy')
        }
    }
}