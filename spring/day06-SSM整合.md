# SSM整合(会用)

## SSM整合思路

~~~markdown
* SSM(SM)
	Spring     业务层   逻辑(声明式事务)
	SpringMVC  表示层   跟用户交互 
	Mybatis    持久层   对数据库操作
	
* SSM整合基本思路：
	使用Spring( 容器 )来整合Mybatis和SpringMVC
	
* 整合步骤是这样：
    1. 先各自搭建SSM的环境
    2. 使用Spring整合Mybatis
    3. 使用Spring整合Springmvc
~~~

## 搭建Mybatis环境

### 创建工程, 转换成web

![image-20210109084211738](assets/image-20210109084211738.png) 

![image-20210109084307540](assets/image-20210109084307540.png) 

### 引入依赖

![image-20210109084505273](assets/image-20210109084505273.png) 

### 创建实体类

![image-20210109084646011](assets/image-20210109084646011.png) 

### 创建dao接口

![image-20210109084740305](assets/image-20210109084740305.png) 

### 创建dao的映射文件

![image-20210109085316455](assets/image-20210109085316455.png) 

### 加入数据库连接配置文件

![image-20210109085640125](assets/image-20210109085640125.png) 

### 加入mybatis的配置文件

![image-20210109090034846](assets/image-20210109090034846.png) 

### 加入日志文件

![image-20210109090129907](assets/image-20210109090129907.png) 

### 测试

![image-20210109090634802](assets/image-20210109090634802.png) 

~~~java
package com.itheima.test;

import com.itheima.dao.AccountDao;
import com.itheima.domain.Account;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class AccountDaoTest {

    @Test
    public void testFindAll() throws IOException {
        //1. 读取配置文件,将文件读成一个输入流
        InputStream inputStream = Resources.getResourceAsStream("mybatis-config.xml");

        //2. 创建sqlSessionFactory
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

        //3. 获取sqlSession
        SqlSession sqlSession = sqlSessionFactory.openSession();

        //4. 获取dao的代理对象,可以操作
        AccountDao accountDao = sqlSession.getMapper(AccountDao.class);
        List<Account> accounts = accountDao.findAll();
        for (Account account : accounts) {
            System.out.println(account);
        }

        //5. 提交事务
        sqlSession.commit();

        //6. 释放资源
        sqlSession.close();
    }
}
~~~



## 搭建Spring环境

### 导入依赖

![image-20210109091255691](assets/image-20210109091255691.png) 

### 创建service接口

![image-20210109091400755](assets/image-20210109091400755.png) 

### 创建service实现类

![image-20210109091718138](assets/image-20210109091718138.png) 

### 加入spring的配置文件

![image-20210109091837017](assets/image-20210109091837017.png) 

### 测试

![image-20210109092034022](assets/image-20210109092034022.png) 

## 搭建SpringMVC环境

### 导入依赖

![image-20210109093609120](assets/image-20210109093609120.png) 

### 加入springmvc的配置文件

![image-20210109093819959](assets/image-20210109093819959.png) 

### 加入web.xml

![image-20210109094947510](assets/image-20210109094947510.png) 

### 编写请求页面

![image-20210109094608965](assets/image-20210109094608965.png) 

### 编写控制器

![image-20210109094630152](assets/image-20210109094630152.png) 

### 编写响应页面

![image-20210109094651595](assets/image-20210109094651595.png) 

### 部署测试

![image-20210109095043167](assets/image-20210109095043167.png) 



## Spring整合Mybatis

### 整合思路

将mybatis的所有配置信息转移到Spring的配置文件中

将Mybatis的SqlSessionFactory托管到Spring的IOC容器中

### 加入mybatis对接Spring的依赖

![image-20210109095822376](assets/image-20210109095822376.png) 

### 将mybatis的所有配置转移到spring的配置文件中

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:tx="http://www.springframework.org/schema/tx"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
			    http://www.springframework.org/schema/beans/spring-beans.xsd
			    http://www.springframework.org/schema/context
			    http://www.springframework.org/schema/context/spring-context.xsd
			    http://www.springframework.org/schema/aop
			    http://www.springframework.org/schema/aop/spring-aop.xsd
			    http://www.springframework.org/schema/tx
			    http://www.springframework.org/schema/tx/spring-tx.xsd">

    <!--注解扫描-->
    <context:component-scan base-package="com.itheima.service"/>

    <!--导入外部的properties配置文件-->
    <context:property-placeholder location="classpath:db.properties"/>

    <!--数据源-->
    <bean id="dataSource" class="com.alibaba.druid.pool.DruidDataSource">
        <property name="driverClassName" value="${jdbc.driver}"/>
        <property name="url" value="${jdbc.url}"/>
        <property name="username" value="${jdbc.username}"/>
        <property name="password" value="${jdbc.password}"/>
    </bean>

    <!--事务管理器-->
    <bean id="transactionManager"
          class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="dataSource"/>
    </bean>

    <!--映射文件导入-->
    <bean id="mapperScannerConfigurer"
          class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <property name="basePackage" value="com.itheima.dao"/>
    </bean>

    <!--将sqlSessionFactory放入spring容器-->
    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <property name="dataSource" ref="dataSource"/>
        <property name="typeAliasesPackage" value="com.itheima.domain"/>
        
        <!--额外引入mybatis的配置文件-->
        <!--<property name="configLocation" value="classpath:mybatis-config.xml"/>-->
    </bean>
</beans>
~~~

![image-20210109101108307](assets/image-20210109101108307.png) 

### 在service中注入dao对象

![image-20210109101023149](assets/image-20210109101023149.png) 

### 测试

![image-20210109101042078](assets/image-20210109101042078.png) 



## Spring整合SpringMVC

### 整合思路

Spring和SpringMVC本身就是一家产品，是不用整合的，

但是现在的Spring容器自己无法启动，我们需要在web容器启动的时候，加载Spring的配置文件，启动Spring容器

那么这个工作是在spring-web包中的一个监听器来做的，这个包不用单独导入，他已经在 spring-webmvc 包中了

它会监听WEB容器的启动和停止，然后就可以控制 Spring容器的启动和停止了

### 配置监听器

![image-20210109102030086](assets/image-20210109102030086.png) 

### 在controller中注入service

![image-20210109102046507](assets/image-20210109102046507.png) 

### 测试

![image-20210109102124996](assets/image-20210109102124996.png) 

### 列表展示

![image-20210109104007677](assets/image-20210109104007677.png) 



# SSM案例(重点)

![image-20210109105324515](assets/image-20210109105324515.png) 

## 思路图

![](assets/image-20200929112155678.png) 

## 增加

### 在列表页添加跳转到增加页面的按钮

![img](assets/wps1.jpg) 

### Controller添加跳转到增加页面的方法

![img](assets/wps2.jpg) 

### 添加增加页面

![img](assets/wps3.jpg) 

### Controller添加增加的方法

![img](assets/wps4.jpg) 

### Service接口添加增加的方法

![img](assets/wps5.jpg) 

### Service实现类添加增加的方法

![img](assets/wps6.jpg) 

### dao添加增加的方法

![img](assets/wps7.jpg) 

### 映射文件中添加的方法

![img](assets/wps8.jpg) 

### 测试

![img](assets/wps9.jpg) 

## 修改

### 数据回显

#### 在list页面上添加修改按钮

![img](assets/wps10.jpg) 

#### 在controller中添加跳转到修改页面的方法

![img](assets/wps11.jpg) 

#### 在service接口中添加查询方法

![img](assets/wps12.jpg) 

#### 在service实现类中添加查询方法

![img](assets/wps13.jpg) 

#### 在dao接口中添加查询方法

![img](assets/wps14.jpg) 

#### 在映射文件中添加查询方法

![img](assets/wps15.jpg) 

#### 添加修改账户的页面

![img](assets/wps16.jpg) 

### 修改提交

#### 在controller中添加修改方法

![img](assets/wps17.jpg) 

#### 在service接口中添加修改方法

![img](assets/wps18.jpg) 

#### 在service实现类中添加修改方法

![img](assets/wps19.jpg) 

#### 在dao接口中添加修改方法

![img](assets/wps20.jpg) 

#### 在映射文件中添加修改方法

![img](assets/wps21.jpg) 

### 测试(略)

## 删除

### 修改list页面，添加删除

![img](assets/wps22.jpg) 

### 在controller中添加删除的方法

![img](assets/wps23.jpg) 

### 在service接口中添加删除的方法

![img](assets/wps24.jpg) 

### 在seivice实现类中添加删除的方法

![img](assets/wps25.jpg) 

### 在dao接口中添加删除的方法

![img](assets/wps26.jpg) 

### 在映射文件中添加删除的方法

![img](assets/wps27.jpg) 

### 测试(略)

## 添加事务控制

### xml版

![image-20210109115018527](assets/image-20210109115018527.png) 

### 注解版

1. 修改xml

   ![image-20210109115159210](assets/image-20210109115159210.png) 

2. 使用注解处理事务

   ![image-20210109115236391](assets/image-20210109115236391.png) 

## Spring的父子容器

### 说明

Spring和SpringMVC的容器具有父子关系，Spring容器为父容器，SpringMVC为子容器

子容器可以引用父容器中的Bean，而父容器不可以引用子容器中的Bean
![image-20210109120655164](assets/image-20210109120655164.png) 

### 配置(会配)

![image-20210109120636544](assets/image-20210109120636544.png) 



## 拦截器使用

### 思路说明

![image-20210109123512166](assets/image-20210109123512166.png) 

### 开发login.jsp

![image-20210109123531739](assets/image-20210109123531739.png) 

### 开发登录方法

![image-20210109123558994](assets/image-20210109123558994.png) 

### 开发拦截器

![image-20210109123616089](assets/image-20210109123616089.png) 

### 配置拦截器

![image-20210109123643412](assets/image-20210109123643412.png) 



 