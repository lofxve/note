CREATE DATABASE /*!32312 IF NOT EXISTS*/`heima_movies` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `heima_movies`;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_banner
-- ----------------------------
DROP TABLE IF EXISTS `tb_banner`;
CREATE TABLE `tb_banner` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL COMMENT '电影名称',
  `pic_path` varchar(200) DEFAULT NULL COMMENT '电影图片路径',
  `content_desc` varchar(500) DEFAULT NULL COMMENT '电影描述',
  `order_no` int(3) DEFAULT NULL COMMENT '排序号，越小越靠前',
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_banner
-- ----------------------------
INSERT INTO `tb_banner` VALUES ('1', '泰山1', '/images/5.jpg', '泰山已经适应了伦敦的生活，他被召回丛林中的故居，调查采矿营地的活动。', '0', 'https://www.iqiyi.com/v_19rrakpya0.html');
INSERT INTO `tb_banner` VALUES ('2', '极速飞行', '/images/2.jpg', '六名儿童，遗传上与鸟类的DNA杂交，飞往全国各地寻找他们的起源。一路上，他们神秘的过去。。。', '1', 'https://v.qq.com/x/cover/7ubvbd3wlslzcsj/x00220wcapo.html?ptag=iqiyi');
INSERT INTO `tb_banner` VALUES ('3', '独立日', '/images/3.jpg', '人类的命运悬而未决，因为美国总统和公民决定这些外星人是值得信任的还是令人恐惧的。', '2', 'https://www.iqiyi.com/v_19rrk0zjb8.html');
INSERT INTO `tb_banner` VALUES ('4', '乌龙特工', '/images/4.jpg', '鲍勃斯通（德韦恩·约翰逊饰）在十几岁时就因为超重而受到欺负，他在高中同学聚会上看起来很健康，肌肉发达。声称掌握了最高机密。。。', '3', 'https://www.iqiyi.com/v_19rrllxz4g.html');
INSERT INTO `tb_banner` VALUES ('5', '冰川时代：星际碰撞', '/images/6.jpg', '在影片的尾声中，斯克里特一直在努力控制这艘外星飞船，直到它在火星上坠毁，摧毁了地球上所有的生命。', '4', 'https://www.iqiyi.com/v_19rr9a6m6w.html');
INSERT INTO `tb_banner` VALUES ('6', 'X战警', '/images/7.jpg', '1977年，超自然研究者艾德（帕特里克·威尔逊饰）和洛林·沃伦（Lorraine Warren）结束了自己的休假，前往北部的一个自治区恩菲尔德。。。', '5', 'https://www.iqiyi.com/v_19rrdmmmg8.html');
INSERT INTO `tb_banner` VALUES ('8', '机器人总动员', '/images/vali.jpg', '皮克斯动画长片《WALL-E》的主角。“WALL-E”是Waste Allocation Load Lifters - Earth（地球废品分装员）的缩写。因为地球的生态平衡受到完全的破坏，罪魁祸首-人类-只得移居到半永久太空船‘公理号’上居住，地球上只剩下自动清除垃圾的Buynlarge公司WALL-E工作机器人，人类打算待万物更新时再飞回地球安居', '2', 'https://www.iqiyi.com/v_19rrjpwu8w.html');

-- ----------------------------
-- Table structure for tb_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category` (
  `id` INT(10) NOT NULL,
  `category_name` VARCHAR(20) DEFAULT NULL,
  `order_no` TINYINT(2) DEFAULT NULL COMMENT '排序号，越小越靠前',
  KEY `id` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_category
-- ----------------------------
INSERT INTO `tb_category` VALUES ('0', '特色的', '0');
INSERT INTO `tb_category` VALUES ('1', '高观看率', '1');
INSERT INTO `tb_category` VALUES ('2', '高评分', '2');
INSERT INTO `tb_category` VALUES ('3', '最新上映', '3');

-- ----------------------------
-- Table structure for tb_comment
-- ----------------------------
DROP TABLE IF EXISTS `tb_comment`;
CREATE TABLE `tb_comment` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `movies_id` int(10) DEFAULT NULL,
  `content` varchar(3000) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `creator_name` varchar(50) DEFAULT NULL,
  `creator_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_comment
-- ----------------------------
INSERT INTO `tb_comment` VALUES ('1', '3', '黄渤真的是拍出了魔幻现实主义的感觉，影片最后的笑令人有些毛骨悚然，总觉得这是用话剧手段拍的一部电影，演戏的路数和语言都不是很生活化，显得有些夸张，当然在荒岛求生的背景下，这样的反应说不定也有充足道理', '2020-10-05 00:00:00', '微风男子', null);
INSERT INTO `tb_comment` VALUES ('2', '3', '还是想吐槽一下，爱情线实在有些鸡肋，舒淇这些年的演技为什么还停留在略显做作的撒娇套路上', '2020-10-05 00:00:00', 'kiwi77', null);
INSERT INTO `tb_comment` VALUES ('3', '3', '黄渤这一次真的拼了，用一群人荒岛求生的故事外壳好好地搞了一出人性实验，黑色，荒诞，疯狂，从生存的法则，部落的建立，文明的诞生，货币的诞生讲到政权的形成以及乌托邦社会的破灭，而在其中穿插着一个男人犹如摩西一般的成长历程，整个剧本的野心极大，不论是宏观上还是微观上都言之有物，有些无法呈现的阴暗面，以巧妙的抉择呈现，效果惊艳', '2020-10-05 00:00:00', '热心网友王老师', null);
INSERT INTO `tb_comment` VALUES ('10', '9', '蜘蛛侠：英雄归来，漫威的电影都不错', '2020-09-28 22:22:32', 'jerry', '2');

-- ----------------------------
-- Table structure for tb_members
-- ----------------------------
DROP TABLE IF EXISTS `tb_members`;
CREATE TABLE `tb_members` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL COMMENT '用户名',
  `password` varchar(30) DEFAULT NULL COMMENT '密码',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `degree` tinyint(2) DEFAULT NULL COMMENT '等级',
  `score` int(8) DEFAULT NULL COMMENT '分值，评论产生分值',
  `is_vip` tinyint(1) DEFAULT '0' COMMENT '0普通用户 1是vip会员',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_members
-- ----------------------------
INSERT INTO `tb_members` VALUES ('1', 'tom', '123456', '2020-01-27 16:57:08', '13800000000', 'tom@heima.com', '1', '0', '0');
INSERT INTO `tb_members` VALUES ('2', 'jerry', '123456', '2020-01-27 16:57:08', '13800000001', 'jerry@heima.com', '1', '0', '0');

-- ----------------------------
-- Table structure for tb_movies
-- ----------------------------
DROP TABLE IF EXISTS `tb_movies`;
CREATE TABLE `tb_movies` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL COMMENT '电影名称',
  `pic_path` varchar(200) DEFAULT NULL COMMENT '电影图片路径',
  `cid` int(2) DEFAULT NULL COMMENT '分类的id  \r\n0：特色的  1：高观看率   2：高评分  3：最新上映',
  `content_desc` varchar(500) DEFAULT NULL COMMENT '电影描述',
  `keyword` varchar(50) DEFAULT NULL COMMENT '关键字，用来搜索',
  `order_no` int(3) DEFAULT NULL COMMENT '排序号，越小越靠前',
  `show_time` datetime DEFAULT NULL COMMENT '创建时间',
  `director` varchar(100) DEFAULT NULL COMMENT '导演姓名',
  `actors` varchar(500) DEFAULT NULL COMMENT '演员姓名',
  `url` varchar(1000) DEFAULT NULL COMMENT '播放连接',
  `need_pay` tinyint(1) DEFAULT '0' COMMENT '是否需要付费，0：不需要 1：需要',
  PRIMARY KEY (`id`),
  KEY `movies_category_fk` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_movies
-- ----------------------------
INSERT INTO `tb_movies` VALUES ('1', '荞麦疯长', '/images/qiaomaifengzhang.jpg', '2', '20世纪90年代的小城市里，云荞(马思纯饰)想要“活成一部电影”；李麦(钟楚曦饰)期待着看得见希望的未来；吴风(黄景瑜饰)要在平凡的日子里背水一战。每个人都有着对未来的憧憬，并带着憧憬与不可知开始了异乡漂泊之路。“云彼有荞麦，无风亦可长”，底层年轻人背井离乡，逆风成长', '背水一战 憧憬 漂泊', '0', '2020-09-12 15:34:47', '徐展雄', '马思纯、钟楚曦、黄景瑜', 'https://www.iqiyi.com/v_19rsjart5o.html', '0');
INSERT INTO `tb_movies` VALUES ('2', '花木兰', '/images/huamulan.jpg', '0', '中国的皇帝颁布法令，要求每家出一名男子服兵役，抵御北方侵略者。作为一名受人尊敬的战士的长女，花木兰（刘亦菲饰）站出来替生病的父亲应征入伍。她女扮男装，化名为花军，经历了种种考验，同时必须利用内在的力量，接纳自己真正的潜能。这是一场史诗般的旅程，让木兰蜕变为一名受人尊敬的战士，也赢得来自国家与骄傲的父亲的尊重', '服兵役 尊重  神秘', '1', '2020-09-12 15:34:47', '妮基·卡罗', '刘亦菲、甄子丹、巩俐、李连杰、安柚鑫、李截、郑佩佩、赵家玲、马志、唐莎娜', 'https://www.iqiyi.com/v_19f5b4f650k.html', '0');
INSERT INTO `tb_movies` VALUES ('3', '一出好戏', '/images/yichuhaoxi.jpg', '2', '《一出好戏》是由上海瀚纳影视文化传媒有限公司制作的喜剧片，由黄渤执导，黄渤、王宝强、舒淇、张艺兴、于和伟、王迅联袂主演。该片于2018年8月10日在中国内地上映，2020年4月2日在韩国上映。该片讲述了公司员工团建出游遭遇海难，众人流落在荒岛之上，为了生存他们共同生活，并面对一系列人性问题的寓言故事', '喜剧 荒岛', '2', '2020-09-12 15:34:47', '黄渤', '黄渤、张冀、郭俊立、查慕春、崔斯韦、邢爱娜、黄湛中', 'https://www.iqiyi.com/v_19rrc17tj8.html', '0');
INSERT INTO `tb_movies` VALUES ('4', '极线杀手', '/images/jisushashou.jpg', '3', '别名「黑色凯萨」的世界顶尖杀手邓肯·维兹拉（麦斯·米科尔森饰）在享受退休生活之际，前雇主突然指控他不利于公司。他在身不由己的情况下重回本行，与一群杀手正面对决。这群心狠手辣的杀手不仅在年纪与体力占尽优势，更不计一切要取他性命。', '复仇特工 机密', '3', '2020-09-12 15:34:47', '乔纳斯·阿克伦德', '麦斯·米科尔森、凡妮莎·哈金斯、凯瑟琳·温妮克、罗伯特·梅耶、马特·卢卡斯', 'https://www.iqiyi.com/v_19rqwwy3ug.html', '0');
INSERT INTO `tb_movies` VALUES ('5', '东北往事：我叫刘海柱', '/images/dongbeiwangshi.jpg', '2', '《东北往事：我叫刘海柱》讲述的是上世纪80年代初的东北，爱慕同事周萌的工人刘海柱因帮扶弱者，爱打抱不平，招惹上了不良分子并给自己的家人朋友带来危险。在经历被坏人打伤，被工厂开除等人生打击低谷后，刘海柱更面临危及生命的挑战。但此时，这个神奇的男人竟然还能重新站起来，面对一个个惊天的挑战，令世人震惊的完成着属于他的精彩传奇', '男人 挑战', '4', '2020-09-12 15:34:47', '周润泽', '许君聪、杨蕊嘉、刘奔、龚小钧、田璐', 'https://www.iqiyi.com/v_17ismck6q8c.html#curid=4434874159860000_192a977c7e4951afa1b66a4825fcd17a', '0');
INSERT INTO `tb_movies` VALUES ('6', '最美逆行', '/images/zuimeinixing.jpg', '1', '电影《最美逆行》是一部反映广东援鄂医务人员广州武汉高铁乘警们在本次疫情中坚难困苦，努力奋斗，可歌可泣的英雄故事', '新冠病毒 疫情 ', '5', '2020-09-12 15:34:47', '范雨林  、邢博、胡树华', '程琤、启杰领衔主演，王奎荣，迟志强，沙溢、黄一山、陈龙，刘烨，柳海龙、梁梓滔、肖午、田甜等', 'https://www.iqiyi.com/v_aftz3h9jjo.html', '0');
INSERT INTO `tb_movies` VALUES ('8', '复仇者联盟4：终局之战', '/images/fulian4.jpg', '2', '来自泰坦星的灭霸为了解决宇宙资源匮乏、人口暴增的问题，集齐了所有无限宝石，一个响指成功地使全宇宙生命随机减半。\r\n宇宙由于灭霸的行动而变得满目疮痍，但是五年之后，被困在量子领域的蚁人意外回到现实世界，他的出现为幸存的复仇者点燃了希望。无论前方将遭遇怎样的后果，幸存的复仇者都必须在剩余盟友的帮助下再一次集结，以逆转灭霸的所作所为，彻底恢复宇宙的秩序', '复联4 漫威 机器人 地球 宇宙', '2', '2015-09-17 00:00:00', '安东尼·罗素、乔·罗素', '小罗伯特·唐尼，克里斯·埃文斯，马克·鲁法洛，克里斯·海姆斯沃斯，斯嘉丽·约翰逊，杰瑞米·雷纳', 'https://www.iqiyi.com/v_19rr7q1fy0.html', '0');
INSERT INTO `tb_movies` VALUES ('9', '蜘蛛侠：英雄归来', '/images/zhizhuxia.jpg', '0', '彼得帕克（汤姆·赫兰德 Tom Holland 饰）在内战后受到了钢铁侠托尼斯塔克（小罗伯特·唐尼 Robert Downey Jr. 饰）的赏识，表面上，彼得进入托尼的公司成为了一名实习生，实际上，他和复仇者联盟的成员们一起接受了各种各样的训练。托尼虽然欣赏彼得的勇敢和正直，却并不认为他目前已经拥有加入复联的实力，他派出了特工哈皮（乔恩·费儒 Jon Favreau 饰）暗中观察，这让十分想证明自己的彼得感到万分焦躁。\r\n　　在对付两个银行劫匪的过程中，彼得发现劫匪们使用的是一种前所未见的新型武器，他孤身一人深入敌后顺藤摸瓜找到了幕后主使秃鹰（迈克尔·基顿 Michael Keaton 饰），让他彼得没有想到的是，秃鹰竟然是他爱慕的女生利兹（劳拉·海瑞尔 Laura Harrier 饰）的父亲', '蜘蛛侠  回归 返校日', '0', '2018-09-12 15:34:47', '乔·沃茨', ' 汤姆·赫兰德 / 小罗伯特·唐尼 / 玛丽莎·托梅 / 迈克尔·基顿 / 雅各布·巴特朗', 'https://www.iqiyi.com/v_19rrdw5cs4.html', '0');
INSERT INTO `tb_movies` VALUES ('10', '哥斯拉2：怪兽之王', '/images/gesila2.jpg', '1', '动物基因组学（帝王计划）研究机构的一个小组在一座庙里研究着魔斯拉。她从幼体中孵出，在一群雇佣兵袭击这个机构时，魔斯拉逃了出去。然后她在一个瀑布包了茧，随后破茧而出，完成了全形态生长。在2014年，哥斯拉被整个世界看到后，“帝王组织”在水下建了一个基地，在这个位于水下好几英里的水中基地中，他们研究着哥斯拉和其它可能存在的生物。那是他们真正的研究核心', '基因 哥斯拉 怪兽', '2', '2018-09-12 15:34:47', '迈克尔·道赫蒂', '凯尔·钱德勒，维拉·法梅加，米莉·博比·布朗，渡边谦，章子怡，布莱德利·惠特福德，莎莉·霍金斯', 'https://www.iqiyi.com/v_19rr7q5ado.html', '0');
INSERT INTO `tb_movies` VALUES ('11', '测试数据', '/images/h2-1.jpg', '0', null, null, '0', '2018-09-12 00:00:00', '测试', '测试', 'ceshi', '0');
INSERT INTO `tb_movies` VALUES ('12', '测试数据', '/images/h2-1.jpg', '0', null, null, '0', '2018-09-12 00:00:00', '测试', '测试', 'ceshi', '0');
INSERT INTO `tb_movies` VALUES ('13', '测试数据', '/images/h2-1.jpg', '0', null, null, '0', '2018-09-12 00:00:00', '测试', '测试', 'ceshi', '0');
INSERT INTO `tb_movies` VALUES ('14', '测试数据', '/images/h2-1.jpg', '0', null, null, '0', '2018-09-12 00:00:00', '测试', '测试', 'ceshi', '0');
INSERT INTO `tb_movies` VALUES ('15', '测试数据', '/images/h2-1.jpg', '0', null, null, '0', '2018-09-12 00:00:00', '测试', '测试', 'ceshi', '0');
INSERT INTO `tb_movies` VALUES ('16', '测试数据', '/images/h2-1.jpg', '0', null, null, '0', '2018-09-12 00:00:00', '测试', '测试', 'ceshi', '0');
INSERT INTO `tb_movies` VALUES ('17', '测试数据', '/images/h2-1.jpg', '0', null, null, '0', '2018-09-12 00:00:00', '测试', '测试', 'ceshi', '0');
INSERT INTO `tb_movies` VALUES ('18', '测试数据', '/images/h2-1.jpg', '0', null, null, '0', '2018-09-12 00:00:00', '测试', '测试', 'ceshi', '0');
INSERT INTO `tb_movies` VALUES ('19', '测试数据', '/images/h2-1.jpg', '0', null, null, '0', '2018-09-12 00:00:00', '测试', '测试', 'ceshi', '0');
INSERT INTO `tb_movies` VALUES ('20', '测试数据', '/images/h2-1.jpg', '0', null, null, '0', '2018-09-12 00:00:00', '测试', '测试', 'ceshi', '0');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL COMMENT '用户名',
  `password` varchar(30) DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('1', 'admin', '123456');
INSERT INTO `tb_user` VALUES ('2', 'xiaowang', '123456');
