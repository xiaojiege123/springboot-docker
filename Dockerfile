#基础镜像，如果本地没有，会从远程仓库拉取。
FROM openjdk:8-jdk-alpine

#镜像的制作人
MAINTAINER xzxiaoshan/365384722@qq.com

#工作目录
WORKDIR /app/

#在容器中创建挂载点，可以多个
VOLUME ["/tmp"]

#声明了容器应该打开的端口并没有实际上将它打开
EXPOSE 8080

#定义参数
ARG JAR_FILE

#拷贝本地文件到镜像中
COPY ${JAR_FILE} app.jar

#指定容器启动时要执行的命令，但如果存在CMD指令，CMD中的参数会被附加到ENTRYPOINT指令的后面
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","app.jar"]
