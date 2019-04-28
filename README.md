# springboot-dockerfile

#### 介绍
springboot的dockerfile例子

#### 本文只是做一个示例，所以不做太多详解，基本都是一看就明白的 
本文内容源码地址：https://gitee.com/catoop/springboot-docker

**一、创建工程文件**
1、正常创建一个springboot工程
2、创建一个TestController测试类，用户在我们部署docker之后访问验证使用
3、创建Dockerfile文件
如图：

![在这里插入图片描述](https://gitee.com/uploads/images/2019/0429/000851_816b0bc2_613422.png)


**二、打包和测试**
1、先单纯的打包工程，验证测试类是否能正常访问
```
#打包
mvn clean package -Dmaven.test.skip=true
#启动
java -jar target/spring-boot-docker-1.0.jar
#访问
http://localhost:8080
```
操作日志如下
```
Administrator@WINDOWS-4HGL3FJ MINGW64 /f/workspace-shanhy/springboot-docker
$ mvn clean package -Dmaven.test.skip=true
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building springboot-docker 0.0.1-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-clean-plugin:3.1.0:clean (default-clean) @ springboot-docker ---
[INFO] Deleting F:\workspace-shanhy\springboot-docker\target
[INFO]
[INFO] --- maven-resources-plugin:3.1.0:resources (default-resources) @ springboot-docker ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.8.0:compile (default-compile) @ springboot-docker ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 2 source files to F:\workspace-shanhy\springboot-docker\target\classes
[INFO]
[INFO] --- maven-resources-plugin:3.1.0:testResources (default-testResources) @ springboot-docker ---
[INFO] Not copying test resources
[INFO]
[INFO] --- maven-compiler-plugin:3.8.0:testCompile (default-testCompile) @ springboot-docker ---
[INFO] Not compiling test sources
[INFO]
[INFO] --- maven-surefire-plugin:2.22.1:test (default-test) @ springboot-docker ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.1.1:jar (default-jar) @ springboot-docker ---
[INFO] Building jar: F:\workspace-shanhy\springboot-docker\target\springboot-docker-0.0.1-SNAPSHOT.jar
[INFO]
[INFO] --- spring-boot-maven-plugin:2.1.4.RELEASE:repackage (repackage) @ springboot-docker ---
[INFO] Replacing main artifact with repackaged archive
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 8.010 s
[INFO] Finished at: 2019-04-28T20:22:02+08:00
[INFO] Final Memory: 34M/273M
[INFO] ------------------------------------------------------------------------

Administrator@WINDOWS-4HGL3FJ MINGW64 /f/workspace-shanhy/springboot-docker
$ java -jar target/springboot-docker-0.0.1-SNAPSHOT.jar

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.4.RELEASE)

2019-04-28 20:22:23.533  INFO 6292 --- [           main] c.s.demo.SpringbootDockerApplication     : Starting SpringbootDockerApplication v0.0.1-SNAPSHOT
on WINDOWS-4HGL3FJ with PID 6292 (F:\workspace-shanhy\springboot-docker\target\springboot-docker-0.0.1-SNAPSHOT.jar started by Administrator in F:\worksp
ace-shanhy\springboot-docker)
2019-04-28 20:22:23.540  INFO 6292 --- [           main] c.s.demo.SpringbootDockerApplication     : No active profile set, falling back to default profil
es: default
2019-04-28 20:22:27.351  INFO 6292 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2019-04-28 20:22:27.490  INFO 6292 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2019-04-28 20:22:27.491  INFO 6292 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.17]
2019-04-28 20:22:27.769  INFO 6292 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2019-04-28 20:22:27.771  INFO 6292 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed
in 4082 ms
2019-04-28 20:22:28.478  INFO 6292 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor
'
2019-04-28 20:22:29.218  INFO 6292 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context p
ath ''
2019-04-28 20:22:29.226  INFO 6292 --- [           main] c.s.demo.SpringbootDockerApplication     : Started SpringbootDockerApplication in 6.742 seconds
(JVM running for 7.661)
2019-04-28 20:22:37.324  INFO 6292 --- [nio-8080-exec-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring DispatcherServlet 'dispatcherServ
let'
2019-04-28 20:22:37.325  INFO 6292 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : Initializing Servlet 'dispatcherServlet'
2019-04-28 20:22:37.351  INFO 6292 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : Completed initialization in 24 ms
```
访问浏览器结果，输出OK正常：

![在这里插入图片描述](https://gitee.com/uploads/images/2019/0429/000849_d8f4e964_613422.png)

2、配置docker主机，开放远程端口
```
# vim编辑docker配置文件/lib/systemd/system/docker.service，并修改ExecStart为下面的内容
# vim /lib/systemd/system/docker.service
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
```
修改后，然后重启docker服务
```
# 1，加载docker守护线程
systemctl daemon-reload
# 2，重启docker 
systemctl restart docker
```
重启服务后，在你springboot-docker工程的电脑上使用telnet进行测试2377端口是否开启成功
```
telnet 192.168.11.88 2375
```
3、为你打包工程的电脑配置环境变量，添加`DOCKER_HOST`，值为`tcp://192.168.11.88:2375`
4、使用maven编译打包镜像
打开cmd窗口，确定环境变量配置生效：输入 `echo %DOCKER_HOST%`，会输出 `tcp://192.168.11.88:2375`
然后使用命令 `mvn clean package dockerfile:build -Dmaven.test.skip=true` 编译项目并构建docker镜像，编译结束自动推送镜像到docker主机中。
首次执行，会比较慢，慢慢等待...
编译过程如下：
```
F:\shanhy-gitcode\springboot-docker>mvn clean package dockerfile:build -Dmaven.test.skip=true
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building springboot-docker 0.0.1-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-clean-plugin:3.1.0:clean (default-clean) @ springboot-docker ---
[INFO] Deleting F:\shanhy-gitcode\springboot-docker\target
[INFO]
[INFO] --- maven-resources-plugin:3.1.0:resources (default-resources) @ springboot-docker ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.8.0:compile (default-compile) @ springboot-docker ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 2 source files to F:\shanhy-gitcode\springboot-docker\target\classes
[INFO]
[INFO] --- maven-resources-plugin:3.1.0:testResources (default-testResources) @ springboot-docker ---
[INFO] Not copying test resources
[INFO]
[INFO] --- maven-compiler-plugin:3.8.0:testCompile (default-testCompile) @ springboot-docker ---
[INFO] Not compiling test sources
[INFO]
[INFO] --- maven-surefire-plugin:2.22.1:test (default-test) @ springboot-docker ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.1.1:jar (default-jar) @ springboot-docker ---
[INFO] Building jar: F:\shanhy-gitcode\springboot-docker\target\springboot-docker-0.0.1-SNAPSHOT.jar
[INFO]
[INFO] --- spring-boot-maven-plugin:2.1.4.RELEASE:repackage (repackage) @ springboot-docker ---
[INFO] Replacing main artifact with repackaged archive
[INFO]
[INFO] --- dockerfile-maven-plugin:1.4.0:build (default-cli) @ springboot-docker ---
[INFO] Building Docker context F:\shanhy-gitcode\springboot-docker
[INFO]
[INFO] Image will be built as xzxiaoshan/springboot-docker:latest
[INFO]
[INFO] Step 1/7 : FROM openjdk:8-jdk-alpine
[INFO]
[INFO] Pulling from library/openjdk
[INFO] Image bdf0201b3a05: Pulling fs layer
[INFO] Image 9e12771959ad: Pulling fs layer
[INFO] Image c4efe34cda6e: Pulling fs layer
[INFO] Image 9e12771959ad: Downloading
[INFO] Image 9e12771959ad: Verifying Checksum
[INFO] Image 9e12771959ad: Download complete
[INFO] Image bdf0201b3a05: Downloading
[INFO] Image bdf0201b3a05: Verifying Checksum
[INFO] Image bdf0201b3a05: Download complete
[INFO] Image bdf0201b3a05: Extracting
[INFO] Image bdf0201b3a05: Pull complete
[INFO] Image 9e12771959ad: Extracting
[INFO] Image 9e12771959ad: Pull complete
[INFO] Image c4efe34cda6e: Downloading
[INFO] Image c4efe34cda6e: Verifying Checksum
[INFO] Image c4efe34cda6e: Download complete
[INFO] Image c4efe34cda6e: Extracting
[INFO] Image c4efe34cda6e: Pull complete
[INFO] Digest: sha256:2a52fedf1d4ab53323e16a032cadca89aac47024a8228dea7f862dbccf169e1e
[INFO] Status: Downloaded newer image for openjdk:8-jdk-alpine
[INFO]  ---> 3675b9f543c5
[INFO] Step 2/7 : MAINTAINER xzxiaoshan/365384722@qq.com
[INFO]
[INFO]  ---> Running in 560a2e21d599
[INFO] Removing intermediate container 560a2e21d599
[INFO]  ---> abf0fad7ff41
[INFO] Step 3/7 : VOLUME ["/tmp"]
[INFO]
[INFO]  ---> Running in c5d8081fa28d
[INFO] Removing intermediate container c5d8081fa28d
[INFO]  ---> 0af574b9bca3
[INFO] Step 4/7 : EXPOSE 8080
[INFO]
[INFO]  ---> Running in 3dcc801027a8
[INFO] Removing intermediate container 3dcc801027a8
[INFO]  ---> c4b45d1d2188
[INFO] Step 5/7 : ARG JAR_FILE
[INFO]
[INFO]  ---> Running in 75df590d4862
[INFO] Removing intermediate container 75df590d4862
[INFO]  ---> db6ac0b9b76c
[INFO] Step 6/7 : COPY ${JAR_FILE} app.jar
[INFO]
[INFO]  ---> 76ab1f2f92b1
[INFO] Step 7/7 : ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
[INFO]
[INFO]  ---> Running in af6dfae863b6
[INFO] Removing intermediate container af6dfae863b6
[INFO]  ---> 436fc4432574
[INFO] Successfully built 436fc4432574
[INFO] Successfully tagged xzxiaoshan/springboot-docker:latest
[INFO]
[INFO] Detected build of image with id 436fc4432574
[INFO] Building jar: F:\shanhy-gitcode\springboot-docker\target\springboot-docker-0.0.1-SNAPSHOT-docker-info.jar
[INFO] Successfully built xzxiaoshan/springboot-docker:latest
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 01:55 min
[INFO] Finished at: 2019-04-28T23:31:07+08:00
[INFO] Final Memory: 49M/473M
[INFO] ------------------------------------------------------------------------

F:\shanhy-gitcode\springboot-docker>
```
5、回到docker主机，查看镜像
```
[root@ceph1 ~]# docker images|grep springboot-docker
xzxiaoshan/springboot-docker       latest              436fc4432574        8 minutes ago       121MB
[root@ceph1 ~]# 
```
6、启动容器，然后访问验证结果
```
[root@ceph1 ~]# docker run -itd --name springboot-docker -p 2233:8080 xzxiaoshan/springboot-docker /bin/bash
d4e721e41cddc9258f76b21ae8d74eca7238cbabc26b7ff2ba531b25d2d5f0a0
[root@ceph1 ~]#
```
7、访问查看结果
浏览器打开 http://192.168.11.88:2233 查看结果，如下：

![在这里插入图片描述](https://gitee.com/uploads/images/2019/0429/000854_83c15a5c_613422.png)

成功，完美！

（结束）
