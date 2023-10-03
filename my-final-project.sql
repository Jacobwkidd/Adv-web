CREATE TABLE `user_roles` (
  `user_role_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user_role_name` varchar(30) NOT NULL,
  `user_role_desc` varchar(200) NOT NULL
);

INSERT INTO `user_roles` (`user_role_id`, `user_role_name`, `user_role_desc`) VALUES
(1, 'Tenant User', 'tenant user with tenant special permissions'),
(2, 'Landlord User', 'landlord user with landlord special permissions'),
(3, 'Admin', 'Extra permissions');

