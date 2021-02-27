---
typora-root-url: 新建文件夹 (3)
typora-copy-images-to: 新建文件夹 (3)
---

# Mybatis

## 谈一谈你对Mybatis框架的理解

~~~markdown
Mybatis是一个半ORM框架，它内部封装了JDBC,使用它可以简化持久层的操作,使程序员在开发时只需要关注SQL语句即可。
~~~

## 在mybatis中,${} 和 #{} 的区别是什么?

~~~markdown
1. Mybatis中#{}是预编译处理，${}是字符串替换
2. Mybatis在处理#{}时，会将sql中的#{}替换为?号，然后调用PreparedStatement进行数据库操作，此方式不存在sql注入问题
   Mybatis在处理${}时，就是把${}替换成变量的值，然后调用Statement进行数据库操作，此方式存在sql注入问题
3. 如果使用#{}接收一个简单类型的参数，{}中可以随便写；如果使用${}接收一个简单类型的参数，{}中只能写value
~~~

## 在mybatis中,resultType和ResultMap的区别是什么?

~~~markdown
	如果数据库结果集中的列名和要封装实体的属性名完全一致的话用 resultType 属性
	如果数据库结果集中的列名和要封装实体的属性名有不一致的情况用 resultMap 属性，通过resultMap手动建立对象关系映射
~~~

## 在Mybatis中你知道的动态SQL的标签有哪些?作用分别是什么?

~~~markdown
1. <if>if是为了判断传入的值是否符合某种规则,比如是否不为空.
2. <where> where标签可以用来做动态拼接查询条件,当和if标签配合的时候,不用显示的声明类型where 1 = 1这种无用的条件
3. <foreach> foreach标签可以把传入的集合对象进行遍历,然后把每一项的内容作为参数传到sql语句中.
4. <include> include可以把大量的重复代码整理起来,当使用的时候直接include即可,减少重复代码的编写;
5. <set>适用于更新中,当匹配某个条件后,才会对该字段进行跟新操作
~~~

## 在mybatis中,Dao接口中的方法支持重载吗? 为什么?

~~~markdown
不支持。
	在Mybatis中，要求接口的方法名要跟映射文件中的ID一致，而ID又是不能重复的；如果接口中的方法重载了，就意味着映射文件中的ID会出现重复的情况，会出异常。
~~~

## 谈一下你对mybatis缓存机制的理解?

~~~markdown
Mybatis有两级缓存，一级缓存是SqlSession级别的，默认开启，无法关闭；二级缓存是Mapper级别的，默认开启，但是可以关闭
	1. 一级缓存：基础PerpetualCache的HashMap本地缓存，其存储作用域为Session,当Session flush或close之后，Session中的所有Cache就将清空
	2. 二级缓存默认也是采用PerpetualCache的HashMap存储，不同在于其存储作用域为Mapper(Namespace），使用二级缓存属性类需要实现Serializable序列化接口
	3. 对于缓存数据更新机制，当某一个作用域(一级缓存Session/二级缓存Namespaces)的进行了C/U/D操作后，默认该作用域下所有select中的缓存将被clear.
~~~



# Spring

## Spring的两大核心是什么?谈一谈你对IOC的理解? 谈一谈你对DI的理解? 谈一谈你对AOP的理解?

~~~markdown
1. Spring的两大核心是：IOC（控制翻转）和AOP（面向切面编程）
	
2. IOC的意思是控制反转，是指创建对象的控制权的转移，以前创建对象的主动权和时机是由自己把控的，而现在这种权力转移到Spring容器中，并由容器根据配置文件去创建实例和管理各个实例之间的依赖关系，对象与对象之间松散耦合，也利于功能的复用。最直观的表达就是，IOC让对象的创建不用去new了，可以由spring根据我们提供的配置文件自动生产，我们需要对象的时候，直接从Spring容器中获取即可.
Spring的配置文件中配置了类的字节码位置及信息, 容器生成的时候加载配置文件识别字节码信息, 通过反射创建类的对象.

3. DI的意思是依赖注入，和控制反转是同一个概念的不同角度的描述，即应用程序在运行时依赖Io 容器来动态注入对象需要的外部资源。

4.   AOP，一般称为面向切面编程，作为面向对象的一种补充，用于将那些与业务无关，但却对多个对象产生影响的公共行为和逻辑，抽取并封装为一个可重用的模块，这个模块被命名为“切面”（Aspect）. SpringAOP使用的动态代理，所谓的动态代理就是说AOP框架不会去修改字节码，而是每次运行时在内存中临时为方法生成一个AOP对象，这个AOP对象包含了目标对象的全部方法，并且在特定的切点做了增强处理，并回调原对象的方法。
5. Spring AOP 中的动态代理主要有两种方式，JDK 动态代理和 CGLIB 动态代理：
(1)JDK 动态代理只提供接口代理，不支持类代理，核心 InvocationHandler 接口和 Proxy 类，InvocationHandler 通过 invoke()方法反射来调用目标类中的代码，动态地将横切逻辑和业务编织在一起，Proxy 利用 InvocationHandler 动态创建一个符合某一接口的的实例, 生成目标类的代理对象。 
(2) 如果代理类没有实现 InvocationHandler 接口，那么 Spring AOP会选择使用 CGLIB 来动态代理目标类。CGLIB（Code Generation Library），是一个代码生成的类库，可以在运行时动态的生成指定类的一个子类对象，并覆盖其中特定方法并添加增强代码，从而实现 AOP。CGLIB 是通过继承的方式做的动态代理，因此如果某个类被标记为 final，那么它是无法使用 CGLIB 做动态代理的。
~~~

## 你能说出Spring的详细生命周期吗?

~~~markdown
1. 实例化一个Bean，也就是我们通常说的new

2. 按照Spring上下文对实例化的Bean进行配置，也就是IOC注入

3. 如果这个Bean实现dao了BeanNameAware接口，会调用它实现的setBeanName(String beanId)方法，此处传递的是Spring配置文件中Bean的ID

4. 如果这个Bean实现了BeanFactoryAware接口，会调用它实现的setBeanFactory()，传递的是Spring工厂本身（可以用这个方法获取到其他Bean）

5. 如果这个Bean实现了ApplicationContextAware接口，会调用setApplicationContext(ApplicationContext)方法，传入Spring上下文，该方式同样可以实现步骤4，但比4更好，以为ApplicationContext是BeanFactory的子接口，有更多的实现方法

6. 如果这个Bean关联了BeanPostProcessor接口，将会调用postProcessBeforeInitialization(Object obj, String s)方法，BeanPostProcessor经常被用作是Bean内容的更改，并且由于这个是在Bean初始化结束时调用After方法，也可用于内存或缓存技术

7. 如果这个Bean在Spring配置文件中配置了init-method属性会自动调用其配置的初始化方法

8. 如果这个Bean关联了BeanPostProcessor接口，将会调用postAfterInitialization(Object obj, String s)方法

	注意：以上工作完成以后就可以用这个Bean了，那这个Bean是一个single的，所以一般情况下我们调用同一个ID的Bean会是在内容地址相同的实例

9. 当Bean不再需要时，会经过清理阶段，如果Bean实现了DisposableBean接口，会调用其实现的destroy方法

10. 最后，如果这个Bean的Spring配置中配置了destroy-method属性，会自动调用其配置的销毁方法
~~~

## 你知道Spring支持bean的作用域有几种吗?  每种作用域是什么样的?

~~~markdown
Spring支持如下5种作用域：
	singleton：单例模式(默认作用域)，在整个Spring IoC容器中，使用singleton定义的Bean将只有一个实例
	prototype：原型模式，每次通过容器的getBean方法获取Bean时，都将产生一个新的Bean实例
	request：对于每次HTTP请求，使用request定义的Bean都将产生一个新实例，即每次HTTP请求将会产生不同的Bean实例。只有在Web应用中使用Spring时，该作用域才有效
	session：对于每次HTTP Session，使用session定义的Bean都将产生一个新实例。同样只有在Web应用中使用Spring时，该作用域才有效
	globalsession：每个全局的HTTP Session，使用session定义的Bean都将产生一个新实例。同样只有在Web应用中使用Spring时，该作用域才有效
~~~

## BeanFactory和ApplicationContext有什么区别

~~~markdown
BeanFactory：
	Spring最顶层的接口,实现了Spring容器的最基础的一些功能, 调用起来比较麻烦, 一般面向Spring自身使用
	BeanFactory在启动的时候不会去实例化Bean，中有从容器中拿Bean的时候才会去实例化
ApplicationContext：
	BeanFactory的子接口,扩展了其功能, 一般面向程序员身使用
	ApplicationContext在启动的时候就把所有的Bean全部实例化了
~~~

## Spring框架中都用到了哪些设计模式?

~~~markdown
1. 工厂模式：BeanFactory就是简单工厂模式的体现，用来创建对象的实例
2. 单例模式：Bean默认为单例模式
3. 代理模式：Spring的AOP功能用到了JDK的动态代理和CGLIB字节码生成技术
4. 模板方法：用来解决代码重复的问题。比如. RestTemplate, JmsTemplate, JpaTemplate
5. 观察者模式：定义对象键一种一对多的依赖关系，当一个对象的状态发生改变时，所有依赖于它的对象都会得到通知被制动更新，如Spring中listener的实现--ApplicationListener
~~~

## Spring事务的实现方式和实现原理

~~~markdown
Spring事务的本质其实就是数据库对事务的支持，没有数据库的事务支持，spring是无法提供事务功能的。真正的数据库层的事务提交和回滚是通过binlog或者redo log实现的。 

spring事务实现主要有两种方法
1、编程式，beginTransaction()、commit()、rollback()等事务管理相关的方法
2、声明式，利用注解Transactional 或者aop配置

参考面试宝典5.14
~~~

## 你知道的Spring的通知类型有哪些,分别在什么时候执行?

~~~markdown
Spring的通知类型有四种，分别为：
	前置通知[]before]：在切点运行之前执行
	后置通知[after-returning]：在切点正常结束之后执行
	异常通知[after-throwing]：在切点发生异常的时候执行
	最终通知[after]：在切点的最终执行
Spring还有一种特殊的通知,叫做环绕通知
	环绕通知运行程序员以编码的方式自己定义通知的位置, 用于解决其他通知时序问题
~~~

## Spring的对象默认是单例的还是多例的? 单例bean存不存在线程安全问题呢?

~~~markdown
1. 在spring中的对象默认是单例的，但是也可以配置为多例。
2. 单例bean对象对应的类存在可变的成员变量并且其中存在改变这个变量的线程时，多线程操作该bean对象时会出现线程安全问题。
		原因是：多线程操作如果改变成员变量，其他线程无法访问该bean对象，造成数据混乱。
		解决办法：1 在bean对象中避免定义可变成员变量；
				2 在bean对象中定义一个ThreadLocal成员变量，将需要的可变成员变量保存在ThreadLocal中。
~~~

## @Resource和@Autowired依赖注入的区别是什么? @Qualifier使用场景是什么?

~~~markdown
@Resource
	只能放在属性上，表示先按照属性名匹配IOC容器中对象id给属性注入值若没有成功，会继续根据当前属性的类型匹配IOC容器中同类型对象来注入值
	若指定了name属性@Resource(name = "对象id")，则只能按照对象id注入值。
@Autowird
	放在属性上：表示先按照类型给属性注入值如果IOC容器中存在多个与属性同类型的对象，则会按照属性名注入值
		也可以配合@Qualifier("IOC容器中对象id")注解直接按照名称注入值。
	放在方法上：表示自动执行当前方法，如果方法有参数，会自动从IOC容器中寻找同类型的对象给参数传值
		也可以在参数上添加@Qualifier("IOC容器中对象id")注解按照名称寻找对象给参数传值。	
@Qualifier使用场景：
	@Qualifier("IOC容器中对象id")可以配合@Autowird一起使用, 表示根据指定的id在Spring容器中匹配对象
~~~

## Spring的常用注解

~~~markdown
1. @Component  @Controller  @Service  @Repository: 用于实例化对象
2. @Scope : 设置Spring对象的作用域
3. @PostConstruct @PreDestroy : 用于设置Spring创建对象在对象创建之后和销毁之前要执行的方法
4. @Value: 简单属性的依赖注入
5. @Autowired: 对象属性的依赖注入
6. @Qualifier: 要和@Autowired联合使用，代表在按照类型匹配的基础上，再按照名称匹配。
7. @Resource 按照属性名称依赖注入
8. @ComponentScan: 组件扫描
9. @Bean: 表在方法上,用于将方法的返回值对象放入容器
10. @PropertySource: 用于引入其它的properties配置文件
11. @Import: 在一个配置类中导入其它配置类的内容
12. @Configuration: 被此注解标注的类,会被Spring认为是配置类。Spring在启动的时候会自动扫描并加载所有配置类，然后将配置	类中bean放入容器
13. @Transactional 此注解可以标在类上，也可以表在方法上，表示当前类中的方法具有事务管理功能。
~~~



# SpringMVC

## 谈一下你对SpringMVC框架的理解

~~~markdown
	SpringMVC是一个基于Java的实现了MVC设计模式的请求驱动类型的轻量级Web框架，通过把Model，View，Controller分离，将web层进行职责解耦，把复杂的web应用分成逻辑清晰的几部分，简化开发，减少出错，方便组内开发人员之间的配合。
	在我看来,SpringMVC就是将我们原来开发在servlet中的代码拆分了,一部分由SpringMVC完成,一部分由我们自己完成
~~~

## 谈一下SpringMVC的执行流程以及各个组件的作用

~~~markdown
1. Request发送请求给前端控制器(dispatcherServlet)进行各个任务的调度
2. dispatcherServlet根据浏览器请求的参数调用处理器映射器(HandlerMapping)进行参数查找
3. HandlerMapping将查找后的结果返回给dispatcherServlet
4. dispatcherServlet根据返回值调用处理器适配器(HandlerAdapter)
5. HandlerAdapter根据参数调用处理器(Controller)
6. Controller将得到的参数进行处理并返回结果给HandlerAdapter
7. HandlerAdapter将得到的结果返回给dispatcherServlet
8. dispatcherServlet根据得到的参数调用视图解析器(ViewReslover)
9. ViewReslover将得到的参数从逻辑视图转换为物理视图并返回给dispatcherServlet
10. dispatcherServlet调用物理视图进行渲染并返回
11. dispatcherServlet将渲染后的结果返回
~~~

## 说一下SpringMVC支持的转发和重定向的写法

~~~markdown
1）转发：
	简单方式：直接return "要跳转的页面"
	forward方式:在返回值前面加"forward:",比如"”"forward:user.do?name=method4"
	原生方式：使用原生的方法通过request直接转发
2) 重定向:
	redirect方式：在返回值前面加”redirect:”,比如"redirect:http://www.baidu.com"
	原生方式：使用原生的方法通过response直接转发	
~~~

## 谈一下SpringMVC统一异常处理的思想和实现方式

~~~markdown
使用SpringMVC之后,代码的调用者是SpringMVC框架,也就是说最终的异常会抛到框架中,然后由框架指定异常处理类进行统一处理
	方式一: 创建一个自定义异常处理器(实现HandlerExceptionResolver接口),并实现里面的异常处理方法,然后将这个类交给Spring容器管理
	方式二: 在类上加注解(@ControllerAdvice)表明这是一个全局异常处理类
            在方法上加注解(@ExceptionHandler),在ExceptionHandler中有一个value属性,可以指定可以处理的异常类型
~~~

## 在SpringMVC中, 如果想通过转发将数据传递到前台,有几种写法?

~~~markdown
方式一：直接使用request域进行数据的传递   
	request.setAttirbuate("name", value);
方式二：使用Model进行传值，底层会将数据放入request域进行数据的传递
	model.addAttribuate("name", value);
方式三：使用ModelMap进行传值，底层会将数据放入request域进行数据的传递
	modelmap.put("name",value);
方式四：借用ModelAndView在其中设置数据和视图
	mv.addObject("name",value);
	mv.setView("success");
	return mv;
~~~

## 在SpringMVC中拦截器的使用步骤是什么样的?

~~~markdown
1 定义拦截器类:
	SpringMVC为我们提供了拦截器规范的接口,创建一个类实现HandlerInterceptor,重写接口中的抽象方法;
		preHandle方法：在调用处理器之前调用该方法，如果该方法返回true则请求继续向下进行，否则请求不会继续向下进行,处理器也不会调用
		postHandle方法：在调用完处理器后调用该方法
		afterCompletion方法：在前端控制器渲染页面完成之后调用此方法		
2 注册拦截器:
	在SpringMVC核心配置文件中注册自定义的拦截器
        <mvc:interceptors>
            <mvc:interceptor>
                <mvc:mapping path="拦截路径规则"/>
                <mvc:exclude-mapping path="不拦截路径规则"/>
                <bean class="自定义拦截器的类全限定名"/>
            </mvc:interceptor>
        </mvc:interceptors>
~~~

## 在SpringMVC中文件上传的使用步骤是什么样的? 前台三要素是什么?

~~~markdown
文件上传步骤:
	1.加入文件上传需要的commons-fileupload包
	2.配置文件上传解析器,springmvc的配置文件的文件上传解析器的id属性必须为multipartResolver
	3.后端对应的接收文件的方法参数类型必须为MultipartFile,参数名称必须与前端的name属性保持一致
文件上传前端三要素:
	1.form表单的提交方式必须为post
	2.enctype属性需要修改为:multipart/form-data
	3.必须有一个type属性为file的input标签,其中需要有一个name属性;如果需要上传多个文件需要添加multiple属性
~~~

## Springmvc 中如何解决GET|POST请求中文乱码问题？

~~~markdown
1. POST乱码: 
	在web.xml中配置一个过滤器设置为utf-8就可以解决post提交方式的中文乱码问题；
2. GET乱码:
	第一种可以修改tomcat配置文件，添加编码与工程编码一致；
	第二种方法是对请求携带的参数进行重新编码，将tomcat编码后的内容按utf-8编码
~~~

## 在SpringMVC的方法参数中,我们在方法形参位置,直接问Spring要的数据类型有哪些?

~~~markdown
1）简单类型: 8+8+1(byte  short char  int  long double float boolean  及其对应的包装类 + String)
2）对象类型: 要保证前端传递的参数名称跟实体的属性名称
3）数组类型: 要保证前端传递的参数名称跟方法中的数组形参名称一致
4）集合类型: 要将集合参数包装到一个实体中
5）格式比较灵活的类型，如日期类型时间类型:这时候需要自定义一个类型转换器并且声明转换服务，再将转换器对象注册到服务；
6）文件类型:配置文件上传解析器，前端页面必须满足文件上传三要素。
7) 内置对象:HttpServletRequest  HttpServletResponse  HttpSession  Model  ModelMap  ModelAndView
~~~



## SpringMVC的常用注解

~~~markdown

1. @RequestMapping: 相当于为当前的方法绑定一个URL地址，可以与前端的请求相匹配。关注value 和 method 属性
2. @RequestParam: 标注在方法参数之前，用于对传入的参数做一些限制，支持三个属性:
    - value：默认属性，用于指定前端传入的参数名称
    - required：用于指定此参数是否必传
    - defaultValue：当参数为非必传参数且前端没有传入参数时，指定一个默认值
3. @RequestHeader 用于接收请求头中的所有信息，会封装到一个Map结构中去
4. @RequestBody 用于接收请求体中的参数,并将其封装到对象中
5. @ResponseBody 用于将方法的返回值放入响应体
6. @PathVariable 用户从url路径上获取指定参数，标注在参数前 @PathVariabel("要获取的参数名")。
7. @ControllerAdvice 标注在一个类上，表示该类是一个全局异常处理的类。
8. @ExceptionHandler(Exception.class) 标注在异常处理类中的方法上，表示该方法可以处理的异常类型。

~~~

