BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"first_name"	varchar(30) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"last_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "hospital_appointment" (
	"id"	integer NOT NULL,
	"doctorId"	integer unsigned CHECK("doctorId" >= 0),
	"appointmentDate"	date NOT NULL,
	"description"	text NOT NULL,
	"status"	bool NOT NULL,
	"doctorName"	varchar(40),
	"patientName"	varchar(40),
	"patientId"	integer unsigned CHECK("patientId" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "hospital_patientdischargedetails" (
	"id"	integer NOT NULL,
	"patientName"	varchar(40) NOT NULL,
	"assignedDoctorName"	varchar(40) NOT NULL,
	"address"	varchar(40) NOT NULL,
	"mobile"	varchar(20),
	"symptoms"	varchar(100),
	"admitDate"	date NOT NULL,
	"releaseDate"	date NOT NULL,
	"daySpent"	integer unsigned NOT NULL CHECK("daySpent" >= 0),
	"roomCharge"	integer unsigned NOT NULL CHECK("roomCharge" >= 0),
	"medicineCost"	integer unsigned NOT NULL CHECK("medicineCost" >= 0),
	"doctorFee"	integer unsigned NOT NULL CHECK("doctorFee" >= 0),
	"OtherCharge"	integer unsigned NOT NULL CHECK("OtherCharge" >= 0),
	"total"	integer unsigned NOT NULL CHECK("total" >= 0),
	"patientId"	integer unsigned CHECK("patientId" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "hospital_patient" (
	"id"	integer NOT NULL,
	"address"	varchar(40) NOT NULL,
	"mobile"	varchar(20) NOT NULL,
	"symptoms"	varchar(100) NOT NULL,
	"assignedDoctorId"	integer unsigned CHECK("assignedDoctorId" >= 0),
	"status"	bool NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	"admitDate"	date NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "hospital_doctor" (
	"id"	integer NOT NULL,
	"address"	varchar(40) NOT NULL,
	"mobile"	varchar(20),
	"status"	bool NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	"profile_pic"	varchar(100),
	"department"	varchar(50) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2024-07-17 02:31:58.225668');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2024-07-17 02:31:58.406882');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2024-07-17 02:31:58.568211');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2024-07-17 02:31:58.733466');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2024-07-17 02:31:58.861939');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2024-07-17 02:31:59.173924');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2024-07-17 02:31:59.315489');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2024-07-17 02:31:59.456801');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2024-07-17 02:31:59.611496');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2024-07-17 02:31:59.775335');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2024-07-17 02:31:59.904409');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2024-07-17 02:32:00.061580');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2024-07-17 02:32:00.210775');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2024-07-17 02:32:00.353614');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2024-07-17 02:32:00.508601');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2024-07-17 02:32:00.699837');
INSERT INTO "django_migrations" VALUES (17,'hospital','0001_initial','2024-07-17 02:32:00.900612');
INSERT INTO "django_migrations" VALUES (18,'hospital','0002_delete_teacherextra','2024-07-17 02:32:01.024333');
INSERT INTO "django_migrations" VALUES (19,'hospital','0003_patient_admitdate','2024-07-17 02:32:01.159195');
INSERT INTO "django_migrations" VALUES (20,'hospital','0004_patientdischargedetails','2024-07-17 02:32:01.298412');
INSERT INTO "django_migrations" VALUES (21,'hospital','0005_appointment','2024-07-17 02:32:01.410918');
INSERT INTO "django_migrations" VALUES (22,'hospital','0006_appointment_status','2024-07-17 02:32:01.531693');
INSERT INTO "django_migrations" VALUES (23,'hospital','0007_auto_20200520_1023','2024-07-17 02:32:01.753260');
INSERT INTO "django_migrations" VALUES (24,'hospital','0008_doctor_profile_pic','2024-07-17 02:32:01.921709');
INSERT INTO "django_migrations" VALUES (25,'hospital','0009_auto_20200523_1118','2024-07-17 02:32:02.087960');
INSERT INTO "django_migrations" VALUES (26,'hospital','0010_auto_20200523_1122','2024-07-17 02:32:02.258108');
INSERT INTO "django_migrations" VALUES (27,'hospital','0011_auto_20200523_1325','2024-07-17 02:32:02.388558');
INSERT INTO "django_migrations" VALUES (28,'hospital','0012_auto_20200523_1336','2024-07-17 02:32:02.509200');
INSERT INTO "django_migrations" VALUES (29,'hospital','0013_patient_profile_pic','2024-07-17 02:32:02.643436');
INSERT INTO "django_migrations" VALUES (30,'hospital','0014_auto_20200526_1455','2024-07-17 02:32:02.821265');
INSERT INTO "django_migrations" VALUES (31,'hospital','0015_auto_20200526_1501','2024-07-17 02:32:03.007649');
INSERT INTO "django_migrations" VALUES (32,'hospital','0016_auto_20200622_1830','2024-07-17 02:32:03.182831');
INSERT INTO "django_migrations" VALUES (33,'hospital','0017_auto_20200622_1835','2024-07-17 02:32:03.441111');
INSERT INTO "django_migrations" VALUES (34,'hospital','0018_auto_20201015_2036','2024-07-17 02:32:03.656789');
INSERT INTO "django_migrations" VALUES (35,'hospital','0019_auto_20240211_2115','2024-07-17 02:32:03.830057');
INSERT INTO "django_migrations" VALUES (36,'sessions','0001_initial','2024-07-17 02:32:03.944256');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'hospital','patient');
INSERT INTO "django_content_type" VALUES (8,'hospital','doctor');
INSERT INTO "django_content_type" VALUES (9,'hospital','patientdischargedetails');
INSERT INTO "django_content_type" VALUES (10,'hospital','appointment');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_patient','Can add patient');
INSERT INTO "auth_permission" VALUES (26,7,'change_patient','Can change patient');
INSERT INTO "auth_permission" VALUES (27,7,'delete_patient','Can delete patient');
INSERT INTO "auth_permission" VALUES (28,7,'view_patient','Can view patient');
INSERT INTO "auth_permission" VALUES (29,8,'add_doctor','Can add doctor');
INSERT INTO "auth_permission" VALUES (30,8,'change_doctor','Can change doctor');
INSERT INTO "auth_permission" VALUES (31,8,'delete_doctor','Can delete doctor');
INSERT INTO "auth_permission" VALUES (32,8,'view_doctor','Can view doctor');
INSERT INTO "auth_permission" VALUES (33,9,'add_patientdischargedetails','Can add patient discharge details');
INSERT INTO "auth_permission" VALUES (34,9,'change_patientdischargedetails','Can change patient discharge details');
INSERT INTO "auth_permission" VALUES (35,9,'delete_patientdischargedetails','Can delete patient discharge details');
INSERT INTO "auth_permission" VALUES (36,9,'view_patientdischargedetails','Can view patient discharge details');
INSERT INTO "auth_permission" VALUES (37,10,'add_appointment','Can add appointment');
INSERT INTO "auth_permission" VALUES (38,10,'change_appointment','Can change appointment');
INSERT INTO "auth_permission" VALUES (39,10,'delete_appointment','Can delete appointment');
INSERT INTO "auth_permission" VALUES (40,10,'view_appointment','Can view appointment');
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
COMMIT;
