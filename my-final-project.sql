DROP TABLE IF EXISTS 'user_roles';
DROP TABLE IF EXISTS 'users';
DROP TABLE IF EXISTS 'landlord';
DROP TABLE IF EXISTS 'tenant';
DROP TABLE IF EXISTS 'property';
DROP TABLE IF EXISTS 'rent_paid';
CREATE TABLE `user_roles` (
  `user_role_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user_role_name` varchar(30) NOT NULL,
  `user_role_desc` varchar(200) NOT NULL
);

INSERT INTO `user_roles` (`user_role_id`, `user_role_name`, `user_role_desc`) VALUES
(1, 'Tenant User', 'tenant user with tenant special permissions'),
(2, 'Landlord User', 'landlord user with landlord special permissions'),
(3, 'Admin', 'Extra permissions');

CREATE TABLE users (
  user_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_first_name varchar(30) NOT NULL,
  user_last_name varchar(30) NOT NULL, 
  user_email varchar(100) NOT NULL UNIQUE,
  user_password char(255) NOT NULL,
  user_salt char(32) NOT NULL,
  user_role INT NOT NULL DEFAULT '1',
  user_active boolean NOT NULL DEFAULT true,
  FOREIGN KEY (user_role) REFERENCES user_roles(user_role_id)
);

CREATE TABLE landlord (
  landlord_user_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  landlord_user_first_name varchar(30) NOT NULL,
  landlord_user_last_name varchar(30) NOT NULL, 
  landlord_user_email varchar(100) NOT NULL UNIQUE,
  landlord_user_password char(255) NOT NULL,
  FOREIGN KEY (landlord_user_id) REFERENCES users(user_id)
);

INSERT INTO `landlord`(`landlord_user_id`, `landlord_user_first_name`,`landlord_user_last_name`,`landlord_user_email`,`landlord_user_password`) VALUES
(1, "Bob", "Smith", "bobsmith@smithprop.com", "123"),
(2, "Gill", "Corn", "gillcorn@cornprop.com", "123"),
(3, "Billy", "Hour", "billyhour@hourprop.com", "123"),
(4, "Michael", "Parker", "michaelparker@parkerprop.com", "123"),
(5, "Seth", "Campbell", "sethcampbell@campbellprop.com", "123");

CREATE TABLE tenant (
  tenant_user_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  tenant_user_first_name varchar(30) NOT NULL,
  tenant_user_last_name varchar(30) NOT NULL, 
  tenant_user_email varchar(100) NOT NULL UNIQUE,
  tenant_user_password char(255) NOT NULL,
  FOREIGN KEY (tenant_user_id) REFERENCES users(user_id)
);

CREATE TABLE properties(
  property_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  property_address varchar(255) NOT NULL,
  property_city varchar(255) NOT NULL,
  property_state varchar(255) NOT NULL,
  property_zip_code int NOT NULL,
  rent int(11) NOT NULL,
  FOREIGN KEY (landlord) REFERENCES landlord(landlord_user_id), 
  FOREIGN KEY (tenant) REFERENCES tenant(tenant_user_id)
);


CREATE TABLE rent_paid(
  rent_paid_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  rent_paid_date DATE,
  FOREIGN KEY (properties) REFERENCES properties(property_id),
  rent_amount int(11) NOT NULL
);