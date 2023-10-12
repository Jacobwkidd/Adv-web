DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS landlord;
DROP TABLE IF EXISTS tenant;
DROP TABLE IF EXISTS property;
DROP TABLE IF EXISTS rent_paid;
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
  user_role INT NOT NULL,
  user_active boolean NOT NULL DEFAULT true,
  FOREIGN KEY (user_role) REFERENCES user_roles(user_role_id)
);

CREATE TABLE landlord (
  landlord_user_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  landlord_user_first_name varchar(30) NOT NULL,
  landlord_user_last_name varchar(30) NOT NULL, 
  landlord_user_email varchar(100) NOT NULL UNIQUE,
  landlord_user_password char(255) NOT NULL
  -- FOREIGN KEY (landlord_user_id) REFERENCES users(user_id)
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
  tenant_user_password char(255) NOT NULL
  -- FOREIGN KEY (tenant_user_id) REFERENCES users(user_id)
);

INSERT INTO `tenant`(`tenant_user_id`, `tenant_user_first_name`, `tenant_user_last_name`, `tenant_user_email`, `tenant_user_password`) VALUES 
(1, "Jif", "Silly", "jifsally@gmail.com", "123"),
(2, "Jeff", "Jacobson", "jeffjacobson@gmail.com", "123"),
(3, "Sally", "Green", "sallygreen@gmail.com", "123"),
(4, "May", "Clausen", "maycleusen@gmail.com", "123"),
(5, "Alex", "Schiender", "alexsch@gmail.com", "123"),
(6, "Alec", "Windsor", "alecwindsor@gmail.com", "123"),
(7, "Alix", "Java", "alixjave@yahoo.com", "123"),
(8, "Jacob", "Pries", "jacobpries@gmail.com", "123"),
(9, "Luke", "Brown", "lukebrown@gmail.com", "123"),
(10, "Matt", "Smith", "mattsmith@gmail.com", "123"),
(11, "Paul", "Play", "paulplay@gmail.com", "123"),
(12, "Grace", "Wood", "gracewood@gmail.com", "123"),
(13, "Carter", "Lockwood", "carterlockwood@gmail.com", "123"),
(14, "Darth", "Vader", "darthvader@deathstar.com", "123"),
(15, "Peter", "Walsh", "petrwalsh@england.com", "123");


CREATE TABLE properties(
  property_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  property_address varchar(255) NOT NULL,
  property_city varchar(255) NOT NULL,
  property_state varchar(255) NOT NULL,
  property_zip_code int NOT NULL,
  rent int(11) NOT NULL
  -- FOREIGN KEY (landlord) REFERENCES landlord(landlord_user_id), 
  -- FOREIGN KEY (tenant) REFERENCES tenant(tenant_user_id)
);

INSERT INTO `properties`(`property_id`, `property_address`, `property_city`, `property_state`, `property_zip_code`, `rent`) VALUES 
(1, '123 Main St', "La Crosse", "WI", 54601, 500),
(2, '456 Elm St', "Miami", "FL", 33101, 1500),
(3, '789 Oak St', "Miami", "FL", 33109, 4000),
(4, '101 Pine St', "New York", "NY", 10001, 5000),
(5, '202 Maple St', "Madison", "WI", 53558, 1500),
(6, '303 Birch St', "Madison", "WI", 53562, 1500),
(7, '404 Cedar St', "Madison", "WI", 53703, 1500),
(8, '505 Spruce St', "Portland", "ME", 04101, 1500),
(9, '606 Redwood St', "Portlan", "ME", 04102, 1500),
(10, '707 Sequoia St', "Miami", "FL", 33102, 1500),
(11, '808 Pine St', "Miami", "FL", 33102, 2500),
(12, '909 Elm St', "Miami", "FL", 33102, 2500),
(13, '1010 Oak St', "Miami", "FL", 33102, 2500),
(14, '1111 Cedar St', "Miami", "FL", 33102, 2500),
(15, '1212 Maple St', "Miami", "FL", 33102, 14000);

CREATE TABLE rent_paid(
  rent_paid_id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  rent_paid_date DATE,
  -- FOREIGN KEY (properties) REFERENCES properties(property_id),
  -- FOREIGN KEY (properties) REFERENCES properties(rent),
  rent_amount int(11) NOT NULL
);