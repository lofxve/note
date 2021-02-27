# day38_web项目_maven基础和项目搭建

```java
项目介绍:
1. maven基础&环境搭建
2. 用户注册模块&svn
3. 用户模块&面向接口编程
4. 导航分类模块&redis
5. 线路分页条件查询（百度前五后四）&线路详情
6. 购物车&订单支付
7. 微信支付&linux
8. 项目部署
今日目标介绍:
		Maven入门
        搭建黑马旅游网的环境    
```

# Maven基础

### 第一章 Maven简介

##### 1.1 Maven是什么？

```java
Maven是一个"专家"软件,功能非常强大!
```

##### 1.2 Maven的作用

```java
a.导入jar包
b.编译
c.运行测试
d.打包&部署
以上问题Maven都可以一键解决!    
```

##### 1.3 Maven的两个核心功能

- ##### 1.3.1 依赖管理

  ```java
  依赖管理:就是指项目中需要哪些jar包(坐标)
  ```

- ##### 1.3.2 项目构建

  ```java
  项目构建(一键构建):可以自动帮助我们,清理,编译,测试,打包,生成报告,部署...
  ```

### 第二章 Maven下载,安装和使用

##### 2.1 Maven下载和安装

- 下载

  ```java
  http://maven.apache.org
  ```

- 安装

  ```java
  解压即是安装(注意,解压目录不要有中文不要有空格,而且你要能随时找到)
  ```

- Maven目录介绍

  ![image-20201220085244433](img/image-20201220085244433.png)

##### 2.2 Maven的配置

- JDK1.7+的配置

  ```java
  必须配置JDK为1.7以上:
  	JAVA_HOME: JDK的家目录
  	PATH: %JAVA_HOME%\bin
  ```

- Maven的配置

  ```java
  MAVEN_HOME: maven的家目录(D:\Develop\Java\apache-maven-3.6.0)
  PATH: %MAVEN_HOME%\bin    
  ```

- Maven配置后的测试

  ```java
  打开cmd窗口,输入mvn -v,如果看到maven版本信息,说明配置成功
  ```

##### 2.3 Maven仓库介绍

- 什么是Maven仓库

  ```java
  专门用于保存各种jar包的地方
  ```

- ==Maven仓库的分类==

  ```java
  Maven仓库的分类:
  	本地仓库: jar包保存到本的某个文件夹内部
  	远程仓库: 
  		中央仓库(Maven团队负责维护)
          镜像仓库(第三方仓库,阿里云仓库) 
          私服仓库(公司内部搭建的仓库)    
  ```

- Maven寻找依赖的过程(寻找jar包,画图)

  ![image-20201220090819939](img/image-20201220090819939.png)
  
- ==Maven本地仓库的配置==

  ```xml
  a.解压本地仓库的压缩包(这是我们上课用到的很多jar包)
      注意:仓库路径没有中文没有空格
  b.修改本地仓库的目录(把默认目录改成刚刚解压到的目录) 
      进入maven软件的conf目录下,打开settings.xml,找到配置本地仓库的那个注释位置
        <!-- localRepository
         | The path to the local repository maven will use to store artifacts.
         |
         | Default: ${user.home}/.m2/repository
        <localRepository>/path/to/local/repo</localRepository>
        -->
  	//复制以上<localRepository>标签,把中间内容改为你仓库的路径
  	<localRepository>D:\Develop\Java\mavenrepository</localRepository>    
          
  ```

- ==Maven远程仓库的配置==

  ```xml
  a.为什么要配置远程仓库?
      因为本地仓库不可能包含你开发中用到的所有jar包
  b.配置何种远程仓库?
      建议配置镜像仓库(阿里云仓库)
  c.如何配置远程仓库?    
      进入maven软件的conf目录下,打开settings.xml,找到<mirrors>,在标签内容添加阿里云仓库坐标即可
      <mirror>
  	  <id>aliyunmaven</id>
  	  <mirrorOf>*</mirrorOf>
  	  <name>阿里云公共仓库</name>
  	  <url>https://maven.aliyun.com/repository/public</url>
  	</mirror>
  ```

- 全局配置和用户配置

  ```java
  全局配置: 在maven下的conf中settings.xml中配置
  用户配置: 在用户目录下的.m2目录中配置,那么这个配置只能是给当前用户使用   
  ```

##### ==2.4 Maven依赖和坐标==

```java
a.什么是依赖 
    项目中需要用到的jar包
b.什么是坐标 
    仓库中jar包唯一标识
b.坐标的定义格式
 	<groupId>项目名</groupId> 
    <artifactId>模块名</artifactId> 
    <version>版本号</version>
    <packaging>web项目就是war 包|普通的Java项目就是jar包</packaging>
```

##### 2.5 Maven工程的认识

- ##### ==Maven工程的目录结构==

  ![image-20201220094714164](img/image-20201220094714164.png)
  
- ##### Maven工程的运行

  ```java
  使用CMD窗口进入Maven项目,使用命令;
  	mvn clean 清理
      mvn complie 编译
      mvn test 执行所有测试  
      mvn package 打包(jar,war)
      mvn install 安装(把项目安装到仓库中,以便别的程序使用) 
      mvn deploy 部署
      mvn tomcat7:run(使用maven中tomcat7插件运行本项目)    
  ```

### 第三章 Maven生命周期和插件

### 3.1 Maven常用命令和插件(理解)

```java
a.clean  清理(把生成的target文件夹全部删除)
b.compile 编译(把main文件夹下所有java文件编译生成class文件)
c.test 执行测试(也是执行编译命令)
d.package 打包项目(也会执行编译和测试命令),如果是普通项目jar包,如果是web项目war包
e.install 安装项目(也会执行编译和测试和打包命令),把项目安装到本地的仓库中,以便其他项目使用
f.deploy 部署项目(mvn tomcat7:run在maven内置的tomcat7插件中运行)把项目部署到某个服务器上
```

##### 3.1 Maven生命周期(了解)

```java
Maven命令构成的三种生命周期:
a.Clean Lifecycle 
    清理生命周期(clean)
b.default Lifecycle 
    默认生命周期(compile,test,package,install)
c.site Lifecycle
    站点生命周期(deploy)
```

##### 3.2 Maven概念模型(了解)

```java
Maven的五个概念模型:
a.项目对象模型: POM文件
b.依赖管理系统: jar包的坐标
c.完整的项目生命周期: 清理周期,默认周期,站点周期
d.一组标准集合: 标准的目录结构(src<main<java,resources,webapps>,test<java,resources>>,target)
e.目标插件: 我们执行所有生命周期命令时都需要基于插件,我们可以使用tomcat7:run执行,基于tomcat7插件
```

### ==第四章 IDEA创建Maven工程==

##### 4.1 IDEA配置本地Maven

```java
a.IDEA配置Maven
b.配置Maven项目的骨架和编码    
```

![image-20201220102454411](img/image-20201220102454411.png)

![image-20201220102851983](img/image-20201220102851983.png)

##### 4.2 使用骨架创建java工程

- 使用骨架创建Java项目

  ![image-20201220105347165](img/image-20201220105347165.png)

- 使用骨架创建web项目

  ![image-20201220105856970](img/image-20201220105856970.png)

- 不使用骨架创建web项目

  ![image-20201220110322393](img/image-20201220110322393.png)

- ==web项目的目录结构==

  ![image-20201220110533702](img/image-20201220110533702.png)

##### 4.3 发布web工程

- ##### 发布到本地tomcat

  ```java
  和以前部署项目一模一样(idea是2018.1或者2020某些版本也有问题)
  ```

- ##### ==使用tomcat插件==

  ```xml
  在项目中的pom文件里,添加tomcat插件即可
  <build>
      <plugins>
          <plugin>
              <groupId>org.apache.tomcat.maven</groupId>
              <artifactId>tomcat7-maven-plugin</artifactId>
              <version>2.2</version>
              <configuration> <!--端口号-->
                  <port>8080</port> <!--虚拟目录-->
                  <path>/my</path> <!--uri编码-->
                  <uriEncoding>utf-8</uriEncoding>
              </configuration>
          </plugin>
      </plugins>
  </build>
  ```

  ![image-20201220111701206](img/image-20201220111701206.png)

##### 4.4 依赖管理

- ##### 导入servlet的依赖

  ```xml
  <!--导入依赖-->
  <dependencies>
      <dependency>
      	<groupId>javax.servlet</groupId>
      	<artifactId>javax.servlet-api</artifactId>
      	<version>3.1.0</version>
      </dependency>
  </dependencies>
  ```

- ##### 设置JDK编译版本

  ```xml
  <!--jdk编译插件-->
  <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-compiler-plugin</artifactId>
      <version>3.2</version>
      <configuration>
      	<source>1.8</source>
      	<target>1.8</target>
      	<encoding>utf-8</encoding>
      </configuration>
  </plugin>
  ```

- ##### 依赖范围

  ```java
  <scope>
      complie(默认) 百分之99%的都是它,mybatis.jar
      test 一般Junit.jar
      provided 一般servlet.jar.jsp.jar
      runtime 一般是驱动jar,mysql-connector.jar
  </scope>    
  ```

- ##### 在maven_web工程中的jar包scope总结：

  ```java
  一般的jar包不写scope(默认是compile)
  Junit.jar包写test
  servlet.jar和jsp.jar写provided
  驱动jar包写runtime    
  ```

  

# ==黑马旅游网环境搭建==

### 一 项目功能介绍

![image-20201220143941693](img/image-20201220143941693.png)

### 二 技术架构

![image-20201220144348084](img/image-20201220144348084.png)

### 三 数据库表设计

![image-20201220145215622](img/image-20201220145215622.png)

### 四 搭建web项目

##### 4.1 项目所需文件

![image-20201220145321662](img/image-20201220145321662.png)

##### 4.2 创建Maven的web项目

![image-20201220150235737](img/image-20201220150235737.png)

##### 4.3 导入依赖坐标

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.itheima</groupId>
    <artifactId>travel144</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>war</packaging>


    <!--jdk环境-->
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
    </properties>

    <!--依赖管理-->
    <dependencies>
        <!--mysql驱动-->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>5.1.47</version>
            <scope>runtime</scope>
        </dependency>
        <!--mybatis-->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>3.5.1</version>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.16.20</version>
        </dependency>
        <!--beanUtils-->
        <dependency>
            <groupId>commons-beanutils</groupId>
            <artifactId>commons-beanutils</artifactId>
            <version>1.9.2</version>
        </dependency>
        <!--jackson-->
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.9.9</version>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.dataformat</groupId>
            <artifactId>jackson-dataformat-xml</artifactId>
            <version>2.9.9</version>
        </dependency>
        <!--javaMail-->
        <dependency>
            <groupId>javax.mail</groupId>
            <artifactId>javax.mail-api</artifactId>
            <version>1.5.6</version>
        </dependency>
        <dependency>
            <groupId>com.sun.mail</groupId>
            <artifactId>javax.mail</artifactId>
            <version>1.5.3</version>
        </dependency>
        <!--jedis-->
        <dependency>
            <groupId>redis.clients</groupId>
            <artifactId>jedis</artifactId>
            <version>2.9.0</version>
        </dependency>
        <!--servlet jsp-->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>3.1.0</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>javax.servlet.jsp</groupId>
            <artifactId>javax.servlet.jsp-api</artifactId>
            <version>2.3.3</version>
            <scope>provided</scope>
        </dependency>
        <!-- 导入commons依赖-->
        <dependency>
            <groupId>commons-io</groupId>
            <artifactId>commons-io</artifactId>
            <version>1.4</version>
        </dependency>
        <dependency>
            <groupId>taglibs</groupId>
            <artifactId>standard</artifactId>
            <version>1.1.2</version>
        </dependency>
        <!-- 导入jstl依赖-->
        <dependency>
            <groupId>jstl</groupId>
            <artifactId>jstl</artifactId>
            <version>1.2</version>
        </dependency>
        <!--字符串处理工具类包-->
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>3.5</version>
        </dependency>
        <dependency>
            <groupId>com.aliyun</groupId>
            <artifactId>aliyun-java-sdk-core</artifactId>
            <version>4.0.6</version> <!-- 注：如提示报错，先升级基础包版，无法解决可联系技术支持 -->
        </dependency>
        <dependency>
            <groupId>com.aliyun</groupId>
            <artifactId>aliyun-java-sdk-dysmsapi</artifactId>
            <version>1.1.0</version>
        </dependency>
        <!--dom4j-->
        <dependency>
            <groupId>dom4j</groupId>
            <artifactId>dom4j</artifactId>
            <version>1.6.1</version>
        </dependency>
        <dependency>
            <groupId>jaxen</groupId>
            <artifactId>jaxen</artifactId>
            <version>1.1.6</version>
        </dependency>
        <!--单元测试-->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
            <scope>test</scope>
        </dependency>
        <!--微信支付-->
        <dependency>
            <groupId>com.github.wxpay</groupId>
            <artifactId>wxpay-sdk</artifactId>
            <version>3.0.9</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <!--tomcat插件-->
            <plugin>
                <groupId>org.apache.tomcat.maven</groupId>
                <artifactId>tomcat7-maven-plugin</artifactId>
                <version>2.2</version>
                <configuration> <!--端口号-->
                    <port>8080</port> <!--虚拟目录-->
                    <path>/HelloWorld</path> <!--uri编码-->
                    <uriEncoding>utf-8</uriEncoding>
                </configuration>
            </plugin>

            <!--JDK编译插件-->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.2</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                    <encoding>utf-8</encoding>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>
```

##### 4.4 创建项目包目录结构

![image-20201220150433505](img/image-20201220150433505.png)

##### 4.5 导入工具类和实体类和中文乱码过滤器

![image-20201220151726181](img/image-20201220151726181.png)

##### 4.6 导入配置文件和静态资源

![image-20201220151744563](img/image-20201220151744563.png)

##### ==4.7 部署web项目==

##### 4.8 lombok

- lombok的作用

  ```java
  自动为实体类生成get/set,无参构造,全参构造,toString
  ```

- 常用的lombok注解:

  ```java
  @Data 生成get/set,toString,无参构造
  @NoArgsConstructor 无参构造
  @AllArgsConstructor 全参构造
  ```

- 在IDEA配置lombok插件：

  ![image-20201220152704612](img/image-20201220152704612.png)

![image-20201220152752462](img/image-20201220152752462.png)

##### 4.9 启动tomcat

- 使用本地Tomcat(2018.1和2020可能不能用)
- 使用Maven插件