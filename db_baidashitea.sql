-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2020-08-07 08:51:54
-- 服务器版本： 5.6.47-log
-- PHP 版本： 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `db_baidashitea`
--

DELIMITER $$
--
-- 存储过程
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pd_article_category_haschildrenBatchUpdate` (OUT `result` VARCHAR(255))  BEGIN
       DECLARE done INT DEFAULT 0;
       DECLARE id1 BIGINT(20);
       DECLARE parentids1 VARCHAR(500) DEFAULT '';
       DECLARE childrens1 INT(11) DEFAULT 0;
       DECLARE haschildrens1 BIT(1) DEFAULT 0;
       DECLARE nccur CURSOR FOR SELECT id,`class_list` FROM `dt_article_category`;
       DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
       OPEN nccur;
       REPEAT
       FETCH nccur INTO id1,parentids1;
       IF NOT done THEN
       SELECT  COUNT(id),CASE WHEN COUNT(id)>0 THEN 1 ELSE 0 END INTO childrens1,haschildrens1 FROM dt_article_category WHERE  `class_list` REGEXP CONCAT('^',parentids1,id1,'/','$');
       UPDATE dt_article_category SET haschildren=haschildrens1,class_layer=fun_string_split(parentids1,'/') WHERE id=id1;
       END IF;
       UNTIL done END REPEAT;
       CLOSE nccur;
       SET result='success';
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pd_article_category_haschildrenSingleUpdate` (IN `rid` BIGINT(20), OUT `result` VARCHAR(255))  BEGIN
       DECLARE done INT DEFAULT 0;
       DECLARE id1 BIGINT(20);
       DECLARE parentids1 VARCHAR(500) DEFAULT '';
       DECLARE childrens1 INT(11) DEFAULT 0;
       DECLARE haschildrens1 BIT(1) DEFAULT 0;
       DECLARE nccur CURSOR FOR SELECT id,`class_list` FROM `dt_article_category` WHERE id=rid;
       DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
       OPEN nccur;
       REPEAT
       FETCH nccur INTO id1,parentids1;
       IF NOT done THEN
       SELECT  COUNT(id),CASE WHEN COUNT(id)>0 THEN 1 ELSE 0 END INTO childrens1,haschildrens1 FROM dt_article_category WHERE  `class_list` REGEXP CONCAT('^',parentids1,id1,'/','$');
       UPDATE dt_article_category SET haschildren=haschildrens1,class_layer=fun_string_split(parentids1,'/') WHERE id=id1;
       END IF;
       UNTIL done END REPEAT;
       CLOSE nccur;
       SET result='success';
    END$$

--
-- 函数
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fun_string_split` (`str` VARCHAR(2048), `split` VARCHAR(20)) RETURNS INT(11) BEGIN
	    DECLARE location INT;
	    DECLARE endloca INT DEFAULT 1;
	    DECLARE start1 INT;
	    DECLARE layers INT;
	    SET str=LTRIM(RTRIM(str));
	    
	    IF RIGHT(str,1)=split THEN
	     SET str=LEFT(str,LENGTH(str)-1);
	    END IF;
	    
	    SET location=INSTR(str,split);
	    SET endloca=location;
	    SET layers=1;   
	    WHILE endloca<>0
	    DO
		SET start1=location+1;
		SET endloca=INSTR(SUBSTRING(str,start1),split);
		SET location=location+endloca;
		
		SET layers=layers+1;
	    END WHILE;
	    RETURN layers;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `dt_article`
--

CREATE TABLE `dt_article` (
  `id` int(11) NOT NULL COMMENT '自动编号',
  `channel_id` int(11) NOT NULL COMMENT '频道ID',
  `category_id` int(11) NOT NULL COMMENT '类别ID',
  `category_title` varchar(256) DEFAULT NULL COMMENT '所属类别名称',
  `call_index` varchar(256) DEFAULT NULL COMMENT '调用别名',
  `title` varchar(256) DEFAULT NULL COMMENT '标题',
  `subTitle` varchar(256) DEFAULT NULL COMMENT '子标题',
  `link_url` varchar(256) DEFAULT NULL COMMENT '外部链接',
  `img_url` varchar(2000) DEFAULT NULL COMMENT '图片地址',
  `seo_title` varchar(256) DEFAULT NULL COMMENT 'SEO标题',
  `seo_keywords` varchar(256) DEFAULT NULL COMMENT 'SEO关健字',
  `seo_description` varchar(256) DEFAULT NULL COMMENT 'SEO描述',
  `tags` varchar(1000) DEFAULT NULL COMMENT 'TAG标签逗号分隔',
  `zhaiyao` varchar(1000) DEFAULT NULL COMMENT '内容摘要',
  `contents` text COMMENT '详细内容',
  `sort_id` int(11) DEFAULT NULL COMMENT '排序',
  `click` int(11) DEFAULT NULL COMMENT '浏览次数',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态：0正常，1推荐，2锁定不显示',
  `is_msg` tinyint(4) DEFAULT NULL COMMENT '是否允许评论',
  `is_top` tinyint(1) DEFAULT NULL COMMENT '是否置顶',
  `is_red` tinyint(1) DEFAULT NULL COMMENT '是否推荐',
  `is_hot` tinyint(1) DEFAULT NULL COMMENT '是否热门',
  `is_slide` tinyint(1) DEFAULT NULL COMMENT '是否幻灯片',
  `is_sys` tinyint(4) DEFAULT '0' COMMENT '是否管理员发布0不是1是',
  `user_name` varchar(256) DEFAULT NULL COMMENT '用户名',
  `add_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `titleEn` varchar(255) DEFAULT NULL,
  `subTitleEn` varchar(255) DEFAULT NULL,
  `zhaiyaoEn` varchar(255) DEFAULT NULL,
  `contentsEn` text,
  `attachment_url` varchar(1000) DEFAULT NULL,
  `localRecOP` varchar(256) NOT NULL COMMENT '本条记录操作管理，分为删,改,复制,查,状态,类型,上传封面数量,上传相关文件数量,封面图，相关文件，前六位为二进制、第七和十位为十进制表示、第十一和第十二位为二进制，二进制1为启用0为禁用，如:101000010100,启用删、复制，改、查、状态、类型禁用，上传封面数量一张、上传相关文件数量一张，封面图、相关文件禁用，值为NULL值或空字符串时，封面图，相关文件禁用其它为全部启用。',
  `remarks` varchar(1000) NOT NULL COMMENT '备注说明'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dt_article`
--

INSERT INTO `dt_article` (`id`, `channel_id`, `category_id`, `category_title`, `call_index`, `title`, `subTitle`, `link_url`, `img_url`, `seo_title`, `seo_keywords`, `seo_description`, `tags`, `zhaiyao`, `contents`, `sort_id`, `click`, `status`, `is_msg`, `is_top`, `is_red`, `is_hot`, `is_slide`, `is_sys`, `user_name`, `add_time`, `update_time`, `titleEn`, `subTitleEn`, `zhaiyaoEn`, `contentsEn`, `attachment_url`, `localRecOP`, `remarks`) VALUES
(199, 7, 149, '更多合作', NULL, '天猫店', '', '', '/uploadfile/images/package/tm.png', '', '', '', NULL, '3000+包装设计案例、 500平专业包装展厅即将开放、 30+包装设计师、插画师、工艺师 500+服务客户', '', 1, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-04-29 03:22:35', '2020-07-17 07:12:42', '', '', '', '', '', '111000010101', ''),
(200, 7, 149, '更多合作', NULL, '京东店', '', '', '/uploadfile/images/package/jd.png', '', '', '', NULL, '跟据企业文化，品牌特色 进行个性化的小批量定制 满足员工福利，节日礼品， 周边文创等创意需求', '', 2, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-04-29 03:23:29', '2020-07-17 07:13:01', '', '', '', '', '', '111000010101', ''),
(201, 7, 149, '更多合作', NULL, '官方微博', '', '', '/uploadfile/images/package/sina.png', '', '', '', NULL, '公司引进先进的包装生产设备， 辅以先进的生产管理体系及供应链协同， 实现了包装的精益生产、个性化定制与最佳成本管控。 为众多品牌企业提供专业的包装解决方案。', '', 3, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-04-29 03:23:59', '2020-07-17 07:13:13', '', '', '', '', '', '111000010101', ''),
(224, 9, 14, '专注品种', NULL, '专注福鼎白茶', '核心产品 169年历史 2000亩高山茶园', 'http://www.163.com', '/uploadfile/images/other/bds3.jpg', '', '', '', NULL, '', '', 3, 0, 1, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-11 10:21:46', '2020-07-17 08:55:34', '', '', '', '', '', '011110010411', ''),
(225, 6, 10, '小方片1.0系列', NULL, '小方片 · 福鼎寿眉', '菜缤纷农贸市场品牌全案策划设计', '', '/uploadfile/images/other/xlcp_2_03.png', '', '', '', NULL, '品牌策划、品牌设计、VI设计、IP吉祥物设计、LOGO设计', '<p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">这款作品名叫【旋铁】，设计之初我们对它的要求有四个：</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">1.设计风格以国潮风为主，但也能自由改动适应其他类型风格。</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">2.匹配品类以茶类为主，但不只适合茶，还可以在容纳食品、滋补品、小物件时不维和。</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">3.说是国潮风，那就必然要有传统元素，但我们还想它能有一点灵动感，不要沉闷单调。</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">4.最重要的一点，在满足以上三点的同时，要实用。</span></p><figure class=\"image image-style-align-left\"><img src=\"/uploadfile/images/logo/hlflogo.jpg\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\"><span class=\"text-big\" style=\"color:rgb(77,77,77);\">接下来开始找灵感：</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">我们认为，确立一件作品的国潮风格，需要分两个步骤——解构传统文化+用设计的语言重塑</span></p><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">传承传统，最好的态度并不是把古老的东西原封不动的搬到神台上，变成一个历史符号供人膜拜，也不只是把传统的样式搬到现代设计中。</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">日本无印良品（MUJI）艺术总监原研哉说过：“传统不是一种纹样，而是早已沉淀在人们心中的东西”；对于传统的尊重，不是机械式地将传统纹样强加于现在的设计中，而是向内心寻找文化深处的感觉。</span></p><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\"><span class=\"text-big\" style=\"color:rgb(77,77,77);\">传统文化怎样动感起来？</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">要把传统趣味（玩乐）和设计结合，翻遍小时候常常玩过的玩具图鉴大全，我们找到了跑马灯。</span></p><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Fi-wiepmHnrBVDO1_6rNVHwxoAjC?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">确定了大概形式，我们来找主题。</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">文化怎样结构和重塑？</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">通过打散固有的结构，往深层次挖掘，对事物进行多角度诠释和刨析，将符号意义进行分解和重塑，就可以塑造出新的视觉、文化及语言的意义。</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">在古代山水画中，我们选择三种代表美好寓意的元素做“走马灯主角”</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">骏马、白鹤、夏荷</span></p><p style=\"margin-left:0px;\"><span style=\"color:rgb(77,77,77);\">由此对应选定主题：马到成功、鹤舞江山、寻味花间</span></p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Fr7nzZW1wtL1zZa-GSRyYe5tEubz?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FjLqoOSKVBJr1tB5wA2WJ1IoK0Fc?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Fgnhs572-4iZY76N0LJCcNip7pVP?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;text-align:center;\">初期线稿<br>&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FrWoFFAIX2K74GI7Iy-9ldhup4Kr?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Fjfead9Da9QvckujW_naOkbU-Xlq?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FuJnISQ0WbtsD9dpMV5xoKhHNmi4?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;text-align:center;\"><span style=\"color:rgb(77,77,77);\">印刷稿</span><br>&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Fg0BYkT2QMLIlPNqJwlz4p8HPTmD?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Ftv_h-qQnzF9QX8DT39SsHNe-IhH?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FusRqhaKKFSQkX8933ciy5H6WpZq?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\">上色<br>&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FlQ7o51fTMiXwR--maUQmckvqbnQ?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FjYe_MPBoN1XkLfUQKBaJSPue7ln?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Fp9cj_UDWf5y8fgCNAwvLRp_Ehla?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\"><strong>最终成品</strong></p><p style=\"margin-left:0px;\">外层是画卷，像展览作品时的“画框”，框出最佳观赏比例。</p><p style=\"margin-left:0px;\">内层是故事，像娓娓道来的电影胶卷，旋转变幻。</p><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FnyW72h4Ku9rZnHWAZYRpXioiRDO?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Fpk7ETjR-SFItXREYpqGYxuL__De?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FnpF_EtDq4M9IFF1eggPVJq8bTYE?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FlS7H_F92al6b4zJHH-qnyuYobWU?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FhpBef04y_8Ve6Xiu112CrPwDAo8?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Fgw7wTOjD7eQBCt4xZlRPwMe31VL?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FpVtT3txCbFLgUnEd0R7zAhH7pOy?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FpU5NIltqWKQXwQbOtBz2HxMUfxN?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Fj6BSRUmDhJ3X2BKaegOfIZF56If?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\">之前在做初步设想时说过想要这款作品能自由改动，适应其他类型风格和产品。</p><p style=\"margin-left:0px;\">后期为大洲新燕在原罐基础上做了改动设计，顶部走马灯提手改为燕子形状，整体色调改为尊贵典雅的铜金色，每幅画卷都是形态不一的金丝飞燕。<br>&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FlgXut7yCvPljiKs0HNAU5TIGu0G?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/Fgj0vJujoWHe45_lB3zlj7fU0SE4?imageView2/2/w/1088/q/100\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image image_resized\" style=\"width:1088px;\"><img src=\"https://img1.gtn9.com/FngoQ8c70AyH9Fkhns51eCQuTdux?imageView2/2/w/1088/q/100\"></figure>', 0, 0, 0, NULL, 1, 0, 1, 0, 0, NULL, '2020-05-12 03:37:16', '2020-07-10 22:21:38', '', '', '', '', '', '', ''),
(256, 6, 10, '小方片1.0系列', '', '小方片 · 白牡丹', '', '', '/uploadfile/images/other/xlcp_2_04.png', '惑水酒水吧', '惑水酒水吧跨界品牌全案策划设计', '品牌策划、品牌设计、VI设计、网站设计、logo设计', '', '品牌策划、品牌设计、VI设计、网站设计、logo设计', '', 1, 0, 0, 0, 1, 0, 1, 0, 0, '', '2020-05-12 15:31:07', '2020-07-10 22:21:57', '', '', '', '', '', '', ''),
(257, 6, 10, '小方片1.0系列', '', '小方片 · 福鼎寿眉', '', '', '/uploadfile/images/other/wwwwww_07.gif', '灵声机器人', '灵声机器人品牌升级设计', 'LOGO设计、品牌设计、VI设计、网站设计、品牌升级', '', 'LOGO设计、品牌设计、VI设计、网站设计、品牌升级', '', 1, 0, 0, 0, 1, 0, 0, 1, 0, '', '2020-05-12 15:31:07', '2020-07-11 02:45:31', '', '', '', '', '', '', ''),
(258, 6, 10, '小方片1.0系列', '', '小方片 · 白牡丹', '', '', '/uploadfile/images/other/wwwwww_09.gif', 'Paton. Brand', '巴顿办公环境空间设计', '办公环境空间设计,会议厅空间设计,SI设计,简约空间设计,设计公司办公空间设计', '', '办公环境空间设计,会议厅空间设计,SI设计,简约空间设计,设计公司办公空间设计', '', 1, 0, 0, 0, 1, 0, 0, 1, 0, '', '2020-05-12 15:31:07', '2020-07-11 03:01:00', '', '', '', '', '', '', ''),
(259, 6, 140, '刚柔并济系列', '', '早春花香 · 白牡丹', '', '', '/uploadfile/images/other/xlcp_2_01.png', '壹禾阳光', '壹禾阳光烘焙品牌设计', '品牌设计、VI设计、专卖店设计、IP设计、产品包装设计', '', '品牌设计、VI设计、专卖店设计、IP设计、产品包装设计', '', 1, 0, 0, 0, 1, 0, 1, 0, 0, '', '2020-05-12 15:31:07', '2020-07-10 22:21:13', '', '', '', '', '', '', ''),
(260, 6, 140, '刚柔并济系列', '', '老树白茶 · 福鼎寿眉', '', '', '/uploadfile/images/other/xlcp_2_02.png', '味峰鸭头', '迷鸭记鸭头品牌全案策划与设计', '品牌命名、标识设计、VI设计、吉祥物设计、空间设计', '', '品牌命名、标识设计、VI设计、吉祥物设计、空间设计', '', 1, 0, 0, 0, 1, 0, 1, 0, 0, '', '2020-05-12 15:31:07', '2020-07-10 22:21:23', '', '', '', '', '', '', ''),
(261, 6, 10, '小方片1.0系列', '', '早春花香 · 白牡丹', '', '', '/uploadfile/images/other/wwwwww_03.gif', '森宇控股集团', '森山铁皮枫斗品牌全案设计', '产品包装、专卖店空间设计', '', '产品包装、专卖店空间设计', '', 1, 0, 0, 0, 1, 0, 0, 1, 0, '', '2020-05-12 15:31:07', '2020-07-11 02:44:06', '', '', '', '', '', '', ''),
(262, 6, 10, '小方片1.0系列', '', '老树白茶 · 福鼎寿眉', '', '', '/uploadfile/images/other/wwwwww_05.gif', '美丽健', '美丽健西湖牌牛奶品牌策划设计', '品牌策略、包装设计、vi设计', '', '品牌策略、包装设计、vi设计', '', 1, 0, 0, 0, 1, 0, 0, 1, 0, '', '2020-05-12 15:31:08', '2020-07-11 02:44:15', '', '', '', '', '', '', ''),
(263, 6, 140, '刚柔并济系列', '', '花香甜柔 · 1号白牡丹', '', '', '/uploadfile/images/other/wwwwww_15.gif', '百瑞源枸杞', '百瑞源枸杞黑标店设计', '空间设计、专卖店设计、vi设计、品牌设计、logo设计', '', '空间设计、专卖店设计、vi设计、品牌设计、logo设计', '', 1, 0, 0, 0, 1, 0, 0, 1, 0, '', '2020-05-12 15:31:08', '2020-07-11 02:44:35', '', '', '', '', '', '', ''),
(264, 6, 140, '刚柔并济系列', '', '7年老茶 · 贮藏寿眉', '', '', '/uploadfile/images/other/wwwwww_16.gif', '澳大利亚 BURDINALE', '班柯葡萄酒全案策划设计', '品牌策略规划、命名、VI设计、产品包装设计、品牌网站', '', '品牌策略规划、命名、VI设计、产品包装设计、品牌网站', '', 1, 0, 0, 0, 1, 0, 0, 1, 0, '', '2020-05-12 15:31:08', '2020-07-11 02:44:52', '', '', '', '', '', '', ''),
(265, 6, 140, '刚柔并济系列', '', '明前头采 · 白毫银针', '', '', '/uploadfile/images/other/wwwwww_17.gif', 'THOMOS托马仕', 'THOMOS新风系统品牌与空间设计', '品牌设计、VI设计、空间设计', '', '品牌设计、VI设计、空间设计', '', 1, 0, 0, 0, 1, 0, 0, 1, 0, '', '2020-05-12 15:31:08', '2020-07-11 02:45:11', '', '', '', '', '', '', ''),
(266, 6, 140, '刚柔并济系列', '', '干仓枣香 · 珍藏贡眉', '', '', '/uploadfile/images/other/wwwwww_18.gif', '金丝燕家居', '金丝燕品牌策略设计', '品牌策略、品牌命名、品牌设计、VI设计', '', '品牌策略、品牌命名、品牌设计、VI设计', '', 1, 0, 0, 0, 1, 0, 0, 1, 0, '', '2020-05-12 15:31:08', '2020-07-11 02:45:21', '', '', '', '', '', '', ''),
(1398, 9, 183, '一体化模式', NULL, '优质原料', '', '', '/uploadfile/images/other/product1.png', '', '', '', NULL, '', '<p style=\"margin-left:0px;text-align:justify;\">在此，江洲镇防汛抗旱指挥部呼吁，江洲在外的18至60周岁之间的父老乡亲们迅速回赴江洲共抗洪魔，一同保护我们的亲人朋友、保卫我们的美丽家园。只有你我万众一心、众志成城，才是江洲大堤岿然不倒的保障，也是一代代江洲人民生生不息、不断强大的法宝。</p><p style=\"margin-left:0px;text-align:justify;\">新华网早前报道提到，江洲镇是一个经江水冲击形成的江心岛镇，四面被江水包围，住着4万多居民。由于地理位置特殊，江洲镇在历史上曾多次遭遇洪涝灾害。在许多江洲镇人的记忆中，每逢汛期来临，家家户户都要派人上堤巡险。</p><p style=\"margin-left:0px;text-align:justify;\">“在江洲大堤上，每隔200米就有一座防汛哨所，确保出现险情能够第一时间处置。”柴桑区应急管理局局长刘玉南说，如此严密的防汛体系需要大量人力支撑，每当人手紧张的时候，不少在外务工的年轻人都会主动回乡，义务投身抗洪抢险，这已经成为江洲镇的传统。</p><p style=\"margin-left:0px;text-align:justify;\">公开新闻报道显示，由于江洲防汛人手告急，已有不少在外游子应召而回共护家乡。</p><p style=\"margin-left:0px;text-align:justify;\">另外在7月10日下午，九江市防指下发《关于全市党政机关取消双休日休假的通知》，从即日起，全市党政机关取消双休日休假，恢复正常休假时间将另行通知。</p><p style=\"margin-left:0px;text-align:justify;\">消息称，7月10日13时，长江水利委员会水文局升级发布鄱阳湖湖口附近江段、鄱阳湖湖区洪水红色预警。当前，长江九江段、鄱阳湖、修河等流域发生超警戒洪水，河道水位仍在持续上涨，汛情形势异常严峻，防洪抢险任务十分艰巨，九江市防指于7月10日12时30分启动防汛应急Ⅰ级响应。市防指要求全市党政机关干部要在迎战洪涝灾害中做表率、勇担当，坚决扛起政治责任，彰显责任担当，全力以赴做好全市防汛抗洪抢险救灾各项工作，确保人民群众生命财产安全。</p><figure class=\"image\"><img src=\"/uploadfile/images/other/bds3.jpg\"></figure>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-18 22:31:27', '2020-07-11 16:08:13', '', '', '', '', '', '', ''),
(1399, 9, 183, '一体化模式', NULL, '标准制作', '', '', '/uploadfile/images/other/product2.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-18 22:31:27', '2020-07-10 14:38:12', '', '', '', '', '', '', ''),
(1400, 9, 183, '一体化模式', NULL, '精美包装', '', '', '/uploadfile/images/other/product3.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-18 22:31:27', '2020-07-10 14:38:37', '', '', '', '', '', '', ''),
(1401, 9, 184, '茶山图', NULL, '白大师-地势', '茶山均海拔在700米，高山云雾常年润泽。', '', '/uploadfile/images/other/teahill.png', '', '', '', NULL, '', '<p><span style=\"background-color:rgb(255,255,255);color:rgb(95,96,97);\">包装设计要先做对，再做好，</span></p><figure class=\"image\"><img src=\"/uploadfile/images/logo/cb00a2cb-0dad-41a6-8353-c200ab4ffd95_shortcuticon_hlf.jpg\"></figure><p><br><span style=\"background-color:rgb(255,255,255);color:rgb(95,96,97);\">美观仅仅是基础，</span><br><span style=\"background-color:rgb(255,255,255);color:rgb(95,96,97);\">要把包装设计当成广告设计,不仅是产品广告，</span><br><span style=\"background-color:rgb(255,255,255);color:rgb(95,96,97);\">也是品牌广告，为品牌积累品牌资产。</span></p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-18 22:51:24', '2020-07-10 15:22:02', '', '', '', '', '', '', ''),
(1405, 9, 191, '一等芽尖', NULL, '白毫银针', '芽头肥壮，头轮采摘时还带有“鱼叶”，芽头饱满重实，品质最优。', '', '/uploadfile/images/other/ydyj01.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-19 08:20:39', '2020-07-11 03:18:13', '', '', '', '', '', '', ''),
(1406, 9, 191, '一等芽尖', NULL, '白牡丹', '必须早采、嫩采；一芽一叶/一芽二叶，只选初展的细嫩芽叶。', '', '/uploadfile/images/other/ydyj02.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-19 08:20:39', '2020-07-11 03:18:52', '', '', '', '', '', '', ''),
(1407, 9, 191, '一等芽尖', NULL, '寿眉', '只有嫩芽才符合规格，选取一芽二叶。', '', '/uploadfile/images/other/ydyj03.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-19 08:20:39', '2020-07-11 03:19:20', '', '', '', '', '', '', ''),
(1408, 9, 190, '传承技艺', NULL, '一筛即成型，摊叶均匀。', '芽头肥壮，头轮采摘时还带有“鱼叶”，芽头饱满重实，品质最优。', '', '/uploadfile/images/other/ccjy01.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-19 08:20:39', '2020-07-11 03:21:35', '', '', '', '', '', '', ''),
(1409, 9, 190, '传承技艺', NULL, '坚守传统，日光萎凋。', '必须早采、嫩采；一芽一叶/一芽二叶，只选初展的细嫩芽叶。', '', '/uploadfile/images/other/ccjy02.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-19 08:20:39', '2020-07-11 03:22:26', '', '', '', '', '', '', ''),
(1410, 9, 190, '传承技艺', NULL, '不炒不揉，拣剔精华。', '只有嫩芽才符合规格，选取一芽二叶。', '', '/uploadfile/images/other/ccjy03.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-19 08:20:39', '2020-07-11 03:23:07', '', '', '', '', '', '', ''),
(1411, 9, 190, '传承技艺', NULL, '烘焙出香,稳定品质香。', '只有嫩芽才符合规格，选取一芽二叶。', '', '/uploadfile/images/other/ccjy04.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-19 08:20:39', '2020-07-11 03:23:43', '', '', '', '', '', '', ''),
(1412, 9, 189, '白茶基地', NULL, '白大师-地势', '茶山均海拔在700米，高山云雾常年润泽。', '', '/uploadfile/images/other/bcjd01.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-19 08:20:39', '2020-07-11 03:25:35', '', '', '', '', '', '', ''),
(1413, 9, 189, '白茶基地', NULL, '白大师-生态', '生态森林茶园，为茶树生长带来稳定的生态条件及鲜爽空气。', '', '/uploadfile/images/other/bcjd02.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-19 08:20:39', '2020-07-11 03:26:11', '', '', '', '', '', '', ''),
(1431, 7, 177, '底部导航栏', NULL, '经销商加盟', '', '', '', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-22 08:03:52', '2020-07-17 09:43:06', '', '', '', '', '', '011000010101', ''),
(1432, 7, 177, '底部导航栏', NULL, '查询门店', '', '', '', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-27 05:10:27', '2020-07-17 10:09:09', '', '', '', '', '', '111000010100', ''),
(1433, 7, 177, '底部导航栏', NULL, '网站地图', '', '', '', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-27 05:11:01', '2020-07-17 10:09:42', '', '', '', '', '', '110000010100', ''),
(1434, 7, 177, '底部导航栏', NULL, '隐私声明', '', '', '', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-27 05:11:36', '2020-07-10 15:50:06', '', '', '', '', '', '', ''),
(1435, 7, 177, '底部导航栏', NULL, '建议与反馈', '', '', '', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-27 05:12:01', '2020-07-10 15:50:40', '', '', '', '', '', '', ''),
(1436, 7, 177, '底部导航栏', NULL, '人才招聘', '', '', '', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-27 05:12:36', '2020-07-10 15:51:30', '', '', '', '', '', '', ''),
(1437, 7, 177, '底部导航栏', NULL, '联系我们', '', '', '', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-05-27 05:13:07', '2020-07-10 15:51:52', '', '', '', '', '', '', ''),
(1439, 7, 149, '更多合作', NULL, '官方微信', '', '', '/uploadfile/images/package/wx.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-09 16:15:06', '2020-07-17 07:11:39', '', '', '', '', '/uploadfile/images/other/erweima.jpg', '011000010101', ''),
(1441, 9, 189, '白茶基地', NULL, '白大师-产区', '福鼎清朝咸丰年间 2000余亩核心产区茶园', '', '/uploadfile/images/other/bcjd03.png', '', '', '', NULL, '', '', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-11 03:26:21', '2020-07-11 03:26:50', '', '', '', '', '', '', ''),
(1442, 11, 154, '政策及支持', NULL, '燕语茶业勇担社会责任 安全复工保障茶农茶商收益', '', '', '/uploadfile/images/infopic/bds01.jpg', '', '', '', NULL, '2020年，是危与机并存的一年。所有产业在疫情的席卷下被迫打乱了节奏，茶行业同样被卷其中。时下，正值春茶季，云南作为茶叶生产大省，压力与挑战并存。受疫情的影响，整个云南省茶产业在春茶上市期间，上游的茶农、中游的茶企、下游的茶商都受到一定程度的波及。', '<p style=\"margin-left:0px;\">2020年，是危与机并存的一年。所有产业在疫情的席卷下被迫打乱了节奏，<a href=\"http://www.zgchawang.com/\"><strong>茶</strong></a>行业同样被卷其中。</p><p style=\"margin-left:0px;\">时下，正值春茶季，云南作为<a href=\"http://www.zgchawang.com/\"><strong>茶叶</strong></a>生产大省，压力与挑战并存。受疫情的影响，整个云南省茶产业在春茶上市期间，上游的茶农、中游的茶企、下游的茶商都受到一定程度的波及。</p><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image\"><img src=\"http://service.mobtou.com/data/images/200401/200401172835626913529.jpeg\" alt=\"\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\"><strong>山头春茶采摘延迟</strong></p><p style=\"margin-left:0px;\">据悉，受干旱的影响，今年云南各大茶山春茶生长速度放缓，开采周期相较往年总体延后了15天左右。“我们这的古树茶已经可以采摘了，营盘茶每年都是按时发芽，今年大批量开采也要延后1星期左右。”云南临沧彭家大茶地营盘村村长李小红介绍道。</p><figure class=\"image\"><img src=\"/uploadfile/images/infopic/bds03.jpg\"></figure><p style=\"margin-left:0px;\">营盘是当年彭锟主政双江时（1904-1928年）大力推广云南大叶种茶种植，遗留下来的近百个村寨的古茶园、老茶园之一。李小红还进一步向记者透露，因为彭家大茶地已经和广州市燕语食品有限公司签约，所以不担心茶叶滞销，营盘古树茶曾获2016中国（广州）国际茶叶博览会全国名优茶质量竞赛最高奖项“特等金奖”，品质出众，头春茶受众多茶友期待。</p><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image\"><img src=\"http://service.mobtou.com/data/images/200401/2004011728351272637380.jpeg\" alt=\"\"></figure><p style=\"margin-left:0px;\"><strong>产业各环节受阻，政府全面助力企业发展</strong></p><p style=\"margin-left:0px;\">相关数据显示，2月10号左右延期开工的企业约占80%，同时云南省茶叶流通协会驻会副会长徐亚和表示：“临沧、普洱、西双版纳、保山等地是<a href=\"http://www.zgchawang.com/zt/puercha/\"><strong>普洱茶</strong></a>的主要产区，原本在2月即可进入春茶采摘季，但受疫情影响，目前采摘团队组建整体困难。”整个生产端浮现出“用工荒”的难题。</p><p style=\"margin-left:0px;\">据悉，茶馆、茶空间、茶叶门店大量暂停营业，春节期间至今几乎无客人进店消费品鉴，2月至3月业绩下滑严重。广州市燕语食品有限公司创始人丛海燕女士受访时说：“作为一家全产业链产品公司，每天的支出都是巨大的，因为疫情，从源头茶山到终端销售都受到了一定影响。”茶农担心用人招工、原料销售问题，同时大部分茶企也在担心茶叶预售、上山收茶、茶叶市场开市等。</p><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image\"><img src=\"http://service.mobtou.com/data/images/200401/200401172835729798998.jpeg\" alt=\"\"></figure><p style=\"margin-left:0px;\">面对严峻形势，云南省委省政府及各地方政府竭力出台应对措施，企图带领企业、经销商、茶农、茶商全面复产复工，度过“短期寒冬”。其中，临沧市政府便公布《临沧市市场监督管理局关于疫情防控期间开展复工复产十项服务的通告》，临沧市政协常委、市市场监督管理局局长李彪为，带领班子成员研究推出的一系列可行举措，切实帮助企业解困、减负减压，保障复工人员到岗。</p><p style=\"margin-left:0px;\"><strong>企业积极展开行动，做好防护复工复产</strong></p><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\">一边各级政府给予企业大力帮助，一边企业也展开“自救”举措，全面做好防护措施复工复产。</p><p style=\"margin-left:0px;\">“我们是临沧市第一批复工复产的企业，今年在临沧的工厂也新增了1500平方米，全面扩大生产及仓储面积，提升产能。”根据市场调研发现，燕语茶业不仅在源头生产端帮助大家复工复产，其位于广州的燕语茶馆、经销商等也已正常营业，并在不断探索和尝试通过线上直播、小程序、社群等方式提升销量，力求在终端零售上也为茶农解决春茶滞后销售等问题，扛起茶农增收的重任。</p><p style=\"margin-left:0px;\">&nbsp;</p><figure class=\"image\"><img src=\"http://service.mobtou.com/data/images/200401/200401172835977651912.jpeg\" alt=\"\"></figure><p style=\"margin-left:0px;\">许多企业负责人也反馈道，现阶段市场线下不景气，正是企业修炼内功、向线上营销进攻的关键时刻。中国<a href=\"http://www.zgchawang.com/culture/\"><strong>茶文化</strong></a>产业委员会秘书长王如良表示：“疫情不会改变茶叶总消费需求持续增长态势，其影响主要体现在消费场景改变与消费产品结构调整方面。”茶行业长久以来都是门店体验模式，线上模式缺乏体验与品尝，对成交量会带来了一定的影响，但是传统的销售模式对年轻消费者的吸引力是有限的，直播或许是传统茶行业突围的一个机会。</p><p style=\"margin-left:0px;\">现如今，国内疫情防控效果显著，为全面打好这场“春茶营收战”，在大家的共同努力下，全国各地的茶企复工复产也在逐步有序进行中，上中下游各端均在为确保茶行业的平稳健康运行贡献自己的力量。全国的茶企业、经销商、个体都在拧成一股绳，一手抓紧防控疫情，一手抓好经济运行，妥善应对疫情的短期冲击，确保实现业绩目标，承担企业责任，推动行业发展。</p><p style=\"margin-left:0px;\">广州市燕语食品有限公司成立于 2012 年，是食尚国味集团旗下品牌，是集源头茶山基地、茶叶初制及精加工、产品研发设计、市场营销、品牌建设于一体的全产业链产品公司。目前，冰岛茶园、营盘茶园的头春茶均已开采，燕语茶业对土壤和茶叶进行双重检的同时，更增加了紫外设备，对仓库的茶叶进行定期消毒，全力做好春茶生产保障、预售的工作。期待春暖花开时节，我们一起把茶言欢。</p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:04:00', '2020-07-16 16:25:37', '', '', '', '', '', '', ''),
(1443, 11, 154, '政策及支持', NULL, '粤鄂合作，华巨臣助力湖北茶叶大湾区营销基地落户深圳', '', '', '/uploadfile/images/infopic/0a33ab80-2d50-4380-afa5-9f34127f957d_2.jpg', '', '', '', NULL, '4月1日，“粤鄂同心，抗疫发展”六大行动、十五项工作正式启动，会议通过同步视频连线的形式在北京、武汉、广州三地举行。广东湖北两省签订多项协议，内容涵盖现代农业领域合作、三农宣传合作、农产品采购等。', '<p>4月1日，“粤鄂同心，抗疫发展”六大行动、十五项工作正式启动，会议通过同步视频连线的形式在北京、武汉、广州三地举行。广东湖北两省签订多项协议，内容涵盖现代农业领域合作、三农宣传合作、农产品采购等。</p><p>&nbsp;</p><p>中央指导组物资保障组组长、工业和信息化部副部长王江平，农业农村部副部长于康震，广东省委常委叶贞琴，湖北省副省长万勇出席活动，深圳市华巨臣实业有限公司副总经理方得顺作为华巨臣集团代表出席仪式并签约。</p><p>&nbsp;</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://www.nhj.com.cn/file/upload/202004/03/140057291.jpg\" alt=\"\"></figure><p>叶贞琴常委（中）为粤鄂合作湖北<a href=\"http://www.zgchawang.com/\"><strong>茶叶</strong></a>大湾区（深圳）营销基地授牌；<br>深圳市华巨臣实业有限公司副总经理方得顺（右一）</p><p>&nbsp;</p><p>签约仪式上，广东省农业农村厅与湖北省农业农村厅签订《“粤鄂同心抗疫发展”六大行动、十五项工作协议》，其中<strong>深圳市华巨臣实业集团与湖北省</strong><a href=\"http://www.zgchawang.com/\"><strong>茶</strong></a><strong>业集团股份有限公司签订湖北茶叶产销对接合作协议。</strong></p><p>&nbsp;</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://www.nhj.com.cn/file/upload/202004/03/140113221.jpg\" alt=\"\"></figure><p>在六大行动、十五项工作中，华巨臣将负责筹备建立<strong>大湾区采购商湖北网络会客室</strong>（茶叶板块）以及<strong>粤鄂合作湖北茶叶大湾区(深圳）营销基地</strong>的工作，助力湖北茶叶产销对接，品牌推广。</p><p>&nbsp;</p><p><strong>粤鄂同心 推动湖北茶产销对接</strong></p><p>&nbsp;</p><p>湖北是全国重要的<a href=\"http://lvcha.zgchawang.com/\"><strong>绿茶</strong></a>、<a href=\"http://red.zgchawang.com/\"><strong>红茶</strong></a>和青砖茶产区，此次疫情对湖北春茶的采摘加工、销售、流通和出口等都造成一定影响。新冠肺炎疫情发生以来，华巨臣始终关注湖北春茶产销形势，心系湖北茶产业的发展，全力支援湖北茶叶产销困境，助力湖北茶产业发展。</p><p>&nbsp;</p><p>华巨臣将在广东省农业农村厅、湖北省农业农村厅的指导下，从宣传推广、流通销售等方面加大支持力度，为湖北茶产业高质量发展贡献力量。</p><p>&nbsp;</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://www.nhj.com.cn/file/upload/202004/03/140130781.jpg\" alt=\"\"></figure><p><br><br>&nbsp;</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://www.nhj.com.cn/file/upload/202004/03/140149541.jpg\" alt=\"\"></figure><p>（2019年湖北名优茶推介会在深圳<a href=\"http://www.zgchawang.com/exhibit/\"><strong>茶博会</strong></a>上举办）</p><p>&nbsp;</p><p>近年来，华巨臣始终秉承“品牌化、市场化、专业化、国际化”的发展理念，着力推动中国茶产业发展，推广优秀<a href=\"http://www.zgchawang.com/invest/\"><strong>茶叶品牌</strong></a>，助推农户增收致富。</p><p>&nbsp;</p><p>未来，华巨臣也将继续履行企业责任，借助华巨臣覆盖全产业链的茶行业百万数据库、茶叶全产业链资源体系，推动湖北名茶发展，助力“鄂茶”的腾飞！</p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:06:30', '2020-07-16 16:12:13', '', '', '', '', '', '', ''),
(1444, 11, 154, '政策及支持', NULL, '福鼎白茶线上销售“井喷”，高潜力白茶品类将成为天猫今年发力重点', '', '', '/uploadfile/images/infopic/bds02.jpg', '', '', '', NULL, '今年春天受疫情影响，全国各地的春茶市场面临巨大的冲击，都受到产量、销量上的挑战，为进一步拓展福鼎白茶的销售方式的多元化创新', '<p style=\"margin-left:0px;\">今年春天受疫情影响，全国各地的春<a href=\"http://www.zgchawang.com/\"><strong>茶</strong></a>市场面临巨大的冲击，都受到产量、销量上的挑战，为进一步拓展福鼎<a href=\"http://white.zgchawang.com/\"><strong>白茶</strong></a>的销售方式的多元化创新，拓宽销售渠道，帮助茶农解决产销难题，让福鼎白茶在全国打响名气，3月29日福鼎市政府举办了第九届福鼎白茶开茶节，本次活动不仅延续了往年的开茶节形式，向世界展示福建特色的白<a href=\"http://www.zgchawang.com/culture/\"><strong>茶文化</strong></a>，还创新性的与线上知名电商阿里巴巴集团建立了深度合作关系，通过其天猫、淘宝、聚划算等全网、全平台渠道资源，大力提高了福鼎白茶的知名度、美誉度和市场占有率，推动茶产业高速平稳发展。</p><p style=\"margin-left:0px;\">　　<strong>天猫携手福鼎开茶节打造正宗原产地金名片</strong></p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://img.danews.cc/upload/doc/20200409/1586413362837853.jpeg\" alt=\"1.jpeg\"></figure><p style=\"margin-left:0px;\">　　第九届福鼎白茶开茶节在福鼎市点头镇大坪村隆重举行，出席开幕式仪式的嘉宾有福建省政协原副主席、海峡两岸茶业交流协会会长陈绍军，中国国际茶文化研究会常务副会长、杭州市原市长孙忠焕，中国工程院院士刘仲华教授，阿里巴巴战略发展部福建总经理郑良西等300多人。</p><p style=\"margin-left:0px;\">　　<strong>原产地认证，为您奉上“正宗”好茶</strong></p><p style=\"margin-left:0px;\">　　开幕式上，天猫授予福鼎“正宗原产地”称号。本次正宗原产地选择福鼎也是标志福鼎原产地和天猫共同联手，为福鼎茶企茶商拓宽销售资源，传递福鼎“正宗”好茶。天猫发起的“正宗原产地”项目，立足产品和产地特色，利用S2B2C模式联合全国各大优质原产地政府、商家共同致力于农产品标准化建设，通过建设标准化流水线、标准化农产品规格，从而完善供应链体系，让原产地农产品走出去，带动原产地产业带升级的同时，成为连接优质产地、产品与城市消费者的桥梁，提升消费者的购物体验，把最为正宗、新鲜的时令农产品送到消费者手中。</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://img.danews.cc/upload/doc/20200409/1586413393601818.jpeg\" alt=\"2.jpeg\"></figure><p style=\"margin-left:0px;text-align:center;\">　　阿里巴巴战略发展部福建总经理郑良西颁发“正宗原产地”授牌，福鼎市人民政府副市长肖剑华接牌</p><p style=\"margin-left:0px;\">　　<strong>福鼎白茶山河图还原产地风貌，重塑公共品牌认知</strong></p><p style=\"margin-left:0px;\">　　天猫春茶山河行活动，是天猫“正宗原产地”项目在今年春季针对全国十大春茶正宗原产地发起的一项活动，活动包括：十城春茶节接力、十幅春茶山河图揭晓、十城春茶匠评选、十城原产地溯源。</p><p style=\"margin-left:0px;\">　　春茶山河图长卷绘画了十大原产地山河的磅礴之势，带消费者走一趟自西向东的<a href=\"http://www.zgchawang.com/\"><strong>茶叶</strong></a>采摘之旅，十大天猫春茶正宗原产地，此前已经过宜宾早茶、峨眉山茶、蒙顶山茶、西湖龙井、安吉白茶、<a href=\"http://www.zgchawang.com/special/mc/biluochun/\"><strong>碧螺春</strong></a>。</p><p style=\"margin-left:0px;\">　　天猫春茶山河行第六站来到了福鼎，结合福鼎白茶正宗原产地风貌绘制出了一幅“福鼎白茶山河图”，并在开幕式当天进行了现场揭幕。福鼎白茶山河图画卷以福鼎，太姥山，翠郊古民居，嵛山岛，太姥娘娘煮茶治疗瘟疫的传说故事等元素结合，绘制而出福鼎白茶原产地山河风貌，展现福鼎白茶初盛时茶山漫山遍野的葱茏景象。通过年轻趣味化的漫画形式呈现福鼎白茶产地风貌，寓意好山、好水、出正宗福鼎好茶，加大福鼎白茶在年轻受众群里中的品牌形象，真正重塑福鼎白茶公共品牌认知，带动商家品牌的沉淀，更进一步凸显出这一活动的品牌属性和营销潜力。</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://img.danews.cc/upload/doc/20200409/1586413428142904.jpeg\" alt=\"3.jpeg\"></figure><p style=\"margin-left:0px;text-align:center;\">　　中共福鼎市委副书记李成双、阿里巴巴战略发展部福建总经理郑良西总经理</p><p style=\"margin-left:0px;text-align:center;\">　　共同揭开“天猫春茶山河行-福鼎白茶山河图”</p><p style=\"margin-left:0px;\">　　<strong>阿里巴巴助力福鼎白茶线上义卖</strong></p><p style=\"margin-left:0px;\">　　在当天开茶节现场中，还出现暖心的一幕，品品香、天湖、广福、六妙、鼎白、誉达、瑞达、合熹堂、大沁、畲依茗、中镇、顺茗道、董德13家福鼎茶企各捐赠1000份茶饼，原价300元/饼，义卖价100元/饼，通过手机淘宝进行线上义卖，并现场实时播报售卖情况，不到1小时的时间，13家茶企捐赠茶饼均已售罄，所得义卖货款130万元全部捐赠于武汉抗疫一线医务人员，阿里助力福鼎政府通过线上义卖这样的公益活动为医护工作人员送出一片心意，更是13家茶企负责人作为企业家的担当，乐于奉献的生动体现。</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://img.danews.cc/upload/doc/20200409/1586413458191689.jpeg\" alt=\"4.jpeg\"></figure><p style=\"margin-left:0px;text-align:center;\">　　品品香、天湖、广福等13家爱心茶企负责人共同捐赠义卖款项</p><p style=\"margin-left:0px;\">　　<strong>匠人代表林振传传递白茶品牌匠心品质</strong></p><p style=\"margin-left:0px;\">　　“天猫春茶十大匠人”是原产地传承茶文化的代表。通过评选各地选竖代表，将匠人匠心和正宗原产地相联结，以淘宝直播、原产地溯源直播等创新形式凸显原产地茶文化、品鉴大师茶标准。福鼎树立了以本地春茶匠人林振传为代表的行业标杆，让福鼎白茶的品牌进一步远播。林振传表示，今年线下的销售遇到了一点困难，但我们逐步加大了网络线上销售的力度，以今年一季度为例，品品香线上销售额比去年同期相比翻番，作为最早一批拥抱线上销售的商家，我们尝到了甜头，也应该拿出更多的好产品来回馈社会。</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://img.danews.cc/upload/doc/20200409/1586413498517312.jpeg\" alt=\"5.jpeg\"></figure><p style=\"margin-left:0px;text-align:center;\">　　阿里巴巴战略发展部福建总经理郑良西总经理授牌，品品香茶叶集团董事长林振传接牌</p><p style=\"margin-left:0px;\">　　<strong>高峰论坛引领茶产业走近新风口</strong></p><p style=\"margin-left:0px;\">　　同日下午，以“福鼎白茶健康产业X互联网”为主题的福鼎白茶高峰论坛在福鼎举行，共同探讨福鼎白茶的<a href=\"http://www.zgchawang.com/knowledge/list/46/\"><strong>养生</strong></a>之道和营销之路，推动茶企在天猫建立福鼎白茶旗舰店，实现线上与线下融合促销。</p><p style=\"margin-left:0px;\">　　阿里巴巴集团乡村事业部福建总监叶明淯表示，这次正宗原产地选择来到福鼎的目的，是让福鼎白茶没有难做的生意，让天下人喝健康的福鼎白茶。在2019年双11的成交数据中，80、90、00后的消费者占比已经超过83%，通过数据发现主流的消费群体正在年轻化，消费的习惯正在改变，用户的需求正在变化。在茶品类数据增长趋势中，增长最高的是白茶品类，说明福鼎白茶已经到了品牌红利期，在红利期中更应该抓住年轻群体的消费习性，进行产业升级的沉淀品牌传播。本次借助天猫正宗原产地，聚划算等渠道，进行原产地IP打造，淘宝直播互动等更加年轻，更加提高货品转化的形式，共创原产地大事件对话更多的消费者，共同打造福鼎白茶成为福建最据含金量的宣传名片。</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://img.danews.cc/upload/doc/20200409/1586413518147877.jpeg\" alt=\"6.jpeg\"></figure><p style=\"margin-left:0px;text-align:center;\">　　阿里巴巴集团乡村事业部福建总监叶明淯</p><p style=\"margin-left:0px;\">　　天猫还通过#春茶山河行#微博话题，在线上针对福鼎白茶上新进行了亮点传播，话题总曝光1.3亿次，广大网友积极参与到该话题的讨论互动中，福鼎<a href=\"http://www.zgchawang.com/brand/list/444/\"><strong>白茶品牌</strong></a>进一步深入人心。</p>', 1, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:12:46', '2020-07-16 16:29:58', '', '', '', '', '', '', ''),
(1445, 11, 154, '政策及支持', NULL, '9.2万网友齐聚龙润茶抖音春茶季直播秀，“云”赏春色，“云”品好茶', '', '', '/uploadfile/images/infopic/112c84d7-2e5d-4736-a67a-28fe1cc25e34_4.jpg', '', '', '', NULL, '2020年4月9日，“云赏春茶，共品春色——龙润茶2020年春茶季直播专场”在云南千年茶乡昌宁正式开播!春茶上市，新品来袭，趁着大好时光龙润茶大茗星邀全国各地的茶友们探名山、访大师、采春茶、品佳茗，9.2万网友直播间“云”品茶、品云茶!', '<p style=\"margin-left:0px;\">2020年4月9日，“云赏春<a href=\"http://www.zgchawang.com/\"><strong>茶</strong></a>，共品春色——龙润茶2020年春茶季直播专场”在云南千年茶乡昌宁正式开播!春茶上市，新品来袭，趁着大好时光龙润茶大茗星邀全国各地的茶友们探名山、访大师、采春茶、品佳茗，9.2万网友直播间“云”品茶、品云茶!</p><figure class=\"image image_resized\" style=\"width:500px;\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200410/301-200410092339A7.jpg\" alt=\"\"></figure><p style=\"margin-left:0px;text-align:center;\"><br>&nbsp;</p><p style=\"margin-left:0px;text-align:center;\"><strong>　　采春茶，黄家寨古树茶开采仪式</strong></p><p style=\"margin-left:0px;\">　　每年清明节的前后，正是春茶上市的旺季，也是茶农忙碌一年收成的关键期。清晨，主播们来到龙润物联网茶园，茶园生机勃勃，新芽吐露芬芳，正是采茶制茶的大好时机。与茶相约，不负韶华，直播间的朋友们随着主播一起采摘绿芽春尖，探秘隐藏在深山里的神秘古茶园。</p><figure class=\"image image_resized\" style=\"width:500px;\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200410/301-20041009243Y42.jpg\" alt=\"\"></figure><p style=\"margin-left:0px;text-align:center;\"><br>&nbsp;</p><figure class=\"image image_resized\" style=\"width:500px;\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200410/301-200410092K5431.jpg\" alt=\"\"></figure><p style=\"margin-left:0px;\">　　现场，大家期待的“龙润茶黄家寨古树茶开采仪式”正式举行，云南龙润茶业集团副总裁赵映旭、副总裁兼品牌总监张福祖与昌宁县古茶树保护与开发协会副会长、昌宁龙润茶业有限公司总经理罗加荣，共同参与出席开采仪式，引来直播间数万人观看。身着民族服装的茶农利索的爬上古茶树上采摘，龙润茶鲜叶技术人员现场对新采的鲜叶进行质量把关和指导，携手合作，共享好茶。</p><p style=\"margin-left:0px;\">　　昌宁，素有“千年茶乡”的美誉，位于北纬24°世界著名的“黄金茶线”上，是世界公认的大叶种茶树原产地。黄家寨位于昌宁漭水镇，平均海拔1780米，年平均气温16.9℃，年平均降水量1463毫米，土壤类型为典型的弱酸性红壤、黄壤，多样的气候及土壤条件适宜茶树生长。黄家寨保存有大量的古树茶群，总面积达33公顷，涉及4个村民小组，177户茶农，古茶树4523株。</p><p style=\"margin-left:0px;text-align:center;\"><strong>　　制好茶，传承大师技艺匠心制茶</strong></p><p style=\"margin-left:0px;\">　　茶园里，主播们在徐文军、于从武和袁应祥三位制茶大师的指导下，学习如何采摘鲜叶，并通过直播传播“三采、三不采”的科学方法。随后，来到初制所体验炒茶、揉捻、摊凉等工艺。鲜叶在大师和主播们的双手中被唤醒，褪去了青草气，散发出迷人茶香，形成<a href=\"http://www.zgchawang.com/zt/puercha/\"><strong>普洱茶</strong></a>的色、香、味等品质特征。现场主播们分享着采茶、制茶的乐趣，直播传递制茶知识，同时也感叹一片<a href=\"http://www.zgchawang.com/\"><strong>茶叶</strong></a>的来之不易。龙润茶饱含了茶农、制茶人的艰辛与用心。</p><figure class=\"image image_resized\" style=\"width:500px;\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200410/301-200410092Z6294.jpg\" alt=\"\"></figure><p style=\"margin-left:0px;\">　　在昌宁直播，除了茶山茶园，必须要去龙润昌宁茶厂。主播们介绍到昌宁茶厂，始创于1958年，是中国茶业版图上高高耸立的一座丰碑，曾获得过周恩来总理签名奖状。这里饱含了三代制茶人的匠心技艺、人文情怀。茶厂里“四合院”风格的水冬瓜木茶仓，木质细腻、坚硬，天生防腐、防虫，与茶树相生相济，六十多年来，成为普洱茶的仓储圣地，15年陈、10年陈、5年陈的普洱茶在茶仓里自由呼吸，散发着醇醇茶香。</p><figure class=\"image image_resized\" style=\"width:500px;\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200410/301-200410093205394.jpg\" alt=\"\"></figure><p style=\"margin-left:0px;\">　　主播们穿戴好清洁的工作衣帽、鞋套、手套和口罩，经过严格的清洁和消毒程序后，跟随着制茶大师进入茶厂生产车间，学习了茶饼压制和包装环节，亲身感受龙润茶“用制药的经验制茶”的严谨。</p><figure class=\"image image_resized\" style=\"width:500px;\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200410/301-200410093136112.jpg\" alt=\"\"></figure><p style=\"margin-left:0px;text-align:center;\"><br>&nbsp;</p><p style=\"margin-left:0px;text-align:center;\"><strong>　　品佳茗，龙润茶“移动营销”显成效</strong></p><p style=\"margin-left:0px;\">　　品茗畅聊，主播们邀请到云南龙润茶业集团副总裁赵映旭、副总裁兼品牌总监张福祖，以及龙润茶制茶大师们共同品鉴了大师茶、8425、昌宁号等佳茗，并邀请到第一代制茶大师杨寿祥讲述昌宁茶厂的历史。现场还不断与龙润茶加盟商、门店进行连麦互动，与网友一起“云”观茶厂、“云”品佳茗、“云”端对话。赵映旭副总裁分享了2020春茶市场情况及疫情对茶山的影响;张福祖副总裁讲解了龙润茶新产品生产计划及2020龙润茶品牌战略规划，为市场增强信心。</p><figure class=\"image image_resized\" style=\"width:487px;\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200410/301-20041009324Oa.jpg\" alt=\"\"></figure><p style=\"margin-left:0px;\">　　此次，龙润茶2020年春茶季直播秀即是带货传播也品牌传播，是龙润茶“移动营销”战略的重要一步。2019年我国在线直播用户达5.04亿，2020年预计到5.26亿，直播销售规模9160亿元，可以说，“直播带货”这一模式有着万亿元的市场，电商直播成为新的风口。龙润茶顺应时局抢占先机，以“央视广告统领+短视频招商引流+平台直播带货”同步打造品牌，并与淘宝、抖音、快手等平台网红、达人合作，进一步推进线上品牌推广、产品销售、招商代理的开展，全面推进移动营销!</p><figure class=\"image image_resized\" style=\"width:447px;\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200410/301-20041009301S04.jpg\" alt=\"\"></figure><p style=\"margin-left:0px;\">　　疫情难阻春茶香，龙润“云”茶香万里。今天龙润茶抖音与淘宝茶山茶厂直播首秀，赢得了网友们的广泛好评，利用网络平台优势，有效拓展了销售市场。实乃一场“视、听、味”的饕餮盛宴，让茶人们通过直播足不出户就能饱览茶山美景，为茶农们带来信心与希望，为消费者带去好茶，也为茶产业开启转型升级之路。</p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:20:41', '2020-07-16 16:22:01', '', '', '', '', '', '', ''),
(1446, 11, 154, '政策及支持', NULL, '打造北方绿茶产区金名片，天猫助信阳毛尖破解滞销难题', '', '', '/uploadfile/images/infopic/ee5f313a-7090-4eb7-b800-bbfec234676b_5.jpg', '', '', '', NULL, '作为绿茶中典型的代表，信阳毛尖从唐代就已经闻名全国。随着时间推移，信阳毛尖在茶叶中的地位也在一步步攀升和巩固。然而，已然是河南一张响亮招牌的信阳毛尖，今年春天，因受新冠肺炎疫情影响，线下滞销十分严重。', '<p>作为<a href=\"http://lvcha.zgchawang.com/\"><strong>绿茶</strong></a>中典型的代表，<a href=\"http://www.zgchawang.com/special/mc/xinyangmaojian/\"><strong>信阳毛尖</strong></a>从唐代就已经闻名全国。随着时间推移，信阳毛尖在<a href=\"http://www.zgchawang.com/\"><strong>茶叶</strong></a>中的地位也在一步步攀升和巩固。然而，已然是河南一张响亮招牌的信阳毛尖，今年春天，因受新冠肺炎疫情影响，线下滞销十分严重。　　<br><br>&nbsp; &nbsp; &nbsp; 考虑到包括信阳毛尖在内的全国十大春<a href=\"http://www.zgchawang.com/\"><strong>茶</strong></a>原产地正遇到销量上的挑战，为帮助茶农解决春茶销售不畅难题，从2月份开始，天猫开始了为期3个月的春茶山河行活动，通过开展线上春茶季专题活动，打通正宗春茶互联网销路，帮助茶农走出困境。</p><p>作为天猫春茶山河行活动的收官站点，信阳毛尖春茶原产地通过天猫的原产地直播溯源以及相关话题打造，在全国消费者心中建立了心智。此外，通过打造「正宗原产地」结合「全球尝鲜季」双IP，天猫进一步扩大了信阳毛尖的原产地品牌知名度。天猫的这一系列动作，为信阳毛尖销量以及声量的双提升起到了重要作用。</p><p><strong>茶农触网，天猫助力信阳毛尖转“危”为“机”</strong></p><p>信阳毛尖作为国内十大名茶，被誉为“绿茶之王”，从唐代就已经全国知名。当年的“淮南茶区”，当时所产的茶叶就被列为贡品。随后到宋代、到元代、再到清代，信阳毛尖的历史地位都在一步步的攀升和巩固，至今已有2300多年的历史。</p><p>茶圣陆羽在《茶经》中称赞：“淮南茶，光州(今信阳)上。”宋代大文豪苏东坡也曾赞赏道：淮南茶，信阳第一。信阳毛尖以其形细美、其香鲜浓、其味醇甜、其韵甘苦的特点，自古以来就享誉全国。<br>公开资料显示，信阳市现有茶园210万亩，经济规模100多亿元。信阳春茶生产期集中在3月下旬到4月下旬之间，尤其是农历清明之前。茶农主要的收入60%以上来自于春茶。</p><p>然而，今年信阳毛尖春茶采摘期，受突发的新冠肺炎疫情影响，众多的外地客商无法在采茶季来到产区收购茶叶，这导致了较多倚重线下渠道销售的信阳毛尖滞销严重，这一度让信阳各个方面为春茶的销售感到焦虑。</p><p><strong>如何帮助信阳茶农在求新求变中化“危“为“机”?</strong></p><p>从今年2月开始，针对茶叶产业销量下滑的实际状况，天猫推出了“春茶山河行”专题活动。在横跨2、3、4月份这三个月时间内，天猫走访了包括信阳毛尖在内的全国十大春茶正宗原产地，通过与产地政府、特色商家、茶叶匠人携手，挖掘各大产地特色。</p><p>作为此次活动的收官站点，在为期3天的活动期间，信阳毛尖在线上得到了最大限度的曝光。通过天猫的一系列帮扶，信阳毛尖不仅探索了产地结构转型，更打通了正宗春茶互联网销路，走出了销售困境。</p><p>据悉，本次春茶活动期间，信阳毛尖的销量整体可观。在4月7日——11日的5天时间，相对去年同比增长大幅攀升，线上销售额同比增长了72%，茶叶的成交件数突破了26000件。</p><p><strong>探索直播新兴卖茶手段，天猫带消费者领略信阳茶山好风光</strong></p><p>天猫今年对信阳毛尖春茶的销售格外重视。在天猫早前发布的“天猫春茶山河行”图中，信阳毛尖压轴出场。</p><p>在绿茶的阵营里，信阳毛尖与西湖龙井、<a href=\"http://www.zgchawang.com/special/mc/biluochun/\"><strong>碧螺春</strong></a>一样位列中国十大名茶之列。不过，相对于大家更为熟知的江南产区绿茶，产于河南的信阳毛尖在消费者心中认知却不深。</p><p>如何将有着北方气候造就的独特香高持久和醇厚滋味的这杯信阳毛尖，在消费者心中留下更深印象?除了线上销售外，作为这一次天猫山河行活动的重要承载形式，直播被天猫赋予了向消费者推介信阳毛尖原产地好风光的重要作用。</p><p>在此次收官站点信阳毛尖站，为了让全国消费者更为了解产出了信阳毛尖的正宗原产地风貌，此次，天猫通过线下溯源直播的方式，带大家在直播间内看到了信阳当地优美的茶山地理风光。全国消费者也第一次透过直播镜头，领略到了信阳毛尖不同于江南绿茶产区的别样风光。</p><p>上个月28号，在信阳毛尖的开采仪式上，信阳市长尚朝阳亲自来到直播间带货，面向全国消费者推介信阳毛尖春茶。</p><figure class=\"image\"><img src=\"http://img.danews.cc/upload/doc/20200414/1586843479670719.jpg\" alt=\"图片1.jpg\"></figure><p>在机器制茶已成主流的当下，制茶工匠的层层把关依然有着独特的重要作用。作为此次天猫春茶山河行活动中的信阳站春茶匠人，信阳毛尖传承人刘文新在直播间讲述了很多关于信阳毛尖的专业知识。</p><figure class=\"image\"><img src=\"http://img.danews.cc/upload/doc/20200414/1586843487924103.jpg\" alt=\"图片2.jpg\"></figure><p>在直播中，他表示，制茶虽然机器化，但也离不开老师傅把控，根据当天温度、湿气变化作临时调整，比如下雨湿度高，锅炉就要加碳。</p><p>来自这位春茶匠人的讲述和专业炒茶示范，极大丰满了直播内容，也让观看直播的消费者对信阳毛尖这一春茶名品有了更深入的认知。</p><p>从风景秀丽的信阳毛尖茶山，到信阳市长的“带货”，再到春茶匠人的专业讲解，这场深入原产地、兼具专业性和趣味性的溯源直播，观看量破10万，并收获了观看直播消费者的破百万级点赞。</p><p><strong>花式营销齐上阵，天猫让传统信阳毛尖变时髦</strong></p><p>为了给信阳毛尖线上销量爆发集中造势，全方位展示原产地之美和历史文化内核，除了用直播这一直观的展示形式，来让大家对信阳毛尖的原产地有深入直观了解外，在信阳站的活动中，天猫还通过对信阳毛尖原产地话题打造，将武侠和茶道进行了巧妙融合。</p><p>自古以来，河南的武侠气息就非常浓郁，而河南信阳又盛产信阳毛尖。能否将武侠和茶道做结合，将信阳毛尖硬核茶道这一特别茶道内涵，在爱茶人士心中留下深刻印象?</p><p>在此次天猫春茶山河行的收官站上，天猫创新性地将武侠和茶道结合。通过拍摄道长到茶山展示河南正宗武术的图片，天猫将信阳毛尖以更为生动的展现方式，带入到全国消费者视线中。</p><p>此外，天猫还打造了阅读量超5400万的#河南武侠硬核茶道#的微博话题。武侠+茶道的这一新颖话题，不仅激发了全民对该话题的讨论，还进一步提升了大家对信阳毛尖新的文化内核认知。</p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:22:22', '2020-07-16 16:23:37', '', '', '', '', '', '', ''),
(1447, 11, 154, '政策及支持', NULL, '浙江：杭州千岛湖严家乡高山茶走进百姓人家', '', '', '/uploadfile/images/infopic/bds03.jpg', '', '', '', NULL, '中国浙江杭州千岛湖，是浙江省特别生态功能区，据了解，580平方千米水域面积中拥有1078座神姿仙态的大小岛屿，现为国家一级水体，也成就了她“天下第一秀水”得美称，同时，也造就了杭州千岛湖严家乡高山茶1800多年的产茶历史。', '<p>中国浙江杭州千岛湖，是浙江省特别生态功能区，据了解，580平方千米水域面积中拥有1078座神姿仙态的大小岛屿，现为国家一级水体，也成就了她“天下第一秀水”得美称，同时，也造就了杭州千岛湖严家乡高山<a href=\"http://www.zgchawang.com/\"><strong>茶</strong></a>1800多年的产茶历史。</p><figure class=\"image\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200401/283-2004010TRbH.jpg\" alt=\"\"></figure><p>据悉，浙江千岛湖是中国名茶之乡和中国重点茶产区，拥有茶园面积19万亩，超过杭州茶园总面积的30%。其中，有3万亩茶园散落在300多个千岛湖碧波荡漾的岛屿之上。</p><p>记者了解到，浙江淳安县，为浙江省杭州市辖县，位于浙江省西部、杭州市西南部丘陵山区，白际山脉和千里岗山脉之间，新安江和千岛湖交汇之处，四面多山，中为丘陵，陆域面积4417.48平方千米，是浙江省陆域面积最大的县。淳安县不仅有着丰富的自然资源，也有着悠久的历史文化，淳安建制始于东汉建安十三年(208年)，距今已有1800多年的历史，是徽派文化和江南文化的融合地，宋代理学家朱熹在淳安讲学时留下了“问渠哪得清如许，为有源头活水来”的名句，明代著名清官海瑞曾在淳安任四年知县。淳安还有着光荣的革命传统，1935年方志敏率领的中国工农红军北上抗日先遣队“二进二出”淳遂两县，1988年，淳安被浙江省人民政府批准为革命老根据地县，是杭州市唯一的革命老区。</p><figure class=\"image\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200401/283-2004010TU3949.jpg\" alt=\"\"></figure><p>千岛湖严家乡是浙江淳安县有名的<a href=\"http://www.zgchawang.com/\"><strong>茶叶</strong></a>之乡，素有“万亩茶海，百里茶香”的美誉。茶树都在海拔800米的山腰上，四季雨量充沛，土壤腐殖质深厚，有机质含量高，用的肥料都是农家肥。严家乡的茶叶就是生长千岛湖边，吃着有机肥、喝着农夫山泉长出来的。炒制出来的茶叶外形硕壮紧结成条，色泽翠绿，香气清高，汤色嫩黄，滋味鲜爽。</p><p>茶叶收入是当地农民的主要经济来源，占到全年收入的一半以上，杭州千岛湖严家乡高山茶叶其德就是严家乡负责茶叶销售的一位村民。他介绍说，严家茶叶有三大优势：海拔最高、环境最美、价格最实惠。</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"http://www2.tscmjt.com/uploads/allimg/200401/283-2004010U011961.jpg\" alt=\"\"></figure><p>海拔最高有1000多米，原生态环境最美，价格最实惠，顾名思义是质优价廉。茶叶每斤单价，明前茶每斤只要千把元，大众新茶每斤只要几百元。今年2月以来，气温持续偏低，连续的降水让包括西湖龙井在内的各种茶叶开采时间，都推迟到了3月底，再加上人工费用上涨，今年龙井新茶的预售价格已经破万。和这些动辄上万元的龙井新茶相比，千岛湖严家乡的高山云雾新茶虽然在品相和炒制手法上处于劣势，但是品质绝对不差。</p><p>叶其德说，我们就采一季春茶，结束以后，就把老茶叶全部剪掉，就放在地里当肥料。平时一般都施农家肥，比如猪粪、牛粪、羊粪。他曾经还把茶叶拿去给中国茶叶博物馆的高级品茶师品鉴，得出的结论是茶叶鲜爽、清香，氨基酸含量也比较高，和同阶段<a href=\"http://www.zgchawang.com/special/mc/longjingcha/\"><strong>龙井茶</strong></a>相比，属于中等偏上，比较适合家庭饮用。</p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:23:53', '2020-07-16 16:25:26', '', '', '', '', '', '', ''),
(1448, 11, 154, '政策及支持', NULL, '2020年春茶铁观音开采！', '', '', '/uploadfile/images/infopic/c535bf59-90fe-4a46-91a2-0ae7ddd6b15b_1.jpg', '', '', '', NULL, '铁观音春茶现已全面开采，请各位茶友耐心等待铁观音春茶制作上市！', '<figure class=\"image image_resized\" style=\"width:58.99%;\"><img src=\"http://www.qdltea.com/userfiles/files/2.jpg\"></figure><figure class=\"image image_resized\" style=\"width:58.06%;\"><img src=\"http://www.qdltea.com/userfiles/files/3.jpg\"></figure><figure class=\"image image_resized\" style=\"width:57.34%;\"><img src=\"http://www.qdltea.com/userfiles/files/4.jpg\"></figure><figure class=\"image image_resized\" style=\"width:56.93%;\"><img src=\"http://www.qdltea.com/userfiles/files/5.jpg\"></figure><figure class=\"image image_resized\" style=\"width:56.58%;\"><img src=\"http://www.qdltea.com/userfiles/files/6.jpg\"></figure><figure class=\"image image_resized\" style=\"width:56.21%;\"><img src=\"http://www.qdltea.com/userfiles/files/7.jpg\"></figure><figure class=\"image image_resized\" style=\"width:55.83%;\"><img src=\"http://www.qdltea.com/userfiles/files/8.jpg\"></figure><figure class=\"image image_resized\" style=\"width:55.27%;\"><img src=\"http://www.qdltea.com/userfiles/files/9.jpg\"></figure><figure class=\"image image_resized\" style=\"width:54.95%;\"><img src=\"http://www.qdltea.com/userfiles/files/10.jpg\"></figure><p>&nbsp;</p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:27:28', '2020-07-16 16:29:22', '', '', '', '', '', '', ''),
(1449, 11, 153, '线下空间', NULL, '「刀哥说茶」景谷大白茶是白茶还是普洱茶？', '', '', '/uploadfile/images/infopic/dc09000210f6103ab97b-300x180.jpg', '', '', '', NULL, '三言两语很难回答清楚，问的人多了，不胜其烦，只好把这带语病的标题列出，详细说道一下。云南分布有22种，3变种，普洱茶小户赛大茶树，普洱茶种例如：南糯山大茶树、班章大茶树、帕沙大茶树、困鹿山大茶树等都都属于普洱茶种；而巴达大茶树、香竹箐大茶树、勐库大雪山1号古茶树、永德大雪山1号古', '<p style=\"margin-left:0px;\">这个标题是有语病的，但很多人都这样问。三言两语很难回答清楚，问的人多了，不胜其烦，只好把这带语病的标题列出，详细说道一下。</p><h2 style=\"margin-left:0px;\"><strong>简单说</strong></h2><p style=\"margin-left:0px;\">景谷大白茶是茶树品种。</p><p style=\"margin-left:0px;\">白茶是一茶类。</p><p style=\"margin-left:0px;\">普洱茶既可以是茶树树种（应该叫普洱茶种），又可以是一茶类。</p><p style=\"margin-left:0px;\">是不是更加疑惑了，是的，小编也被自己绕晕了，咱还是整复杂一点。</p><h2 style=\"margin-left:0px;\"><strong>复杂说</strong></h2><p style=\"margin-left:0px;\"><strong>1、从茶的分类来说：</strong>普洱茶和白茶都是按加工工艺分成的不同茶类。</p><p style=\"margin-left:0px;\">家张宏达教授将这些茶组植物划分成32种，4变种：中国分布有30种、4变种；云南分布有22种，3变种，普洱茶（种）便是这22种之一）</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/153939688313034f8f7362a\" alt=\"「刀哥说茶」景谷大白茶是白茶还是普洱茶？\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\">小户赛大茶树，普洱茶种</p><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\">例如：南糯山大茶树、班章大茶树、帕沙大茶树、困鹿山大茶树等都都属于<strong>普洱茶种</strong>；而巴达大茶树、香竹箐大茶树、勐库大雪山1号古茶树、永德大雪山1号古茶树等等却属于<strong>大理茶种</strong>；而曼松贡茶、困鹿山细叶茶、黄草坝蚂蚁茶、宝洪茶等等却属于<strong>茶种。</strong></p><p style=\"margin-left:0px;\">通过上述分析，我们得到两条结论：一、普洱茶既可以是茶树品种，也可以是茶类；二、茶叶的分类以加工工艺为主，茶组类不同的种按同一种工艺加工，则属于同一类茶，诸如曼松、巴达等茶树虽然不属于普洱茶种，但如果用普洱茶的加工工艺来加工，则他们应属于普洱茶。</p><p style=\"margin-left:0px;\"><strong>3、从基因学划分：</strong>可将茶树分为<strong>有性系品种和无性系品种</strong>两大类</p><p style=\"margin-left:0px;\">这里所谓的”种”，乃是指品种或品系，不同于植物分类学上的种，此处系借用习惯上的称谓。这些茶树品种往往根据地域或茶树特征来命名来命名，比如有性系的勐海大叶种、勐库大叶种、凤庆大叶种…无性系的云抗10号、云抗14号等等。</p><p style=\"margin-left:0px;\">景谷大白茶就属于这种划分的有性系品种之一，其命名是一景谷的地名和当地茶树多白毫的特征进行的。同为有性系品种的麻栗坡白毛茶、河头白毛茶（保山）、文龙大白茶（景东）等等也是这样命名的。</p><p style=\"margin-left:0px;\">这样的茶树品种，按不同工艺可以加工成不同茶类，比如景谷大白茶按普洱茶工艺加工成的就是普洱茶，按白茶工艺加工的就是白茶。</p><h2 style=\"margin-left:0px;\"><strong>例</strong></h2><p style=\"margin-left:0px;\">好啦，解释的够详细了，为了加深理解，下面我们设置几个问题，看看你答对了没有：</p><p style=\"margin-left:0px;\">1、景谷大白茶是白茶（×）</p><p style=\"margin-left:0px;\">解释：景谷大白茶是基因学划分的有性系品种，白茶是茶类。</p><p style=\"margin-left:0px;\">2、苦竹山大茶树是普洱茶种（√）</p><p style=\"margin-left:0px;\">解释：是的，从基因学划分它又属于景谷大白茶系列。</p><p style=\"margin-left:0px;\">3、曼松贡茶是普洱茶种（×）</p><p style=\"margin-left:0px;\">解释：曼松贡茶属于茶种，不属于普洱茶种。</p><p style=\"margin-left:0px;\">4、易武小叶茶是普洱茶种（×）</p><p style=\"margin-left:0px;\">解释：易武小叶茶属于茶种，不属于普洱茶种。</p><p style=\"margin-left:0px;\">5、落水洞大茶树是普洱茶种（×）</p><p style=\"margin-left:0px;\">解释：落水洞大茶树属于德宏茶种。</p><p style=\"margin-left:0px;\">6、老曼娥苦茶不是普洱茶种（√）</p><p style=\"margin-left:0px;\">解释：老曼娥苦茶属于苦茶变种。</p><p style=\"margin-left:0px;\">7、香竹箐大茶树是普洱茶种（×）</p><p style=\"margin-left:0px;\">解释：香竹箐大茶树是大理茶种。</p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:49:46', '2020-07-16 16:51:17', '', '', '', '', '', '', ''),
(1450, 11, 153, '线下空间', NULL, '其它茶是喝，普洱茶要品', '', '', '/uploadfile/images/infopic/1531012430810f1ba64ce4f-300x180.jpg', '', '', '', NULL, '传说上古神农氏发现的荼这种植物，先是作为药用，或作为食材，或作为祭品，后来它逐渐在中国历朝历代发扬光大。', '<p style=\"margin-left:0px;\">传说上古神农氏发现的荼这种植物，先是作为药用，或作为食材，或作为祭品，后来它逐渐在中国历朝历代发扬光大，唐代伟大的茶圣陆羽把它的名称固定成了“茶”，直到现代，它主要功能成了一种饮品。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/1531012430810f1ba64ce4f\" alt=\"「刀哥说茶」其它茶是喝，普洱茶要品\"></figure><p style=\"margin-left:0px;\">也就是说，无论人们怎么渲染“人在草木中”的这种植物，无论绿茶红茶白茶花茶…归根到底都是一种饮品。</p><p style=\"margin-left:0px;\">既然是饮品，喝和品又有何区别呢？对其它茶类来说，基本没啥区别，都是入口的货，对普洱这种奇葩茶类，就非得咬文爵字了：</p><p style=\"margin-left:0px;\">说道这里对古人的造字功夫，小编是佩服的五体投地：</p><p style=\"margin-left:0px;\">“品”字三个“口”，便不是一口闷的牛饮，也不再是大杯喝的驴灌，成为小杯一口二口三口地细细品味，或浅尝或低啜，闻杯香观汤色，俨然上升到了茶艺茶道的境界。</p><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/pgc-image/15310124307993566616bbf\" alt=\"「刀哥说茶」其它茶是喝，普洱茶要品\"></figure><p style=\"margin-left:0px;\">当然，小编说“其它茶是喝，普洱茶要品”，此处丝毫没有贬低其它茶类之意，同样是喝，也可以喝到如玉川子般“乘此清风欲归去”的境界，即使是水，也可以如陆鸿渐出神入化鉴水的地步，您也可以说这是在“品”，不过这更多是基于品的主体，而不是品的对象——茶或是水了。</p><p style=\"margin-left:0px;\">小编说“其它茶是喝，普洱茶要品”主要是想强调普洱茶是一种很挑剔的茶，不细细品，难知其味。</p><p style=\"margin-left:0px;\"><strong>生茶挑原料</strong></p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/153101243079965da49c5e5\" alt=\"「刀哥说茶」其它茶是喝，普洱茶要品\"></figure><p style=\"margin-left:0px;\">这里的生茶指的是新茶或年份较短的生茶，这种茶的价值如何评估？相信对普洱茶了解不多的茶友也能说明白，往往是还没等到喝，便先提出疑问：哪个茶区的茶？古树还是小树？</p><p style=\"margin-left:0px;\"><strong>熟茶挑工艺</strong></p><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/pgc-image/1531012430848356e88cb67\" alt=\"「刀哥说茶」其它茶是喝，普洱茶要品\"></figure><p style=\"margin-left:0px;\">普洱熟茶，行业内对其发酵工艺一直讳莫如深，号称国家二级保密工艺，可见工艺在最终成品熟茶的口感上起着决定性的因素！</p><p style=\"margin-left:0px;\"><strong>老茶挑仓储</strong></p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/15310124307948cdcf29145\" alt=\"「刀哥说茶」其它茶是喝，普洱茶要品\"></figure><p style=\"margin-left:0px;\">普洱老茶，历经岁月打磨，查看它包装外观已经毫无意义，故事讲多了估计也没人信了，最直接的便是品饮，品什么？更多的实际是在挑仓储的毛病，如果有啥怪味、异味和霉味，很自然的就被怀疑到仓储问题上！如果老茶的仓储没问题，才去细细品鉴它的它滋味。原料和工艺，在老茶阶段，其实已被弱化了。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/15310124309173616baaa23\" alt=\"「刀哥说茶」其它茶是喝，普洱茶要品\"></figure><p style=\"margin-left:0px;\">正因为普洱茶有此<strong>“三挑”</strong>，我们才不得已根据它不同的形态特征细加品味。不品完普洱茶的生、熟、陈三味，何以识普洱?</p><p style=\"margin-left:0px;\"><strong>有幸尝美茗，不慕百花竞风流；机缘识普洱，但知三味了无憾。</strong></p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/1531012430850af11a19047\" alt=\"「刀哥说茶」其它茶是喝，普洱茶要品\"></figure>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:52:21', '2020-07-16 16:53:19', '', '', '', '', '', '', '');
INSERT INTO `dt_article` (`id`, `channel_id`, `category_id`, `category_title`, `call_index`, `title`, `subTitle`, `link_url`, `img_url`, `seo_title`, `seo_keywords`, `seo_description`, `tags`, `zhaiyao`, `contents`, `sort_id`, `click`, `status`, `is_msg`, `is_top`, `is_red`, `is_hot`, `is_slide`, `is_sys`, `user_name`, `add_time`, `update_time`, `titleEn`, `subTitleEn`, `zhaiyaoEn`, `contentsEn`, `attachment_url`, `localRecOP`, `remarks`) VALUES
(1451, 11, 153, '线下空间', NULL, '普洱茶是其它茶类的终结者', '', '', '/uploadfile/images/infopic/154008919731135d2fdd925-300x180.jpg', '', '', '', NULL, '有人说：茶人的最后一站是普洱茶，我也曾说过，普洱茶是其它茶类的终结者，表达的是同样的意思。在我看来，有三点原因：一、饮茶规律造成从饮茶的规律来看，很多茶友都有这样的感觉。', '<p style=\"margin-left:0px;\">有人说：茶人的最后一站是普洱茶，我也曾说过，普洱茶是其它茶类的终结者，表达的是同样的意思。</p><p style=\"margin-left:0px;\">为什么这样说呢？</p><p style=\"margin-left:0px;\">在我看来，有三点原因：</p><h2 style=\"margin-left:0px;\"><strong>一、饮茶规律造成</strong></h2><p style=\"margin-left:0px;\">从 饮茶的规律来看，很多茶友都有这样的感觉：六大茶类喝来喝去，最后喝到普洱茶，其它茶基本就喝不下去了，也就不会选择了。</p><p style=\"margin-left:0px;\">为什么呢？</p><p style=\"margin-left:0px;\">因为普洱茶是活性的茶，是有生命的茶，普洱茶从生产出来的那一刻起就开始了持续发酵、不断成长的一生，其香气、汤色、滋味都在不断地变化、成长，在其从新到老不断的成长过程中，普洱茶的香气、汤色、口感、韵味会次第呈现出六大茶类的特点：</p><p style=\"margin-left:0px;\">刚生产出来的普洱茶生茶滋味口感像绿茶，清爽、清润；</p><p style=\"margin-left:0px;\">陈化个十年八年，像白茶、黄茶；</p><p style=\"margin-left:0px;\">再放个十年八年，像青茶；</p><p style=\"margin-left:0px;\">陈化到三四十年，又像红茶，红亮暖润；</p><p style=\"margin-left:0px;\">陈化到五六十年后，回归到黑茶本身，红褐透亮，香柔滑顺，沉稳平和。</p><p style=\"margin-left:0px;\">普洱茶集各大茶类的特点于一身，选择喝普洱茶，可以得到不同茶类的口感体验，基本就选择了喝所有茶。</p><p style=\"margin-left:0px;\">这也是喝过普洱茶之后就不再喝其它茶类的原因之一。</p><figure class=\"image\"><img src=\"http://p9.pstatp.com/large/pgc-image/154008919731135d2fdd925\" alt=\"「刀哥说茶」普洱茶是其它茶类的终结者\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><h2 style=\"margin-left:0px;\"><strong>二、、变化让人着迷</strong></h2><p style=\"margin-left:0px;\">普洱茶的香气不如其它茶类的浓、高、扬，但也是很迷人的，它贵在变化：新生的普洱茶香气浓烈、高扬，在时间的作用下，越陈化，香气越沉稳悠扬，就像一个人的一生，从一张白纸一样的婴儿，到懵懂青涩的少年、青春张扬的青年、沉稳持重的中年，到内敛冲和的睿智老者，虽满腹经纶，却笑而不语，但慈祥目光过处，秒杀天下英雄。</p><p style=\"margin-left:0px;\">普洱茶香气的变化是从高扬走向低沉，内涵的变化是从浅薄走向深厚，韵味的变化是从短促走向悠长，普洱不止是用来喝的，还是用来品的，品普洱茶其实是品岁月的滋味，时间的味道。从这个层面来看，普洱茶实在是喝茶人的最后一站。</p><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/pgc-image/1540089197356559bce1851\" alt=\"「刀哥说茶」普洱茶是其它茶类的终结者\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\">绿茶喝的是鲜嫩鲜香，普洱茶喝的是成长和变化，随着时间的推移，绿茶的变化是从浓到淡，从好到坏，而普洱茶的变化则呈抛物线，从弱到强，从单纯到饱满，从青涩到张扬，从张扬到沉稳、从沉稳到平和，随着时间的推移，普洱茶越变越好，越来越有韵味。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/15400891975811505142ae4\" alt=\"「刀哥说茶」普洱茶是其它茶类的终结者\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><h2 style=\"margin-left:0px;\"><strong>三、保健功效强大</strong></h2><p style=\"margin-left:0px;\">作为喝茶最后一站的普洱茶，富含益生菌和多种活性物质、微量元素，保健价值极高，尤其是普洱茶的熟茶，由于经过了有微生物参与的渥堆发酵等特殊工艺，茶叶的内含物质在微生物的作用下，原先的营养物质得到了优化，同时还生成了新的营养物质，比如他汀和茶褐素等，在软化血管、平衡体内各种代谢等多方面表现优异，极具养生保健价值。</p><p style=\"margin-left:0px;\">研究数据显示，绿茶中含有100多种营养物质，而由大叶种晒青毛茶加工而成的普洱茶内含的营养物质却有300多种。</p><p style=\"margin-left:0px;\">最难得的是，普洱茶有生茶、熟茶和老茶之分，喝茶之人可以通过对自己身体状况的判断选择一种适合自己品饮、养生保健的普洱茶。</p><figure class=\"image\"><img src=\"http://p9.pstatp.com/large/pgc-image/1540089197357c4925868e3\" alt=\"「刀哥说茶」普洱茶是其它茶类的终结者\"></figure><p style=\"margin-left:0px;\">&nbsp;</p><p style=\"margin-left:0px;\">凡体味到上述普洱茶三个特点的茶友，相信已经体味到了“普洱茶是其它茶类的终结者”。</p><p style=\"margin-left:0px;\">当然，虽言其为“终结者”，是说普洱茶是一种兼容的茶，却不是很霸道的茶，准确说它是一种包容的茶，假如您还没喜欢上它，那就继续喝您的绿茶、继续品您的岩茶、红茶。。。</p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:54:26', '2020-07-16 16:56:18', '', '', '', '', '', '', ''),
(1452, 11, 153, '线下空间', NULL, '真假“易武茶”如何判断？易武普洱茶有哪些特点？', '', '', '/uploadfile/images/infopic/3c750001e5b601439cd5-300x180.jpg', '', '', '', NULL, '一款优质的好的普洱茶制品，“原料是基础，工艺是关键，存放是升华”，除了原料本身和制作工艺之外，在后期陈化的空间仓储环节也至关重要。', '<p style=\"margin-left:0px;\">一款优质的好的普洱茶制品，“原料是基础，工艺是关键，存放是升华”，除了原料本身和制作工艺之外，在后期陈化的空间仓储环节也至关重要。就普洱茶仓定义而言，泛指一切可为普洱茶制品在后期存储过程中实现后发酵而提供的空间环境，按仓储的温湿度条件来划分，可分为普洱湿仓和普洱干仓两大类别，而普洱干仓概念是由普洱湿仓概念演化而来。下面，就普洱干仓与普洱湿仓两大概念作具体阐述。</p><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/3c750001e5b601439cd5\" alt=\"真假“易武茶”如何判断？易武普洱茶有哪些特点？\"></figure><p style=\"margin-left:0px;\">熟谙普洱茶领域的人士皆知，普洱茶制品其仓储发展历程是这样的：普洱茶制品早期在香港、广州、台湾等茶叶市场流通，茶量之大 ，必然形成与此相对应的“普洱茶仓”。在香港、广州、台湾沿海地带，气温相对高温高湿，特别是在梅雨季节，在此地带所存放的普洱茶制品，也就是2007年之前流行于茶叶市场的普洱茶湿仓茶，此等仓储的茶叶制品，目前已渐而淡出普洱茶消费市场。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/3c7a00000a5b65376817\" alt=\"真假“易武茶”如何判断？易武普洱茶有哪些特点？\"></figure><p style=\"margin-left:0px;\">随着湿仓普洱茶制品的淡出，取而代之的主流仓储茶，便是干仓普洱。而干仓普洱之概念，在市场细分的今天，又可分为现代仓、密闭仓、自然仓三种。其中，以人干预控制仓储环境温度、湿度等条件的普洱茶仓称为现代仓（也称标准仓），这类仓储主要分布在广东、深圳等沿海地带，其优点是，在一定时间内可使得普洱茶制品实现稳定快速的发酵，最终达量化、标准化的陈化与后发酵的普洱茶制品。当然，此等普洱茶仓陈化出来的普洱茶制品，其缺点是，茶叶内在的物质变化不够丰富，口感滋味较为平淡，同时也加大了仓储成本（如人工管理成本等）。而密闭仓，是指一个没有空气流动的环境下实现普洱茶制品陈化与后发酵的空间环境；其优势是，可最大限度的保留普洱茶制品“香不走失”，其缺点是因仓储缺少了流动的空气、湿气而抑制了茶叶后发酵的速度。此等仓储在普洱茶界较为少见，常见的以家庭存茶较多，如“自封袋”密闭式家庭存茶。</p><p style=\"margin-left:0px;\">第三种干仓普洱，是目前消费市场的主流茶，即自然仓茶。所谓自然仓，是指遵循大自然变化的规律，依靠自然温度、湿度等条件来实现普洱茶的后发酵过程的仓储环境（人为的干预系数较小）。此等类型的仓储环境，以云南地区的仓储为佳。就笔者所知，这类型的自然仓，在昆明地区以商仓为主的自然仓有“中茶仓”，其具有代表性的中期茶如“福禄寿喜（生）”“回归金砖（生）”，经自然干仓醇化，陈香高扬，醇厚稠滑，乃昆明干仓陈存的典范；海湾茶业“老同志仓”，其代表性的中期茶如2005年、2006年、2007年出品“深山老树”生熟茶；以及近期挂牌的“信茂茶业集团万吨大茶仓”等。此外，云南地州级的自然仓有“下关仓”“勐海仓”和普洱市“新华国茶仓”等等。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/3c760001e0e6c989a29c\" alt=\"真假“易武茶”如何判断？易武普洱茶有哪些特点？\"></figure><p style=\"margin-left:0px;\">近几年，随原产地区建设自然仓之趋势，加码“普洱茶仓”之力度，和普洱茶市的调整与推动下，普洱茶之话语权逐渐转向云南，其优势日益突显，因而孵化出“云南中期茶”概念。在“云南中期茶”黄金时代到来之前，说茶网商城自上线以来，本着精选、严选的理念，近日应诸多普洱茶爱好者、老茶客之愿，从诸多普洱茶品牌中甄选中茶、老同志等茶企品牌，再从诸多品牌产品中优中选优，精选出独具代表品牌高品质且高性价的中期茶制品，与茶友同享。目前，中茶“福禄寿喜”生熟砖正在说茶网商城热销中，老同志中期茶制品也即将上架，敬请关注。</p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:57:03', '2020-07-16 16:58:08', '', '', '', '', '', '', ''),
(1453, 11, 152, '奖项认证', NULL, '1700年茶树王的故乡邦崴：1700年茶树王的故乡', '', '', '/uploadfile/images/infopic/141c0008620dff65c8db-300x180.jpg', '', '', '', NULL, '这段时间喝大家分享的都是临沧的茶山，今天开始，我们就来看看普洱的茶山，敬请大家持续关注！今天文章和大家分享的是澜沧县的邦崴茶山。提到邦崴古茶山，相信很多茶友都会想到那棵生长在邦崴古茶山上已有1700多年树龄的过渡型茶树王，其树高11.8米，树幅8.2米×9米，基部干径1.', '<figure class=\"image\"><img src=\"http://p1.pstatp.com/large/141c0008620dff65c8db\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\"><strong>【引言】</strong>这段时间喝大家分享的都是临沧的茶山，今天开始，我们就来看看普洱的茶山，敬请大家持续关注！今天文章和大家分享的是澜沧县的邦崴茶山。</p><p style=\"margin-left:0px;\">提到邦崴古茶山，相信很多茶友都会想到那棵生长在邦崴古茶山上已有1700多年树龄的过渡型茶树王，其树高11.8米，树幅8.2米×9米，基部干径1.14米，树冠挺拔，枝叶繁茂，并至今都在采摘食用。是世界上首次发现唯一一棵最古老的野生型与栽培型间的过渡茶树王。</p><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/142100045d5587756b01\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\">这棵邦崴茶树王与有着2700多年树龄的镇沅彝族哈尼族拉祜族自治县千家寨野生茶树王及有着1300多年的澜沧景迈芒景栽培型古茶林共同构成三个不同时期、不同形态的古茶树演变标志，是普洱成为“世界茶源”的有力证据之一。邦崴过渡型茶树王也就成了普洱茶名茶树。1997年4月8日，国家邮电部发行《茶》邮票一套四枚，第一枚《茶树》就是邦崴的这棵古树茶。邦崴古茶山也因这棵茶树王而名扬天下。</p><h2 style=\"margin-left:0px;\"><strong>【邦崴地理位置】</strong></h2><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/142000071e4ebae7fc73\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\">邦崴古茶山主要位于普洱市澜沧县富东乡，涉及的乡镇还有澜沧县的文东乡、东河乡、上允镇和大山乡。因大茶树在富东乡邦崴村而得名。邦崴古茶山地处澜沧、双江、景谷三县交界处的澜沧江畔，距澜沧县城155公里，是“两江并流三县交界”的地方，有澜沧江沿岸线24公里，境内河流有小坝河、打黑河、富东河、南滇河。</p><h2 style=\"margin-left:0px;\"><strong>【邦崴气候环境】</strong></h2><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/149a00004ea7dec41e51\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\">邦崴古茶山坡大无平地，海拔在1900-2300米之间，年平均气温16.8℃，阳光充足，气候温和，夏无酷暑，冬无严寒，有利于高品质茶叶的生长。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/142100045d429c888918\" alt=\"邦崴：1700年茶树王的故乡\"></figure><h2 style=\"margin-left:0px;\"><strong>【邦崴茶树资源及价值】</strong></h2><p style=\"margin-left:0px;\">据悉，1991年3月，当时思茅地区茶学会理事长何仕华根据群众反映到邦崴村对古茶树进行了初步考察，之后思茅的多位茶专家于1991年4月和11月两次考察了邦崴古茶树和古茶林。1992年10月，云南省茶叶学会、思茅行署、云南省农科院茶叶研究所、思茅地区茶叶学会、澜沧县政府共同召开了“澜沧邦崴大茶树考察论证会”，认为邦崴大茶树既有野生大茶树的花果种子形态特征，又有栽培茶树芽叶枝梢特点，是野生型与栽培型之间的过渡型。</p><figure class=\"image\"><img src=\"http://p9.pstatp.com/large/142000071e5b4e5994a1\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\">1993年4月，“中国普洱国际学术研讨会”和“中国古茶树遗产保护研讨会”在思茅举行。来自9个国家和地区的181名专家学者亲临现场对邦崴古茶树进行研究表明：邦崴大茶树是较云南大叶种和印度阿萨姆种更原始，起源更早的茶树，是野生型向栽培型过渡的过渡型茶树的结论，这一结论轰动了世界。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/14190006a807450b3be2\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\">邦崴古茶树雄辩地证明了世界茶叶原产地在中国—云南—普洱，邦崴古茶树奠定了中国、云南普洱是世界茶叶起源地的地位，云南普洱是世界最早的种茶之地。普洱是一片孕育生命奇迹的热土，从而彻底改变了世界茶源地在印度的传统学说，也改写了人类种茶的历史。澜沧邦崴过渡型古茶树从此闻名于世界，成为世界茶树原产地的座标和活化石，也是世界茶学界标志性的珍宝级古茶树。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/141e00047530ac2d5c9e\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\">邦崴地处澜沧江以南的崇山峻岭，为扎发谷山脉分支之一，是澜沧江畔很早就人工种植茶的古老原始沃土。特别是这里地处北回归线以南，海拔高度、雨量和温湿度构成了特别的生存环境，孕育了众多的古山茶科植物，最终演化为野生古茶树群落和过渡型、驯化栽培型古茶树群落。到目前为止，在邦崴古茶山有纯野生古茶树，有野生型与栽培型间的过渡型古茶树，有上千百年的人工栽培型古茶树。包括富东乡的邦崴、小坝，文东乡的帕赛，芒糯等村落，均有大量的古树茶和古茶园分布，其中邦崴村一带干径10厘米以上的老茶树有上千株。</p><h2 style=\"margin-left:0px;\"><strong>【邦崴普洱茶产量】</strong></h2><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/149a00004eb1095a6aa1\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\">邦崴村有居民730户，人口2794人，以汉族和拉祜族为主。邦崴村古茶树主要分布在各寨子旁，成片种植和零星种植相结合，茶树品种以大叶种普洱茶为主。全村有茶叶6200余亩，古茶面积1650多亩，10万多株；树龄在500年以上的，茶树基部直径在20公分以上有2286多株，有不少茶树一株就能卖万元以上，其中邦崴二茶王单株年产值达8万多元。</p><h2 style=\"margin-left:0px;\"><strong>【邦崴普洱茶特点】</strong></h2><p style=\"margin-left:0px;\">邦崴古树级普洱生茶的特点是：</p><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/14190006a802a46da86a\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\">茶风硬朗、入口丰满、山野风韵很强、耐泡、口感转换得快。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/141c00086202f6c377c3\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\">香气高锐持久，香甜质重饱满，滋味浓烈。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/141e0004752d70055e73\" alt=\"邦崴：1700年茶树王的故乡\"></figure><p style=\"margin-left:0px;\">醇厚稳健，舌面与上颚中后段微苦涩，甘韵强而集中于舌面，香型层次明显，汤色清澈明亮。</p><p style=\"margin-left:0px;\">如果您有更多的茶叶知识需要咨询，请添加南茗佳人高级茶艺师、评茶师红傧号个人号：<strong>dydy280 </strong>（长按复制）交流学习。</p><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/141e00047529d3727bd1\" alt=\"邦崴：1700年茶树王的故乡\"></figure>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 16:58:58', '2020-07-16 17:00:24', '', '', '', '', '', '', ''),
(1454, 11, 152, '奖项认证', NULL, '穿越千年的茶历史，茶叶进化史穿越千年的茶历史，茶叶进化史', '', '', '/uploadfile/images/infopic/1533884668505d75e63f1d9-300x180.jpg', '', '', '', NULL, '作为中国最古老的饮品，茶已经成为国人生活中不可分割的一部分。它不受地域限制，也没有民族差别，几千年来一直流传下来。', '<p style=\"margin-left:0px;\">作为中国最古老的饮品，茶已经成为国人生活中不可分割的一部分。它不受地域限制，也没有民族差别，几千年来一直流传下来。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/1533884668505d75e63f1d9\" alt=\"穿越千年的茶历史，茶叶进化史\"></figure><p style=\"margin-left:0px;\"><strong>1、古老的药材</strong></p><p style=\"margin-left:0px;\">我国最早发现茶和利用茶的时间，大约可以追溯到原始社会时期。当时，人们直接食用茶树的新鲜叶片，从中汲取茶汁。据记载，我国大约在五千年以前就开始食用茶了。</p><p style=\"margin-left:0px;\">那时，人们将含嚼茶叶作为一种习惯，时间们将新鲜的茶叶洗净之后，用水煮熟，连着汤汁当时人们主要将它当作药或药引。如果有人生病取其茶汁，或是配合其他中药让病人一同服用，炎解毒的作用。这可以说是茶作为药用的开端。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/1533884875384f648c800df\" alt=\"穿越千年的茶历史，茶叶进化史\"></figure><p style=\"margin-left:0px;\">那时，人们将含嚼茶叶作为一种习惯，时间久了之后，生嚼茶叶变成了煮熟服用。人们将新鲜的茶叶洗净之后，用水煮熟，连着汤汁一同服下。</p><p style=\"margin-left:0px;\">不过煮出来的茶叶味道苦涩当时人们主要将它当作药或药引。如果有人生病了，人们就从茶树上采摘下新鲜的芽叶，取其茶汁，或是配合其他中药让病人一同服用，虽然煮出来的茶水非常苦，但确实有着消炎解毒的作用。这可以说是茶作为药用的开端。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/1533885133635fd0cb6678f\" alt=\"穿越千年的茶历史，茶叶进化史\"></figure><p style=\"margin-left:0px;\"><strong>2、以茶为食</strong></p><p style=\"margin-left:0px;\">慢慢地,茶在人们生活中的作用开始了改变。以茶作为食物,并不是近现代才发明的新创意。《诗疏》说:“椒树、茱萸，蜀人作茶，吴人作茗，皆合煮其中以为食。”早在汉代之前人们就以茶当菜，茶叶煮熟以后，与饭菜一同食用。三国时，魏朝已出现了茶叶的简单加工，采来的叶子先做成饼，晒干或烘干，这是制茶工艺的萌芽。</p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/1533885186833cd90b76e1c\" alt=\"穿越千年的茶历史，茶叶进化史\"></figure><p style=\"margin-left:0px;\"><strong>3、饼茶、串茶、茶膏的出现</strong></p><p style=\"margin-left:0px;\">饼茶又称团茶，就是把茶叶加工成饼。它始于隋唐，盛于宋代。隋唐时，为改善茶叶苦涩的味道，人们开始在饼茶中掺合薄荷、盐、红枣等。欧阳修《归田录》中写道：“茶之品，莫贵于龙凤，谓之团茶，凡八饼重一斤。”初步加工的饼茶仍有很浓的青草味，经反复实践，人们发明了蒸青制茶，即通过洗涤鲜叶，蒸青压榨，去汁制饼，使茶叶苦涩味大大降低。</p><p style=\"margin-left:0px;\">唐朝人将饼茶用黑茶叶包裹住，在中间打一个洞，用绳子串起来，称其为串茶。</p><p style=\"margin-left:0px;\">茶膏现如今很少被人提及，只有在过去宫廷中才会被饮用。饮茶时先将荼膏敲碎，再经过仔细研磨、碾细、筛选，最后置于杯中，然后冲入沸水，由此看来，其整个制作过程和饮用都非常繁琐。</p><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/pgc-image/1533885238759dfdaf24d67\" alt=\"穿越千年的茶历史，茶叶进化史\"></figure><p style=\"margin-left:0px;\"><strong>4、散茶的出现</strong></p><p style=\"margin-left:0px;\">最早的砖茶、团茶被称为块状茶，饮茶方式也不想现在一样对茶叶进行冲泡，而是采用“煮”的方式。直到宋朝中后期，茶叶生产才由先前的以团茶为主，逐渐转向以散茶为主。</p><p style=\"margin-left:0px;\">到了明代，明太祖朱元璋发布诏令，废团荼，兴叶茶，才出现散茶。从此人们不再将茶叶制作成饼茶，而是直接在壶或盏中沏泡条形散茶，人类的泡茶、饮茶方式发生了重大的变革。饮茶方法也由“点”茶演变成“泡”茶。我们现在通行的“泡茶”的说法是明代才出现的，清代才开始广为流行。</p><figure class=\"image\"><img src=\"http://p3.pstatp.com/large/pgc-image/153388545707900f3a19bf2\" alt=\"穿越千年的茶历史，茶叶进化史\"></figure><p style=\"margin-left:0px;\"><strong>5、七大茶系产生</strong></p><p style=\"margin-left:0px;\">茶文化发展到清朝时，奢侈的团茶和饼茶虽然已经被散茶所取代，但我国的茶文化却在清朝完成了由鼎盛到顶级的转化。清朝的茶饮最突出的特点就是出现了七大茶系，即<strong>绿茶、红茶、黄茶、黑茶、白茶、花茶和青茶。</strong></p><figure class=\"image\"><img src=\"http://p1.pstatp.com/large/pgc-image/153388510255685ff6a399c\" alt=\"穿越千年的茶历史，茶叶进化史\"></figure><p style=\"margin-left:0px;\"><strong>6、现代茶的发展</strong></p><p style=\"margin-left:0px;\">时至今日,茶文化已经融入了各家各户的生活中。除了茶叶品种越来越丰富，饮用方式也趋于多样化。除了七大茶系之外，人们还逐步发明出各式各样的茶饮，例如花草茶、果茶和保健荼等。这些茶饮的形式也开始多样化：液体茶、速溶茶、袋泡茶……这些缤纷的茶饮充分满足了人们的日常需要，其独特的魅力也让各类人群越来越热衷。</p>', 0, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, '2020-07-16 17:01:54', '2020-07-16 17:03:04', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `dt_article_attribute_field`
--

CREATE TABLE `dt_article_attribute_field` (
  `id` int(10) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT '',
  `control_type` varchar(50) DEFAULT NULL,
  `data_type` varchar(50) DEFAULT NULL,
  `data_length` int(10) DEFAULT NULL,
  `data_place` tinyint(3) UNSIGNED DEFAULT NULL,
  `item_option` text,
  `default_value` text,
  `is_required` tinyint(3) UNSIGNED DEFAULT NULL,
  `is_password` tinyint(3) UNSIGNED DEFAULT NULL,
  `is_html` tinyint(3) UNSIGNED DEFAULT NULL,
  `editor_type` tinyint(3) UNSIGNED DEFAULT NULL,
  `valid_tip_msg` varchar(255) DEFAULT '',
  `valid_error_msg` varchar(255) DEFAULT '',
  `valid_pattern` text,
  `sort_id` int(10) DEFAULT NULL,
  `is_sys` tinyint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dt_article_attribute_field`
--

INSERT INTO `dt_article_attribute_field` (`id`, `name`, `title`, `control_type`, `data_type`, `data_length`, `data_place`, `item_option`, `default_value`, `is_required`, `is_password`, `is_html`, `editor_type`, `valid_tip_msg`, `valid_error_msg`, `valid_pattern`, `sort_id`, `is_sys`) VALUES
(2, 'sub_title', '副标题', 'single-text', 'nvarchar(255)', 255, 0, '', '', 0, 0, 0, 0, '可为空，最多255个字符', '', 's0-255', 99, 1),
(3, 'source', '信息来源', 'single-text', 'nvarchar(100)', 100, 0, '', '本站', 0, 0, 0, 0, '非必填，最多50个字符', '', 's0-50', 100, 1),
(4, 'author', '文章作者', 'single-text', 'nvarchar(50)', 50, 0, '', '', 0, 0, 0, 0, '非必填，最多50个字符', '', 's0-50', 101, 1),
(5, 'goods_no', '商品货号', 'single-text', 'nvarchar(100)', 100, 0, '', '', 0, 0, 0, 0, '允许字母、下划线，100个字符内', '', 's0-100', 102, 1),
(6, 'stock_quantity', '库存数量', 'number', 'int', 0, 0, '', '0', 0, 0, 0, 0, '库存数量为0时显示缺货状态', '', 'n', 103, 1),
(7, 'market_price', '市场价格', 'number', 'decimal(9,2)', 0, 2, '', '0', 0, 0, 0, 0, '市场的参与价格，不参与计算', '', '/^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){1,2})?$/', 104, 1),
(8, 'sell_price', '销售价格', 'number', 'decimal(9,2)', 0, 2, '', '0', 1, 0, 0, 0, '*出售的实际交易价格', '', '/^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){1,2})?$/', 105, 1),
(9, 'point', '交易积分', 'number', 'int', 0, 0, '', '0', 0, 0, 0, 0, '*正为返还，负为消费积分', '', 'n', 106, 1),
(12, 'video_src', '视频上传', 'video', 'nvarchar(255)', 0, 0, '', '', 0, 0, 0, 0, '', '', '', 99, 0);

-- --------------------------------------------------------

--
-- 表的结构 `dt_article_attribute_value`
--

CREATE TABLE `dt_article_attribute_value` (
  `article_id` int(10) NOT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `goods_no` varchar(100) DEFAULT NULL,
  `stock_quantity` int(10) DEFAULT NULL,
  `market_price` decimal(9,2) DEFAULT NULL,
  `sell_price` decimal(9,2) DEFAULT NULL,
  `point` int(10) DEFAULT NULL,
  `video_src` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `dt_article_category`
--

CREATE TABLE `dt_article_category` (
  `id` int(10) NOT NULL,
  `channel_id` int(10) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `subTitle` varchar(256) DEFAULT NULL COMMENT '副标题 ',
  `zhaiyao` varchar(500) DEFAULT NULL COMMENT '内容摘要',
  `call_index` varchar(50) DEFAULT '',
  `parent_id` int(10) DEFAULT NULL,
  `class_list` varchar(2000) DEFAULT NULL,
  `class_layer` int(10) DEFAULT NULL,
  `sort_id` int(10) DEFAULT NULL,
  `link_url` varchar(255) DEFAULT '',
  `img_url` varchar(2000) DEFAULT '',
  `content` text,
  `seo_title` varchar(255) DEFAULT '',
  `seo_keywords` varchar(255) DEFAULT '',
  `seo_description` varchar(255) DEFAULT '',
  `class_status` int(11) DEFAULT '0' COMMENT '状态：0正常，1推荐，2锁定不显示',
  `titleEn` varchar(255) DEFAULT NULL,
  `subTitleEn` varchar(255) DEFAULT NULL,
  `zhaiyaoEn` varchar(255) DEFAULT NULL,
  `contentsEn` text,
  `attachment_url` varchar(1000) DEFAULT NULL,
  `haschildren` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否有子级',
  `localRecOP` varchar(256) NOT NULL COMMENT '本条记录操作管理，分为增,删,改,查,状态,类型,上传封面数量,上传相关文件数量,封面图，相关文件，前六位为二进制、第七到十位为十进制表示、第十一和第十二位为二进制，二进制1为启用0为禁用，如:101000010100,启用增、改，删、查、状态、类型禁用,上传封面数量一张、上传相关文件数量一张，封面图、相关文件禁用，值为NULL值或空字符串时，封面图，相关文件禁用其它为全部启用。',
  `remarks` varchar(1000) NOT NULL COMMENT '备注说明'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dt_article_category`
--

INSERT INTO `dt_article_category` (`id`, `channel_id`, `title`, `subTitle`, `zhaiyao`, `call_index`, `parent_id`, `class_list`, `class_layer`, `sort_id`, `link_url`, `img_url`, `content`, `seo_title`, `seo_keywords`, `seo_description`, `class_status`, `titleEn`, `subTitleEn`, `zhaiyaoEn`, `contentsEn`, `attachment_url`, `haschildren`, `localRecOP`, `remarks`) VALUES
(4, 6, '系列产品', '', '', '', 0, '0/', 1, 2, '', '', '<figure class=\"image\"><img src=\"http://localhost:8458/uploadfile/files/lbgsnew01.jpg\"></figure>', '', '', '', 0, '', '', 'Silicon coating technology for high hardness steel, high speed machining, dry cutting.', '', '', b'1', '', ''),
(10, 6, '小方片1.0系列', '小方片1.0系列', '', '', 4, '0/4/', 2, 0, '', '/uploadfile/images/pctranimgs/banner_xlcp_02.png', '<figure class=\"image\"><img src=\"/uploadfile/images/other/xfp0102.png\"></figure><figure class=\"image\"><img src=\"/uploadfile/images/other/xfp0101.png\"></figure><figure class=\"image\"><img src=\"/uploadfile/images/other/xfp0103.png\"></figure>', '', '', '', 0, '', '', '', '', '/uploadfile/images/other/xlcp_01.png', b'0', '101000010101', ''),
(14, 9, '专注品种', '', '', '', 0, '0/', 1, 1, 'javascript:void(0);', '', '', '关于我们1', '关于我们2', '关于我们3', 0, 'Company', '', '', '', '', b'0', '001110010310', ''),
(25, 11, '品牌资讯', '', '', '', 0, '0/', 1, 99, '', '', '', '', '', '', 0, 'mycase001', '', '', '', '', b'1', '', ''),
(42, 7, '其它相关设置', '', '', '', 0, '0/', 1, 100, '', '', '', '影音娱乐', '空调,音响,DVD,影音配件,电视配件', '电视音响，DVD，影音配件提供最新报价、价格、促销、参数、评价、排行、图片等选购信息。', 0, '', '', '', '', '', b'1', '', ''),
(50, 7, '前端顶部菜单左边LOGO', '', '', '', 42, '0/42/', 2, 5, '', '/uploadfile/images/logo/logo1.png', '', '音响DVD', '空调,音响,DVD,影音配件,电视配件', '电视音响，DVD，影音配件提供最新报价、价格、促销、参数、评价、排行、图片等选购信息。', 0, '', '', '', '', '', b'0', '', '图片尺寸：140 x28'),
(51, 7, '管理后台LOGO', '', 'ccccc', '', 42, '0/42/', 2, 4, 'bbbb', '/uploadfile/images/logo/bdslogo.png', '', '', '', '', 0, '', '', '', '', '', b'0', '', '图片尺寸：170*57'),
(97, 7, '网站通用标题', '福建白大师茶叶有限公司', '', '', 42, '0/42/', 2, 0, '', '', '', '福建白大师茶叶有限公司', '福建白大师茶叶有限公司', '福建白大师茶叶有限公司', 0, '', '', '', '', '', b'0', '', ''),
(98, 10, '在线订单', '', '尊敬的客户，如果你对本公司产品有兴趣或需预购的话，请填写以下表单。我们将尽快与你联系，谢谢您的支持，祝我们合作成功！', '', 0, '0/', 1, 0, '/ordercn?p=0/98/&categoryId=98&ch=10', '/uploadfile/productCategoryPics/83968410-45cb-48e6-9c89-bb9ddcb16a21_02-gettyimages-165844341_resized.jpg', '', '', '', '', 0, 'Order', '', 'Dear customers, if you are interested in our products or want to pre-order, please fill in the following form.We will contact you as soon as possible, thank you for your support, wish us a successful cooperation!', '', '', b'0', '', ''),
(139, 6, '小方片2.0系列', '小方片，刚刚好。', '', '', 4, '0/4/', 2, 1, '', '/uploadfile/images/pctranimgs/banner_xlcp_02.png', '<figure class=\"image\"><img src=\"/uploadfile/images/other/xfp0101.png\"></figure><figure class=\"image\"><img src=\"/uploadfile/images/other/xfp0102.png\"></figure><figure class=\"image\"><img src=\"/uploadfile/images/other/xfp0103.png\"></figure>', '', '', '', 0, '', '', '', '', '/uploadfile/images/other/xlcp_03.png', b'0', '111000010101', ''),
(140, 6, '刚柔并济系列', '刚柔并济系列', '', '', 4, '0/4/', 2, 2, '', '/uploadfile/images/pctranimgs/banner_xlcp_03.png', '<figure class=\"image\"><img src=\"/uploadfile/images/other/glbj-01-03.png\"></figure><figure class=\"image\"><img src=\"/uploadfile/images/other/glbj-01-02.png\"></figure><figure class=\"image\"><img src=\"/uploadfile/images/other/glbj0101.png\"></figure>', '', '', '', 0, '', '', '', '', '/uploadfile/images/other/xlcp_04.png', b'0', '111000010101', ''),
(141, 6, '阅天下系列', '大师白茶好，存成传家宝', '', '', 4, '0/4/', 2, 3, '', '/uploadfile/images/pctranimgs/banner_xlcp_01.png', '<figure class=\"image\"><img src=\"/uploadfile/images/other/ytx0101.png\"></figure><figure class=\"image\"><img src=\"/uploadfile/images/other/ytx0102.png\"></figure><figure class=\"image\"><img src=\"/uploadfile/images/other/ytx0103.png\"></figure>', '', '', '', 1, '', '', '', '', '/uploadfile/images/other/xlcp_02.png', b'0', '111000010101', ''),
(147, 7, '登录页LOGO', '', '', '', 42, '0/42/', 2, 6, '', '/uploadfile/images/logo/loginlogo.png', '', '', '', '', 0, '', '', '', '', '', b'0', '', '图片尺寸：159*205'),
(148, 7, '浏览器标题图标', '', '', '', 42, '0/42/', 2, 7, '', '/uploadfile/images/logo/llico.png', '', '', '', '', 0, '', '', '', '', '', b'0', '', '图片尺寸：100*100'),
(149, 7, '更多合作', '', '', '', 0, '0/', 1, 0, '', '', '', '', '', '', 0, '', '', '', '', '', b'0', '111111030100', '图片尺寸：748x685'),
(152, 11, '奖项认证', '奖项认证', '', '', 25, '0/25/', 2, 2, '', '/uploadfile/images/pctranimgs/bannerppzx01.png', '<figure class=\"image\"><img src=\"/uploadfile/images/other/jxrz.png\"></figure>', '', '', '', 0, '', '', '', '', '', b'0', '', ''),
(153, 11, '线下空间', '线下空间', '', '', 25, '0/25/', 2, 1, '', '/uploadfile/images/pctranimgs/bannerppzx02.png', '<figure class=\"image\"><img src=\"/uploadfile/images/other/xxkj.png\"></figure>', '', '', '', 1, '', '', '', '', '', b'0', '', ''),
(154, 11, '政策及支持', '政策及支持', '', '', 25, '0/25/', 2, 0, '', '/uploadfile/images/pctranimgs/bannerppzx01.png', '', '', '', '', 1, '', '', '', '', '', b'0', '101000010101', ''),
(177, 7, '底部导航栏', '底部导航栏', '盒立方核心优势', '', 42, '0/42/', 2, 5, '', '', '', '音响DVD', '空调,音响,DVD,影音配件,电视配件', '电视音响，DVD，影音配件提供最新报价、价格、促销、参数、评价、排行、图片等选购信息。', 0, '', '', '', '', '', b'0', '', '图片尺寸：2560x1155'),
(178, 6, '轮播图片', '', '', '', 0, '0/', 1, 0, '', '/uploadfile/images/pctranimgs/banner_xlcp_04.png', '', '', '', '', 0, '', '', 'Silicon coating technology for high hardness steel, high speed machining, dry cutting.', '', '', b'0', '001110100000', '宽度>=1920最佳，高度自适应'),
(179, 9, '轮播图片', '', '', '', 0, '0/', 1, 0, 'javascript:void(0);', '/uploadfile/images/pctranimgs/bds1.jpg,/uploadfile/images/pctranimgs/banner04.png,/uploadfile/images/pctranimgs/banner05.png,/uploadfile/images/pctranimgs/bds2.jpg', '<p>&nbsp; &nbsp; &nbsp; &nbsp;泉德利茶业是一家集茶叶种植、生产、销售、连锁经营于一体的综合性茶企，以“利以德取”为立企之本，真诚回馈广大消费者。我们始终坚信，中国茶只有绝大多数人爱喝并且喝得起，才能长久不衰。</p><figure class=\"table\"><table style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><tbody><tr><td style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><figure class=\"image\"><img src=\"http://www.qdltea.com/userfiles/files/ppjj2.jpg\"></figure></td><td style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><figure class=\"image\"><img src=\"http://www.qdltea.com/userfiles/files/ppjj1.jpg\"></figure></td></tr></tbody></table></figure><p>&nbsp; &nbsp; &nbsp; &nbsp;1992年，德利铁观音已进入济南的各大商场和茶店，从而成为安溪铁观音在山东市场的开拓先行者。泉德利茗茶凭借原汁原味原产地的优质产品和脚踏实地、诚信经营、热情服务的理念，获得长足发展。</p><p>&nbsp; &nbsp; &nbsp; &nbsp; 泉德利茶业在保障产品品质的同时，通过规模优势、场地优势、包装优势实现成本的精准掌控。使得价格不再成为消费者追求高品质品牌茶业的鸿沟，让好茶走进千家万户，真正实现“好茶零距离，与你更亲近。”</p><figure class=\"image\"><img src=\"http://localhost:8458/userfiles/images/ppjj3.jpg\"></figure>', '关于我们1', '关于我们2', '关于我们3', 0, 'Company', '', '', '', '', b'0', '001110100000', '宽度>=1920最佳，高度自适应'),
(180, 11, '轮播图片', '', '', '', 0, '0/', 1, 0, '', '/uploadfile/images/pctranimgs/bannerppzx02.png,/uploadfile/images/pctranimgs/bannerppzx01.png', '', '', '', '', 0, 'mycase001', '', '', '', '', b'0', '001110100000', '宽度>=1920最佳，高度自适应'),
(181, 12, '轮播图片', '', '', '', 0, '0/', 1, 1, '', '/uploadfile/images/pctranimgs/bannerppzx02.png', '', '', '', '', 0, '', '', '', '', '', b'0', '001000010110', ''),
(183, 9, '一体化模式', '白大师从生产/制作/包装，均已实现一体化模式<br/>目前销售额已突破1000万', '', '', 0, '0/', 1, 2, 'javascript:void(0);', '', '<p>&nbsp; &nbsp; &nbsp; &nbsp;泉德利茶业是一家集茶叶种植、生产、销售、连锁经营于一体的综合性茶企，以“利以德取”为立企之本，真诚回馈广大消费者。我们始终坚信，中国茶只有绝大多数人爱喝并且喝得起，才能长久不衰。</p><figure class=\"table\"><table style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><tbody><tr><td style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><figure class=\"image\"><img src=\"http://www.qdltea.com/userfiles/files/ppjj2.jpg\"></figure></td><td style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><figure class=\"image\"><img src=\"http://www.qdltea.com/userfiles/files/ppjj1.jpg\"></figure></td></tr></tbody></table></figure><p>&nbsp; &nbsp; &nbsp; &nbsp;1992年，德利铁观音已进入济南的各大商场和茶店，从而成为安溪铁观音在山东市场的开拓先行者。泉德利茗茶凭借原汁原味原产地的优质产品和脚踏实地、诚信经营、热情服务的理念，获得长足发展。</p><p>&nbsp; &nbsp; &nbsp; &nbsp; 泉德利茶业在保障产品品质的同时，通过规模优势、场地优势、包装优势实现成本的精准掌控。使得价格不再成为消费者追求高品质品牌茶业的鸿沟，让好茶走进千家万户，真正实现“好茶零距离，与你更亲近。”</p><figure class=\"image\"><img src=\"http://localhost:8458/userfiles/images/ppjj3.jpg\"></figure>', '关于我们1', '关于我们2', '关于我们3', 0, 'Company', '', '', '', '', b'0', '001110010000', ''),
(184, 9, '茶山图', '', '', '', 0, '0/', 1, 3, 'javascript:void(0);', '', '<p>&nbsp; &nbsp; &nbsp; &nbsp;泉德利茶业是一家集茶叶种植、生产、销售、连锁经营于一体的综合性茶企，以“利以德取”为立企之本，真诚回馈广大消费者。我们始终坚信，中国茶只有绝大多数人爱喝并且喝得起，才能长久不衰。</p><figure class=\"table\"><table style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><tbody><tr><td style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><figure class=\"image\"><img src=\"http://www.qdltea.com/userfiles/files/ppjj2.jpg\"></figure></td><td style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><figure class=\"image\"><img src=\"http://www.qdltea.com/userfiles/files/ppjj1.jpg\"></figure></td></tr></tbody></table></figure><p>&nbsp; &nbsp; &nbsp; &nbsp;1992年，德利铁观音已进入济南的各大商场和茶店，从而成为安溪铁观音在山东市场的开拓先行者。泉德利茗茶凭借原汁原味原产地的优质产品和脚踏实地、诚信经营、热情服务的理念，获得长足发展。</p><p>&nbsp; &nbsp; &nbsp; &nbsp; 泉德利茶业在保障产品品质的同时，通过规模优势、场地优势、包装优势实现成本的精准掌控。使得价格不再成为消费者追求高品质品牌茶业的鸿沟，让好茶走进千家万户，真正实现“好茶零距离，与你更亲近。”</p><figure class=\"image\"><img src=\"http://localhost:8458/userfiles/images/ppjj3.jpg\"></figure>', '关于我们1', '关于我们2', '关于我们3', 0, 'Company', '', '', '', '', b'0', '001110010000', ''),
(185, 9, '白大师分类介绍', '', '', '', 0, '0/', 1, 4, 'javascript:void(0);', '', '<p>&nbsp; &nbsp; &nbsp; &nbsp;泉德利茶业是一家集茶叶种植、生产、销售、连锁经营于一体的综合性茶企，以“利以德取”为立企之本，真诚回馈广大消费者。我们始终坚信，中国茶只有绝大多数人爱喝并且喝得起，才能长久不衰。</p><figure class=\"table\"><table style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><tbody><tr><td style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><figure class=\"image\"><img src=\"http://www.qdltea.com/userfiles/files/ppjj2.jpg\"></figure></td><td style=\"border-bottom:0px solid;border-left:0px solid;border-right:0px solid;border-top:0px solid;\"><figure class=\"image\"><img src=\"http://www.qdltea.com/userfiles/files/ppjj1.jpg\"></figure></td></tr></tbody></table></figure><p>&nbsp; &nbsp; &nbsp; &nbsp;1992年，德利铁观音已进入济南的各大商场和茶店，从而成为安溪铁观音在山东市场的开拓先行者。泉德利茗茶凭借原汁原味原产地的优质产品和脚踏实地、诚信经营、热情服务的理念，获得长足发展。</p><p>&nbsp; &nbsp; &nbsp; &nbsp; 泉德利茶业在保障产品品质的同时，通过规模优势、场地优势、包装优势实现成本的精准掌控。使得价格不再成为消费者追求高品质品牌茶业的鸿沟，让好茶走进千家万户，真正实现“好茶零距离，与你更亲近。”</p><figure class=\"image\"><img src=\"http://localhost:8458/userfiles/images/ppjj3.jpg\"></figure>', '福建白大师茶叶有限公司', '福建白大师茶叶有限公司', '福建白大师茶叶有限公司', 0, 'Company', '', '', '', '', b'1', '101110010000', ''),
(189, 9, '白茶基地', '', '', '', 185, '0/185/', 2, 0, '', '/uploadfile/images/pctranimgs/bds2.jpg', '', '', '', '', 0, '', '', '', '', '', b'0', '', ''),
(190, 9, '传承技艺', '福鼎白茶非物质文化遗产传承人<br/>点头镇白茶制作技艺第五代传承人<br/>30年制茶经验', '', '', 185, '0/185/', 2, 0, '', '/uploadfile/images/pctranimgs/banner04.png', '', '', '', '', 0, '', '', '', '', '', b'0', '', ''),
(191, 9, '一等芽尖', '', '', '', 185, '0/185/', 2, 0, '', '/uploadfile/images/pctranimgs/bannerydyj.png', '', '', '', '', 0, '', '', '', '', '', b'0', '101000010100', ''),
(207, 13, '私人定制', '', '', '', 0, '0/', 1, 1, '', '', '<p>&nbsp; &nbsp; &nbsp; 中国自古便是礼仪之邦，上下五千年历史发展至今，送礼俨然成了一门学问、一门艺术。送的是礼，表的是情，送对礼，是贴心，送得有创意，则更显送礼人的用心。 &nbsp;为能满足您的特别需求，也为您多添一份心意，我们特推出白茶私人订制服务。<br>&nbsp;</p><figure class=\"image\"><img src=\"/uploadfile/images/other/bannerppzx02.png\"></figure><p><br>一泡有灵魂的订制茶，于无声之中，表达了情感，也最大限度地满足了专属的尊贵感，更是品质和内涵的象征。唯有当礼物超越了礼物，价值才会变得更有价值。<br>&nbsp;</p><figure class=\"image\"><img src=\"/uploadfile/images/other/xfp0103.png\"></figure><p><br>&nbsp; &nbsp; &nbsp; 茶礼，为什么要订制？个性订制、独具匠心当订制茶添加了您或客户（朋友）的风格烙印，将具有更多的个性元素和纪念意义，避免了您所赠送的茶礼被随意转赠的尴尬。以礼寄情、彰显珍贵具有专属感的个人签名和包装韵味，以礼寄情、传递真情、升华情感、彰显珍贵。礼品诚可贵，真情价更高。予人茶礼，手留余香古代茶代礼的习俗延续至今，白茶越陈越香、收藏价值高。予人茶礼，茶无价、情更浓。专属茶礼、宜饮宜藏白茶是天然茶饮、宜饮宜藏、健康养生，能更好地诠释新时代的茶礼文化。一对一高端订制服务我们的私人订制，采取一对一的形式，将依据客户个性需求、送礼对象和不同用途，从白茶品类、礼盒包装等着手，为您量身打造出具有浓郁个人专属风格的茶叶礼品。量身定制的情谊，有新意，不俗套。<br>&nbsp;</p>', '', '', '', 0, '', '', '', '', '', b'0', '', ''),
(208, 13, '轮播图片', '', '', '', 0, '0/', 1, 0, '', '/uploadfile/images/pctranimgs/banner_xlcp_04.png', '', '', '', '', 0, '', '', '', '', '', b'0', '', ''),
(209, 12, '招商', '', '', '', 0, '0/', 1, 2, '', '', '<p style=\"margin-left:0px;\"><strong>&nbsp; &nbsp; &nbsp; &nbsp;白牡丹、普洱、霍山黄芽冲泡方式，你了解多少，别再暴殄天物了！</strong></p><p style=\"margin-left:0px;\">　　之前我们探讨了正山小种、龙井、大红袍的冲泡方式，知道茶汤香气和口感受冲泡方式影响较大。只有正确冲泡，好茶才能免于浪费。</p><p style=\"margin-left:0px;\">　　有些茶客会收藏一些名贵好茶，这时掌握一些冲泡方式和注意事项就很有必要了。</p><p style=\"margin-left:0px;\">　　那么除却红茶、绿茶、乌龙茶之外的另外三种茶冲泡方式是不是也很讲究呢，现在咱们就可以来探索一下。</p><p style=\"margin-left:0px;\">　　<strong>1、白牡丹冲泡方式</strong></p><p style=\"margin-left:0px;\">　　白牡丹对冲泡茶具类型限制较少，所以玻璃杯、盖碗或茶壶，都可以完成冲泡使命。</p><p style=\"margin-left:0px;\">　　无论如何，都要按照标准规格挑选茶具，还要保证茶叶适量，冲泡温度适宜，这是冲泡的标准要求。</p><p style=\"margin-left:0px;\">　　普通的上班族或嫌费事、图方便的朋友可以优先选择玻璃杯，茶叶投放量受茶杯大小限制，如果茶杯容量在200ml左右，茶叶量则不能少于5g。</p><p style=\"margin-left:0px;\">　　投茶后，开始进入温润环节，此时注入的水体温度大约在90度左右。浸润时间极短，在浸润过程中，白牡丹香气充盈周围空间，此时结束浸润，沸水入杯，完成冲泡。</p><p style=\"margin-left:0px;\">　　喜欢一段时光一壶茶的朋友，则可以选择大壶泡法。在这种方法中，茶壶容量较大，茶客对茶叶耐泡时间要求比较高，所以茶叶用量可以增加3g。</p><p style=\"margin-left:0px;\">　　在冲泡环节，投茶注水。在沸水环境里，白牡丹依旧可以盛开，散发清香，所以其自然也不会在90度水体环境中翻船。但茶客要注意一点，避免茶叶受沸水直接击打。</p><figure class=\"image image_resized\" style=\"width:550px;\"><img src=\"https://img.ys991.com/uploads/allimg/20190923/1569221823691595.jpg\" alt=\"18.jpg\"></figure><p style=\"margin-left:0px;\">　　<strong>2、普洱冲泡方式</strong></p><p style=\"margin-left:0px;\">　　普洱分生熟两种，茶客需要分清冲泡方式，才能真正识茶滋味。</p><p style=\"margin-left:0px;\">　　冲泡茶具类型多元，风格各异。对于活泼好动的茶客，可以选择轻盈的飘逸杯，对于沉稳含蓄的茶客，可以选择温婉的盖碗或紫砂壶。</p><p style=\"margin-left:0px;\">　　茶、茶具、水、冲泡方式呈相互辩证、相互影响关系。只有做好万全准备，才能悠然品饮，享受普洱带来的愉悦感。</p><p style=\"margin-left:0px;\">　　在冲泡生普洱时，需要预先处理好茶叶，如果茶叶为茶砖形式，茶客还要用茶针将茶砖分成方便冲泡的茶叶，此时茶叶为全叶状态。</p><p style=\"margin-left:0px;\">　　茶叶量与冲水量相适应，如果使用100ml左右的容具，则要将差量控制在5g左右，不能低于3g。生普冲泡虽然没有特别强调使用沸水，但也要在90度以上。</p><p style=\"margin-left:0px;\">　　在正式冲泡环节，投茶后醒茶，醒茶时间需要控制在几十秒左右。醒茶后的茶汤可以倒掉，等待下一泡茶，后面的每一泡茶等待时间可以延长几秒，但时间不能太长。</p><p style=\"margin-left:0px;\">　　在冲泡熟普洱时，除了控制茶量和水量外，还必须使用沸水入驻茶具。</p><p style=\"margin-left:0px;\">　　茶客可以从紫陶和紫砂壶中挑选合适的茶具，在冲泡时，也要用滚烫的沸水冲洗茶具。</p><p style=\"margin-left:0px;\">　　在洗茶、温茶、醒茶后，继续冲入沸水，短时间内出汤品饮。</p><p style=\"margin-left:0px;\">　　<strong>3、霍山黄芽冲泡方式</strong></p><p style=\"margin-left:0px;\">　　黄茶在寻常百姓家出现的机率不是很大，但我们也要晓得如何冲泡。细细品来，霍山黄芽也别有一番滋味。</p><p style=\"margin-left:0px;\">　　霍山黄芽和龙井绿茶冲泡后，茶叶都会有剧烈的变化，为了提升茶叶的观赏价值，我们可以选择玻璃杯作为该种黄茶的容纳器具，还要配备合适的水壶。</p><p style=\"margin-left:0px;\">　　在冲泡时，虽然水温需要控制在80度左右，但其也要在沸水基础上自然冷却下去。茶友可现场煮水。</p><p style=\"margin-left:0px;\">　　开水洁杯后，在水杯中注入适量的水和茶叶。</p><p style=\"margin-left:0px;\">　　沸水最好不要直接击打在茶叶上，可以使水流沿着杯壁下滑。</p><p style=\"margin-left:0px;\">　　开始水量不要太多，可以使霍山黄芽有缓冲时间和空间，此为润茶。</p><p style=\"margin-left:0px;\">　　最后高冲水，使茶叶与水体共舞。短时间过后，你便可以享受这杯黄茶了。</p>', '', '', '', 0, '', '', '', '', '', b'0', '001000010110', ''),
(210, 7, '天猫店链接网址', '', '', '', 42, '0/42/', 2, 8, 'http://www.tmall.com', '/uploadfile/images/package/tm.png', '', '', '', '', 0, '', '', '', '', '', b'0', '', ''),
(211, 7, '京东链接网址', '', '', '', 42, '0/42/', 2, 9, 'http://www.jd.com', '/uploadfile/images/package/jd.png', '', '', '', '', 0, '', '', '', '', '', b'0', '', ''),
(212, 7, '客服电话', '', '', '', 42, '0/42/', 2, 10, 'tel:4006666560', '/uploadfile/images/package/kf.png', '', '', '', '', 0, '', '', '', '', '', b'0', '', ''),
(213, 7, '网站底部版权', '', '', '', 42, '0/42/', 2, 11, '', '', '<p style=\"text-align:center;\">&nbsp;闽ICP备20001027号-1，©baidashitea.com 2020，本网站设计及其中所展示之作品著作权，均属于福建白大师茶叶有限公司，保留所有权利。</p>', '', '', '', 0, '', '', '', '', '', b'0', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `dt_article_goods`
--

CREATE TABLE `dt_article_goods` (
  `id` int(10) NOT NULL,
  `article_id` int(10) DEFAULT NULL,
  `goods_no` varchar(50) DEFAULT NULL,
  `spec_ids` text,
  `spec_text` text,
  `stock_quantity` int(10) DEFAULT NULL,
  `market_price` decimal(9,2) DEFAULT NULL,
  `sell_price` decimal(9,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dt_article_goods`
--

INSERT INTO `dt_article_goods` (`id`, `article_id`, `goods_no`, `spec_ids`, `spec_text`, `stock_quantity`, `market_price`, `sell_price`) VALUES
(67, 87, 'SD9102356032-1', ',9,16,', '颜色：白色；版本：移动4G', 10, '2499.00', '2195.00'),
(68, 87, 'SD9102356032-2', ',9,17,', '颜色：白色；版本：联通4G', 10, '2499.00', '2195.00'),
(69, 87, 'SD9102356032-3', ',9,19,', '颜色：白色；版本：双网通', 10, '2899.00', '2499.00'),
(70, 87, 'SD9102356032-4', ',13,16,', '颜色：黑色；版本：移动4G', 10, '2499.00', '2499.00'),
(71, 87, 'SD9102356032-5', ',13,17,', '颜色：黑色；版本：联通4G', 10, '2499.00', '2200.00'),
(72, 87, 'SD9102356032-6', ',13,19,', '颜色：黑色；版本：双网通', 10, '2499.00', '2200.00'),
(73, 88, 'SD7159810321-1', ',9,22,', '颜色：白色；版本：全网通', 100, '6388.00', '5780.00'),
(74, 88, 'SD7159810321-2', ',13,22,', '颜色：黑色；版本：全网通', 100, '6388.00', '5780.00'),
(75, 89, 'SD2932214404-1', ',9,16,', '颜色：白色；版本：移动4G', 10, '2699.00', '2299.00'),
(76, 89, 'SD2932214404-2', ',9,17,', '颜色：白色；版本：联通4G', 10, '2699.00', '2299.00'),
(77, 89, 'SD2932214404-3', ',9,19,', '颜色：白色；版本：双网通', 10, '2899.00', '2499.00'),
(78, 89, 'SD2932214404-4', ',13,16,', '颜色：黑色；版本：移动4G', 10, '2699.00', '2299.00'),
(79, 89, 'SD2932214404-5', ',13,17,', '颜色：黑色；版本：联通4G', 10, '2699.00', '2299.00'),
(80, 89, 'SD2932214404-6', ',13,19,', '颜色：黑色；版本：双网通', 10, '2899.00', '2499.00'),
(82, 90, 'SD8861076806-1', ',13,', '颜色：黑色', 100, '5099.00', '4799.00'),
(83, 91, 'SD1260286073-1', ',13,', '颜色：黑色', 10, '3150.00', '3180.00'),
(84, 92, 'SD6808149048-1', ',13,', '颜色：黑色', 100, '4599.00', '2999.00'),
(86, 94, 'SD3720019286-1', ',9,', '颜色：白色', 100, '99.00', '79.00'),
(87, 93, 'SD9683710842-1', ',9,', '颜色：白色', 10, '7988.00', '7200.00');

-- --------------------------------------------------------

--
-- 表的结构 `dt_article_goods_spec`
--

CREATE TABLE `dt_article_goods_spec` (
  `article_id` int(10) DEFAULT NULL,
  `spec_id` int(10) DEFAULT NULL,
  `parent_id` int(10) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dt_article_goods_spec`
--

INSERT INTO `dt_article_goods_spec` (`article_id`, `spec_id`, `parent_id`, `title`, `img_url`) VALUES
(87, 8, 0, '颜色', NULL),
(87, 9, 8, '白色', '/upload/201503/25/201503251553231051.jpg'),
(87, 13, 8, '黑色', '/upload/201503/25/201503251554034624.jpg'),
(87, 15, 0, '版本', NULL),
(87, 16, 15, '移动4G', NULL),
(87, 17, 15, '联通4G', NULL),
(87, 19, 15, '双网通', NULL),
(88, 8, 0, '颜色', NULL),
(88, 9, 8, '白色', '/upload/201503/25/201503251553231051.jpg'),
(88, 13, 8, '黑色', '/upload/201503/25/201503251554034624.jpg'),
(88, 15, 0, '版本', NULL),
(88, 22, 15, '全网通', NULL),
(89, 8, 0, '颜色', ''),
(89, 9, 8, '白色', '/upload/201503/25/201503251553231051.jpg'),
(89, 13, 8, '黑色', '/upload/201503/25/201503251554034624.jpg'),
(89, 15, 0, '版本', ''),
(89, 16, 15, '移动4G', ''),
(89, 17, 15, '联通4G', ''),
(89, 19, 15, '双网通', ''),
(90, 8, 0, '颜色', NULL),
(90, 13, 8, '黑色', '/upload/201503/25/201503251554034624.jpg'),
(91, 8, 0, '颜色', ''),
(91, 13, 8, '黑色', '/upload/201503/25/201503251554034624.jpg'),
(92, 8, 0, '颜色', ''),
(92, 13, 8, '黑色', '/upload/201503/25/201503251554034624.jpg'),
(93, 8, 0, '颜色', NULL),
(93, 9, 8, '白色', '/upload/201503/25/201503251553231051.jpg'),
(94, 8, 0, '颜色', ''),
(94, 9, 8, '白色', '/upload/201503/25/201503251553231051.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `dt_article_spec`
--

CREATE TABLE `dt_article_spec` (
  `id` int(10) NOT NULL,
  `parent_id` int(10) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `sort_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dt_article_spec`
--

INSERT INTO `dt_article_spec` (`id`, `parent_id`, `title`, `img_url`, `remark`, `sort_id`) VALUES
(8, 0, '颜色', NULL, '全部颜色规格', 99),
(9, 8, '白色', '/upload/201503/25/201503251553231051.jpg', NULL, 99),
(10, 8, '红色', '/upload/201503/25/201503251553387052.jpg', NULL, 101),
(11, 8, '绿色', '/upload/201503/25/201503251553466924.jpg', NULL, 101),
(12, 8, '黄色', '/upload/201503/25/201503251553550852.jpg', NULL, 102),
(13, 8, '黑色', '/upload/201503/25/201503251554034624.jpg', NULL, 103),
(14, 8, '蓝色', '/upload/201503/25/201503251554117928.jpg', NULL, 104),
(15, 0, '版本', NULL, '', 100),
(16, 15, '移动4G', '', NULL, 99),
(17, 15, '联通4G', '', NULL, 100),
(18, 15, '电信4G', '', NULL, 101),
(19, 15, '双网通', '', NULL, 102),
(22, 15, '全网通', '', NULL, 103);

-- --------------------------------------------------------

--
-- 表的结构 `dt_article_tags_relation`
--

CREATE TABLE `dt_article_tags_relation` (
  `id` int(10) NOT NULL,
  `article_id` int(10) DEFAULT NULL,
  `tag_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dt_article_tags_relation`
--

INSERT INTO `dt_article_tags_relation` (`id`, `article_id`, `tag_id`) VALUES
(14, 13, 5),
(15, 13, 6),
(18, 14, 7),
(19, 14, 8),
(20, 15, 9),
(21, 16, 10),
(22, 17, 11),
(23, 17, 12),
(24, 17, 13),
(25, 19, 14),
(26, 20, 15),
(27, 29, 16),
(28, 30, 17),
(29, 36, 18),
(30, 36, 19),
(31, 37, 20),
(32, 38, 21),
(33, 56, 22),
(34, 59, 23),
(35, 60, 23),
(36, 61, 23),
(37, 62, 24),
(41, 74, 26),
(42, 71, 25),
(43, 72, 25),
(44, 73, 25);

-- --------------------------------------------------------

--
-- 表的结构 `dt_channel`
--

CREATE TABLE `dt_channel` (
  `id` int(10) NOT NULL,
  `site_id` int(10) DEFAULT NULL,
  `name` varchar(50) DEFAULT '',
  `title` varchar(100) DEFAULT '',
  `is_albums` tinyint(1) DEFAULT '0',
  `is_attach` tinyint(1) DEFAULT '0',
  `is_spec` tinyint(1) DEFAULT '0',
  `sort_id` int(10) DEFAULT NULL,
  `limitShowLevels` varchar(255) DEFAULT NULL COMMENT '类别控制参数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dt_channel`
--

INSERT INTO `dt_channel` (`id`, `site_id`, `name`, `title`, `is_albums`, `is_attach`, `is_spec`, `sort_id`, `limitShowLevels`) VALUES
(6, 4, 'productcenter', '系列产品', 1, 1, 0, 3, '0,0,0,2,0,1,1,0,1,0,0,3,3,2,3'),
(7, 4, 'fmtp', '网站设置', 1, 1, 0, 1, '0,0,0,0,0,0,0,0,0,0,0,3,0,0,0'),
(9, 4, 'gywm', '关于白大师', 1, 1, 0, 2, '0,2,0,0,0,0,1,0,0,0,0,3,3,2,3'),
(11, 4, 'alfx', '品牌资讯', 1, 0, 0, 4, '0,0,0,2,0,1,1,0,0,0,0,3,3,2,3'),
(12, 4, 'mdyb001', '招商', 1, 0, 0, 5, '1,0,0,0,0,0,1,0,0,1,0,3,0,0,0'),
(13, 4, 'project01', '私人定制', 1, 0, 0, 7, '0,1,0,1,0,1,1,1,0,0,0,3,0,0,0');

-- --------------------------------------------------------

--
-- 表的结构 `dt_channel_field`
--

CREATE TABLE `dt_channel_field` (
  `id` int(10) NOT NULL,
  `channel_id` int(10) DEFAULT NULL,
  `field_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `dt_channel_site`
--

CREATE TABLE `dt_channel_site` (
  `id` int(10) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `build_path` varchar(100) DEFAULT '',
  `templet_path` varchar(100) DEFAULT '',
  `domain` varchar(255) DEFAULT '',
  `name` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `crod` varchar(100) DEFAULT NULL,
  `copyright` text,
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_keyword` varchar(255) DEFAULT NULL,
  `seo_description` text,
  `is_mobile` tinyint(3) UNSIGNED DEFAULT NULL,
  `is_default` tinyint(3) UNSIGNED DEFAULT NULL,
  `sort_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dt_channel_site`
--

INSERT INTO `dt_channel_site` (`id`, `title`, `build_path`, `templet_path`, `domain`, `name`, `logo`, `company`, `address`, `tel`, `fax`, `email`, `crod`, `copyright`, `seo_title`, `seo_keyword`, `seo_description`, `is_mobile`, `is_default`, `sort_id`) VALUES
(4, '默认站点', 'main', 'main', '', 'DTcms内容管理系统', '', '深圳市动力启航软件有限公司', '深圳市宝安区西乡街道铁岗村一巷二号', '13695245546', '-', 'info@dtcms.net', '粤ICP备11064298号', '版权所有 深圳市动力启航软件有限公司 ? Copyright 2009 - 2015. dtcms.net. All Rights Reserved.', 'DTcms网站管理系统 - 动力启航_开源cms_NET开源_cms建站', '动力启航,DTCMS系统,ASP.NET开源,开源CMS,网站管理系统,互联网开发', '让更多的人分享互联网开发技术', 0, 1, 99),
(5, '手机网站', 'mobile', 'mobile', 'm.dtcms.net', 'DTcms内容管理系统', '', '深圳市动力启航软件有限公司', '深圳市宝安区西乡街道铁岗村一巷二号', '13695245546', '', 'info@dtcms.net', '粤ICP备11064298号', '版权所有 深圳市动力启航软件有限公司 @ Copyright 2009 - 2015. dtcms.net. All Rights Reserved.', 'DTcms网站管理系统 - 动力启航_开源cms_NET开源_cms建站', '动力启航,DTCMS系统,ASP.NET开源,开源CMS,网站管理系统,互联网开发', '让更多的人分享互联网开发技术', 1, 0, 100);

-- --------------------------------------------------------

--
-- 表的结构 `dt_config`
--

CREATE TABLE `dt_config` (
  `id` bigint(20) NOT NULL COMMENT '自动编号',
  `mkey` varchar(256) NOT NULL COMMENT '键',
  `mvalue` varchar(256) NOT NULL COMMENT '值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `dt_orders`
--

CREATE TABLE `dt_orders` (
  `id` int(11) NOT NULL COMMENT '自动编号',
  `title` varchar(256) DEFAULT NULL COMMENT '订单标题',
  `Name` varchar(256) DEFAULT NULL COMMENT '客户名字',
  `ompanyName` varchar(256) DEFAULT NULL COMMENT '公司名称',
  `tel` varchar(256) DEFAULT NULL COMMENT '联系电话',
  `fax` varchar(256) DEFAULT NULL COMMENT '传真',
  `ddr` varchar(256) DEFAULT NULL COMMENT '地址',
  `email` varchar(256) DEFAULT NULL COMMENT '邮箱',
  `contents` text COMMENT '详细内容'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sys_icons`
--

CREATE TABLE `sys_icons` (
  `id` int(11) NOT NULL COMMENT '自动编号',
  `iconclass` varchar(100) NOT NULL COMMENT '图标样式class类',
  `iconname` varchar(100) NOT NULL COMMENT 'icon名字'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sys_icons`
--

INSERT INTO `sys_icons` (`id`, `iconclass`, `iconname`) VALUES
(1, 'am-icon-adjust', 'adjust'),
(2, 'am-icon-anchor', 'anchor'),
(3, 'am-icon-archive', 'archive'),
(4, 'am-icon-area-chart', 'area-chart'),
(5, 'am-icon-arrows', 'arrows'),
(6, 'am-icon-arrows-h', 'arrows-h'),
(7, 'am-icon-arrows-v', 'arrows-v'),
(8, 'am-icon-asterisk', 'asterisk'),
(9, 'am-icon-at', 'at'),
(10, 'am-icon-automobile', 'automobile'),
(11, 'am-icon-ban', 'ban'),
(12, 'am-icon-bank', 'bank'),
(13, 'am-icon-bar-chart', 'bar-chart'),
(14, 'am-icon-bar-chart-o', 'bar-chart-o'),
(15, 'am-icon-barcode', 'barcode'),
(16, 'am-icon-bars', 'bars'),
(17, 'am-icon-beer', 'beer'),
(18, 'am-icon-bell', 'bell'),
(19, 'am-icon-bell-o', 'bell-o'),
(20, 'am-icon-bell-slash', 'bell-slash'),
(21, 'am-icon-bell-slash-o', 'bell-slash-o'),
(22, 'am-icon-bicycle', 'bicycle'),
(23, 'am-icon-bar-chart', 'bar-chart'),
(24, 'am-icon-bar-chart-o', 'bar-chart-o'),
(25, 'am-icon-line-chart', 'line-chart'),
(26, 'am-icon-pie-chart', 'pie-chart');

-- --------------------------------------------------------

--
-- 表的结构 `sys_organization`
--

CREATE TABLE `sys_organization` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_ids` varchar(100) DEFAULT NULL,
  `available` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sys_organization`
--

INSERT INTO `sys_organization` (`id`, `name`, `parent_id`, `parent_ids`, `available`) VALUES
(1, '总公司', 0, '0/', 1),
(3, '厦门分公司', 1, '0/1/', 1),
(26, '湖里办事处', 3, '0/1/3/', 1),
(39, '福州分公司', 1, '0/1/', 0),
(40, '西湖办事处', 39, '0/1/39/', 0),
(42, '思明办事处', 3, '0/1/3/', 0);

-- --------------------------------------------------------

--
-- 表的结构 `sys_resource`
--

CREATE TABLE `sys_resource` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `nameCode` varchar(255) NOT NULL DEFAULT '' COMMENT '资源名称代码',
  `type` varchar(50) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_ids` varchar(100) DEFAULT NULL,
  `permission` varchar(100) DEFAULT NULL,
  `available` tinyint(1) DEFAULT '0',
  `picicon` varchar(50) NOT NULL COMMENT '代表图标',
  `dsc` varchar(1000) DEFAULT NULL COMMENT '对该模块功能进行描述',
  `sort_id` int(11) NOT NULL DEFAULT '0' COMMENT '序号',
  `channel_id` int(11) DEFAULT NULL COMMENT '频道ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sys_resource`
--

INSERT INTO `sys_resource` (`id`, `name`, `nameCode`, `type`, `url`, `parent_id`, `parent_ids`, `permission`, `available`, `picicon`, `dsc`, `sort_id`, `channel_id`) VALUES
(1, '系统管理', '1', 'menu', '', 0, '0/', 'sys:*:*', 1, 'am-icon-bars', '', 2, NULL),
(11, '组织机构管理', '11', 'menu', '/sysmanage/organization', 1, '0/1/', 'sys:*:organization', 1, 'am-icon-area-chart', '对组织结构进行分配，该模块对组织结构可进行新增、修改、删除、显示等操作。', 0, NULL),
(12, '组织机构新增', '12', 'button', '', 11, '0/1/11/', 'sys:create:organization', 1, 'am-icon-tv', '', 0, NULL),
(13, '组织机构修改', '13', 'button', '', 11, '0/1/11/', 'sys:update:organization', 1, 'am-icon-tv', NULL, 0, NULL),
(14, '组织机构删除', '14', 'button', '', 11, '0/1/11/', 'sys:delete:organization', 1, 'am-icon-tv', NULL, 0, NULL),
(15, '组织机构查看', '15', 'button', '', 11, '0/1/11/', 'sys:view:organization', 1, 'am-icon-tv', NULL, 0, NULL),
(21, '用户管理', '21', 'menu', '/sysmanage/user', 1, '0/1/', 'sys:*:user', 1, 'am-icon-asterisk', '该模块包含用户列表显示、新增、修改、删除、密码修改等操作。', 0, NULL),
(22, '用户新增', '22', 'button', '', 21, '0/1/21/', 'sys:create:user', 1, 'am-icon-tv', NULL, 0, NULL),
(23, '用户修改', '23', 'button', '', 21, '0/1/21/', 'sys:update:user', 1, 'am-icon-tv', NULL, 0, NULL),
(24, '用户删除', '24', 'button', '', 21, '0/1/21/', 'sys:delete:user', 1, 'am-icon-tv', NULL, 0, NULL),
(25, '用户查看', '25', 'button', '', 21, '0/1/21/', 'sys:view:user', 1, 'am-icon-tv', NULL, 0, NULL),
(31, '资源管理', '31', 'menu', '/sysmanage/resource', 1, '0/1/', 'sys:*:resource', 1, 'am-icon-archive', '此模块包含资源新增、修改、删除、显示等相关操作', 0, NULL),
(32, '资源新增', '32', 'button', '', 31, '0/1/31/', 'sys:create:resource', 1, 'am-icon-tv', NULL, 0, NULL),
(33, '资源修改', '33', 'button', '', 31, '0/1/31/', 'sys:update:resource', 1, 'am-icon-tv', NULL, 0, NULL),
(34, '资源删除', '34', 'button', '', 31, '0/1/31/', 'sys:delete:resource', 1, 'am-icon-tv', NULL, 0, NULL),
(35, '资源查看', '35', 'button', '', 31, '0/1/31/', 'sys:view:resource', 1, 'am-icon-tv', NULL, 0, NULL),
(41, '角色管理', '41', 'menu', '/sysmanage/role', 1, '0/1/', 'sys:*:role', 1, 'am-icon-bell-o', '对用户的权限进行分组，该模块包含角色新增、显示、删除、修改等操作。', 0, NULL),
(42, '角色新增', '42', 'button', '', 41, '0/1/41/', 'sys:create:role', 1, 'am-icon-tv', NULL, 0, NULL),
(43, '角色修改', '43', 'button', '', 41, '0/1/41/', 'sys:update:role', 1, 'am-icon-tv', NULL, 0, NULL),
(44, '角色删除', '44', 'button', '', 41, '0/1/41/', 'sys:delete:role', 1, 'am-icon-tv', NULL, 0, NULL),
(45, '角色查看', '45', 'button', '', 41, '0/1/41/', 'sys:view:role', 1, 'am-icon-tv', NULL, 0, NULL),
(46, 'URL管理', '46', 'menu', '/sysmanage/urlFilter', 1, '0/1/', 'sys:*:urlFilter', 1, 'am-icon-pie-chart', 'URL权限控制，此模块对URL权限新增、显示、修改、删除等进行操作。', 0, NULL),
(47, 'URL新增', '47', 'button', '', 46, '0/1/46/', 'sys:create:urlFilter', 1, 'am-icon-tv', NULL, 0, NULL),
(48, 'URL修改', '48', 'button', '', 46, '0/1/46/', 'sys:update:urlFilter', 1, 'am-icon-tv', NULL, 0, NULL),
(49, 'URL删除', '49', 'button', '', 46, '0/1/46/', 'sys:delete:urlFilter', 1, 'am-icon-tv', NULL, 0, NULL),
(50, 'URL查看', '50', 'button', '', 46, '0/1/46/', 'sys:view:urlFilter', 1, 'am-icon-tv', NULL, 0, NULL),
(53, '网站管理', '53', 'menu', '', 0, '0/', 'web:*:*', 1, 'am-icon-tv', '', 1, NULL),
(54, '关于白大师', '54', 'menu', '/sysmanage/aboutus', 53, '0/53/', 'web:*:aboutus', 1, 'am-icon-archive', '公司介绍、文化以及相关内容进行动态管理。', 3, 9),
(58, '系列产品', '58', 'menu', '/sysmanage/baseset', 53, '0/53/', 'web:*:baseset', 1, 'am-icon-asterisk', '可对产品进行管理，如产品分类、产品资料等功能', 4, 6),
(59, '网站设置', '59', 'menu', '/sysmanage/fmpics', 53, '0/53/', 'web:*:fmpics', 1, 'am-icon-asterisk', '该模块功能：可以设置网站网版、LOGO等', 0, 7),
(68, '系统设置', '68', 'menu', '', 0, '0/', 'sysset:*:*', 1, 'am-icon-anchor', '', 3, NULL),
(69, '基本设置', '69', 'menu', '', 68, '0/68/', 'sysset:*:baseset', 1, 'am-icon-bar-chart', '', 0, NULL),
(70, '栏目类别', 'A001', 'menu', '/sysmanage/webmanage/products/productcategory', 58, '0/53/58/', '', 1, 'am-icon-barcode', '', 3, 6),
(76, '控制面板', 'kzmb01', 'menu', '', 0, '0/', 'syscontrol:*:*', 1, 'am-icon-asterisk', '', 4, NULL),
(77, '站点管理', 'zdbl01', 'menu', '', 76, '0/76/', 'syscontrol:*:zdgl', 1, 'am-icon-tv', '', 0, NULL),
(78, '频道管理', 'pdgl01', 'menu', '/sysmanage/channel/channel_list', 76, '0/76/', 'syscontrol:*:pdgl', 1, 'am-icon-tv', '', 1, NULL),
(79, '扩展字段', 'kzzd01', 'menu', '', 76, '0/76/', 'syscontrol:*:kzzd', 1, 'am-icon-tv', '', 2, NULL),
(81, '栏目类别', 'ydyfm', 'menu', '/sysmanage/webmanage/products/productcategory', 59, '0/53/59/', '', 1, 'am-icon-tv', '', 0, NULL),
(83, '内容管理', 'fmtpc', 'menu', '/sysmanage/webmanage/products/article_list', 59, '0/53/59/', '', 1, 'am-icon-tv', '', 1, NULL),
(86, '栏目类别', 'aboutus01', 'menu', '/sysmanage/webmanage/products/productcategory', 54, '0/53/54/', '', 1, 'am-icon-tv', '', 0, NULL),
(89, '品牌资讯', 'case001', 'menu', '/sysmanage/cases', 53, '0/53/', 'web:*:cases', 1, 'am-icon-tv', '', 5, 11),
(90, '栏目类别', 'case002', 'menu', '/sysmanage/webmanage/products/productcategory', 89, '0/53/89/', '', 0, 'am-icon-tv', '', 1, 11),
(91, '内容管理', 'case003', 'menu', '/sysmanage/webmanage/products/article_list', 89, '0/53/89/', '', 1, 'am-icon-tv', '', 2, 11),
(92, '内容管理', 'pdcontents', 'menu', '/sysmanage/webmanage/products/article_list', 58, '0/53/58/', '', 1, 'am-icon-tv', '', 4, 6),
(95, '招商', 'mdyb0001', 'menu', '/sysmanage/mdyb', 53, '0/53/', '', 1, 'am-icon-tv', '', 6, 12),
(96, '栏目类别', 'mdyblmlb', 'menu', '/sysmanage/webmanage/products/productcategory', 95, '0/53/95/', '', 1, 'am-icon-tv', '', 0, 12),
(101, '内容管理', 'helifangbz00001', 'menu', '/sysmanage/webmanage/products/article_list', 54, '0/53/54/', '', 1, 'am-icon-tv', '', 1, 9),
(103, '招商申请资料', 'helifangbz00003', 'menu', '/sysmanage/webmanage/products/order', 95, '0/53/95/', '', 1, 'am-icon-tv', '', 2, 12),
(104, '私人定制', 'srdz001', 'menu', '', 53, '0/53/', '', 1, 'am-icon-tv', '', 8, 13),
(105, '栏目类别', '22601', 'menu', '/sysmanage/webmanage/products/productcategory', 104, '0/53/104/', '', 1, 'am-icon-tv', '', 0, 13);

-- --------------------------------------------------------

--
-- 表的结构 `sys_role`
--

CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL,
  `role` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `resource_ids` varchar(100) DEFAULT NULL,
  `available` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sys_role`
--

INSERT INTO `sys_role` (`id`, `role`, `description`, `resource_ids`, `available`) VALUES
(1, 'admin', '超级管理员', '11,21,31,41,46,54,56,57,58,59,69,77,78,79,89,', 1),
(2, 'user', '一般用户', '54,57,58,59,89,95,104,', 1);

-- --------------------------------------------------------

--
-- 表的结构 `sys_url_filter`
--

CREATE TABLE `sys_url_filter` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `roles` varchar(100) DEFAULT NULL,
  `permissions` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sys_url_filter`
--

INSERT INTO `sys_url_filter` (`id`, `name`, `url`, `roles`, `permissions`) VALUES
(4, 'myurl', '/lgt/info', 'zg', ''),
(5, 'youurl', '/you/info', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `sys_user`
--

CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL,
  `organization_id` bigint(20) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(1000) DEFAULT NULL,
  `salt` varchar(100) DEFAULT NULL,
  `role_ids` varchar(100) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT '0',
  `parentId` bigint(20) NOT NULL DEFAULT '0' COMMENT '父编号',
  `parentIds` varchar(100) DEFAULT NULL COMMENT '父编号列表',
  `nickName` varchar(255) DEFAULT NULL COMMENT '呢称',
  `headIcon` varchar(2000) DEFAULT NULL COMMENT '头像',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `mobilePhone` varchar(255) DEFAULT NULL COMMENT '移动电话',
  `remark` text COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sys_user`
--

INSERT INTO `sys_user` (`id`, `organization_id`, `username`, `password`, `salt`, `role_ids`, `locked`, `parentId`, `parentIds`, `nickName`, `headIcon`, `email`, `mobilePhone`, `remark`) VALUES
(1, 3, 'admin', '792a63a25ede0a407927b58ea721700f', 'c415aeb460e13f87a8df72cf8ae9710a', '1,', 0, 0, NULL, '白大师', '/uploadfile/images/pctranimgs/banner_xlcp_01.png', '3010163688@qq.com', '18965121889', ''),
(4, NULL, 'baodashitea', '8b7eab041ce25422e068db064adb6c32', 'bc192f79169261d8c46aa6569a6cd9ce', '2,', 0, 0, NULL, '白大师', '', '', '', '');

--
-- 转储表的索引
--

--
-- 表的索引 `dt_article`
--
ALTER TABLE `dt_article`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dt_article_attribute_field`
--
ALTER TABLE `dt_article_attribute_field`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `PK_DT_ARTICLE_ATTRIBUTE_FIELD` (`id`);

--
-- 表的索引 `dt_article_attribute_value`
--
ALTER TABLE `dt_article_attribute_value`
  ADD PRIMARY KEY (`article_id`),
  ADD UNIQUE KEY `PK_DT_ARTICLE_ATTRIBUTE_VALUE` (`article_id`);

--
-- 表的索引 `dt_article_category`
--
ALTER TABLE `dt_article_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `PK_DT_ARTICLE_CATEGORY` (`id`);

--
-- 表的索引 `dt_article_goods`
--
ALTER TABLE `dt_article_goods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `PK_DT_ARTICLE_GOODS` (`id`);

--
-- 表的索引 `dt_channel`
--
ALTER TABLE `dt_channel`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dt_orders`
--
ALTER TABLE `dt_orders`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_resource`
--
ALTER TABLE `sys_resource`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_user`
--
ALTER TABLE `sys_user`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `dt_article`
--
ALTER TABLE `dt_article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自动编号', AUTO_INCREMENT=1455;

--
-- 使用表AUTO_INCREMENT `dt_article_category`
--
ALTER TABLE `dt_article_category`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=214;

--
-- 使用表AUTO_INCREMENT `dt_channel`
--
ALTER TABLE `dt_channel`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用表AUTO_INCREMENT `dt_orders`
--
ALTER TABLE `dt_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自动编号';

--
-- 使用表AUTO_INCREMENT `sys_resource`
--
ALTER TABLE `sys_resource`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- 使用表AUTO_INCREMENT `sys_user`
--
ALTER TABLE `sys_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
