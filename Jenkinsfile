pipeline {
    agent {
        docker {image 'golang:latest'}
    }
    stages {
        stage('环境监测') {
            steps {
                sh 'export GO111MODULE=on'
                sh "export GOPROXY='https://goproxy.cn,direct'"
                sh 'printenv'
                sh 'pwd && ls -alh'
            }
        }
        stage('初始化环境') {
            steps {
                sh 'rm -f go.mod'
                sh 'go mod init go_test'
                sh 'printenv'
                sh 'echo $GOPROXY'
                sh 'go mod tidy'
            }
        }
        stage('测试') {
            steps {
                sh 'go run main.go'
            }
        }
        stage('构建镜像') {
            steps {
                sh 'docker build -t go_test .'
            }
        }
        stage('推送镜像') {
            steps {
                input message: '需要部署到线上吗？', ok: '需要', parameters: [text(defaultValue: 'v1.0', description: '线上环境需要部署的版本', name: 'IMAGE_VERSION')]
                withCredentials([usernamePassword(credentialsId: '2e98779c-545f-4ea3-b362-f69bf9cd2f9c', passwordVariable: 'aliyun_repo_pwd', usernameVariable: 'aliyun_repo_user')]) {
                    // some block
                    sh 'docker images -a'
                    sh "docker login -u ${aliyun_repo_user} -p ${aliyun_repo_pwd} registry.cn-hangzhou.aliyuncs.com"
                    sh "docker tag go_test registry.cn-hangzhou.aliyuncs.com/annnj/go_test:${IMAGE_VERSION}"
                    sh "docker push registry.cn-hangzhou.aliyuncs.com/annnj/go_test:${IMAGE_VERSION}"
                }
            }
        }
        stage('发送报告') {
            steps {
                sh 'echo 开始发送报告...'
                emailext body: '''<!DOCTYPE html>
                <html>
                <head>
                <meta charset="UTF-8">
                <title>${ENV, var="JOB_NAME"}-第${BUILD_NUMBER}次构建日志</title>
                </head>

                <body leftmargin="8" marginwidth="0" topmargin="8" marginheight="4"
                    offset="0">
                    <table width="95%" cellpadding="0" cellspacing="0"  style="font-size: 11pt; font-family: Tahoma, Arial, Helvetica, sans-serif">
                <h3>本邮件由系统自动发出，请勿回复！</h3>
                        <tr>
                           <br/>
                            各位同事，大家好，以下为${PROJECT_NAME }项目构建信息</br>
                            <td><font color="#CC0000">构建结果 - ${BUILD_STATUS}</font></td>
                        </tr>
                        <tr>
                            <td><br />
                            <b><font color="#0B610B">构建信息</font></b>
                            <hr size="2" width="100%" align="center" /></td>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>项目名称 ： ${PROJECT_NAME}</li>
                                    <li>构建编号 ： 第${BUILD_NUMBER}次构建</li>
                                    <li>触发原因： ${CAUSE}</li>
                                    <li>构建状态： ${BUILD_STATUS}</li>
                                    <li>构建日志： <a href="${BUILD_URL}console">${BUILD_URL}console</a></li>
                                    <li>构建  Url ： <a href="${BUILD_URL}">${BUILD_URL}</a></li>
                                    <li>工作目录 ： <a href="${PROJECT_URL}ws">${PROJECT_URL}ws</a></li>
                                    <li>项目  Url ： <a href="${PROJECT_URL}">${PROJECT_URL}</a></li>
                                </ul>


                <h4><font color="#0B610B">最近提交</font></h4>
                <ul>
                <hr size="2" width="100%" />
                ${CHANGES_SINCE_LAST_SUCCESS, reverse=true, format="%c", changesFormat="<li>%d [%a] %m</li>"}
                </ul>
                详细提交: <a href="${PROJECT_URL}changes">${PROJECT_URL}changes</a><br/>

                            </td>
                        </tr>
                    </table>
                </body>
                </html>''', subject: '${ENV, var="JOB_NAME"}-第${BUILD_NUMBER}次构建日志', to: '381147353@qq.com'
            }
        }
    }
}