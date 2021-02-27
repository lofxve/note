## 一 项目演示

把模块复制到idea中,分别启动服务器端和客户端

![1605747546410](img/1605747546410.png)

## 二 项目说明

### 1 所采用的知识点

​	 本系统采用了我们学过的以下几个核心知识点：

​		1). IO流技术

​				服务器端读写本地的文件,我们采用IO流

​				要求一个学生对象一行数据,并且学生的属性之间使用","隔开

​				1,小明,男,20

​				2,小张,男,20

​		2). 网络编程技术

​				客户端和服务器采用"**短连接**"

​				每个功能当需要连接完服务器之后,断开连接,执行下一个功能在重写连接服务器

​				每个功能都连接一次服务器

​		3). 序列化

​				客户端根据id查询学生信息,服务器端读取文件,查询学生,给客户端返回一个Student对象

​				客户端使用反序列化流读取Student对象

​				客户端查询所有学生信息,服务器读取文件,把查询到的多个Student对象封装到一个ArrayList集合中

​				客户端使用反序列化流读取ArrayList集合对象

```java
1,小名,男,20  Student s = new Student("小名","男",20);
2,小张,男,20  Student s = new Student("小名","男",20);
ArrayList<Student> list = new ArrayList<Student> ();
OutputStream os = socket.getOutputStream();
ObjectOutputStream oos = new ObjectOutputStream(os);
oos.writeObject(list); //服务器给客户端写多个学生信息
oos.writeObject(s); // 服务器给客户端写会一个学生信息

InputStream is = socket.getInputStream();
ObjectInputStream ois = new ObjectInputStream(is);
ArrayList<Student> list = (ArrayList<Student>)ois.readObject();
Student s = (Student)ois.readObject();
```

​		4). 多线程

​				支持多个客户端,同时连接服务器

​				服务器每获取一个客户端对象,都开启一个线程,对客户端对象进行增删改查

### 2 业务交互模式图示

![1595471438925](img/1595471438925.png)

​	【说明】

​		1).客户端和服务器端采用TCP连接；

​		2).数据保存在服务器端；

​		3). 客户端增删改查发送数据格式说明：

​			a). 添加："[1]数据"，例如："[1]张三,男,22"，意思：没有id字段，由服务器端在写入数据前自动添加。

​			b).根据id查询一条数据："[2]id"，例如："[2]1"，意思：查询id为1的学员信息

​			c). 修改一条数据："[3]新数据"。例如："[3]1,张三2,女,19"，意思：将id=1的学员改为后面的新数据。

​			d). 查询所有数据："[4]"。例如："[4]"，意思：后面不用带任何数据。

​			e). 删除一条数据："[5]id"。例如："[5]1"，意思：删除id为1的记录。

## 三 案例代码

### 一.客户端

### 1.创建实体类Student类

~~~java
package com.itheima.pojo;

import java.io.Serializable;

//创建学生类,实现序列化接口
public class Student implements Serializable{
    //添加序列号,防止序列化冲突异常
    private static final long serialVersionUID = 1L;
    //编号
    private int id;
    //姓名
    private String name;
    //性别
    private String sex;
    //年龄
    private int age;

    public Student() {
    }

    public Student(int id, String name, String sex, int age) {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.age = age;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
~~~

### 2.创建操作学生的工具类

```java
package com.itheima.utils;

import com.itheima.pojo.Student;

import java.io.IOException;
import java.net.Socket;
import java.util.ArrayList;

/*
    创建操作学生的工具类
    工具类中的方法一般都是静态的,通过类名可以直接使用
 */
public class StudentUtils {
    //私有构造方法,不让用户创建对象调用静态方法
    private StudentUtils() { }

    //定义一个打印学生信息的静态方法
    public static void printStudent(Student s){
        System.out.println("--------------------------------------------------------------");
        //打印表头
        System.out.println("编号\t姓名\t\t性别\t年龄");
        //打印学生信息
        System.out.println(s.getId()+"\t\t"+s.getName()+"\t\t"+s.getSex()+"\t\t"+s.getAge());
        System.out.println("--------------------------------------------------------------");
    }

    //定义一个打印学生集合中所有学生的静态方法
    public static void printArrayList(ArrayList<Student> list){
        System.out.println("--------------------------------------------------------------");
        //打印表头
        System.out.println("编号\t姓名\t\t性别\t年龄");
        //遍历集合,获取每一个学生对象,打印学生的信息
        for (Student s : list) {
            System.out.println(s.getId()+"\t\t"+s.getName()+"\t\t"+s.getSex()+"\t\t"+s.getAge());
        }
        System.out.println("--------------------------------------------------------------");
    }

    //定义一个根据服务器的ip地址和端口号,获取Socket对象的方法
    public static Socket getSocket(){
        Socket socket = null;
        try {
            socket = new Socket("127.0.0.1",8888);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return socket;
    }
}
```

### 3.创建主类StudentClient类

```java
package com.itheima.main;

import java.util.Scanner;

/*
    创建主类StudentClient类
    1.添加main方法,用于启动程序
    2.定义一个静态的成员Scanner对象,供所有的方法使用
    3.定义一个死循环,让功能重复执行
    4.打印功能菜单
    5.获取用户输入的功能选项
    6.定义一个switch语句,根据用户输入的功能选项,选择对应的功能
 */
public class StudentClient {
    //2.定义一个静态的成员Scanner对象,供所有的方法使用
    public static Scanner sc = new Scanner(System.in);

    //1.添加main方法,用于启动程序
    public static void main(String[] args) {
        //3.定义一个死循环,让功能重复执行
        while (true){
            //4.打印功能菜单
            System.out.println("---------------------------欢迎使用学生管理系统--------------------------------");
            System.out.println("1.添加学生  2.根据id查询学生  3.修改学生  4.查看所有学生 5.删除学生  6.退出");
            //5.获取用户输入的功能选项
            System.out.println("请输入您要选择的功能:");
            int choose = sc.nextInt();
            //6.定义一个switch语句,根据用户输入的功能选项,选择对应的功能
            switch (choose){
                case 1:
                    //1.添加学生==>调用添加学生的方法
                    addStudent();
                    break;
                case 2:
                    //2.根据id查询学生==>调用根据id查询学生的方法
                    getStudentById();
                    break;
                case 3:
                    //3.修改学生==>调用修改学生的方法
                    updateStudent();
                    break;
                case 4:
                    //4.查看所有学生==>调用查看所有学生的方法
                    selectAllStudent();
                    break;
                case 5:
                    //5.删除学生==>调用删除学生的方法
                    deleteStudent();
                    break;
                case 6:
                    //6.退出
                    System.out.println("欢迎您下次在继续使用!");
                    System.out.println("拜拜!");
                    System.exit(0);//终止JVM
                default:
                    //用户输入不是123456,提示输入有误
                    System.out.println("您输入的功能选项["+choose+"]不存在,请重新输入!");
                    break;
            }

        }
    }

    /*
        删除学生的方法
     */
    private static void deleteStudent() {
        System.out.println("---------------------------欢迎使用删除学生的功能--------------------------------");
    }

    /*
        查看所有学生的方法
     */
    private static void selectAllStudent() {
        System.out.println("---------------------------欢迎使用查看所有学生的功能--------------------------------");
    }

    /*
        修改学生的方法
     */
    private static void updateStudent() {
        System.out.println("---------------------------欢迎使用修改学生的功能--------------------------------");
    }

    /*
        根据id查询学生的方法
     */
    private static void getStudentById() {
        System.out.println("---------------------------欢迎使用根据id查询学生的功能--------------------------------");
    }

    /*
        添加学生的方法
     */
    private static void addStudent() {
        System.out.println("---------------------------欢迎使用添加学生的功能--------------------------------");
    }
}
```

### 4.添加学生功能

```java
/*
    添加学生的方法
    1.获取用户输入的数据(姓名,性别,年龄)
    2.使用工具类获取客户端Socket对象
    3.给服务器发送数据  "[1]小明,男,20"
    4.获取服务器返回的结果    1:成功    0:失败
    5.根据服务器返回的结果,给用户展示结果
    6.释放资源
 */
private static void addStudent() {
    System.out.println("---------------------------欢迎使用添加学生的功能--------------------------------");
    //1.获取用户输入的数据(姓名,性别,年龄)
    System.out.println("请输入学生的姓名:");
    String name = sc.next();
    System.out.println("请输入学生的性别:");
    String sex = sc.next();
    System.out.println("请输入学生的年龄:");
    int age = sc.nextInt();
    //2.使用工具类获取客户端Socket对象
    Socket socket = StudentUtils.getSocket();
    //对获取到的客户端进行一个非空的判断
    if(socket==null){
        System.out.println("[服务器暂时无法连接,让稍后在重试!]");
        return;//结束添加学生的方法
    }
    try {
        //3.给服务器发送数据  "[1]小明,男,20"
        OutputStream os = socket.getOutputStream();
        os.write(("[1]"+name+","+sex+","+age).getBytes());

        //4.获取服务器返回的结果    1:成功    0:失败
        InputStream is = socket.getInputStream();
        int len = is.read();
        //5.根据服务器返回的结果,给用户展示结果
        if(len==1){
            System.out.println("[恭喜您,添加学生成功!]");
        }else{
            System.out.println("[添加学生失败,请联系管理员!]");
        }
        //6.释放资源
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

### 5.根据id查询学生

```java
/*
    根据id查询学生的方法
    1.获取用户输入的数据(学生id)
    2.使用工具类获取客户端Socket对象
    3.给服务器发送数据  "[2]id"
    4.获取服务器返回的结果   Student对象,需要使用反序列化流读取对象
    5.根据服务器返回的结果,给用户展示结果
    6.释放资源
 */
private static void getStudentById() {
    System.out.println("---------------------------欢迎使用根据id查询学生的功能--------------------------------");
    //1.获取用户输入的数据(学生id)
    System.out.println("请输入你要查询的学生id:");
    int id = sc.nextInt();
    //2.使用工具类获取客户端Socket对象
    Socket socket = StudentUtils.getSocket();
    //对获取到的客户端进行一个非空的判断
    if(socket==null){
        System.out.println("[服务器暂时无法连接,让稍后在重试!]");
        return;//结束根据id查询学生的方法
    }
    try {
        //3.给服务器发送数据  "[2]id"
        OutputStream os = socket.getOutputStream();
        os.write(("[2]"+id).getBytes());
        //4.获取服务器返回的结果   Student对象,需要使用反序列化流读取对象
        InputStream is = socket.getInputStream();
        ObjectInputStream ois = new ObjectInputStream(is);
        Student student = (Student)ois.readObject();

        //5.根据服务器返回的结果,给用户展示结果
        if(student==null){
            System.out.println("[查无此人!]");
        }else{
            //调用工具类中打印学生的方法
            StudentUtils.printStudent(student);
        }
        //6.释放资源
        ois.close();
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
}
```

### 6.查询所有学生

```java
/*
    查看所有学生的方法
    1.获取用户输入的数据(不需要用户输入)
    2.使用工具类获取客户端Socket对象
    3.给服务器发送数据  "[4]"
    4.获取服务器返回的结果   ArrayList集合对象,需要使用反序列化流读取对象
    5.根据服务器返回的结果,给用户展示结果
    6.释放资源
 */
private static void selectAllStudent() {
    System.out.println("---------------------------欢迎使用查看所有学生的功能--------------------------------");
    //1.获取用户输入的数据(不需要用户输入)
    //2.使用工具类获取客户端Socket对象
    Socket socket = StudentUtils.getSocket();
    //对获取到的客户端进行一个非空的判断
    if(socket==null){
        System.out.println("[服务器暂时无法连接,让稍后在重试!]");
        return;//结束查看所有学生的的方法
    }
    try {
        //3.给服务器发送数据  "[4]"
        OutputStream os = socket.getOutputStream();
        os.write("[4]".getBytes());
        //4.获取服务器返回的结果   ArrayList集合对象,需要使用反序列化流读取对象
        InputStream is = socket.getInputStream();
        ObjectInputStream ois = new ObjectInputStream(is);
        ArrayList<Student> list =  (ArrayList<Student>)ois.readObject();
        //5.根据服务器返回的结果,给用户展示结果
        if(list==null || list.size()==0){
            System.out.println("[服务器暂时没有学生的信息,请添加后在尝试!]");
        }else{
            //调用工具类中打印学生集合的方法
            StudentUtils.printArrayList(list);
        }
        //6.释放资源
        ois.close();
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
}
```

### 7.根据id修改学生

```java
/*
    修改学生的方法
    1.获取用户输入的数据(学生id)
        a.修改学生之前,先根据id查询学生是否存在
        b.学生不存在,给用户显示"您修改id为x的学生不存在"
        c.学生存在,调用工具类中打印学生的方法
        d.获取用户输入的要修改的学生信息(新的姓名,新的性别,新的年龄)
    2.使用工具类获取客户端Socket对象
    3.给服务器发送数据  "[3]1,小马,男,20"
    4.获取服务器返回的结果    1:成功    0:失败
    5.根据服务器返回的结果,给用户展示结果
    6.释放资源
 */
private static void updateStudent() {
    System.out.println("---------------------------欢迎使用修改学生的功能--------------------------------");
    //1.获取用户输入的数据(学生id)
    System.out.println("请输入您要修改的学生id:");
    int id = sc.nextInt();
    //a.修改学生之前,先根据id查询学生是否存在
    Socket socket = StudentUtils.getSocket();
    //对获取到的客户端进行一个非空的判断
    if(socket==null){
        System.out.println("[服务器暂时无法连接,让稍后在重试!]");
        return;//结束根据id查询学生的方法
    }
    Student student = null;
    try {
        OutputStream os = socket.getOutputStream();
        os.write(("[2]"+id).getBytes());
        InputStream is = socket.getInputStream();
        ObjectInputStream ois = new ObjectInputStream(is);
        student = (Student)ois.readObject();

        //b.学生不存在,给用户显示"您修改id为x的学生不存在"
        if(student==null){
            System.out.println("[您修改id为"+id+"的学生不存在]");
        }else{
            //c.学生存在,调用工具类中打印学生的方法
            System.out.println("您要修改的学员信息如下:");
            StudentUtils.printStudent(student);
        }
        ois.close();
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    //d.获取用户输入的要修改的学生信息(新的姓名,新的性别,新的年龄)
    System.out.println("请输入新的学生姓名(保留原值,输入0):");
    String name = sc.next();
    System.out.println("请输入新的学生性别(保留原值,输入0):");
    String sex = sc.next();
    System.out.println("请输入新的学生年龄(保留原值,输入0):");
    int age = sc.nextInt();
    //判断用户输入的数据是否为0,不为0在替换学生信息
    if(!"0".equals(name)){
        student.setName(name);
    }
    if(!"0".equals(sex)){
        student.setSex(sex);
    }
    if(age!=0){
        student.setAge(age);
    }
    
    //2.使用工具类获取客户端Socket对象
    Socket socket2 = StudentUtils.getSocket();
    //对获取到的客户端进行一个非空的判断
    if(socket2==null){
        System.out.println("[服务器暂时无法连接,让稍后在重试!]");
        return;//结束根据id查询学生的方法
    }
    try {
        //3.给服务器发送数据  "[3]1,小马,男,20"
        OutputStream os = socket2.getOutputStream();
        os.write(("[3]"+student.getId()+","+student.getName()+","+ student.getSex()+","+student.getAge()).getBytes());

        //4.获取服务器返回的结果    1:成功    0:失败
        InputStream is = socket2.getInputStream();
        int len = is.read();
        //5.根据服务器返回的结果,给用户展示结果
        if(len==1){
            System.out.println("[恭喜您,修改学生信息成功!]");
        }else{
            System.out.println("[修改学生信息失败,请联系管理员!]");
        }
        //6.释放资源
        socket2.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

### a.把根据id查询学生的代码封装到一个方法中(提高代码复用性)

```java
/*
    把根据id查询学生的代码封装到一个方法中(提高代码复用性)
    参数:  int id
    返回值: Student
 */
public static Student findStudentById(int id){
    //2.使用工具类获取客户端Socket对象
    Socket socket = StudentUtils.getSocket();
    //对获取到的客户端进行一个非空的判断
    if(socket==null){
        System.out.println("[服务器暂时无法连接,让稍后在重试!]");
        return null;//结束根据id查询学生的方法
    }
    Student student = null;
    try {
        //3.给服务器发送数据  "[2]id"
        OutputStream os = socket.getOutputStream();
        os.write(("[2]"+id).getBytes());
        //4.获取服务器返回的结果   Student对象,需要使用反序列化流读取对象
        InputStream is = socket.getInputStream();
        ObjectInputStream ois = new ObjectInputStream(is);
         student = (Student)ois.readObject();

        //5.根据服务器返回的结果,给用户展示结果
        if(student==null){
            System.out.println("[查无此人!]");
        }
        //6.释放资源
        ois.close();
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    return student;
}
```

### b.优化修改学生的代码

```java
/*
    修改学生的方法
    1.获取用户输入的数据(学生id)
        a.修改学生之前,先根据id查询学生是否存在
        b.学生不存在,给用户显示"您修改id为x的学生不存在"
        c.学生存在,调用工具类中打印学生的方法
        d.获取用户输入的要修改的学生信息(新的姓名,新的性别,新的年龄)
    2.使用工具类获取客户端Socket对象
    3.给服务器发送数据  "[3]1,小马,男,20"
    4.获取服务器返回的结果    1:成功    0:失败
    5.根据服务器返回的结果,给用户展示结果
    6.释放资源
 */
private static void updateStudent() {
    System.out.println("---------------------------欢迎使用修改学生的功能--------------------------------");
    //1.获取用户输入的数据(学生id)
    System.out.println("请输入您要修改的学生id:");
    int id = sc.nextInt();
    //a.修改学生之前,先根据id查询学生是否存在
    //调用根据id查询学生的方法
    Student student = findStudentById(id);
    if(student==null){
        //结束方法
        return;
    }else{
        //调用工具类中打印学生信息的方法
        System.out.println("您要修改的学生信息如下:");
        StudentUtils.printStudent(student);
    }

    //d.获取用户输入的要修改的学生信息(新的姓名,新的性别,新的年龄)
    System.out.println("请输入新的学生姓名(保留原值,输入0):");
    String name = sc.next();
    System.out.println("请输入新的学生性别(保留原值,输入0):");
    String sex = sc.next();
    System.out.println("请输入新的学生年龄(保留原值,输入0):");
    int age = sc.nextInt();
    //判断用户输入的数据是否为0,不为0在替换学生信息
    if(!"0".equals(name)){
        student.setName(name);
    }
    if(!"0".equals(sex)){
        student.setSex(sex);
    }
    if(age!=0){
        student.setAge(age);
    }

    //2.使用工具类获取客户端Socket对象
    Socket socket2 = StudentUtils.getSocket();
    //对获取到的客户端进行一个非空的判断
    if(socket2==null){
        System.out.println("[服务器暂时无法连接,让稍后在重试!]");
        return;//结束根据id查询学生的方法
    }
    try {
        //3.给服务器发送数据  "[3]1,小马,男,20"
        OutputStream os = socket2.getOutputStream();
        os.write(("[3]"+student.getId()+","+student.getName()+","+ student.getSex()+","+student.getAge()).getBytes());

        //4.获取服务器返回的结果    1:成功    0:失败
        InputStream is = socket2.getInputStream();
        int len = is.read();
        //5.根据服务器返回的结果,给用户展示结果
        if(len==1){
            System.out.println("[恭喜您,修改学生信息成功!]");
        }else{
            System.out.println("[修改学生信息失败,请联系管理员!]");
        }
        //6.释放资源
        socket2.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

### c.优化根id查询学生的代码

```java
/*
    根据id查询学生的方法
    1.获取用户输入的数据(学生id)
    2.使用工具类获取客户端Socket对象
    3.给服务器发送数据  "[2]id"
    4.获取服务器返回的结果   Student对象,需要使用反序列化流读取对象
    5.根据服务器返回的结果,给用户展示结果
    6.释放资源
 */
private static void getStudentById() {
    System.out.println("---------------------------欢迎使用根据id查询学生的功能--------------------------------");
    //1.获取用户输入的数据(学生id)
    System.out.println("请输入你要查询的学生id:");
    int id = sc.nextInt();
    //调用根据id查询学生的方法
    Student student = findStudentById(id);
    if(student!=null){
        //调用工具类中打印学生信息的方法
        StudentUtils.printStudent(student);
    }
}
```

### 8.根据id删除学生

```java
/*
    删除学生的方法
    1.获取用户输入的数据(学生id)
        a.修改学生之前,先根据id查询学生是否存在(调用查询的方法)
        b.学生不存在,结束删除的方法
        c.学生存在,调用工具类中打印学生的方法
        d.获取用户是否确定删除的选项(y|n)
    2.使用工具类获取客户端Socket对象
    3.给服务器发送数据  "[5]id"
    4.获取服务器返回的结果    1:成功    0:失败
    5.根据服务器返回的结果,给用户展示结果
    6.释放资源
 */
private static void deleteStudent() {
    System.out.println("---------------------------欢迎使用删除学生的功能--------------------------------");
    //1.获取用户输入的数据(学生id)
    System.out.println("请输入您要删除的学生id:");
    int id = sc.nextInt();
    //a.修改学生之前,先根据id查询学生是否存在(调用查询的方法)
    Student student = findStudentById(id);
    if(student==null){
        //b.学生不存在,结束删除的方法
        return;
    }else{
        //c.学生存在,调用工具类中打印学生的方法
        System.out.println("您要删除的学生信息如下:");
        StudentUtils.printStudent(student);
    }
    //d.获取用户是否确定删除的选项(y|n)
    System.out.println("您确定要删除以上学生信息吗?(y|n)");
    String yesAndNo = sc.next();
    if(!"y".equals(yesAndNo)){
        System.out.println("[删除操作已经取消!]");
        return;//结束方法
    }

    //2.使用工具类获取客户端Socket对象
    Socket socket = StudentUtils.getSocket();
    //对获取到的客户端进行一个非空的判断
    if(socket==null){
        System.out.println("[服务器暂时无法连接,让稍后在重试!]");
        return;//结束删除学生的方法
    }
    try {
        //3.给服务器发送数据  "[5]id"
        OutputStream os = socket.getOutputStream();
        os.write(("[5]"+id).getBytes());
        //4.获取服务器返回的结果    1:成功    0:失败
        InputStream is = socket.getInputStream();
        int len = is.read();
        //5.根据服务器返回的结果,给用户展示结果
        if(len==1){
            System.out.println("[恭喜您,删除学生信息成功!]");
        }else{
            System.out.println("[删除学生信息失败,请联系管理员!]");
        }
        //6.释放资源
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

### 二.服务器端

### 1.创建实体类Student类

~~~java
package com.itheima.pojo;

import java.io.Serializable;

//创建学生类,实现序列化接口
public class Student implements Serializable{
    //添加序列号,防止序列化冲突异常
    private static final long serialVersionUID = 1L;
    //编号
    private int id;
    //姓名
    private String name;
    //性别
    private String sex;
    //年龄
    private int age;

    public Student() {
    }

    public Student(int id, String name, String sex, int age) {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.age = age;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
~~~

注意:客户端和服务器端的Student类必须是一样,必须在同一个包路径下,否则序列化和反序列化会抛出异常

![1605768009539](img/1605768009539.png)

### 2.导入服务器端增删改查工具类

```java
package com.itheima.dao;

import com.itheima.pojo.Student;

import java.io.*;
import java.net.URLDecoder;
import java.util.ArrayList;

public class StudentDao {
    //将集合中所有学生对象,写入到文件中
    public static void writeAll(ArrayList<Student> stuList) {
        try (FileWriter out = new FileWriter("day17_server\\student.txt")) {
            for (Student stu : stuList) {
                //格式: id,姓名,性别,年龄
                out.write(stu.getId() + "," + stu.getName() + "," + stu.getSex() + "," + stu.getAge());
                //换行
                out.write("\r\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    //从文件中读取所有学生的信息,返回学生集合
    public static ArrayList<Student> readAll() {
        ArrayList<Student> stuList = new ArrayList<>();
        /*
		  1.创建File对象
		    如果没等添加学生呢,就开始读取学生了,那么我们需要先把文件创建出来
		*/
        File file = new File("day17_server\\student.txt");
        if (!file.exists()) {
            try {
                //2.如果不存在,则创建,否则读取会抛异常
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        //3.读数据,一次一行 格式: id,姓名,性别,年龄
        try (BufferedReader bufIn = new BufferedReader(
                new FileReader("day17_server\\student.txt"))) {
            String line = null;
            while ((line = bufIn.readLine()) != null) {
                //4.一行切割成一个数组,[id,姓名,性别,年龄]
                String[] rowArray = line.split(",");
                //5.创建学生对象,封装数据
                Student stu = new Student();
				//因为获取出来0索引的元素是String,所以我们需要将String变成int
                stu.setId(Integer.parseInt(rowArray[0]));
                stu.setName(rowArray[1]);
                stu.setSex(rowArray[2]);
                stu.setAge(Integer.parseInt(rowArray[3]));
                //6.添加到集合中
                stuList.add(stu);
            }
        } catch (IOException e) {
            return null;
        }
        //7.返回整个集合
        return stuList;
    }

    //添加一个学生,返回boolean代表是否添加成功
    public static boolean addStudent(Student student) {
        //1.先读取所有学生
        ArrayList<Student> stuList = readAll();
        if (stuList == null) {//说明读取文件出错
            return false;
        }

        //2.获取最后一个学生的id,加1后作为新学生的id
        if (stuList.size() != 0) {
            student.setId(stuList.get(stuList.size() - 1).getId() + 1);//取最后一个对象的id + 1
        } else {
            //3.如果没有学生,说明是第一个,则id设置为1
            student.setId(1);//第一次添加，文件中没有内容
        }
        //4.添加到集合中
        stuList.add(student);
        //5.把集合重写写入到文件中,会覆盖之前的文件
        writeAll(stuList);
        //6.返回添加成功
        return true;
    }
	
    //根据id删除一个学生,返回boolean代表是否删除成功
    public static boolean deleteById(int id) {
        //1.先读取所有学生
        ArrayList<Student> stuList = readAll();
        if (stuList == null) {//说明读取文件出错
            return false;
        }
        //2.遍历集合
        for (int i = 0; i < stuList.size(); i++) {
            Student stu = stuList.get(i);
            //3.判断学生的id是否和要删除的id相等
            if (stu.getId() == id) {
                //4.从集合中删除学生
                stuList.remove(i);
                //5.重写写入到文件中,覆盖之前的文件
                writeAll(stuList);
                //6.返回成功
                return true;
            }
        }
        //7.如果没找到学生返回失败
        return false;
    }
    //修改学生,返回boolean代表是否修改成功
    public static boolean updateStudent(Student student) {
        //1.先读取所有学生
        ArrayList<Student> stuList = readAll();
        if (stuList == null) {//说明读取文件出错
            return false;
        }
        System.out.println("修改的数据：" + student);
        //2.遍历集合
        for (int i = 0; i < stuList.size(); i++) {
            Student stu = stuList.get(i);
            //3.判断哪个学生id和要修改的学生id相同
            if (stu.getId() == student.getId()) {
                //4.将学生改为新的学生
                stuList.set(i, student);
                //5.重新将集合写入到文集中,会覆盖之前的文件
                writeAll(stuList);//写回文件
                //6.返回成功
                return true;
            }
        }
        //7.返回失败
        return false;//没找到
    }
    //根据id查询学生,返回查询到的学生
    public static Student findById(int id) {
        //1.先读取所有学生
        ArrayList<Student> stuList = readAll();
        if (stuList == null) {//说明读取文件出错
            return null;
        }
        //2.遍历集合
        for (int i = 0; i < stuList.size(); i++) {
            Student stu = stuList.get(i);
            //3.比较id
            if (stu.getId() == id) {
                //4.找到返回学生对象
                return stu;
            }
        }
        //5.找不到返回null
        return null;
    }
}
```

### 3.创建服务器端主类StudentServer类

~~~java
package com.itheima.main;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

/*
    创建服务器端主类StudentServer类
    1.创建一个main方法,用于启动项目
    2.创建一个服务器ServerSocket对象,和系统要指定的端口号
    3.定义一个死循环,轮询的执行accpet方法
    4.使用ServerSocket对象中的方法accpet,监听客户端的请求,有客户端请求服务器,获取客户端Socket对象
    5.开启一个线程,对获取到的Socket对象进行处理(增删改查)
 */
public class StudentServer {
    //1.创建一个main方法,用于启动项目
    public static void main(String[] args) throws IOException {
        //2.创建一个服务器ServerSocket对象,和系统要指定的端口号
        ServerSocket server = new ServerSocket(8888);
        System.out.println("-----------------------服务器已经启动---------------------------");
        //3.定义一个死循环,轮询的执行accpet方法
        while (true){
            //4.使用ServerSocket对象中的方法accpet,监听客户端的请求,有客户端请求服务器,获取客户端Socket对象
            Socket socket = server.accept();
            //5.开启一个线程,对获取到的Socket对象进行处理(增删改查)
            new Thread(new ServerThread(socket)).start();
        }
    }
}
~~~

```java
package com.itheima.main;

import java.net.Socket;

//是一个线程类
public class ServerThread implements Runnable{
    private Socket socket;

    public ServerThread(Socket socket) {
        this.socket = socket;
    }
    //重写run,设置线程任务
    @Override
    public void run() {
        System.out.println("有客户端请求服务器,执行run方法!");
    }
}
```

### 4.服务端之解析功能序号执行对应方法

**注意:复制过来的方法,需要去掉static关键字**

```java
package com.itheima.main;

import java.io.IOException;
import java.io.InputStream;
import java.net.Socket;

//是一个线程类
public class ServerThread implements Runnable{
    private Socket socket;

    public ServerThread(Socket socket) {
        this.socket = socket;
    }
    //重写run,设置线程任务
    @Override
    public void run() {
        System.out.println("有客户端请求服务器,执行run方法!");
        /*
            服务端之解析功能序号执行对应方法  "[1]小明,男,20"
            1.使用Socket对象中的方法getInputStream,获取网络字节输入流InputStream对象
            2.使用InputStream对象中的方法read,读取客户端发送的数据,把数据转换为字符串
            3.把客户端发送的字符串中功能序号截取出来
            4.创建switch语句,根据功能序号,选择对应的功能
         */
        try {
            //1.使用Socket对象中的方法getInputStream,获取网络字节输入流InputStream对象
            InputStream is = socket.getInputStream();
            //2.使用InputStream对象中的方法read,读取客户端发送的数据,把数据转换为字符串
            byte[] bytes = new byte[1024];
            int len = is.read(bytes);
            String msg = new String(bytes,0,len);
            //3.把客户端发送的字符串中功能序号截取出来 1,2,3,4,5
            int choose = Integer.parseInt(msg.substring(1, 2));
            //4.创建switch语句,根据功能序号,选择对应的功能
            switch (choose){
                case 1:
                    //1.添加学生==>调用添加学生的方法
                    addStudent(msg);
                    break;
                case 2:
                    //2.根据id查询学生==>调用根据id查询学生的方法
                    getStudentById(msg);
                    break;
                case 3:
                    //3.修改学生==>调用修改学生的方法
                    updateStudent(msg);
                    break;
                case 4:
                    //4.查看所有学生==>调用查看所有学生的方法
                    selectAllStudent();
                    break;
                case 5:
                    //5.删除学生==>调用删除学生的方法
                    deleteStudent(msg);
                    break;
                default:
                    break;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /*
        删除学生的方法
     */
    private void deleteStudent(String msg) {
        System.out.println("---------------------------欢迎使用删除学生的功能--------------------------------");
    }

    /*
        查看所有学生的方法
     */
    private void selectAllStudent() {
        System.out.println("---------------------------欢迎使用查看所有学生的功能--------------------------------");
    }

    /*
        修改学生的方法
     */
    private void updateStudent(String msg) {
        System.out.println("---------------------------欢迎使用修改学生的功能--------------------------------");
    }

    /*
        根据id查询学生的方法
     */
    private void getStudentById(String msg) {
        System.out.println("---------------------------欢迎使用根据id查询学生的功能--------------------------------");
    }

    /*
        添加学生的方法
     */
    private void addStudent(String msg) {
        System.out.println("---------------------------欢迎使用添加学生的功能--------------------------------");
    }
}
```

### 5.添加学生功能

```java
/*
    添加学生的方法  "[1]小明,男,20"
    1.获取除了序号之外的其他学生的信息"小明,男,20"
    2.创建Student对象,封装学生的信息
    3.调用StudentDao工具类中添加学生的方法addStudent,获取添加的结果(true,false)
    4.根据添加的结果(true,false),给客户端返回结果(true:1,false:0)
    5.释放资源
 */
private void addStudent(String msg) {
    System.out.println("---------------------------欢迎使用添加学生的功能--------------------------------");
    //1.获取除了序号之外的其他学生的信息"小明,男,20"
    String s = msg.substring(3);
    String[] arr = s.split(",");
    //2.创建Student对象,封装学生的信息
    Student stu = new Student();
    stu.setName(arr[0]);
    stu.setSex(arr[1]);
    stu.setAge(Integer.parseInt(arr[2]));
    //3.调用StudentDao工具类中添加学生的方法addStudent,获取添加的结果(true,false)
    boolean b = StudentDao.addStudent(stu);
    //4.根据添加的结果(true,false),给客户端返回结果(true:1,false:0)
    try {
        OutputStream os = socket.getOutputStream();
        if(b){
            os.write(1);
        }else{
            os.write(0);
        }
        //5.释放资源
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

![1605770686584](img/1605770686584.png)

### 6.查询所有学生

```java
/*
    查看所有学生的方法
    1.调用StudentDao中readAll查询所有的学生,返回一个ArrayList集合
    2.创建序列化流ObjectOutputStream对象
    3.使用序列化流把集合对象写回到客户端
    4.释放资源
 */
private void selectAllStudent() {
    System.out.println("---------------------------欢迎使用查看所有学生的功能--------------------------------");
    //1.调用StudentDao中readAll查询所有的学生,返回一个ArrayList集合
    ArrayList<Student> list = StudentDao.readAll();
    try {
        //2.创建序列化流ObjectOutputStream对象
        ObjectOutputStream oos = new ObjectOutputStream(socket.getOutputStream());
        //3.使用序列化流把集合对象写回到客户端
        oos.writeObject(list);
        //4.释放资源
        oos.close();
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

### 7.根据id查询学生

```java
/*
    根据id查询学生的方法  "[2]id"
    1.获取除了序号之外的其他学生的信息"id"
    2.调用StudentDao工具类中的findById方法,根据id查询学生Student对象
    3.创建序列化流ObjectOutputStream对象
    4.使用序列化流把Student对象写回到客户端
    5.释放资源
 */
private void getStudentById(String msg) {
    System.out.println("---------------------------欢迎使用根据id查询学生的功能--------------------------------");
    //1.获取除了序号之外的其他学生的信息"id"
    int id = Integer.parseInt(msg.substring(3));
    //2.调用StudentDao工具类中的findById方法,根据id查询学生Student对象
    Student student = StudentDao.findById(id);
    try {
        //3.创建序列化流ObjectOutputStream对象
        ObjectOutputStream oos = new ObjectOutputStream(socket.getOutputStream());
        //4.使用序列化流把Student对象写回到客户端
        oos.writeObject(student);
        //5.释放资源
        oos.close();
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

![1605772602403](img/1605772602403.png)

### 8.根据id修改学生

```java
/*
    修改学生的方法  "[3]1,张三,男,18"
    1.获取除了序号之外的其他学生的信息("1,张三,男,18")
    2.根据逗号切割字符串,返回一个String数组
    3.创建Student对象,封装学生信息
    4.调用StudentDao工具类中的updateStudent方法,修改学生,获取方法的返回值(true,false)
    5.根据修改的结果(true,false),给客户端返回对应的结果(true:1,false:0)
    6.释放资源
 */
private void updateStudent(String msg) {
    System.out.println("---------------------------欢迎使用修改学生的功能--------------------------------");
    //1.获取除了序号之外的其他学生的信息("1,张三,男,18")
    String s = msg.substring(3);
    //2.根据逗号切割字符串,返回一个String数组
    String[] arr = s.split(",");
    //3.创建Student对象,封装学生信息
    Student stu = new Student();
    stu.setId(Integer.parseInt(arr[0]));
    stu.setName(arr[1]);
    stu.setSex(arr[2]);
    stu.setAge(Integer.parseInt(arr[3]));
    //4.调用StudentDao工具类中的updateStudent方法,修改学生,获取方法的返回值(true,false)
    boolean b = StudentDao.updateStudent(stu);
    try {
        //5.根据修改的结果(true,false),给客户端返回对应的结果(true:1,false:0)
        OutputStream os = socket.getOutputStream();
        if(b){
            os.write(1);
        }else{
            os.write(0);
        }
        //6.释放资源
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

![1605773143864](img/1605773143864.png)

### 9.根据id删除学生

```java
/*
    删除学生的方法  "[5]id"
    1.获取除了序号之外的其他学生的信息"id"
    2.调用StudentDao工具类中的deleteById方法,根据id删除学生,获取方法的返回值(true,false)
    3.根据方法的返回值(true,false),给客户端发送数据(true:1,false:0)
    4.释放资源
 */
private void deleteStudent(String msg) {
    System.out.println("---------------------------欢迎使用删除学生的功能--------------------------------");
    //1.获取除了序号之外的其他学生的信息"id"
    int id = Integer.parseInt(msg.substring(3));
    //2.调用StudentDao工具类中的deleteById方法,根据id删除学生,获取方法的返回值(true,false)
    boolean b = StudentDao.deleteById(id);
    try {
        //3.根据方法的返回值(true,false),给客户端发送数据(true:1,false:0)
        OutputStream os = socket.getOutputStream();
        if(b){
            os.write(1);
        }else{
            os.write(0);
        }
        //4.释放资源
        socket.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

![1605773621846](img/1605773621846.png)