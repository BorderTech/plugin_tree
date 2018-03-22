class jenkins::plugins {

  jenkins_plugins { 'jenkins_plugins_provider':
    name        => 'installing_jenkins_plugins',
    plugins     => {
      'matrix-project'                    => '1.7.1',
      'maven-plugin'                      => '2.14',
      'ace-editor'                        => '1.1',
      'analysis-collector'                => '1.50',
      'analysis-core'                     => '1.82',
      'antisamy-markup-formatter'         => '1.5',
      'ant'                               => '1.4',
      'async-http-client'                 => '1.7.24.1',
      'authentication-tokens'             => '1.3',
      'bouncycastle-api'                  => '1.0.2',
      'branch-api'                        => '1.11.1',
      'build-failure-analyzer'            => '1.17.2',
      'build-flow-plugin'                 => '0.20',
      'build-timeout'                     => '1.18',
      'checkstyle'                        => '3.47',
      'chucknorris'                       => '1.0',
      'claim'                             => '2.9',
      'cloudbees-bitbucket-branch-source' => '1.9',
      'cloudbees-folder'                  => '5.15',
      'cobertura'                         => '1.9.8',
      'collabnet'                         => '2.0.2',
      'conditional-buildstep'             => '1.3.5',
      'config-file-provider'              => '2.15.1',
      'configurationslicing'              => '1.47',
      'credentials-binding'               => '1.10',
      'credentials'                       => '2.1.10',
      'cvs'                               => '2.13',
      'dashboard-view'                    => '2.9.10',
      'display-url-api'                   => '0.5',
      'docker-commons'                    => '1.5',
      'docker-workflow'                   => '1.9.1',
      'dry'                               => '2.46',
      'durable-task'                      => '1.12',
      'email-ext'                         => '2.53',
      'emailext-template'                 => '1.0',
      'embeddable-build-status'           => '1.9',
      'external-monitor-job'              => '1.6',
      'extra-tool-installers'             => '0.3',
      'filesystem-list-parameter-plugin'  => '0.0.3',
      'findbugs'                          => '4.69',
      'gerrit-trigger'                    => '2.23.0',
      'git-client'                        => '2.7.1',
      'github-api'                        => '1.82',
      'github-branch-source'              => '1.10.1',
      'github'                            => '1.25.0',
      'github-organization-folder'        => '1.5',
      'git'                               => '3.0.1',
      'git-server'                        => '1.7',
      'gradle'                            => '1.25',
      'groovy'                            => '1.30',
      'handlebars'                        => '1.1.1',
      'htmlpublisher'                     => '1.11',
      'icon-shim'                         => '2.0.3',
      'ivy'                               => '1.26',
      'jackson2-api'                      => '2.7.3',
      'jacoco'                            => '2.1.0',
      'javadoc'                           => '1.4',
      'job-dsl'                           => '1.55',
      'job-restrictions'                  => '0.6',
      'jquery-detached'                   => '1.2.1',
      'jquery'                            => '1.11.2-0',
      'jquery-ui'                         => '1.0.2',
      'junit'                             => '1.19',
      'jython'                            => '1.9',
      'ldap'                              => '1.13',
      'logfilesizechecker'                => '1.2',
      'logstash'                          => '1.2.0',
      'mailer'                            => '1.18',
      'managed-scripts'                   => '1.3',
      'mapdb-api'                         => '1.0.9.0',
      'mask-passwords'                    => '2.9',
      'matrix-auth'                       => '1.4',
      'mercurial'                         => '1.57',
      'metrics'                           => '3.1.2.9',
      'momentjs'                          => '1.1.1',
      'mttr'                              => '1.1',
      'multi-branch-project-plugin'       => '0.5.1',
      'multiple-scms'                     => '0.6',
      'naginator'                         => '1.17.2',
      'nant'                              => '1.4.3',
      #'nexus-jenkins-plugin'              => '1.1.0-05' ,
      'node-iterator-api'                 => '1.5.0',
      'pam-auth'                          => '1.3',
      'parameterized-trigger'             => '2.32',
      'pipeline-build-step'               => '2.4',
      'pipeline-graph-analysis'           => '1.3',
      'pipeline-input-step'               => '2.5',
      'pipeline-milestone-step'           => '1.3',
      'pipeline-rest-api'                 => '2.4',
      'pipeline-stage-step'               => '2.2',
      'pipeline-stage-view'               => '2.4',
      'pipeline-utility-steps'            => '1.3.0',
      'plain-credentials'                 => '1.3',
      'pmd'                               => '3.46',
      'PrioritySorter'                    => '3.4.1',
      'project-inheritance'               => '1.5.3',
      'promoted-builds'                   => '2.28',
      'publish-over-ssh'                  => '1.14',
      'python'                            => '1.3',
      'rabbitmq-consumer'                 => '2.7',
      'rebuild'                           => '1.25',
      'resource-disposer'                 => '0.3',
      'run-condition'                     => '1.0',
      'scm-api'                           => '1.3',
      'script-security'                   => '1.27',
      'sidebar-link'                      => '1.7',
      'slave-status'                      => '1.6',
      'sonar'                             => '2.5',
      'ssh-agent'                         => '1.15',
      'ssh-credentials'                   => '1.12',
      'ssh'                               => '2.4',
      'ssh-slaves'                        => '1.12',
      'structs'                           => '1.5',
      'subversion'                        => '2.7.1',
      'support-core'                      => '2.38',
      'tasks'                             => '4.50',
      'timestamper'                       => '1.8.8',
      'token-macro'                       => '2.0',
      'violations'                        => '0.7.11',
      'vsphere-cloud'                     => '2.15',
      'warnings'                          => '4.59',
      'windows-slaves'                    => '1.2',
      'workflow-aggregator'               => '2.4',
      'workflow-api'                      => '2.8',
      'workflow-basic-steps'              => '2.3',
      'workflow-cps-global-lib'           => '2.5',
      'workflow-cps'                      => '2.23',
      'workflow-durable-task-step'        => '2.6',
      'workflow-job'                      => '2.9',
      'workflow-multibranch'              => '2.9.2',
      'workflow-scm-step'                 => '2.3',
      'workflow-step-api'                 => '2.12',
      'workflow-support'                  => '2.11',
      'ws-cleanup'                        => '0.32',
      'swarm'                             => '3.10',
    },
    source      => 'ftp-nyc.osuosl.org',
    source_path => '/pub/jenkins/plugins',
    dest_path   => '/var/lib/jenkins/plugins',
    owner       => 'jenkins',
    group       => 'jenkins',
    require     => File['/var/lib/jenkins/plugins']
  }

  file { '/var/lib/jenkins/plugins':
    ensure => 'directory',
    owner  => 'jenkins',
    group  => 'jenkins',
    mode   => '0750',
    before => Jenkins_plugins['jenkins_plugins_provider'],
  }
}
