pipeline {
    agent any
    environment {
        hello=123456
        world=456789
    }

    stages {
        stage('环境监测') {
            steps {
                sh 'whoami'
            }
        }
        stage('编译') {
            agent {
                docker {image 'golang:latest'}
            }
            steps {
                //
                sh 'go version'
            }
        }
        stage('测试') {
            steps {
                //
                echo '测试...'
            }
        }
        stage('打包') {
            steps {
                //
                echo '打包...'
            }
        }
        stage('部署') {
            steps {
                //
                echo '部署...'
            }
        }
        stage('发送报告') {
            steps {
                echo '开始发送报告.....'
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