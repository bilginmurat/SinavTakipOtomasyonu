-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for osx10.10 (x86_64)
--
-- Host: 0.0.0.0    Database: SinavTakipDb
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add classroom',7,'add_classroom'),(26,'Can change classroom',7,'change_classroom'),(27,'Can delete classroom',7,'delete_classroom'),(28,'Can view classroom',7,'view_classroom'),(29,'Can add department',8,'add_department'),(30,'Can change department',8,'change_department'),(31,'Can delete department',8,'delete_department'),(32,'Can view department',8,'view_department'),(33,'Can add Exam Date',9,'add_examdate'),(34,'Can change Exam Date',9,'change_examdate'),(35,'Can delete Exam Date',9,'delete_examdate'),(36,'Can view Exam Date',9,'view_examdate'),(37,'Can add feature',10,'add_feature'),(38,'Can change feature',10,'change_feature'),(39,'Can delete feature',10,'delete_feature'),(40,'Can view feature',10,'view_feature'),(41,'Can add lesson',11,'add_lesson'),(42,'Can change lesson',11,'change_lesson'),(43,'Can delete lesson',11,'delete_lesson'),(44,'Can view lesson',11,'view_lesson'),(45,'Can add department user',12,'add_departmentuser'),(46,'Can change department user',12,'change_departmentuser'),(47,'Can delete department user',12,'delete_departmentuser'),(48,'Can view department user',12,'view_departmentuser'),(49,'Can add Exam Time',13,'add_examtime'),(50,'Can change Exam Time',13,'change_examtime'),(51,'Can delete Exam Time',13,'delete_examtime'),(52,'Can view Exam Time',13,'view_examtime'),(53,'Can add classroom feature',14,'add_classroomfeature'),(54,'Can change classroom feature',14,'change_classroomfeature'),(55,'Can delete classroom feature',14,'delete_classroomfeature'),(56,'Can view classroom feature',14,'view_classroomfeature'),(57,'Can add lesson department',15,'add_lessondepartment'),(58,'Can change lesson department',15,'change_lessondepartment'),(59,'Can delete lesson department',15,'delete_lessondepartment'),(60,'Can view lesson department',15,'view_lessondepartment'),(61,'Can add process log',16,'add_processlog'),(62,'Can change process log',16,'change_processlog'),(63,'Can delete process log',16,'delete_processlog'),(64,'Can view process log',16,'view_processlog'),(65,'Can add request',17,'add_request'),(66,'Can change request',17,'change_request'),(67,'Can delete request',17,'delete_request'),(68,'Can view request',17,'view_request');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `is_approved`) VALUES (1,'pbkdf2_sha256$720000$SBMKWPVtyDrjiYri66rAvu$NqDn8OUGvzxLIrEgVtPW/Q7oYY5hUgFFtZtOn9m+gSA=','2024-12-12 10:55:23.816166',1,'bilginmurat','Murat','Bilgin','bilgin_murat@outlook.com',1,1,'2024-12-12 00:02:38.807238',1),(2,'pbkdf2_sha256$720000$IfxzoKsvNe0anIVDVcpcW9$3Uo2lS1p7zNEiOURE3kAK57XfiWdCktZqvGZ3vuk+O4=',NULL,0,'merve.oguz','Merve','İsabeyoğlu Oğuz','merve.oguz@erzincan.edu.tr',1,1,'2024-12-12 10:54:24.642723',1),(3,'pbkdf2_sha256$720000$KCHu5fum2DKI81oh7VeGKz$V7P62asgbWUDoTBINJgc92KUMusSD5OC5Xx99QvVw58=',NULL,0,'celik','Cengiz','Çelik','celik@erzincan.edu.tr',0,1,'2024-12-12 10:54:59.087874',1),(4,'pbkdf2_sha256$720000$6P35psI0bj5DOVLcLbz1tS$7jqvDNmQalUV7MxYyI61rZSZZ6N8YAyuzc47AJ8WLcQ=',NULL,0,'oalkan','Okan','Alkan','oalkan@erzincan.edu.tr',0,1,'2024-12-12 10:55:21.360691',1);
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Classes`
--

DROP TABLE IF EXISTS `Classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Classes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_date` datetime(6) NOT NULL DEFAULT (now(6)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Classes`
--

LOCK TABLES `Classes` WRITE;
/*!40000 ALTER TABLE `Classes` DISABLE KEYS */;
INSERT INTO `Classes` (`id`, `title`, `capacity`, `status`, `created_date`) VALUES (1,'Yazılım Mühendisliği Giriş Sınıfı',30,0,'2024-12-12 03:02:05.784975'),(2,'İleri Programlama Kursu',25,0,'2024-12-12 03:02:05.784975'),(3,'Siber Güvenlik Eğitimi',20,0,'2024-12-12 03:02:05.784975'),(4,'Bulut Bilişim Sertifika Programı',15,0,'2024-12-12 03:02:05.784975'),(5,'Veri Bilimi Yaz Okulu',40,0,'2024-12-12 03:02:05.784975'),(6,'Yapay Zeka Temel Eğitimi',35,0,'2024-12-12 03:02:05.784975'),(7,'Mobil Uygulama Geliştirme Kampı',25,0,'2024-12-12 03:02:05.784975'),(8,'Network Güvenliği Uzmanlaşma Programı',20,0,'2024-12-12 03:02:05.784975'),(9,'Robotik ve Otomasyon Kursu',30,0,'2024-12-12 03:02:05.784975'),(10,'Veri Tabanı Yönetimi Sertifika Programı',25,0,'2024-12-12 03:02:05.784975'),(11,'Nesne Yönelimli Programlama Atölyesi',20,0,'2024-12-12 03:02:05.784975'),(12,'Makine Öğrenmesi Uzmanlık Programı',35,0,'2024-12-12 03:02:05.784975'),(13,'Gömülü Sistemler Geliştirme Kursu',15,0,'2024-12-12 03:02:05.784975'),(14,'Oyun Geliştirme Akademisi',40,0,'2024-12-12 03:02:05.784975'),(15,'Görüntü İşleme ve Yapay Zeka Kursu',25,0,'2024-12-12 03:02:05.784975');
/*!40000 ALTER TABLE `Classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ClassFeatureRelation`
--

DROP TABLE IF EXISTS `ClassFeatureRelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ClassFeatureRelation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL DEFAULT (now(6)),
  `classroom_id` int DEFAULT NULL,
  `feature_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ClassFeatureRelation_classroom_id_54dd57ad_fk_Classes_id` (`classroom_id`),
  KEY `ClassFeatureRelation_feature_id_9b66e3ea_fk_Features_id` (`feature_id`),
  CONSTRAINT `ClassFeatureRelation_classroom_id_54dd57ad_fk_Classes_id` FOREIGN KEY (`classroom_id`) REFERENCES `Classes` (`id`),
  CONSTRAINT `ClassFeatureRelation_feature_id_9b66e3ea_fk_Features_id` FOREIGN KEY (`feature_id`) REFERENCES `Features` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ClassFeatureRelation`
--

LOCK TABLES `ClassFeatureRelation` WRITE;
/*!40000 ALTER TABLE `ClassFeatureRelation` DISABLE KEYS */;
INSERT INTO `ClassFeatureRelation` (`id`, `created_date`, `classroom_id`, `feature_id`) VALUES (1,'2024-12-12 03:08:03.974843',1,8),(2,'2024-12-12 03:08:03.974843',1,14),(3,'2024-12-12 03:08:03.974843',1,7),(4,'2024-12-12 03:08:03.974843',2,1),(5,'2024-12-12 03:08:03.974843',2,10),(6,'2024-12-12 03:08:03.974843',2,3),(7,'2024-12-12 03:08:03.974843',3,3),(8,'2024-12-12 03:08:03.974843',3,5),(9,'2024-12-12 03:08:03.974843',3,14),(10,'2024-12-12 03:08:03.974843',4,13),(11,'2024-12-12 03:08:03.974843',4,6),(12,'2024-12-12 03:08:03.974843',4,14),(13,'2024-12-12 03:08:03.974843',5,14),(14,'2024-12-12 03:08:03.974843',5,2),(15,'2024-12-12 03:08:03.974843',5,6),(16,'2024-12-12 03:08:03.974843',6,9),(17,'2024-12-12 03:08:03.974843',6,12),(18,'2024-12-12 03:08:03.974843',6,3),(19,'2024-12-12 03:08:03.974843',7,14),(20,'2024-12-12 03:08:03.974843',7,9),(21,'2024-12-12 03:08:03.974843',7,5),(22,'2024-12-12 03:08:03.974843',8,15),(23,'2024-12-12 03:08:03.974843',8,14),(24,'2024-12-12 03:08:03.974843',8,4),(25,'2024-12-12 03:08:03.974843',9,13),(26,'2024-12-12 03:08:03.974843',9,5),(27,'2024-12-12 03:08:03.974843',9,8),(28,'2024-12-12 03:08:03.974843',10,14),(29,'2024-12-12 03:08:03.974843',10,4),(30,'2024-12-12 03:08:03.974843',10,5),(31,'2024-12-12 03:08:03.974843',11,13),(32,'2024-12-12 03:08:03.974843',11,1),(33,'2024-12-12 03:08:03.974843',11,2),(34,'2024-12-12 03:08:03.974843',12,15),(35,'2024-12-12 03:08:03.974843',12,6),(36,'2024-12-12 03:08:03.974843',12,4),(37,'2024-12-12 03:08:03.974843',13,6),(38,'2024-12-12 03:08:03.974843',13,13),(39,'2024-12-12 03:08:03.974843',13,3),(40,'2024-12-12 03:08:03.974843',14,2),(41,'2024-12-12 03:08:03.974843',14,1),(42,'2024-12-12 03:08:03.974843',14,5),(43,'2024-12-12 03:08:03.974843',15,10),(44,'2024-12-12 03:08:03.974843',15,8),(45,'2024-12-12 03:08:03.974843',15,12);
/*!40000 ALTER TABLE `ClassFeatureRelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Departments`
--

DROP TABLE IF EXISTS `Departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Departments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Departments`
--

LOCK TABLES `Departments` WRITE;
/*!40000 ALTER TABLE `Departments` DISABLE KEYS */;
INSERT INTO `Departments` (`id`, `name`) VALUES (1,'Bilgisayar Mühendisliği'),(2,'Elektrik Elektronik Mühendisliği'),(3,'Makine Mühendisliği'),(4,'Yazılım Mühendisliği'),(5,'Endüstri Mühendisliği'),(6,'Mekatronik Mühendisliği'),(7,'Yapay Zeka Mühendisliği'),(8,'Veri Bilimi Mühendisliği'),(9,'Robotik Mühendisliği'),(10,'Network Mühendisliği');
/*!40000 ALTER TABLE `Departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DepartmentUserRelation`
--

DROP TABLE IF EXISTS `DepartmentUserRelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DepartmentUserRelation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `department_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `DepartmentUserRelation_department_id_e6440a66_fk_Departments_id` (`department_id`),
  KEY `DepartmentUserRelation_user_id_6ef447fa_fk_auth_user_id` (`user_id`),
  CONSTRAINT `DepartmentUserRelation_department_id_e6440a66_fk_Departments_id` FOREIGN KEY (`department_id`) REFERENCES `Departments` (`id`),
  CONSTRAINT `DepartmentUserRelation_user_id_6ef447fa_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DepartmentUserRelation`
--

LOCK TABLES `DepartmentUserRelation` WRITE;
/*!40000 ALTER TABLE `DepartmentUserRelation` DISABLE KEYS */;
INSERT INTO `DepartmentUserRelation` (`id`, `department_id`, `user_id`) VALUES (1,1,1),(2,1,2),(3,10,3),(4,4,4);
/*!40000 ALTER TABLE `DepartmentUserRelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(7,'SinavTakip','classroom'),(14,'SinavTakip','classroomfeature'),(8,'SinavTakip','department'),(12,'SinavTakip','departmentuser'),(9,'SinavTakip','examdate'),(13,'SinavTakip','examtime'),(10,'SinavTakip','feature'),(11,'SinavTakip','lesson'),(15,'SinavTakip','lessondepartment'),(16,'SinavTakip','processlog'),(17,'SinavTakip','request');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (1,'contenttypes','0001_initial','2024-12-12 10:45:59.583152'),(2,'auth','0001_initial','2024-12-12 10:45:59.677781'),(3,'SinavTakip','0001_initial','2024-12-12 10:45:59.816869'),(4,'admin','0001_initial','2024-12-12 10:45:59.840811'),(5,'admin','0002_logentry_remove_auto_add','2024-12-12 10:45:59.844925'),(6,'admin','0003_logentry_add_action_flag_choices','2024-12-12 10:45:59.848709'),(7,'contenttypes','0002_remove_content_type_name','2024-12-12 10:45:59.866034'),(8,'auth','0002_alter_permission_name_max_length','2024-12-12 10:45:59.876774'),(9,'auth','0003_alter_user_email_max_length','2024-12-12 10:45:59.887124'),(10,'auth','0004_alter_user_username_opts','2024-12-12 10:45:59.891082'),(11,'auth','0005_alter_user_last_login_null','2024-12-12 10:45:59.904817'),(12,'auth','0006_require_contenttypes_0002','2024-12-12 10:45:59.905339'),(13,'auth','0007_alter_validators_add_error_messages','2024-12-12 10:45:59.908463'),(14,'auth','0008_alter_user_username_max_length','2024-12-12 10:45:59.921824'),(15,'auth','0009_alter_user_last_name_max_length','2024-12-12 10:45:59.934654'),(16,'auth','0010_alter_group_name_max_length','2024-12-12 10:45:59.942529'),(17,'auth','0011_update_proxy_permissions','2024-12-12 10:45:59.946790'),(18,'auth','0012_alter_user_first_name_max_length','2024-12-12 10:45:59.961055'),(19,'auth','0013_user_is_approved','2024-12-12 10:45:59.975223'),(20,'sessions','0001_initial','2024-12-12 10:45:59.980380');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('st0o8rktpfkmyr6arduitcv5dzvs95xu','.eJxVjE0OgyAYBe_CuiGIiNJl956BfH8W2wYS0VXTu1cTF-32zcx7qwjbmuJWZYkzq6tq1OV3Q6Cn5APwA_K9aCp5XWbUh6JPWvVYWF630_07SFDTXluxzhhgpk5EAngDIv0QpOWBafLIbIEbJN_xFAhxl1oU1_bBuuCt-nwBKXY5iw:1tLgqp:RFIsB4pcoFdD2zwmyZgb8NPz_o7ZMEnjuc9rnEDWUWY','2024-12-26 10:55:23.817170');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_dates`
--

DROP TABLE IF EXISTS `exam_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_dates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_dates`
--

LOCK TABLES `exam_dates` WRITE;
/*!40000 ALTER TABLE `exam_dates` DISABLE KEYS */;
INSERT INTO `exam_dates` (`id`, `date`) VALUES (1,'2025-01-13'),(2,'2025-01-14'),(3,'2025-01-15'),(4,'2025-01-16'),(5,'2025-01-17'),(6,'2025-01-18'),(7,'2025-01-19'),(8,'2025-01-20'),(9,'2025-01-21'),(10,'2025-01-22'),(11,'2025-01-23'),(12,'2025-01-24'),(13,'2025-01-25'),(14,'2025-01-26');
/*!40000 ALTER TABLE `exam_dates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_times`
--

DROP TABLE IF EXISTS `exam_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_times` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_slot` varchar(11) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `date_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_times_date_id_81a232_idx` (`date_id`),
  CONSTRAINT `exam_times_date_id_f72b6221_fk_exam_dates_id` FOREIGN KEY (`date_id`) REFERENCES `exam_dates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_times`
--

LOCK TABLES `exam_times` WRITE;
/*!40000 ALTER TABLE `exam_times` DISABLE KEYS */;
INSERT INTO `exam_times` (`id`, `time_slot`, `status`, `date_id`) VALUES (1,'08:00-09:00',0,14),(2,'08:00-09:00',0,13),(3,'08:00-09:00',0,12),(4,'08:00-09:00',0,11),(5,'08:00-09:00',0,10),(6,'08:00-09:00',0,9),(7,'08:00-09:00',0,8),(8,'08:00-09:00',0,7),(9,'08:00-09:00',0,6),(10,'08:00-09:00',0,5),(11,'08:00-09:00',0,4),(12,'08:00-09:00',0,3),(13,'08:00-09:00',0,2),(14,'08:00-09:00',0,1),(15,'09:00-10:00',0,14),(16,'09:00-10:00',0,13),(17,'09:00-10:00',0,12),(18,'09:00-10:00',0,11),(19,'09:00-10:00',0,10),(20,'09:00-10:00',0,9),(21,'09:00-10:00',0,8),(22,'09:00-10:00',0,7),(23,'09:00-10:00',0,6),(24,'09:00-10:00',0,5),(25,'09:00-10:00',0,4),(26,'09:00-10:00',0,3),(27,'09:00-10:00',0,2),(28,'09:00-10:00',0,1),(29,'10:00-11:00',0,14),(30,'10:00-11:00',0,13),(31,'10:00-11:00',0,12),(32,'10:00-11:00',0,11),(33,'10:00-11:00',0,10),(34,'10:00-11:00',0,9),(35,'10:00-11:00',0,8),(36,'10:00-11:00',0,7),(37,'10:00-11:00',0,6),(38,'10:00-11:00',0,5),(39,'10:00-11:00',0,4),(40,'10:00-11:00',0,3),(41,'10:00-11:00',0,2),(42,'10:00-11:00',0,1),(43,'11:00-12:00',0,14),(44,'11:00-12:00',0,13),(45,'11:00-12:00',0,12),(46,'11:00-12:00',0,11),(47,'11:00-12:00',0,10),(48,'11:00-12:00',0,9),(49,'11:00-12:00',0,8),(50,'11:00-12:00',0,7),(51,'11:00-12:00',0,6),(52,'11:00-12:00',0,5),(53,'11:00-12:00',0,4),(54,'11:00-12:00',0,3),(55,'11:00-12:00',0,2),(56,'11:00-12:00',0,1),(57,'13:00-14:00',0,14),(58,'13:00-14:00',0,13),(59,'13:00-14:00',0,12),(60,'13:00-14:00',0,11),(61,'13:00-14:00',0,10),(62,'13:00-14:00',0,9),(63,'13:00-14:00',0,8),(64,'13:00-14:00',0,7),(65,'13:00-14:00',0,6),(66,'13:00-14:00',0,5),(67,'13:00-14:00',0,4),(68,'13:00-14:00',0,3),(69,'13:00-14:00',0,2),(70,'13:00-14:00',0,1),(71,'14:00-15:00',0,14),(72,'14:00-15:00',0,13),(73,'14:00-15:00',0,12),(74,'14:00-15:00',0,11),(75,'14:00-15:00',0,10),(76,'14:00-15:00',0,9),(77,'14:00-15:00',0,8),(78,'14:00-15:00',0,7),(79,'14:00-15:00',0,6),(80,'14:00-15:00',0,5),(81,'14:00-15:00',0,4),(82,'14:00-15:00',0,3),(83,'14:00-15:00',0,2),(84,'14:00-15:00',0,1),(85,'15:00-16:00',0,14),(86,'15:00-16:00',0,13),(87,'15:00-16:00',0,12),(88,'15:00-16:00',0,11),(89,'15:00-16:00',0,10),(90,'15:00-16:00',0,9),(91,'15:00-16:00',0,8),(92,'15:00-16:00',0,7),(93,'15:00-16:00',0,6),(94,'15:00-16:00',0,5),(95,'15:00-16:00',0,4),(96,'15:00-16:00',0,3),(97,'15:00-16:00',0,2),(98,'15:00-16:00',0,1),(99,'16:00-17:00',0,14),(100,'16:00-17:00',0,13),(101,'16:00-17:00',0,12),(102,'16:00-17:00',0,11),(103,'16:00-17:00',0,10),(104,'16:00-17:00',0,9),(105,'16:00-17:00',0,8),(106,'16:00-17:00',0,7),(107,'16:00-17:00',0,6),(108,'16:00-17:00',0,5),(109,'16:00-17:00',0,4),(110,'16:00-17:00',0,3),(111,'16:00-17:00',0,2),(112,'16:00-17:00',0,1),(113,'17:00-18:00',0,14),(114,'17:00-18:00',0,13),(115,'17:00-18:00',0,12),(116,'17:00-18:00',0,11),(117,'17:00-18:00',0,10),(118,'17:00-18:00',0,9),(119,'17:00-18:00',0,8),(120,'17:00-18:00',0,7),(121,'17:00-18:00',0,6),(122,'17:00-18:00',0,5),(123,'17:00-18:00',0,4),(124,'17:00-18:00',0,3),(125,'17:00-18:00',0,2),(126,'17:00-18:00',0,1);
/*!40000 ALTER TABLE `exam_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Features`
--

DROP TABLE IF EXISTS `Features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Features` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_date` datetime(6) NOT NULL DEFAULT (now(6)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Features`
--

LOCK TABLES `Features` WRITE;
/*!40000 ALTER TABLE `Features` DISABLE KEYS */;
INSERT INTO `Features` (`id`, `name`, `created_date`) VALUES (1,'Çevrimiçi Ders','2024-12-12 03:02:05.775760'),(2,'Laboratuvar Uygulaması','2024-12-12 03:02:05.775760'),(3,'Proje Tabanlı Eğitim','2024-12-12 03:02:05.775760'),(4,'Staj Programı','2024-12-12 03:02:05.775760'),(5,'Araştırma Projesi','2024-12-12 03:02:05.775760'),(6,'Mentörlük Desteği','2024-12-12 03:02:05.775760'),(7,'Uluslararası Sertifika','2024-12-12 03:02:05.775760'),(8,'Endüstri İş Birliği','2024-12-12 03:02:05.775760'),(9,'Açık Kaynak Kod Projesi','2024-12-12 03:02:05.775760'),(10,'Yazılım Geliştirme Kampı','2024-12-12 03:02:05.775760'),(11,'Yapay Zeka Atölyesi','2024-12-12 03:02:05.775760'),(12,'Network Güvenliği Eğitimi','2024-12-12 03:02:05.775760'),(13,'Veri Analizi Kursu','2024-12-12 03:02:05.775760'),(14,'Robotik Programlama','2024-12-12 03:02:05.775760'),(15,'Bulut Teknolojileri Sertifikası','2024-12-12 03:02:05.775760');
/*!40000 ALTER TABLE `Features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LessonDepartmentRel`
--

DROP TABLE IF EXISTS `LessonDepartmentRel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LessonDepartmentRel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `department_id` int DEFAULT NULL,
  `lesson_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `LessonDepartmentRel_department_id_1cff1747_fk_Departments_id` (`department_id`),
  KEY `LessonDepartmentRel_lesson_id_41bbe80c_fk_Lessons_id` (`lesson_id`),
  CONSTRAINT `LessonDepartmentRel_department_id_1cff1747_fk_Departments_id` FOREIGN KEY (`department_id`) REFERENCES `Departments` (`id`),
  CONSTRAINT `LessonDepartmentRel_lesson_id_41bbe80c_fk_Lessons_id` FOREIGN KEY (`lesson_id`) REFERENCES `Lessons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LessonDepartmentRel`
--

LOCK TABLES `LessonDepartmentRel` WRITE;
/*!40000 ALTER TABLE `LessonDepartmentRel` DISABLE KEYS */;
INSERT INTO `LessonDepartmentRel` (`id`, `department_id`, `lesson_id`) VALUES (1,3,1),(2,1,2),(3,1,3),(4,9,4),(5,4,5),(6,9,6),(7,3,7),(8,8,8),(9,1,9),(10,6,10),(11,10,11),(12,4,12),(13,8,13),(14,2,14),(15,10,15),(16,5,4);
/*!40000 ALTER TABLE `LessonDepartmentRel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lessons`
--

DROP TABLE IF EXISTS `Lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Lessons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(35) DEFAULT NULL,
  `is_have_class` tinyint(1) DEFAULT NULL,
  `created_date` datetime(6) NOT NULL DEFAULT (now(6)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lessons`
--

LOCK TABLES `Lessons` WRITE;
/*!40000 ALTER TABLE `Lessons` DISABLE KEYS */;
INSERT INTO `Lessons` (`id`, `name`, `is_have_class`, `created_date`) VALUES (1,'Algoritma ve Programlama',0,'2024-12-12 03:02:05.766370'),(2,'Veri Yapıları',0,'2024-12-12 03:02:05.766370'),(3,'Bilgisayar Ağları',0,'2024-12-12 03:02:05.766370'),(4,'Yapay Zeka Giriş',0,'2024-12-12 03:02:05.766370'),(5,'Mobil Uygulama Geliştirme',0,'2024-12-12 03:02:05.766370'),(6,'Veri Tabanı Yönetimi',0,'2024-12-12 03:02:05.766370'),(7,'Nesne Yönelimli Programlama',0,'2024-12-12 03:02:05.766370'),(8,'Siber Güvenlik',0,'2024-12-12 03:02:05.766370'),(9,'Bulut Bilişim',0,'2024-12-12 03:02:05.766370'),(10,'Makine Öğrenmesi',0,'2024-12-12 03:02:05.766370'),(11,'Yazılım Mühendisliği',0,'2024-12-12 03:02:05.766370'),(12,'Bilgisayar Mimarisi',0,'2024-12-12 03:02:05.766370'),(13,'Görüntü İşleme',0,'2024-12-12 03:02:05.766370'),(14,'Gömülü Sistemler',0,'2024-12-12 03:02:05.766370'),(15,'Oyun Geliştirme',0,'2024-12-12 03:02:05.766370');
/*!40000 ALTER TABLE `Lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProcessLog`
--

DROP TABLE IF EXISTS `ProcessLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProcessLog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `process_type` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `process_time` datetime(6) NOT NULL DEFAULT (now(6)),
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ProcessLog_user_id_20d734b2_fk_auth_user_id` (`user_id`),
  CONSTRAINT `ProcessLog_user_id_20d734b2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProcessLog`
--

LOCK TABLES `ProcessLog` WRITE;
/*!40000 ALTER TABLE `ProcessLog` DISABLE KEYS */;
INSERT INTO `ProcessLog` (`id`, `process_type`, `description`, `process_time`, `user_id`) VALUES (5,'2','oalkan kullanıcısı onaylandı.','2024-12-12 10:55:26.750585',1),(6,'2','merve.oguz kullanıcısı onaylandı.','2024-12-12 10:55:27.732183',1),(7,'2','celik kullanıcısı onaylandı.','2024-12-12 10:55:29.079592',1);
/*!40000 ALTER TABLE `ProcessLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Requests`
--

DROP TABLE IF EXISTS `Requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` int NOT NULL,
  `rejection_message` longtext,
  `request_date` datetime(6) NOT NULL DEFAULT (now(6)),
  `approved_user_id` int DEFAULT NULL,
  `classroom_id` int NOT NULL,
  `exam_time_id` int DEFAULT NULL,
  `requested_lesson_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Requests_approved_user_id_10947c75_fk_auth_user_id` (`approved_user_id`),
  KEY `Requests_classroom_id_9e3dff94_fk_Classes_id` (`classroom_id`),
  KEY `Requests_exam_time_id_80a77a26_fk_exam_times_id` (`exam_time_id`),
  KEY `Requests_requested_lesson_id_3110f4d2_fk_Lessons_id` (`requested_lesson_id`),
  KEY `Requests_user_id_48d0a61c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Requests_approved_user_id_10947c75_fk_auth_user_id` FOREIGN KEY (`approved_user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `Requests_classroom_id_9e3dff94_fk_Classes_id` FOREIGN KEY (`classroom_id`) REFERENCES `Classes` (`id`),
  CONSTRAINT `Requests_exam_time_id_80a77a26_fk_exam_times_id` FOREIGN KEY (`exam_time_id`) REFERENCES `exam_times` (`id`),
  CONSTRAINT `Requests_requested_lesson_id_3110f4d2_fk_Lessons_id` FOREIGN KEY (`requested_lesson_id`) REFERENCES `Lessons` (`id`),
  CONSTRAINT `Requests_user_id_48d0a61c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Requests`
--

LOCK TABLES `Requests` WRITE;
/*!40000 ALTER TABLE `Requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `Requests` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-12 13:56:36
