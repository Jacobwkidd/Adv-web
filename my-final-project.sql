CREATE TABLE `user_roles` (
  `user_role_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user_role_name` varchar(30) NOT NULL,
  `user_role_desc` varchar(200) NOT NULL
);

INSERT INTO `user_roles` (`user_role_id`, `user_role_name`, `user_role_desc`) VALUES
(1, 'Tenant User', 'tenant user with tenant special permissions'),
(2, 'Landlord User', 'landlord user with landlord special permissions'),
(3, 'Admin', 'Extra permissions');

CREATE TABLE landlord (
  landlord_user_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  landlord_user_first_name varchar(30) NOT NULL,
  landlord_user_last_name varchar(30) NOT NULL, 
  landlord_user_email varchar(100) NOT NULL UNIQUE,
  landlord_user_password char(255) NOT NULL,
  landlord_user_salt char(32) NOT NULL,
  landlord_user_role INT NOT NULL DEFAULT '2',
  landlord_user_active boolean NOT NULL DEFAULT true,
  FOREIGN KEY (user_role) REFERENCES user_roles(user_role_id)
);

CREATE TABLE tenant (
  tenant_user_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  tenant_user_first_name varchar(30) NOT NULL,
  tenant_user_last_name varchar(30) NOT NULL, 
  tenant_user_email varchar(100) NOT NULL UNIQUE,
  tenant_user_password char(255) NOT NULL,
  tenant_user_salt char(32) NOT NULL,
  tenant_user_role INT NOT NULL DEFAULT '1',
  tenant_user_active boolean NOT NULL DEFAULT true,
  FOREIGN KEY (user_role) REFERENCES user_roles(user_role_id)
);

CREATE TABLE properties(
  property_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  property_address varchar(255) NOT NULL,
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