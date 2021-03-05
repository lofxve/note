# SpringBoot

==**约定优于配置**==

==版本锁定==：SpringBoot在父工程中进行了大量常见依赖的版本锁定==maven==
==起步依赖==：SpringBoot以功能化的方式将需要的依赖进行组装，并且允许程序员以start的方式进行引入==ssm-starter==
==自动配置==：SpringBoot实现了大量依赖框架的==默认配置项==，程序员无须再进行自己配置
==内置Tomcat==：SpringBoot内置了一个tomcat，使用它开发的程序无需再进行tomcat部署，可直接运行

# 入门案例

## 依赖

```xml
<!--1. 设置父工程: 里面进行版本的锁定-->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.2.2.RELEASE</version>
    </parent>

    <!--2. 引入依赖启动器: 里面是一堆需要的依赖的集合-->
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>
    </dependencies>
```

## Controller

```java
package com.lofxve.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @ClassName IndexController
 * @Author lofxve
 * @Date 2021/1/17 8:56
 * @Version 1.0
 */
@Controller
public class IndexController {

    @ResponseBody
    @RequestMapping("/index")
    public String dome01() {
        return "Hello SpringBoot!";
    }
}
```

## 启动类

### 启动main

```java
package com.lofxve;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @ClassName QuickStartApplication
 * @Author lofxve
 * @Date 2021/1/17 8:58
 * @Version 1.0
 */
@SpringBootApplication
public class QuickStartApplication {
    public static void main(String[] args) {
        SpringApplication.run(QuickStartApplication.class, args);
    }
}
```

### maven启动

#### 依赖

```xml
			<plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <!--<version>${spring.boot.version}</version>-->
                <!--<executions>-->
                    <!--<execution>-->
                        <!--<goals>-->
                            <!--<goal>repackage</goal>-->
                        <!--</goals>-->
                    <!--</execution>-->
                <!--</executions>-->
            </plugin>
```

> mvn spring-boot:run

### jar启动

> java -jar emample.jar --server.port=8081

# 配置yaml

## 数据格式

```yaml
# 纯量：单个的、不可再分的值（包括字符串字符串、布尔值、数值、Null、时间类型）
username: 'jack'

# 对象：键值对的集合，又称为映射（mapping）/ 哈希（hashes） / 字典（dictionary）
user:
  username: '张三'
  password: '123'
  
# 数组：一组按次序排列的值，又称为序列（sequence） / 列表（list）
addressList:
  - '北京'
  - '上海'
  - '广州'
```

## 读取方式

==Environment（了解）==

==@Value==

==@Configuration==

```java
//        方式一: Environment（了解）
//        此对象是Spring框架提供的，用来表示整个应用运行时的环境，可以读取配置文件中的属性值并逐个注入到Bean对象的对应属性中
    @Autowired
    private Environment environment;
//        方式二: @Value
//        此注解是Spring框架提供的，用来读取配置文件中的属性值并逐个注入到Bean对象的对应属性中
    @Value("${sms.username}")
    private String username;
    @Value("${sms.password}")
    private String password;

//        方式三: @Configuration
//        此注解是SpringBoot框架提供的，用来快速、方便地将配置文件中的自定义属性值批量注入到某个Bean对象的多个对应属性中
    @Autowired
    private UserConfig userConfig;
    @ResponseBody
    @RequestMapping("/index01")
    public String dome02() {
//        方式一: Environment（了解）
//        此对象是Spring框架提供的，用来表示整个应用运行时的环境，可以读取配置文件中的属性值并逐个注入到Bean对象的对应属性中
        System.out.println(environment.getProperty("sms.username") + "====>" + environment.getProperty("sms.password"));
//        方式二: @Value
//        此注解是Spring框架提供的，用来读取配置文件中的属性值并逐个注入到Bean对象的对应属性中
        System.out.println(username + "====>" + password);
//        方式三: @Configuration
//        此注解是SpringBoot框架提供的，用来快速、方便地将配置文件中的自定义属性值批量注入到某个Bean对象的多个对应属性中
        System.out.println(userConfig.getUsername() + "====>" + userConfig.getPassword());
        return "Hello SpringBoot!";
    }
```

```java
package com.lofxve.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @ClassName UserConfig
 * @Author lofxve
 * @Date 2021/1/18 17:22
 * @Version 1.0
 */
@Data
@Configuration
@ConfigurationProperties("sms")
public class UserConfig {
    @Value("${sms.username}")
    private String username;
    @Value("${sms.password}")
    private String password;
}
```

## ==重要配置==

```yaml
server:
  port: 8080
  servlet:
    context-path: '/'
spring:
  #mysql数据源
  datasource:
    url: jdbc:mysql:///heima_movies?useUnicode=true&characterEncoding=utf-8
    password: root
    username: root
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.jdbc.Driver
  redis:
    host: 127.0.0.1
    port: 6379
    database: 0
  #自定义静态文件位置
  resources:
    static-locations: classpath:/templates/
  #thymeleaf 文件位置配置
  thymeleaf:
    # 自定义前缀
    prefix: classpath:/templates/
    # 自定义后缀
    suffix: .html

# mybatis简单配置
mybatis:
  # 指定mapper映射文件
  mapper-locations: classpath:mapper/*
  configuration:
    # 开启驼峰式映射
    map-underscore-to-camel-case: true

# 日志级别设置格式是
# 包名: 日志级别(常用的级别有4个: debug info warn error)
logging:
  level:
    com.lofxve: info
sms:
  username: 张三
  password: 123
```

# SpringBoot整合

## 整合junit

### 依赖

```xml
<!--引入junit依赖-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
</dependency>
```

### 编写测试类

```java
// 主类包下面
@org.springframework.boot.test.context.SpringBootTest
@RunWith(SpringJUnit4ClassRunner.class)
public class SpringBootTest {
}
```

## 整合SpringMVC

### 日志

```yaml
# 日志级别设置格式是
# 包名: 日志级别(常用的级别有4个: debug info warn error)
logging:
  level:
    com.lofxve: info
```

### 访问静态资源

```java
public class ResourceProperties {
//定义了静态资源路径
private static final String[] CLASSPATH_RESOURCE_LOCATIONS = 
	new String[]{"classpath:/META-INF/resources/", "classpath:/resources/", "classpath:/static/", "classpath:/public/"};
}
```

```yaml
# 当然，如果想自定义位置也可以，使用下面格式即可
spring:
	resources:
		static-locations: classpath:/templates/
```

### 拦截器配置

#### 自定义拦截器

```java
package com.lofxve.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName MyInterceptor
 * @Author lofxve
 * @Date 2021/1/18 17:41
 * @Version 1.0
 */
@Component
public class MyInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("进入控制器之前");
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("离开控制器之后");
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("页面渲染完毕之后");
    }
}
```

```java
package com.lofxve.config;

import com.lofxve.interceptor.MyInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @ClassName SpringMVCConfig
 * @Author lofxve
 * @Date 2021/1/18 17:44
 * @Version 1.0
 */
@Configuration
public class SpringMVCConfig implements WebMvcConfigurer {
    @Autowired
    private MyInterceptor myInterceptor;

    // 将拦截器注册到Springboot
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(myInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/index01");
    }
}
```

### 全局异常处理==@ControllerAdvice==

@ExceptionHandler(RuntimeException.class)

```java
@ControllerAdvice ////要标注在类上,表示当前类是一个全局异常处理器的类
public class GlobalExceptionHandler {
    @ExceptionHandler(RuntimeException.class) ///标注在方法上,表示当前方法可以处理哪些异常
    @ResponseBody // 返回json接口
    public Map<String, Object> exceptionHandler() {
        Map<String, Object> result = new HashMap<>();
        result.put("code", "500");
        result.put("msg", "系统错误");
        return result;
    }
}
```

## 整合Thymeleaf

### 依赖

```xml
<!--thymeleaf 起步依赖-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>
```

### 配置

```yaml
spring：
 #thymeleaf 文件位置配置
  thymeleaf:
    prefix: classpath:/templates/  # 自定义前缀
    suffix: .html # 自定义后缀
```
### 后端

```java
@RequestMapping("/index02")
public String dome03(HttpServletRequest request) {
    //1. 模拟数据
    List<User> users = new ArrayList<User>();
    users.add(new User(1, "张三", "admin"));
    users.add(new User(2, "李四", "admin"));
    users.add(new User(3, "王五", "admin"));
    users.add(new User(4, "赵六", "admin"));
    users.add(new User(5, "孙七", "admin"));
    users.add(new User(6, "钱八", "admin"));

    //2 放入request域
    request.setAttribute("users", users);

    //3. 页面转发
    return "user_list";
}
```

### 前端

```html
<table border="1" cellpadding="0" cellspacing="0">
    <tr>
        <td>id</td>
        <td>username</td>
        <td>password</td>
    </tr>
    <tr th:each="user:${users}">
        <td th:text="${user.id}">id</td>
        <td th:text="${user.username}">username</td>
        <td th:text="${user.password}">password</td>
    </tr>
</table>
```

## 整合Mybatis 

### 依赖

```xml
	   <!--加入mybatis的启动器,这是mybatis公司提供的-->
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
            <version>2.1.1</version>
        </dependency>
```

### 配置

```yaml
# 数据源配置（springboot内置连接池对象HiKariCP）
spring:
  datasource:
    driver-class-name: com.mysql.jdbc.Driver
    url: jdbc:mysql:///springboot
    username: root
    password: root

# mybatis简单配置
mybatis:
  mapper-locations: classpath:mappers/** # 指定mapper映射文件
  configuration:
    map-underscore-to-camel-case: true # 开启驼峰式映射
```

### 接口

```java
public interface UserMapper {
    List<User> findAll();
}
```

### 映射

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.lofxve.mapper.UserMapper">
    <select id="findAll" resultType="com.lofxve.domain.User">
        select  * from tb_user;
    </select>
</mapper>
```

### 启动类

```java
package com.lofxve;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @ClassName QuickStartApplication
 * @Author lofxve
 * @Date 2021/1/17 8:58
 * @Version 1.0
 */
@SpringBootApplication
@MapperScan("com.lofxve.mapper")
public class QuickStartApplication {
    public static void main(String[] args) {
        SpringApplication.run(QuickStartApplication.class, args);
    }
}
```

### 测试

```java
@Autowired
private UserMapper userMapper;

@Test
public void findAllUser() {
    List<User> userList = userMapper.findAll();
    for (User user : userList) {
        log.info(user.toString());
    }
}
```

## 整合Redis

### 依赖

```xml
<!--        redis-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

### 配置

```yaml
spring:
	redis:
      host: localhost # 服务器地址
      port: 6379 # 端口
      database: 0 # 使用库的索引标识
```

### 测试

```java
@Test
public void rdeisTest() {
    // 从缓存中获取数据
    List<User> userList = (List<User>) redisTemplate.opsForValue().get("users");
    // 如果缓存中不存在数据，则从数据库中查找
    if (userList == null) {
        System.out.println("从数据库查询");
        userList = userMapper.findAll();
        redisTemplate.opsForValue().set("users", userList);
    }
    // 数据展示
    for (User user : userList) {
        System.out.println(user);
    }
}
```

## 整合MybatisPlus

### 依赖

```xml
<!-- mybatisplus集成，引入 MyBatis-Plus 之后请不要再次引入 MyBatis 以及 MyBatis-Spring，以避免因版本差异导致的问题。 -->
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.4.0</version>
</dependency>
```

### 配置

```yaml
spring:
  datasource:
    url: jdbc:mysql:///heima_movies?useUnicode=true&characterEncoding=utf-8
    password: root
    username: root
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.jdbc.Driver

#开启logging myabtis语句打印
#logback配置
logging:
  pattern:
    console: '%d -%msg%n'
#  path: D:/data/log/seller.log
  level:
    root: info

mybatis-plus:
  configuration:
    # 是否将sql打印到控制面板(该配置会将sql语句和查询的结果都打印到控制台)
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
```

### 实体

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("tb_user")// 用于指定数据库的表名，如果没有默认类名下首字母小写
public class User implements Serializable {
    @TableId(type = IdType.AUTO) // 数据库自增
    private Integer id;
    private String username;
    private String password;
}
```

### 接口

```java
public interface UserMapper extends BaseMapper<User> {
}
```

### 启动类

```java
@MapperScan("com.lofxve.mapper")
```

### 测试

```java
@org.junit.Test
public void test() {
    User user = new User();
    user.setUsername("zhangsan");
    user.setPassword("123");
    userMapper.insert(user);
}
```

### crud

```java
int insert(T entity);// 插入一条记录

int deleteById(Serializable id); // ID删除
int deleteBatchIds(Collection idList);// ID批量删除
int delete(Wrapper<T> wrapper);// 条件删除

int updateById(T entity);// ID修改
int update(T entity,Wrapper<T> updateWrapper);// 条件更新

T selectById(Serializable id);// 主键查询
List<T> selectBatchIds(Collection idList); // 主键批量查询
T selectOne(Wrapper<T> queryWrapper);// 条件查询，返回值为一条记录
List<T> selectList(Wrapper<T> queryWrapper);// 条件查询，返回值为多条记录
Integer selectCount(Wrapper<T> queryWrapper);// 条件查询记录数
IPage<T> selectPage(IPage<T> page, Wrapper<T> queryWrapper);//条件分页查询
```

### 条件查询

> 官网使用：QueryWrapper对象用于生成 sql 的 where 条件

| 查询方法                                                     | 说明     | 例子                                                         |
| ------------------------------------------------------------ | -------- | ------------------------------------------------------------ |
| eq(=)、ne(<>)、gt(>)、ge(>=)、lt(<)、le(<=)、isNull、isNotNull | 比较运算 | eq("name", "老王")`--->`name = '老王'                        |
| like、notLike、likeLeft、likeRight                           | 模糊查询 | likeRight("name", "王")`--->`name like '王%'                 |
| in、notIn、between、notBetween                               | 范围运算 | in("age",{1,2,3})`--->`age in (1,2,3)                        |
| orderByAsc、orderByDesc                                      | 排序     | orderByDesc("id", "name")`--->`order by id DESC,name DESC    |
| groupBy                                                      | 分组     | groupBy("id", "name")`--->`group by id,name                  |
| having                                                       | 过滤     | having("sum(age) > 10")`--->`having sum(age) > 10            |
| or、and                                                      | 拼接     | eq("id",1).or().eq("name","老王")`--->`id = 1 or name = '老王' |

## 整合Dubbo

### Dubbo简介

Apache Dubbo是一款高性能的Java RPC框架，可以和Spring框架无缝集成。官网地址：[http://dubbo.apache.org]



![1580452294908](assets/1580452294908.png)

![image-20210120095747162](assets/image-20210120095747162.png)

**节点角色说明：**

| **节点**  | **角色名称**                           |
| --------- | -------------------------------------- |
| Provider  | 暴露服务的服务提供方                   |
| Consumer  | 调用远程服务的服务消费方               |
| Registry  | 服务注册与发现的注册中心               |
| Monitor   | 统计服务的调用次数和调用时间的监控中心 |
| Container | 服务运行容器                           |

**调用关系说明**:

0. 服务容器负责启动，加载，运行服务提供者。
1. 服务提供者在启动时，向注册中心注册自己提供的服务。
2. 服务消费者在启动时，向注册中心订阅自己所需的服务。
3. 注册中心返回服务提供者地址列表给消费者，如果有变更，注册中心将基于长连接推送变更数据给消费者。
4. 服务消费者，从提供者地址列表中，基于软负载均衡算法，选一台提供者进行调用，如果调用失败，再选另一台调用。
5. 服务消费者和提供者，在内存中累计调用次数和调用时间，定时每分钟发送一次统计数据到监控中心。

#### ==分布式和集群==

集群:多台服务器重复完成同一个任务,即同一个任务部署在多台服务器上
分布式:多台服务器协同完成同一个任务,即同一个任务拆分为多个子任务,多个子任务部署在多台服务器上协同完成同一个任务 

### spring

#### 依赖

```xml
<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <spring.version>5.1.6.RELEASE</spring.version>
</properties>

<dependencies>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context</artifactId>
        <version>${spring.version}</version>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-beans</artifactId>
        <version>${spring.version}</version>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>${spring.version}</version>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-jdbc</artifactId>
        <version>${spring.version}</version>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-aspects</artifactId>
        <version>${spring.version}</version>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-jms</artifactId>
        <version>${spring.version}</version>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context-support</artifactId>
        <version>${spring.version}</version>
    </dependency>
    <!-- dubbo相关 -->
    <dependency>
        <groupId>com.alibaba</groupId>
        <artifactId>dubbo</artifactId>
        <version>2.6.6</version>
    </dependency>
    <dependency>
        <groupId>io.netty</groupId>
        <artifactId>netty-all</artifactId>
        <version>4.1.32.Final</version>
    </dependency>
    <dependency>
        <groupId>org.apache.curator</groupId>
        <artifactId>curator-framework</artifactId>
        <version>4.0.0</version>
        <exclusions>
            <exclusion>
                <groupId>org.apache.zookeeper</groupId>
                <artifactId>zookeeper</artifactId>
            </exclusion>
        </exclusions>
    </dependency>
    <dependency>
        <groupId>org.apache.zookeeper</groupId>
        <artifactId>zookeeper</artifactId>
        <version>3.4.7</version>
    </dependency>
    <dependency>
        <groupId>com.github.sgroschupf</groupId>
        <artifactId>zkclient</artifactId>
        <version>0.1</version>
    </dependency>
</dependencies>

<build>
    <plugins>
        <!-- 设置编译版本为1.8 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.1</version>
            <configuration>
                <source>1.8</source>
                <target>1.8</target>
                <encoding>UTF-8</encoding>
            </configuration>
        </plugin>
    </plugins>
</build>
```

#### api

```java
public interface HelloService {
    String sayHello(String name);
}
```

#### 生产者

```java
@Service
public class HelloServiceImpl implements HelloService {
    @Override
    public String sayHello(String name) {
        return "Hello," + name;
    }
}
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:dubbo="http://code.alibabatech.com/schema/dubbo"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
        http://code.alibabatech.com/schema/dubbo http://code.alibabatech.com/schema/dubbo/dubbo.xsd">

    <!-- 1.当前服务的名称-->
    <dubbo:application name="dubbo_provider"></dubbo:application>

    <!-- 2.连接zookeeper注册中心地址-->
    <dubbo:registry address="zookeeper://127.0.0.1:2181"></dubbo:registry>

    <!-- 3.指定rpc的具体通信协议和端口-->
    <dubbo:protocol name="dubbo" port="20880"></dubbo:protocol>

    <!-- 4.开启业务层包扫描
            1.扫描所有带@service注解的类交给ioc容器
            2.通过dubbo对外暴露服务
    -->
    <dubbo:annotation package="com.lofxve.dubbo.com.lofxve.dubbo.service"></dubbo:annotation>
</beans>
```

```xml
<context-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>classpath*:applicationContext-*.xml</param-value>
</context-param>
<listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
```

#### 消费者

```java
@Controller
public class HelloController {
    @Reference
    private HelloService helloService;

    @ResponseBody
    @RequestMapping("sayHello")
    public String sayHello(String name) {
        return helloService.sayHello(name);
    }
}
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:dubbo="http://code.alibabatech.com/schema/dubbo"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc.xsd
        http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd
        http://code.alibabatech.com/schema/dubbo http://code.alibabatech.com/schema/dubbo/dubbo.xsd
        http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">

       <!-- spring的注解扫描,让@Controller和@RequestMapping生效-->
    <context:component-scan base-package="com.lofxve.dubbo.controller" />
    <!--注解驱动-->
    <mvc:annotation-driven />

    <!-- 1.当前服务的名称-->
    <dubbo:application name="dubbo_consumer" />

    <!-- 2.连接zookeeper注册中心地址-->
    <dubbo:registry address="zookeeper://127.0.0.1:2181" />

    <!-- 3.dubbo的注解扫描,创建service接口代理对象，实现RPC远程通信-->
    <dubbo:annotation package="com.itheima.dubbo.controller" />
</beans>
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns="http://java.sun.com/xml/ns/javaee"
         xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
         version="2.5">
    <servlet>
        <servlet-name>springmvc</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:springmvc.xml</param-value>
        </init-param>
        <load-on-startup>4</load-on-startup>
    </servlet>

    <servlet-mapping>
        <servlet-name>springmvc</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
</web-app>
```

### springboot

#### 依赖

```xml
<parent>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-parent</artifactId>
	<version>2.2.2.RELEASE</version>
</parent>

<properties>
	<java.version>1.8</java.version>
</properties>

<dependencies>
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter</artifactId>
	</dependency>
	<!--dubbo的起步依赖-->
	<dependency>
		<groupId>org.apache.dubbo</groupId>
		<artifactId>dubbo-spring-boot-starter</artifactId>
		<version>2.7.5</version>
	</dependency>

	<!-- zookeeper的api管理依赖 -->
	<dependency>
		<groupId>org.apache.curator</groupId>
		<artifactId>curator-recipes</artifactId>
		<version>4.2.0</version>
	</dependency>
	<!-- zookeeper依赖 -->
	<dependency>
		<groupId>org.apache.zookeeper</groupId>
		<artifactId>zookeeper</artifactId>
		<version>3.4.12</version>
	</dependency>
</dependencies>
```

#### api

```java
public interface HelloService {
    String sayHello(String name);
}
```

#### 生产者

```java
@Service
public class HelloServiceImpl implements HelloService {
    @Override
    public String sayHello(String name) {
        return "Hello," + name;
    }
}
```

```yaml
dubbo:
  application:
    name: springboot-provider
  registry:
    address: zookeeper://127.0.0.1:2181
  protocol:
    name: dubbo
    port: 20880
  scan:
    base-packages: com.lofxve.dubbo.service
```

#### 消费者

```java
@Controller
public class HelloController {
    @Reference
    private HelloService helloService;

    @ResponseBody
    @RequestMapping("/say")
    public String sayHello(String name){
        return helloService.sayHello(name);
    }
}
```

```yaml
dubbo:
  application:
    name: springboot-consumer
  registry:
    address: zookeeper://127.0.0.1:2181
  scan:
    base-packages: com.lofxve.dubbo.controller
```

### 使用细节说明

#### 包扫描

~~~xml
<!--服务提供者和服务消费者都需要配置包扫描，作用是扫描指定包(包括子包)下的类中的注解: @Service  @Reference-->
<dubbo:annotation package="com.itheima.dubbo.controller" />
~~~

#### 协议

```xml
<!--
	在服务提供者一方配置，可以指定使用的协议名称和端口号。
	其中Dubbo支持的协议有：dubbo、rmi、hessian、http、webservice、rest、redis等。
-->
<dubbo:protocol name="dubbo" port="20880"/>
```

#### 启动时检查

```xml
<!--
    启动时检查, 配置在服务消费者一方，用于服务消费者在启动的时候主动检查服务提供者是否准备好提供服务
       如果配置为false, 代表不检查
       如果配置为true, 代表检查, 一旦检查到服务提供者未准备好, 就会直接抛异常
-->
<dubbo:consumer check="false"/>
```

####  超时时间和重试机制

```xml
<!--配置在消费者端一方: 默认的超时时间是1s ，默认的重试次数是3次--> 
<dubbo:consumer timeout="50000000" retries="0"/>
```

## 整合swagger2

### 依赖

```xml
<!-- swagger2 配置 -->
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>2.4.0</version>
</dependency>
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger-ui</artifactId>
    <version>2.4.0</version>
</dependency>
<dependency>
    <groupId>com.github.xiaoymin</groupId>
    <artifactId>swagger-bootstrap-ui</artifactId>
    <version>1.6</version>
</dependency>
```

### 配置

```java
@Configuration
@EnableSwagger2
public class Swagger3Config {
//    http://localhost:8080/swagger-ui.html
//    http://localhost:8080/doc.html

    // 配置swagger2核心配置 docket
    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                    .apiInfo(apiInfo())
                    .select()
                .apis(RequestHandlerSelectors
                        .basePackage("com.lofxve.app.controller"))
                .paths(PathSelectors.any())
                    .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("后台接口api")
                .description("后台api文档")
                .version("1.0.1")
                .termsOfServiceUrl("https://www.xxxx.com")
                .build();
    }
}
```

### 参数

==@Api==用于给类添加描述。
==@ApiOperation==用于给方法添加描述。
==@ApiParam==用于给单个参数添加描述。
==@ApiImplicitParams==用于给方法的所有参数添加描述。跟@ApiParam类似

@Api：用在请求的类上，表示对类的说明
    tags="说明该类的作用，可以在UI界面上看到的注解"
    value="该参数没什么意义，在UI界面上也看到，所以不需要配置"

@ApiOperation：用在请求的方法上，说明方法的用途、作用
    value="说明方法的用途、作用"
    notes="方法的备注说明"

@ApiImplicitParams：用在请求的方法上，表示一组参数说明
    @ApiImplicitParam：用在@ApiImplicitParams注解中，指定一个请求参数的各个方面
       各个参数说明： 

1. name ：参数名。 
2. value ： 参数的具体意义，作用。 
3. required ： 参数是否必填。 
4. dataType ：参数的数据类型。 
5. paramType ：查询参数类型，这里有几种形式：

​    path 以地址的形式提交数据
​    query 直接跟参数完成自动映射赋值
​    body 以流的形式提交 仅支持POST
​    header 参数在request headers 里边提交
​    form 以form表单的形式提交 仅支持POST


@ApiResponses：用在请求的方法上，表示一组响应
    @ApiResponse：用在@ApiResponses中，一般用于表达一个错误的响应信息
        code：数字，例如400
        message：信息，例如"请求参数没填好"
        response：抛出异常的类

@ApiModel：用于响应类上，表示一个返回响应数据的信息
            （这种一般用在post创建的时候，使用@RequestBody这样的场景，
            请求参数无法使用@ApiImplicitParam注解进行描述的时候）
    @ApiModelProperty：用在属性上，描述响应类的属性

# SpringBoot工作原理

## 源码分析

>SpringBootApplication注解分析

~~~java
@Target({ElementType.TYPE})   //标注位置: 类  接口
@Retention(RetentionPolicy.RUNTIME) // 保留策略  运行时代码
@Documented // 生成JavaDoc
@Inherited //运行被继承

@SpringBootConfiguration // 相当于@Configuration  表示这是一个配置类
@EnableAutoConfiguration // 借助@Import的支持，将所有符合自动配置条件的bean定义加载到IoC容器
@ComponentScan(...) // 注解扫描  扫描的是当前类所在包及其子包中类中的注解
public @interface SpringBootApplication {}
~~~

>@EnableAutoConfiguration注解分析

~~~java
@AutoConfigurationPackage // 获取注解扫描的包路径
@Import({AutoConfigurationImportSelector.class})// 选择所有符合自动配置条件的bean，然后将其加载到IoC容器
public @interface EnableAutoConfiguration {}
~~~

>Registrar类分析

~~~java
//@AutoConfigurationPackage包中使用了@Import导入了Registrar.class
@Import({Registrar.class})
public @interface AutoConfigurationPackage {}
~~~

~~~java
static class Registrar...{
        //加载启动类所在的包下的主类与子类的所有组件注册到spring容器，这就是springboot默认扫描启动类所在的包下的主类与子类的所有组件。
        public void registerBeanDefinitions(AnnotationMetadata metadata, BeanDefinitionRegistry registry) {
            AutoConfigurationPackages.register(registry, (new AutoConfigurationPackages.PackageImport(metadata)).getPackageName());
        }
}
~~~

> AutoConfigurationImportSelector类分析

~~~java
public class AutoConfigurationImportSelector...{
    ...

    public String[] selectImports(AnnotationMetadata annotationMetadata) {
        if (!this.isEnabled(annotationMetadata)) {
            return NO_IMPORTS;
        } else {
            AutoConfigurationMetadata autoConfigurationMetadata = AutoConfigurationMetadataLoader.loadMetadata(this.beanClassLoader);
            AutoConfigurationImportSelector.AutoConfigurationEntry autoConfigurationEntry
                		= this.getAutoConfigurationEntry(autoConfigurationMetadata, annotationMetadata);
            return StringUtils.toStringArray(autoConfigurationEntry.getConfigurations());
        }
    }

    protected AutoConfigurationImportSelector.AutoConfigurationEntry 
        getAutoConfigurationEntry(AutoConfigurationMetadata autoConfigurationMetadata, AnnotationMetadata annotationMetadata) {
        if (!this.isEnabled(annotationMetadata)) {
            return EMPTY_ENTRY;
        } else {
            AnnotationAttributes attributes = this.getAttributes(annotationMetadata);
            List<String> configurations = this.getCandidateConfigurations(annotationMetadata, attributes);
            configurations = this.removeDuplicates(configurations);
            Set<String> exclusions = this.getExclusions(annotationMetadata, attributes);
            this.checkExcludedClasses(configurations, exclusions);
            configurations.removeAll(exclusions);
            configurations = this.filter(configurations, autoConfigurationMetadata);
            this.fireAutoConfigurationImportEvents(configurations, exclusions);
            return new AutoConfigurationImportSelector.AutoConfigurationEntry(configurations, exclusions);
        }
    }

    protected List<String> getCandidateConfigurations(AnnotationMetadata metadata, AnnotationAttributes attributes) {
        //从所有的jar包中读取META-INF/spring.factories文件信息。
        List<String> configurations = SpringFactoriesLoader.loadFactoryNames(this.getSpringFactoriesLoaderFactoryClass(), this.getBeanClassLoader());
        Assert.notEmpty(configurations, "No auto configuration classes found in META-INF/spring.factories....");
        return configurations;
    }
}
~~~

>下面是spring-boot-autoconfigure这个jar中spring.factories文件部分内容，其中有一个key为org.springframework.boot.autoconfigure.EnableAutoConfiguration的值定义了需要自动配置的bean，通过读取这个配置获取一组@Configuration类。

~~~properties
org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
org.springframework.boot.autoconfigure.admin.SpringApplicationAdminJmxAutoConfiguration,\
org.springframework.boot.autoconfigure.aop.AopAutoConfiguration,\
org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration,\
org.springframework.boot.autoconfigure.data.redis.RedisReactiveAutoConfiguration,\
org.springframework.boot.autoconfigure.data.redis.RedisRepositoriesAutoConfiguration,\
org.springframework.boot.autoconfigure.mail.MailSenderAutoConfiguration,\
org.springframework.boot.autoconfigure.mail.MailSenderValidatorAutoConfiguration,\
org.springframework.boot.autoconfigure.web.servlet.DispatcherServletAutoConfiguration,\
org.springframework.boot.autoconfigure.web.servlet.ServletWebServerFactoryAutoConfiguration,\
org.springframework.boot.autoconfigure.web.servlet.error.ErrorMvcAutoConfiguration,\
org.springframework.boot.autoconfigure.web.servlet.HttpEncodingAutoConfiguration,\
org.springframework.boot.autoconfigure.web.servlet.MultipartAutoConfiguration,\
org.springframework.boot.autoconfigure.web.servlet.WebMvcAutoConfiguration,\
......省略了很多
~~~

>DispatcherServletAutoConfiguration

~~~java
@AutoConfigureOrder(-2147483648)
@Configuration(
    proxyBeanMethods = false
)
@ConditionalOnWebApplication(
    type = Type.SERVLET
)
@ConditionalOnClass({DispatcherServlet.class})  //只有JVM中有DispatcherServlet这个类的字节码时,当前类才有效
@AutoConfigureAfter({ServletWebServerFactoryAutoConfiguration.class})
public class DispatcherServletAutoConfiguration {
    public static final String DEFAULT_DISPATCHER_SERVLET_BEAN_NAME = "dispatcherServlet";
    public static final String DEFAULT_DISPATCHER_SERVLET_REGISTRATION_BEAN_NAME = "dispatcherServletRegistration";

    @Configuration(
        proxyBeanMethods = false
    )
    @Conditional({DispatcherServletAutoConfiguration.DefaultDispatcherServletCondition.class})
    @ConditionalOnClass({ServletRegistration.class})
    @EnableConfigurationProperties({HttpProperties.class, WebMvcProperties.class})
    protected static class DispatcherServletConfiguration {
        protected DispatcherServletConfiguration() {
        }

        //创建DispatcherServlet的对象并放入容器
        @Bean(
            name = {"dispatcherServlet"}
        )
        public DispatcherServlet dispatcherServlet(HttpProperties httpProperties, WebMvcProperties webMvcProperties) {
            DispatcherServlet dispatcherServlet = new DispatcherServlet();
            dispatcherServlet.setDispatchOptionsRequest(webMvcProperties.isDispatchOptionsRequest());
            dispatcherServlet.setDispatchTraceRequest(webMvcProperties.isDispatchTraceRequest());
            dispatcherServlet.setThrowExceptionIfNoHandlerFound(webMvcProperties.isThrowExceptionIfNoHandlerFound());
            dispatcherServlet.setPublishEvents(webMvcProperties.isPublishRequestHandledEvents());
            dispatcherServlet.setEnableLoggingRequestDetails(httpProperties.isLogRequestDetails());
            return dispatcherServlet;
        }

        @Bean
        @ConditionalOnBean({MultipartResolver.class})
        @ConditionalOnMissingBean(
            name = {"multipartResolver"}
        )
        public MultipartResolver multipartResolver(MultipartResolver resolver) {
            return resolver;
        }
    }
}
~~~

![image-20210118102932463](assets/image-20210118102932463.png)

>条件装配

~~~markdown
* 并不是读取META-INF/spring.factories所有的Bean都会被初始化，在配置类中使用@Condition来加载满足条件的Bean
- ConditionalOnClass：      判断环境中是否有对应字节码文件才初始化Bean
- ConditionalOnProperty：   判断配置文件中是否有对应属性和值才初始化Bean
- ConditionalOnMissingBean：判断环境中没有对应Bean才初始化Bean
~~~

## 源码图示

![image-20201215161912317](assets/image-20201215161912317.png)

# 自定义启动器

![image-20210118201203813](assets/image-20210118201203813.png)

## 依赖

```xml
 <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-autoconfigure</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-configuration-processor</artifactId>
    </dependency>
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
    </dependency>
```

## 配置==spring.factories==

```properties
# Auto Configure
org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
  com.lofxve.sms.autoconfigure.SmsAutoConfiguration
```

## 工具类

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SmsTemplate {
    private String username;
    private String password;

    public void send(){
        System.out.println("发送短信");
    }
}
```

## 配置类

```java
@Data
@ConfigurationProperties(
        prefix = "sms"
)
public class SmsProperties {
    private String username;
    private String password;
}
```

## 自动装配类

```java
@Configuration
@EnableConfigurationProperties({SmsProperties.class})
public class SmsAutoConfiguration {

    @Bean
    public SmsTemplate smsTemplate(SmsProperties smsProperties) {
        SmsTemplate smsTemplate = new SmsTemplate();
        smsTemplate.setUsername(smsProperties.getUsername());
        smsTemplate.setPassword(smsProperties.getPassword());
        return smsTemplate;
    }
}
```

## 测试

### 依赖

```xml
<dependency>
    <groupId>com.lofxve</groupId>
    <artifactId>springboot-sms-starter</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
```

### 配置

```yaml
sms:
  username: 张三
  password: 123
```

### 单元测试

```java
@Autowired
private SmsTemplate smsTemplate;
@Test
public void starterTest(){
    smsTemplate.send();
}
```

# 项目监控

## Actuator监控

### 导入依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

### 添加配置

```yaml
# 配置展示详细信息
management:
  endpoint:
    health:
      show-details: always
  endpoints:
    web:
      exposure:
        include: "*"
```

### 选项说明

>访问地址`http://localhost:8080/actuator`查看监控信息，下面是详细项

| **路径**        | **描述**                                                     |
| --------------- | ------------------------------------------------------------ |
| /beans          | 描述应用程序上下文里全部的Bean，以及它们的关系               |
| /env            | 获取全部环境属性                                             |
| /env/{name}     | 根据名称获取特定的环境属性值                                 |
| /health         | 报告应用程序的健康指标，这些值由HealthIndicator的实现类提供  |
| /info           | 获取应用程序的定制信息，这些信息由info打头的属性提供         |
| /mappings       | 描述全部的URI路径，以及它们和控制器(包含Actuator端点)的映射关系 |
| /metrics        | 报告各种应用程序度量信息，比如内存用量和HTTP请求计数         |
| /metrics/{name} | 报告指定名称的应用程序度量值                                 |
| /trace          | 提供基本的HTTP请求跟踪信息(时间戳、HTTP头等)                 |

## SpringBootAdmin

### 服务端

#### 依赖

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>2.2.2.RELEASE</version>
</parent>

<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>de.codecentric</groupId>
        <artifactId>spring-boot-admin-starter-server</artifactId>
        <version>2.2.2</version>
    </dependency>
</dependencies>
```

#### 配置

```yaml
server:
  port: 9999
```

#### 启动类

```java
@SpringBootApplication
@EnableAdminServer//开启服务支持
public class AdminApplication {
}
```

### 客户端

#### 依赖

```xml
<dependency>
    <groupId>de.codecentric</groupId>
    <artifactId>spring-boot-admin-starter-client</artifactId>
    <version>2.2.2</version>
</dependency>
```

#### 配置

```yaml
spring:
  boot:
    admin:
      client:
	    url: http://localhost:9999/
```

# 项目打包

## jar

### 依赖

```xml
<build>
    <finalName>user-manager</finalName>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```

## war包发布（了解）

### 项目打包方式

> 找到项目的pom.xml文件修改默认打包方式为war

![image-20210118121232754](assets/image-20210118121232754.png) 

### 配置启动类

>在主类中添加下面配置

```java
package com.itheima;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
@MapperScan("com.itheima.mapper")
public class MybatisApplication  extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(MybatisPlusApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(MybatisPlusApplication.class);
    }
}
```

### 部署到Tomcat

> 执行maven的package命令，将打好的war包放入Tomcat中运行即可

# 定时任务

## 任务类

```java
@Component
public class ScheduledTasks {
    public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @Scheduled(fixedDelay = 5000)
    public void reportCurrentTime() {
        System.out.println(DATE_FORMAT.format(new Date()));
    }
}
```

## 启动类

```java
@EnableScheduling
```

# 日志AOP

```java
@Aspect
@Component
public class WebLogAspect {
    private Logger logger = LoggerFactory.getLogger(getClass());
    @Pointcut("execution(public * com.lofxve..*.*(..))")
    public void webLog() {
    }
    @Before("webLog()")
    public void doBefore(JoinPoint joinPoint) throws Throwable {
        // 接收到请求，记录请求内容
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        // 记录下请求内容
        logger.info("URL : " + request.getRequestURL().toString());
        logger.info("HTTP_METHOD : " + request.getMethod());
        logger.info("IP : " + request.getRemoteAddr());
        Enumeration<String> enu = request.getParameterNames();
        while (enu.hasMoreElements()) {
            String name = (String) enu.nextElement();
            logger.info("name:{},value:{}", name, request.getParameter(name));
        }
    }
    @AfterReturning(returning = "ret", pointcut = "webLog()")
    public void doAfterReturning(Object ret) throws Throwable {
        // 处理完请求，返回内容
        logger.info("RESPONSE : " + ret);
    }
}
```

# @Async实现异步调用

启动加上@EnableAsync ,需要执行异步方法上加入@Async

# CommandLineRunner

> 需要提前将部分数据加载到Spring容器中
>
> ==@Order==注解，且value值越小则优先级越高。
>
> ==ClassDo对象==，主要是能够体现@Order注解的加载顺序



1. 定义静态常量，随着类的生命周期加载而提前加载（这种方式可能对于工作经验较少的伙伴，选择是最多的）；

2. 实现CommandLineRunner接口；容器启动之后，加载实现类的逻辑资源，已达到完成资源初始化的任务；

3. @PostConstruct；在具体Bean的实例化过程中执行，@PostConstruct注解的方法，会在构造方法之后执行；

   加载顺序为：Constructor > @Autowired > @PostConstruct > 静态方法；

   特点：

   - 只有一个非静态方法能使用此注解
   - 被注解的方法不得有任何参数
   - 被注解的方法返回值必须为void
   - 被注解方法不得抛出已检查异常
   - 此方法只会被执行一次

4. 实现InitializingBean接口；重写afterPropertiesSet()方法；

```java
@Component
@Order(1)
public class RunnerLoadOne implements CommandLineRunner {

    @Override
    public void run(String... args) throws Exception {
        ClassDo classDo = SpringContextUtil.getBean(ClassDo.class);
        classDo.setClassName("Java");
        System.out.println("------------容器初始化bean之后,加载资源结束-----------");
    }
}

@Component
@Order(2)
public class RunnerLoadTwo implements CommandLineRunner {
    @Override
    public void run(String... args) throws Exception {
        ClassDo bean = SpringContextUtil.getBean(ClassDo.class);
        System.out.println("依赖预先加载的资源数据：" + bean.getClassName());
    }
}
```

# JDBC必知必会

## 多数据源

```java
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class,
        DataSourceTransactionManagerAutoConfiguration.class,
        JdbcTemplateAutoConfiguration.class})// 去除Springboot自动配置的类
@Slf4j
public class MultiDataSourceDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(MultiDataSourceDemoApplication.class, args);
    }

    @Bean
    @ConfigurationProperties("foo.datasource") // 获取配置属性
    public DataSourceProperties fooDataSourceProperties() {
        return new DataSourceProperties();
    }

    @Bean
    public DataSource fooDataSource() { // 数据源
        DataSourceProperties dataSourceProperties = fooDataSourceProperties();
        log.info("foo datasource: {}", dataSourceProperties.getUrl());
        return dataSourceProperties.initializeDataSourceBuilder().build();
    }

    @Bean
    @Resource
    public PlatformTransactionManager fooTxManager(DataSource fooDataSource) { //事务管理
        return new DataSourceTransactionManager(fooDataSource);
    }

    @Bean
    @ConfigurationProperties("bar.datasource")
    public DataSourceProperties barDataSourceProperties() {
        return new DataSourceProperties();
    }

    @Bean
    public DataSource barDataSource() {
        DataSourceProperties dataSourceProperties = barDataSourceProperties();
        log.info("bar datasource: {}", dataSourceProperties.getUrl());
        return dataSourceProperties.initializeDataSourceBuilder().build();
    }

    @Bean
    @Resource
    public PlatformTransactionManager barTxManager(DataSource barDataSource) {
        return new DataSourceTransactionManager(barDataSource);
    }
}
```

## HikariCP==光==

### HikariCP为什么快？

![image-20210120211802041](assets/image-20210120211802041.png)

### 配置

![image-20210120212150727](assets/image-20210120212150727.png)

# O/R Mapper

## 依赖金融相关

```xml
<dependency>
   <groupId>org.joda</groupId>
   <artifactId>joda-money</artifactId>
   <version>1.0.1</version>
</dependency>
<dependency>
   <groupId>org.jadira.usertype</groupId>
   <artifactId>usertype.core</artifactId>
   <version>6.0.1.GA</version>
</dependency>
```

## hibernate

### 实体

```java
@Entity //实体类
@Table(name = "T_MENU") // 关联的表
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Coffee implements Serializable {
    @Id // 主键
    @GeneratedValue // 自增主键
    private Long id;
    private String name;
    @Column
    @Type(type = "org.jadira.usertype.moneyandcurrency.joda.PersistentMoneyAmount",
            parameters = {@org.hibernate.annotations.Parameter(name = "currencyCode", value = "CNY")})
    private Money price;
    @Column(updatable = false) //不可修改
    @CreationTimestamp // 创建时间
    private Date createTime;
    @UpdateTimestamp  // 修改时间
    private Date updateTime;
}
```

### 配置

```properties
#创建表结构然后删除
spring.jpa.hibernate.ddl-auto=create-drop
#打印执行sql
spring.jpa.properties.hibernate.show_sql=true
#格式化sql
spring.jpa.properties.hibernate.format_sql=true
```

### 启动类

```
@EnableJpaRepositories
```

# NOSQL

## mongo

### 依赖

```xml
<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-starter-data-mongodb</artifactId>
</dependency>
```

### 配置

```properties
spring.data.mongodb.uri=mongodb://springbucks:springbucks@localhost:27017/springbucks
```

### 实体

```java
@Document
public class Coffee {
    @Id
    private String id;
    private String name;
    private Money price;
    private Date createTime;
    private Date updateTime;
}
```

### 测试

```java
@SpringBootApplication
@Slf4j
public class MongoDemoApplication implements ApplicationRunner {
   @Autowired
   private MongoTemplate mongoTemplate;

   public static void main(String[] args) {
      SpringApplication.run(MongoDemoApplication.class, args);
   }

   @Bean
   public MongoCustomConversions mongoCustomConversions() {
      return new MongoCustomConversions(Arrays.asList(new MoneyReadConverter()));
   }

   @Override
   public void run(ApplicationArguments args) throws Exception {
      Coffee espresso = Coffee.builder()
            .name("espresso")
            .price(Money.of(CurrencyUnit.of("CNY"), 20.0))
            .createTime(new Date())
            .updateTime(new Date()).build();
      Coffee saved = mongoTemplate.save(espresso);
      log.info("Coffee {}", saved);

      List<Coffee> list = mongoTemplate.find(
            Query.query(Criteria.where("name").is("espresso")), Coffee.class);
      log.info("Find {} Coffee", list.size());
      list.forEach(c -> log.info("Coffee {}", c));

      Thread.sleep(1000); // 为了看更新时间
      UpdateResult result = mongoTemplate.updateFirst(query(where("name").is("espresso")),
            new Update().set("price", Money.ofMajor(CurrencyUnit.of("CNY"), 30))
                  .currentDate("updateTime"),
            Coffee.class);
      log.info("Update Result: {}", result.getModifiedCount());
      Coffee updateOne = mongoTemplate.findById(saved.getId(), Coffee.class);
      log.info("Update Result: {}", updateOne);

      mongoTemplate.remove(updateOne);
   }
}
```

## redis

### jedis

#### 依赖

```xml
<dependency>
   <groupId>redis.clients</groupId>
   <artifactId>jedis</artifactId>
</dependency>
```

#### 配置

```properties
redis.host=192.168.136.129
spring.redis.port=6378
redis.maxTotal=5
redis.maxIdle=5
redis.testOnBorrow=true
```

#### 测试

```java
@Slf4j
@EnableTransactionManagement
@SpringBootApplication
@EnableJpaRepositories
public class SpringBucksApplication implements ApplicationRunner {
   @Autowired
   private CoffeeService coffeeService;
   @Autowired
   private JedisPool jedisPool;
   @Autowired
   private JedisPoolConfig jedisPoolConfig;

   public static void main(String[] args) {
      SpringApplication.run(SpringBucksApplication.class, args);
   }

   @Bean
   @ConfigurationProperties("redis")
   public JedisPoolConfig jedisPoolConfig() {
      return new JedisPoolConfig();
   }

   @Bean(destroyMethod = "close")
   public JedisPool jedisPool(@Value("${redis.host}") String host) {
      return new JedisPool(jedisPoolConfig(), host);
   }

   @Override
   public void run(ApplicationArguments args) throws Exception {
      log.info(jedisPoolConfig.toString());

      try (Jedis jedis = jedisPool.getResource()) {
         coffeeService.findAllCoffee().forEach(c -> {
            jedis.hset("springbucks-menu",
                  c.getName(),
                  Long.toString(c.getPrice().getAmountMinorLong()));
         });

         Map<String, String> menu = jedis.hgetAll("springbucks-menu");
         log.info("Menu: {}", menu);

         String price = jedis.hget("springbucks-menu", "espresso");
         log.info("espresso - {}",
               Money.ofMinor(CurrencyUnit.of("CNY"), Long.parseLong(price)));
      }
   }
}
```

### 部署模式

#### 哨兵模式

redis的高可用方案、监控、通知、自动故障迁移，服务发现

#### 集群模式

数据自动分片（分成16384个hash slot）,在部分节点失效时具有一定的可用性

