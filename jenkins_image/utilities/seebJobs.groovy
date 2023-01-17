freeStyleJob('devops/seedJobs') {
    label('built-in')
    displayName('Seed Jobs')
    logRotator {
        numToKeep(5)
        artifactNumToKeep(1)
    }
    triggers {
        hudsonStartupTrigger {
            quietPeriod('5')
            runOnChoice('ON_CONNECT')
            label('built-in')
            nodeParameterName('')
        }
    }
    parameters {
        gitParameter {
            name('BRANCH')
            defaultValue('master')
            type(gitType)
        }
    }
    scm {
        git {
            remote {
                github('filenkoB/devops', 'https')
            }
            branches('${BRANCH}')
        }
    }
    steps {
        dsl {
            external('jobs/*.groovy')
        }
    }
}