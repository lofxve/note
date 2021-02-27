# Redis基础

## 一 NoSQL简介

### 1.1 NoSQL是什么？

NoSQL，泛指非关系型的数据库，NoSQL即Not-Only SQL，它可以作为关系型数据库的良好补充。



### 1.2 为什么需要NOSQL？

#### 1.2.1 当海量用户同时访问网站时

例如：12306一天的访问量超过11亿次,对数据库的瞬时访问量超过了DB能够承受的范围

![1569230201094](assets/1569230201094.png) 

1. **mysql等关系型数据库已无法独自胜任海量用户下的互联网应用**,尤其应对高并发,海量数据时,mysql的瓶颈就体现出来
2. 传统DB必须和新兴的NOsql共同配合才能适应互联网的发展

#### 1.2.2  关系型数据库的瓶颈

1. **性能瓶颈**:例如mysql等数据存在磁盘中,磁盘io的性能很低,造成mysql性能瓶颈
2. **扩展性瓶颈:**关系型数据库,数据之间关系复杂,扩展性差.
3. **不适合存储海量的非关系型数据** 
   	由于扩展性差,不便于大规模集群,使得关系型数据库无法胜任海量数据的存储

#### 1.2.3 NoSQL的出现

​	Nosql就是为了解决关系型数据库海量用户和数据下的性能差,扩展性不好,无法海量存储非关系数据库的一系列产品解决方案。

​	关系型数据库与NoSQL数据库并非对立而是互补的关系，即通常情况下使用关系型数据库，在适合使用NoSQL的时候使用NoSQL数据库，NoSQL数据库对关系型数据库的不足进行弥补。

### 1.3 NoSQL特点

1. 易扩展
2. 高性能
3. 高可用
4. 灵活的数据模型

### 1.4 NoSQL的主流产品

![1569230735095](assets/1569230735095.png) 

- 键值(Key-Value)存储数据库

  ​	相关产品：Gemfire、redis

  ​	应用场景：内容缓存，主要用于处理大量数据的高访问负载。

- 列存储数据库

  ​	相关产品：Hbase

  ​	应用场景：分布式的文件系统

- 文档型数据库(json)

  ​	相关产品：MongoDB

  ​	应用场景：web应用的数据库（已支持事物但不支持表关系）

- 图形(Graph)数据库

  ​	相关产品：Neo4J

  ​	应用场景：社交网络。


## 二 Redis简介

### 2.1 Redis是什么？

​	Redis是用C语言开发的一个开源的高性能键值对（key-value）数据库，官方提供测试数据，50个并发执行100000个请求,读的速度是110000次/s,写的速度是81000次/s ，且Redis通过提供多种键值数据类型来适应不同场景下的存储需求，目前为止Redis支持的键值数据类型如下：

- 字符串类型 string
- 散列类型 hash
- 列表类型 list
- 集合类型 set
- 有序集合类型 sortedset

### 2.2 Redis应用场景

1. 缓存（数据查询、短连接、新闻内容、商品内容等等）。（最多使用）
2. 分布式集群架构中的session分离。
3. 聊天室的在线好友列表。
4. 任务队列。（秒杀、抢购、12306等等）
5. 应用排行榜。
6. 网站访问统计。
7. 数据过期处理（可以精确到毫秒）
8.  消息队列
9. 分布式锁

## 三 window版Redis的安装与使用

### 3.1 window版下载和安装

#### 3.1.1 Linux版本的下载和安装(了解)

官方提倡使用Linux版的Redis，所以官网只提供了Linux版的Redis下载
官网下载地址：http://redis.io/download

#### 3.1.2 windows版本的下载和安装

我们可以从GitHub上下载window版的Redis，具体链接地址如下：
github下载地址：https://github.com/MSOpenTech/redis/tags
如下图:

![1569231190275](assets/1569231190275.png) 

在今天的课程资料中提供的下载完毕的window版本的Redis：

![1569231220443](assets/1569231220443.png) 

解压Redis压缩包后到非中文路径下，绿色免安装：

![1569231472829](assets/1569231472829.png) 

### 3.2 window版Redis的目录结构

解压Redis压缩包后，见到如下目录结构：

| 目录或文件         | 作用                              |
| ------------------ | --------------------------------- |
| redis-benchmark    | 性能测试工具                      |
| redis-check-aof    | AOF文件修复工具                   |
| redis-check-dump   | RDB文件检查工具（快照持久化文件） |
| redis-cli          | 命令行客户端                      |
| redis-server       | redis服务器启动命令               |
| redis.windows.conf | redis核心配置文件                 |

### 3.3 window版Redis服务端的启动与关闭

双击Redis目录中redis-server.exe可以启动redis服务，Redis服务占用的端口是6379![1569232391386](assets/1569232391386.png)

关闭Redis的控制台窗口就可以关闭Redis服务

---

### :reminder_ribbon: 经验分享：

#### 报错信息

redis服务启动不起来，报出如下错误

![image-20200316202659259](assets/image-20200316202659259.png)

#### 问题的分析

redis配置的maxmemory（最大允许使用内存）不足

#### **问题解决办法**

此时需要在redis的配置文件(redis.windows.conf)中,添加如下配置 maxmemory  3221225472（3G）

然后重新启动redis服务即可

![image-20200316203221249](assets/image-20200316203221249.png)

---

### 3.4 window版Redis客户端的操作

#### 3.4.1 命令行

双击Redis目录中redis-cli.exe可以启动redis客户端

![1569232351704](assets/1569232351704.png)  

#### 3.4.2 图形化工具

1. 安装，无脑下一步，选择非中文路径： ![1569232094600](assets/1569232094600.png) 

2. 开启redis服务端,并创建连接

   ![1569232221932](assets/1569232221932.png)

3. 操作界面

![1569232323493](assets/1569232323493.png)

## 四 Reids常用数据类型

### 4.1 Redis的5种数据类型

redis是一种高级的key-value的存储系统，其中value支持五种数据类型：

- 字符串（String）
- 哈希（hash）
- 字符串列表（list）
- 字符串集合（set）
- 有序字符串集合（sorted set）

关于key的定义，注意如下几点：

- key不要太长，最好不要操作1024个字节，这不仅会消耗内存还会降低查找效率
- key不要太短，如果太短会降低key的可读性 
- 在项目中，key最好有一个统一的命名规范

### 4.2 字符串类型string

#### 4.2.1 介绍

​	字符串 string 是 Redis 最简单的数据结构。在Redis中字符串类型的Value最多可以容纳的数据长度是512M。

![img](.\assets\8b13632762d0f703e3710ecd05fa513d2797c5e4.jpg)

#### 4.2.2 常用命令

**set key value**

设定key持有指定的字符串value，如果该key存在则进行覆盖操作。总是返回”OK”

```
127.0.0.1:6379> set company "itcast"
OK
127.0.0.1:6379>
```

**get key**

获取key的value。如果与该key关联的value不是String类型，redis将返回错误信息，因为get命令只能用于获取String value；如果该key不存在，返回(nil)。

```
127.0.0.1:6379> set name "itcast"
OK
127.0.0.1:6379> get name
"itcast"
```

**del key**

删除指定key

```
127.0.0.1:6379> del name
(integer) 1
127.0.0.1:6379> get name
(nil)
```

**主键自增**

将 key 中储存的数字值增一	

```
127.0.0.1:6379> set id 0
OK
127.0.0.1:6379> incr id
(integer) 1
127.0.0.1:6379> get id
"1"
127.0.0.1:6379>
```

### 4.3 哈希类型hash

#### 4.3.1 介绍

​	Redis中的Hash类型可以看成具有String Key和String Value的map容器。所以该类型非常适合于存储值对象的信息。如Username、Password和Age等。如果Hash中包含很少的字段，那么该类型的数据也将仅占用很少的磁盘空间。每一个Hash可以存储4294967295个键值对。

![img](.\assets\aa64034f78f0f7369310d7100755b319ebc41330.jpg)

#### 4.3.2 常用命令

**hset key field value**

为指定的key设定field/value对（键值对）。

```
127.0.0.1:6379> hset myhash username tom
(integer) 1
127.0.0.1:6379>
```

**hget key field**

返回指定的key中的field的值

```
127.0.0.1:6379> hset myhash username tom
(integer) 1
127.0.0.1:6379> hget myhash username
"tom"
```

**hdel key field [field … ]** 

可以删除一个或多个字段，返回值是被删除的字段个数

```
127.0.0.1:6379> hdel myhash username
(integer) 1
127.0.0.1:6379> hget myhash username
(nil)
127.0.0.1:6379>
```

### 4.4 列表类型list

#### 4.4.1 介绍

​	在Redis中，List类型是按照插入顺序排序的字符串链表。和数据结构中的普通链表一样，我们可以在其头部(left)和尾部(right)添加新的元素。在插入时，如果该键并不存在，Redis将为该键创建一个新的链表。与此相反，如果链表中所有的元素均被移除，那么该键也将会被从数据库中删除。List中可以包含的最大元素数量是4294967295个。

![img](.\assets\e850352ac65c1038f66154d3bf119313b07e8980-1565518019552.jpg)

#### 4.4.2 常用命令

**lpush key values[value1 value2…]**

在指定的key所关联的list的头部插入所有的values，如果该key不存在，该命令在插入的之前创建一个与该key关联的空链表，之后再向该链表的头部插入数据。插入成功，返回元素的个数。

```
127.0.0.1:6379> lpush mylist a b c
(integer) 3
127.0.0.1:6379>
```

**lpop key**

返回并弹出指定的key关联的链表中的第一个元素，即头部元素。如果该key不存在，返回nil；若key存在，则返回链表的头部元素。

```
127.0.0.1:6379> lpush mylist a b c
(integer) 3
127.0.0.1:6379> lpop mylist
"c"
127.0.0.1:6379> lpop mylist
"b"
```

**rpop key**

从尾部弹出元素。

```
127.0.0.1:6379> lpush mylist a b c
(integer) 3
127.0.0.1:6379> rpop mylist
"a"
```

### 4.5 集合类型set

#### 4.5.1 介绍

​	在Redis中，我们可以将Set类型看作为没有排序的字符集合，和List类型一样，我们也可以在该类型的数据值上执行添加、删除或判断某一元素是否存在等操作。需要说明的是，这些操作的时间复杂度为O(1)，即常量时间内完成次操作。Set可包含的最大元素数量是4294967295，和List类型不同的是，Set集合中不允许出现重复的元素。

![img](.\assets\54fbb2fb43166d2232ad8e854b2309f79152d2cd.jpg)

#### 4.5.2 常用命令

**sadd key values[value1、value2…]**

向set中添加数据，如果该key的值已有则不会重复添加

```
127.0.0.1:6379> sadd myset a b c
(integer) 3
```

**smembers key**

获取set中所有的成员

```
127.0.0.1:6379> sadd myset a b c
(integer) 3
127.0.0.1:6379> smembers myset
1) "c"
2) "a"
3) "b"
```

**srem key members[member1、member2…]**

删除set中指定的成员

```
127.0.0.1:6379> srem myset a b
(integer) 2
127.0.0.1:6379> smembers myset
1) "c"
127.0.0.1:6379>
```

### 4.6 有序集合类型sorted set

#### 4.6.1 介绍

​	Redis 有序集合和集合一样也是string类型元素的集合,且不允许重复的成员。不同的是每个元素都会关联一个double类型的分数。redis正是通过分数来为集合中的成员进行从小到大的排序。有序集合的成员是唯一的,但分数(score)却可以重复。集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是O(1)。 集合中最大的成员数为 232 - 1 (4294967295, 每个集合可存储40多亿个成员)。

![img](.\assets\0bd162d9f2d3572c7d0c07cd8713632762d0c331.jpg)

#### 4.6.2 常用命令

**zadd key score member [score member ...]**

​	向有序集合中加入一个元素和该元素的分数，如果该元素已经存在则会用新的分数替换原有的分数。返回值是新加入到集合中的元素个数，不包含之前已经存在的元素。

```
127.0.0.1:6379> zadd scoreboard 80 zhangsan 89 lisi 94 wangwu 
(integer) 3
127.0.0.1:6379> zadd scoreboard 97 lisi 
(integer) 0
```

**zscore key member**

获取元素的分数

```
127.0.0.1:6379> zscore scoreboard lisi 
"97"
```

**zrem key member [member ...]**

​	移除有序集key中的一个或多个成员，不存在的成员将被忽略。当key存在但不是有序集类型时，返回一个错误。

```
127.0.0.1:6379> zrem scoreboard lisi
(integer) 1
```

**zrange key start stop [WITHSCORES]**

​	按照元素分数从小到大的顺序返回索引从start到stop之间的所有元素（包含两端的元素）

```
127.0.0.1:6379> zrange scoreboard 0 2
1) "zhangsan"
2) "wangwu"
3) "lisi“
```

**zrevrange key start stop [WITHSCORES]**

按照元素分数从大到小的顺序返回索引从start到stop之间的所有元素（包含两端的元素）

```
127.0.0.1:6379> zrevrange scoreboard 0 2
1) " lisi "
2) "wangwu"
3) " zhangsan 

如果需要获得元素的分数的可以在命令尾部加上WITHSCORES参数 

127.0.0.1:6379> zrange scoreboard 0 1 WITHSCORES
1) "zhangsan"
2) "80"
3) "wangwu"
4) "94"
```

## 五 通用命令

**keys ***

返回满足给定pattern 的所有key

```
redis 127.0.0.1:6379> keys mylist*
1) "mylist"
2) "mylist5"
3) "mylist6"
4) "mylist7"
5) "mylist8"
```

**del key1 key2**

```
redis 127.0.0.1:6379> del age
(integer) 1
redis 127.0.0.1:6379> exists age
(integer) 0
```

**exists key(容易记错的命令)**

确认一个key 是否存在
示例：从结果来看，数据库中不存在HongWan 这个key，但是age 这个key 是存在的

```
redis 127.0.0.1:6379> exists HongWan
(integer) 0
redis 127.0.0.1:6379> exists age
(integer) 1
redis 127.0.0.1:6379>
```

**type key**

查看key的数据类型

```
redis 127.0.0.1:6379> type addr
string
redis 127.0.0.1:6379> type myzset2
zset
redis 127.0.0.1:6379> type mylist
list
redis 127.0.0.1:6379>
```

**缓存相关**

Redis在实际使用过程中更多的用作缓存，然而缓存的数据一般都是需要设置生存时间的，即：到期后数据销毁。

```
EXPIRE key seconds			 设置key的生存时间（单位：秒）key在多少秒后会自动删除
TTL key 					查看key生于的生存时间
PERSIST key				清除生存时间 
PEXPIRE key milliseconds	生存时间设置单位为：毫秒

例子：
127.0.0.1:6379> set test 1		设置test的值为1
OK
127.0.0.1:6379> get test			获取test的值
"1"
127.0.0.1:6379> EXPIRE test 5	设置test的生存时间为5秒
(integer) 1
127.0.0.1:6379> TTL test			查看test的生于生成时间还有1秒删除
(integer) 1
127.0.0.1:6379> TTL test
(integer) -2
127.0.0.1:6379> get test			获取test的值，已经删除
(nil)
```

**多数据库操作**

select index:切换库

```
127.0.0.1:6379[16]> select 15
OK
127.0.0.1:6379[15]>
```

dbsiz: 返回当前库中有多少个key

```
127.0.0.1:6379> dbsize
(integer) 7
```

flushdb:清空当前数据库数据

```
127.0.0.1:6379> flushdb
OK
```

flushall:清空当前实例下所有的数据库数据

```
127.0.0.1:6379> flushall
OK
```

## 六 Redis的持久化

### 6.1 Redis持久化概述

Redis的高性能是由于其将所有数据都存储在了内存中，为了使Redis在重启之后仍能保证数据不丢失，需要将数据从内存中同步到硬盘中，这一过程就是持久化。Redis支持两种方式的持久化，一种是RDB方式，一种是AOF方式。可以单独使用其中一种或将二者结合使用。

- RDB持久化（默认支持，无需配置）

  该机制是指在指定的时间间隔内将内存中的数据集快照写入磁盘。

- AOF持久化

  该机制将以日志的形式记录服务器所处理的每一个写操作，在Redis服务器启动之初会读取该文件来重新构建数据库，以保证启动后数据库中的数据是完整的。

- 无持久化

  我们可以通过配置的方式禁用Redis服务器的持久化功能，这样我们就可以将Redis视为一个功能加强版的memcached了。

- redis可以同时使用RDB和AOF

### 6.2 RDB持久化机制

#### 6.2.1 RDB持久化机制优点

- 一旦采用该方式，那么你的整个Redis数据库将只包含一个文件，这对于文件备份而言是非常完美的。比如，你可能打算每个小时归档一次最近24小时的数据，同时还要每天归档一次最近30天的数据。通过这样的备份策略，一旦系统出现灾难性故障，我们可以非常容易的进行恢复。
- 对于灾难恢复而言，RDB是非常不错的选择。因为我们可以非常轻松的将一个单独的文件压缩后再转移到其它存储介质上
- 性能最大化。对于Redis的服务进程而言，在开始持久化时，它唯一需要做的只是fork（分叉）出子进程，之后再由子进程完成这些持久化的工作，这样就可以极大的避免服务进程执行IO操作了。

相比于AOF机制，如果数据集很大，RDB的启动效率会更高

#### 6.2.2 RDB持久化机制缺点

- 如果你想保证数据的高可用性，即最大限度的避免数据丢失，那么RDB将不是一个很好的选择。因为系统一旦在定时持久化之前出现宕机现象，此前没有来得及写入磁盘的数据都将丢失。
- 由于RDB是通过fork子进程来协助完成数据持久化工作的，因此，如果当数据集较大时，可能会导致整个服务器停止服务几百毫秒，甚至是1秒钟

#### 6.2.3 RDB持久化机制的配置

在redis.windows.conf配置文件中有如下配置：

```conf
################################ SNAPSHOTTING  #################################
#
# Save the DB on disk:
#
#   save <seconds> <changes>
#
#   Will save the DB if both the given number of seconds and the given
#   number of write operations against the DB occurred.
#
#   In the example below the behaviour will be to save:
#   after 900 sec (15 min) if at least 1 key changed
#   after 300 sec (5 min) if at least 10 keys changed
#   after 60 sec if at least 10000 keys changed
#
#   Note: you can disable saving at all commenting all the "save" lines.
#
#   It is also possible to remove all the previously configured save
#   points by adding a save directive with a single empty string argument
#   like in the following example:
#
#   save ""

save 900 1
save 300 10
save 60 10000
```

其中，上面配置的是RDB方式数据持久化时机：

| 关键字 | 时间(秒) | key修改数量 | 解释                                                  |
| ------ | -------- | ----------- | ----------------------------------------------------- |
| save   | 900      | 1           | 每900秒(15分钟)至少有1个key发生变化，则dump内存快照   |
| save   | 300      | 10          | 每300秒(5分钟)至少有10个key发生变化，则dump内存快照   |
| save   | 60       | 10000       | 每60秒(1分钟)至少有10000个key发生变化，则dump内存快照 |

### 6.3 AOF持久化机制

#### 6.3.1 AOF持久化机制优点

- 该机制可以带来更高的数据安全性，即数据持久性。Redis中提供了3中同步策略，即每秒同步、每修改同步和不同步。事实上，每秒同步也是异步完成的，其效率也是非常高的，所差的是一旦系统出现宕机现象，那么这一秒钟之内修改的数据将会丢失。而每修改同步，我们可以将其视为同步持久化，即每次发生的数据变化都会被立即记录到磁盘中。可以预见，这种方式在效率上是最低的。至于无同步，无需多言，我想大家都能正确的理解它。
- 由于该机制对日志文件的写入操作采用的是append模式，因此在写入过程中即使出现宕机现象，也不会破坏日志文件中已经存在的内容。然而如果我们本次操作只是写入了一半数据就出现了系统崩溃问题，不用担心，在Redis下一次启动之前，我们可以通过redis-check-aof工具来帮助我们解决数据一致性的问题。
- 如果日志过大，Redis可以自动启用rewrite机制。即Redis以append模式不断的将修改数据写入到老的磁盘文件中，同时Redis还会创建一个新的文件用于记录此期间有哪些修改命令被执行。因此在进行rewrite切换时可以更好的保证数据安全性。
- AOF包含一个格式清晰、易于理解的日志文件用于记录所有的修改操作。事实上，我们也可以通过该文件完成数据的重建

#### 6.3.2 AOF持久化机制缺点

- 对于相同数量的数据集而言，AOF文件通常要大于RDB文件
- 根据同步策略的不同，AOF在运行效率上往往会慢于RDB。总之，每秒同步策略的效率是比较高的，同步禁用策略的效率和RDB一样高效。

#### 6.3.3 AOF持久化机制配置

##### 6.3.3.1 开启AOF持久化

```conf
############################## APPEND ONLY MODE ###############################

# By default Redis asynchronously dumps the dataset on disk. This mode is
# good enough in many applications, but an issue with the Redis process or
# a power outage may result into a few minutes of writes lost (depending on
# the configured save points).
#
# The Append Only File is an alternative persistence mode that provides
# much better durability. For instance using the default data fsync policy
# (see later in the config file) Redis can lose just one second of writes in a
# dramatic event like a server power outage, or a single write if something
# wrong with the Redis process itself happens, but the operating system is
# still running correctly.
#
# AOF and RDB persistence can be enabled at the same time without problems.
# If the AOF is enabled on startup Redis will load the AOF, that is the file
# with the better durability guarantees.
#
# Please check http://redis.io/topics/persistence for more information.

appendonly no
```

将appendonly修改为yes，开启aof持久化机制，默认会在目录下产生一个appendonly.aof文件

##### 6.3.3.2 AOF持久化时机

```
# appendfsync always
appendfsync everysec
# appendfsync no
```

上述配置为aof持久化的时机，解释如下：

| 关键字      | 持久化时机 | 解释                                         |
| ----------- | ---------- | -------------------------------------------- |
| appendfsync | always     | 每执行一次更新命令，持久化一次               |
| appendfsync | everysec   | 每秒钟持久化一次                             |
| appendfsync | no         | 不会主动执行持久话，依赖于操作系统的空闲调用 |

## 七 Jedis的基本使用

### 7.1 jedis的介绍

Redis不仅是使用命令来操作，现在基本上主流的语言都有客户端支持，比如java、C、C#、C++、php、Node.js、Go等。 在官方网站里列一些Java的客户端，有Jedis、Redisson、Jredis、JDBC-Redis、等其中官方推荐使用Jedis和Redisson。 在企业中用的最多的就是Jedis，Jedis同样也是托管在github上，地址：https://github.com/xetorthio/jedis。

![1569236088703](assets/1569236088703.png) 



使用Jedis操作redis需要导入jar包坐标如下：

```xml
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>2.9.0</version>
</dependency>
```

### 7.2 jedis的基本操作

#### 7.2.1 jedis官方文档

- 官方文档地址：http://xetorthio.github.io/jedis/
- 官方API文档查询方式：

![1569236195673](assets/1569236195673.png) 

#### 7.2.2 jedis常用API

| 方法                  | 解释                                                         |
| --------------------- | ------------------------------------------------------------ |
| new Jedis(host, port) | 创建jedis对象，参数host是redis服务器地址，参数port是redis服务端口 |
| set(key,value)        | 设置字符串类型的数据                                         |
| get(key)              | 获得字符串类型的数据                                         |
| hset(key,field,value) | 设置哈希类型的数据                                           |
| hget(key,field)       | 获得哈希类型的数据                                           |
| lpush(key,values)     | 设置列表类型的数据                                           |
| lpop(key)             | 列表左面弹栈                                                 |
| rpop(key)             | 列表右面弹栈                                                 |
| del(key)              | 删除指定的key                                                |

#### 7.2.3 jedis的基本操作

```java
@Test
public void testJedisSingle(){
	//1 设置ip地址和端口
	Jedis jedis = new Jedis("localhost", 6379);
	//2 设置数据
	jedis.set("name", "itheima");
	//3 获得数据
	String name = jedis.get("name");
	System.out.println(name);
	//4 释放资源
	jedis.close();
}
```



### :reminder_ribbon: 经验分享：

#### 1.已知的代码

~~~java
@Test
public void testJedisSingle(){
	//1 设置ip地址和端口
	Jedis jedis = new Jedis("localhost", 6379);
    .......
}
~~~

#### 报错信息

![image-20200316201714218](assets/image-20200316201714218.png)

#### 问题的分析

redis连接不上，极有可能是redis服务停止了

#### **问题解决办法**

启动redis服务即可

---

### 7.3 jedis连接池的使用

#### 7.3.1 jedis连接池的基本概念

jedis连接资源的创建与销毁是很消耗程序性能，所以jedis为我们提供了jedis的池化技术，jedisPool在创建时初始化一些连接资源存储到连接池中，使用jedis连接资源时不需要创建，而是从连接池中获取一个资源进行redis的操作，使用完毕后，不需要销毁该jedis连接资源，而是将该资源归还给连接池，供其他请求使用。

#### 7.3.2 jedis连接池API查询方式

![1569236210276](assets/1569236210276.png)

#### 7.3.3 jedisPool的基本使用

```java
@Test
public void testJedisPool(){
	//1 获得连接池配置对象，设置配置项
	JedisPoolConfig config = new JedisPoolConfig();
	// 1.1 最大连接数
	config.setMaxTotal(30);
	// 1.2  最大空闲连接数
	config.setMaxIdle(10);
	
	//2 获得连接池
	JedisPool jedisPool = new JedisPool(config, "localhost", 6379);
	
	//3 获得核心对象
	Jedis jedis = null;
	try {
		jedis = jedisPool.getResource();
		
		//4 设置数据
		jedis.set("name", "itcast");
		//5 获得数据
		String name = jedis.get("name");
		System.out.println(name);
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally{
		if(jedis != null){
			jedis.close();
		}
		// 虚拟机关闭时，释放pool资源
		if(jedisPool != null){
			jedisPool.close();
		}
	}
}
```

### 7.4 案例-编写jedis连接池工具类

**JedisUtils.java**

```java
public class JedisUtils {
	
	private static JedisPoolConfig poolConfig = null;
	private static JedisPool jedisPool = null;
	
	private static Integer maxTotal = null;
	private static Integer maxIdle = null;
	private static String host = null;
	private static Integer port = null;
	
	static{
		
		//读取配置文件 获得参数值
		ResourceBundle rb = ResourceBundle.getBundle("jedis");
		maxTotal = Integer.parseInt(rb.getString("jedis.maxTotal"));
		maxIdle = Integer.parseInt(rb.getString("jedis.maxIdle"));
		port = Integer.parseInt(rb.getString("jedis.port"));
		host = rb.getString("jedis.host");
		
		poolConfig = new JedisPoolConfig();
		poolConfig.setMaxTotal(maxTotal);
		poolConfig.setMaxIdle(maxIdle);
		jedisPool = new JedisPool(poolConfig,host,port);
	}

	public static Jedis getJedis(){
		Jedis jedis = jedisPool.getResource();
		return jedis;
	}
	
}
```

**jedis.properties**

```properties
jedis.host=localhost
jedis.port=6379
jedis.maxTotal=30
jedis.maxIdle=10
```

