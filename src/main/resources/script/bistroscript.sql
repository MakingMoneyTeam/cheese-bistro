# create user 'bistrocheese'@'%' identified by '12345678';
# grant all privileges on *.* to 'bistrocheese'@'%';
# flush privileges;

# select host, user from mysql.user;
#
# drop DATABASE if exists restaurant_management;
#
# CREATE DATABASE  restaurant_management;
# use  restaurant_management;
# show tables;

-- user domain --
CREATE TABLE `template` (
                            `id` int NOT NULL AUTO_INCREMENT,
                            `code` varchar(255) NOT NULL,
                            `content` varchar(255) NOT NULL,
                            `name` varchar(255) NOT NULL,
                            `title` varchar(255) NOT NULL,
                            `type` int NOT NULL,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- address --
drop table if exists `address`;
CREATE TABLE if not exists `address`  (
  `id` binary(16) NOT NULL,
  `addr_line` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- user--
drop table if exists `user`;
CREATE TABLE if not exists `user` (
  `id` binary(16) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `avt` varchar(255) DEFAULT NULL,
  `dob` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `enabled` bit(1) NOT NULL,
  `fst_name` varchar(255) DEFAULT NULL,
  `lst_name` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone_num` varchar(255) DEFAULT NULL,
  `role` int NOT NULL,
  `status` int DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `addr_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_addr_fk` FOREIGN KEY (`addr_id`) REFERENCES `address` (`id`),
  CONSTRAINT `user_chk_1` CHECK ((`role` between 0 and 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- token --
CREATE TABLE if not exists `token` (
  `id` binary(16) NOT NULL,
  `expired` bit(1) DEFAULT NULL,
  `revoked` bit(1) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_type` enum('BEARER') DEFAULT NULL,
  `usr_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `token_user_id` (`usr_id`),
  CONSTRAINT `token_user_fk` FOREIGN KEY (`usr_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- staff --
CREATE TABLE if not exists `staff` (
  `acdmic_lv` varchar(255) DEFAULT NULL,
  `frg_lg` varchar(255) DEFAULT NULL,
  `id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `staff_user_fk` FOREIGN KEY (`id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- owner --
CREATE TABLE if not exists `owner` (
  `branch` varchar(255) NOT NULL,
  `licen_business` varchar(255) NOT NULL,
  `id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `owner_user_fk` FOREIGN KEY (`id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- manager --
CREATE TABLE if not exists `manager` (
  `certi_managment` varchar(255) NOT NULL,
  `ex_y` varchar(255) NOT NULL,
  `frg_lg` varchar(255) NOT NULL,
  `id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `manager_user_fk` FOREIGN KEY (`id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE if not exists `schedule` (
  `id` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `staff_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `schedule_staff_id` (`staff_id`),
  CONSTRAINT `schedule_staff_fk` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- schedule_line --
CREATE TABLE if not exists `schedule_line` (
  `id` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `shift` tinyint NOT NULL,
  `status` tinyint DEFAULT NULL,
  `timekeeping_by` binary(16) DEFAULT NULL,
  `work_date` datetime(6) NOT NULL,
  `schedule_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `line_schedule_id` (`schedule_id`),
  CONSTRAINT `line_schedule_fk` FOREIGN KEY (`schedule_id`) REFERENCES `schedule` (`id`),
  CONSTRAINT `schedule_line_chk_1` CHECK ((`shift` between 0 and 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- user domain --

-- food domain --
-- category --
CREATE TABLE if not exists `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- food --
CREATE TABLE if not exists `food` (
  `id` binary(16) NOT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(38,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `status` int NOT NULL,
  `category_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_food_name` (`name`),
  KEY `food_category_id` (`category_id`),
  CONSTRAINT `food_category_fk` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- food domain --

-- order domain --

-- table --
CREATE TABLE if not exists `res_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seat_num` int NOT NULL,
  `tab_num` int DEFAULT NULL,
  `status` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `res_table_chk_1` CHECK ((`status` between 0 and 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




  -- order --
CREATE TABLE if not exists `res_order` (
  `id` binary(16) NOT NULL,
  `phone_cus` varchar(255) DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `staff_id` binary(16) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  PRIMARY KEY (`id`),
  KEY `orders_table_id` (`table_id`),
  KEY `orders_staff_id` (`staff_id`),
  CONSTRAINT `orders_staff_fk` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`),
  CONSTRAINT `orders_table_fk` FOREIGN KEY (`table_id`) REFERENCES `res_table` (`id`),
  CONSTRAINT `orders_chk_1` CHECK ((`status` between 0 and 3))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


  -- order line --
CREATE TABLE if not exists `order_line` (
  `id` binary(16) NOT NULL,
  `quantity` int DEFAULT NULL,
  `food_id` binary(16) DEFAULT NULL,
  `order_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `o_line_food_key` (`food_id`),
  KEY `o_line_orders_key` (`order_id`),
  CONSTRAINT `o_line_food_fk` FOREIGN KEY (`food_id`) REFERENCES `food` (`id`),
  CONSTRAINT `o_line_orders_fk` FOREIGN KEY (`order_id`) REFERENCES `res_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE if not exists `transfer_method` (
  `id` int NOT NULL AUTO_INCREMENT,
  `acc_holder_name` varchar(255) NOT NULL,
  `acc_num` varchar(255) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `method_name` varchar(255) NOT NULL,
  `method_type` tinyint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  PRIMARY KEY (`id`),
  CONSTRAINT `transfer_method_chk_1` CHECK ((`method_type` between 0 and 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE if not exists `payment` (
  `id` binary(16) NOT NULL,
  `type` tinyint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `cus_nme` varchar(255) NOT NULL,
  `phone_num` varchar(255) NOT NULL,
  `method_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `key_payment_method` (`method_id`),
  CONSTRAINT `payment_method_fk` FOREIGN KEY (`method_id`) REFERENCES `transfer_method` (`id`),
  CONSTRAINT `payment_chk_1` CHECK ((`type` between 0 and 7))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE if not exists `discount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `type` tinyint NOT NULL,
  `uses_cnt` int DEFAULT NULL,
  `uses_max` int DEFAULT NULL,
  `value` decimal(38,2) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `name` varchar(255) NOT NULL,
   `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE if not exists `bill` (
  `id` binary(16) NOT NULL,
  `change_paid` decimal(38,2) DEFAULT NULL,
  `cus_in` datetime(6) DEFAULT NULL,
  `cus_out` datetime(6) DEFAULT NULL,
  `paid` decimal(38,2) DEFAULT NULL,
  `sub_total` decimal(38,2) DEFAULT NULL,
  `total` decimal(38,2) DEFAULT NULL,
  `discount_id` int DEFAULT NULL,
  `order_id` binary(16) DEFAULT NULL,
  `pay_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bill_orders_key` (`order_id`),
  KEY `bill_discount_key` (`discount_id`),
  KEY `bill_pay_key` (`pay_id`),
  CONSTRAINT `bill_orders_fk` FOREIGN KEY (`pay_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `bill_discount_fk` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`id`),
  CONSTRAINT `bill_pay_fk` FOREIGN KEY (`order_id`) REFERENCES `res_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- order domain --

-- inventory domain --
CREATE TABLE if not exists `ingredient` (
  `id` bigint NOT NULL auto_increment,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ingredient_type` tinyint NOT NULL,
  `name` varchar(45) NOT NULL,
  `supplier` varchar(255) NOT NULL,
  `unit` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE if not exists `inventory` (
  `id` binary(16) NOT NULL,
  `ingredient_id` bigint NOT NULL,
  `total_quan` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  PRIMARY KEY (`id`),
  KEY `inventory_ingredient_id_idx` (`ingredient_id`),
  CONSTRAINT `inventory_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE if not exists `operation` (
  `id` binary(16) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` binary(16) DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `quantity` double NOT NULL,
  `type` tinyint NOT NULL,
  `inventory_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `operation_inven_key` (`inventory_id`),
  CONSTRAINT `operation_inven_fk` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`),
  CONSTRAINT `operation_chk_1` CHECK ((`type` between 0 and 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- inventory domain --

-- daily revenue --

CREATE TABLE if not exists `daily_revenue`
 (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` datetime(6) NOT NULL,
  `revenue` decimal(38,2) DEFAULT NULL,
  `num_of_orders` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `restaurant_management`.`daily_revenue`
ADD UNIQUE INDEX `date_UNIQUE` (`date` ASC) VISIBLE;
;

-- Create trigger report daily revenue
-- Insert Bill Trigger --
DROP TRIGGER IF EXISTS trg_after_bill_insert;
DELIMITER //
CREATE TRIGGER trg_after_bill_insert
AFTER INSERT ON bill
FOR EACH ROW
BEGIN
    DECLARE revenue_exists INT;
    DECLARE total_amount DECIMAL(38,2);

    -- Check if a record already exists for the current date in daily_revenue
    SELECT COUNT(*) INTO revenue_exists FROM daily_revenue WHERE `date` = DATE(NEW.cus_out);

    -- If a record exists, update it, otherwise insert a new record
    IF revenue_exists > 0 THEN
        -- Update existing record
        UPDATE daily_revenue
        SET `revenue` = `revenue` + NEW.total,
            `num_of_orders` = `num_of_orders` + 1
        WHERE `date` = DATE(NEW.cus_out);
    ELSE
        -- Insert a new record
        INSERT INTO daily_revenue (`date`, `revenue`, `num_of_orders`)
        VALUES (DATE(NEW.cus_out), NEW.total, 1);
    END IF;
END //

DELIMITER ;

-- Delete Bill Trigger --
DELIMITER //

CREATE TRIGGER trg_after_bill_delete
AFTER DELETE ON bill
FOR EACH ROW
BEGIN
    DECLARE revenue_exists INT;
    DECLARE total_amount DECIMAL(38,2);

    -- Check if a record already exists for the current date in daily_revenue
    SELECT COUNT(*) INTO revenue_exists FROM daily_revenue WHERE `date` = DATE(OLD.cus_out);

    -- If a record exists, update it, otherwise do nothing (as it shouldn't happen)
    IF revenue_exists > 0 THEN
        -- Update existing record
        UPDATE daily_revenue
        SET `revenue` = `revenue` - OLD.total,
            `num_of_orders` = `num_of_orders` - 1
        WHERE `date` = DATE(OLD.cus_out);
    END IF;
END //

DELIMITER ;;


-- UPDATE BILL TRIGGER
DELIMITER //

CREATE TRIGGER trg_after_bill_update
AFTER UPDATE ON bill
FOR EACH ROW
BEGIN
    DECLARE revenue_exists INT;
    DECLARE total_amount DECIMAL(38,2);

    -- Check if a record already exists for the current date in daily_revenue
    SELECT COUNT(*) INTO revenue_exists FROM daily_revenue WHERE `date` = DATE(OLD.cus_out);

    -- If a record exists, update it, otherwise do nothing (as it shouldn't happen)
    IF revenue_exists > 0 THEN
        -- Update existing record
        UPDATE daily_revenue
        SET `revenue` = `revenue` - OLD.total
        WHERE `date` = DATE(OLD.cus_out);

        UPDATE daily_revenue
        SET `revenue` = `revenue` + NEW.total
        WHERE `date` = DATE(OLD.cus_out);

    END IF;
END //

DELIMITER ;;

-- daily revenue --

-- INSERT  DB
-- Category --
-- Drink, Appetizer, Main Course, Dessert
INSERT INTO `restaurant_management`.`category`
(`id`, `name`) VALUES (1, "Appetizer");
INSERT INTO `restaurant_management`.`category`
(`id`, `name`) VALUES (2, "Main Course");
INSERT INTO `restaurant_management`.`category`
(`id`, `name`) VALUES (3, "Dessert");
INSERT INTO `restaurant_management`.`category`
(`id`, `name`) VALUES (4, "Drink");

-- insert address --
INSERT INTO `restaurant_management`.`address`
(`id`, `addr_line`, `city`, `region`)
VALUES (1, '123 Duong so 1', 'Long An', 'Southern');
INSERT INTO `restaurant_management`.`address`
(`id`, `addr_line`, `city`, `region`)
VALUES (2, 'Dang Tran Con', 'Quang Tri', 'Midside');
INSERT INTO `restaurant_management`.`address`
(`id`, `addr_line`, `city`, `region`)
VALUES (3, 'Tran Hung Dao', 'Binh Duong', 'Southern');
INSERT INTO `restaurant_management`.`address`
(`id`, `addr_line`, `city`, `region`)
VALUES (4, 'Thanh Khe', 'Da Nang', 'Midside');


-- insert user --
-- insert manager --
START TRANSACTION;
INSERT INTO `restaurant_management`.`user`
(`id`, `fst_name`, `lst_name`, `dob`, `phone_num`, `username`, `email`, `password`, `role`, `status`, `addr_id`, `enabled`)
VALUES (1, 'Tuan', 'Nguyen', '2003-02-21 00:00:00', '0810000005', 'tuanmanager', 'tuannguyen.manager@gmail.com', '$2a$10$uCKotqDQ9RP5UIKKS9kbL.gvu/gIoiyzTp9XRvFJC6.7a.PzShptW', '1', '0', 2, true);
INSERT INTO `restaurant_management`.`manager`
(`id`, `certi_managment`, `frg_lg`, `ex_y`)
VALUES (1, 'Restaurant Management Certification', 'English', '2');

INSERT INTO `restaurant_management`.`user`
(`id`, `fst_name`, `lst_name`, `dob`, `phone_num`, `username`, `email`, `password`, `role`, `status`, `addr_id`, `enabled`)
VALUES (2, 'Long', 'Tran', '2003-09-22 00:00:00', '0810000006', 'longmanager', 'longtran.manager@gmail.com', '$2a$10$ICoQ4J3I8GFO4HealbbZk.Dxh069TIHCXKW/zka9zl7RaAwEqNTBC', '1', '0', 1, true);
INSERT INTO `restaurant_management`.`manager`
(`id`, `certi_managment`, `frg_lg`, `ex_y`)
VALUES (2, 'AWS Certification', 'ThaiLand', '1');

INSERT INTO `restaurant_management`.`user`
(`id`, `fst_name`, `lst_name`, `dob`, `phone_num`, `username`, `email`, `password`, `role`, `status`, `addr_id`, `enabled`)
VALUES (3, 'Nhat', 'Nguyen', '2003-08-17 00:00:00', '0810000004', 'nhatmanager', 'nhatnguyen.manager@gmail.com', '$2a$10$h7kq534JmguEGeBEGlUg7u8L29.ZEYjszMErH6UXjqrouKsTNXnce', '1', '0', 4, true);
INSERT INTO `restaurant_management`.`manager`
(`id`, `certi_managment`, `frg_lg`, `ex_y`)
VALUES (3, 'ReactJs Certification', 'Singapore', '3');
COMMIT;

-- insert owner --
Start transaction;
INSERT INTO `restaurant_management`.`user`
(`id`, `fst_name`, `lst_name`, `dob`, `phone_num`, `username`, `email`, `password`, `role`, `status`, `addr_id`, `enabled`)
VALUES (4, 'Tuan', 'Nguyen', '2003-02-21 00:00:00', '0810000002', 'tuanowner', 'tuannguyen.owner@gmail.com', '$2a$10$qnr.Xcx1D//yI.MFP2xWSefM6pySLqMknFxMqThHinfluWpDBzJLW', '0', '0', 2, true);
INSERT INTO `restaurant_management`.`owner`
(`id`, `branch`, `licen_business`) VALUES (4, 'Quang Tri', 'Bistro Cheese License');

INSERT INTO `restaurant_management`.`user`
(`id`, `fst_name`, `lst_name`, `dob`, `phone_num`, `username`, `email`, `password`, `role`, `status`, `addr_id`, `enabled`)
VALUES (5, 'Long', 'Tran', '2003-09-22 00:00:00', '0810000001', 'longowner', 'longtran.owner@gmail.com', '$2a$10$8gigr/cESvHD1W7CO.BGL.hHqnLJmB.q9l.wiMssTI8OHgAbh6bG.', '0', '0', 1, true);
INSERT INTO `restaurant_management`.`owner`
(`id`, `branch`, `licen_business`) VALUES (5, 'Long An', 'Bistro Cheese License');

INSERT INTO `restaurant_management`.`user`
(`id`, `fst_name`, `lst_name`, `dob`, `phone_num`, `username`, `email`, `password`, `role`, `status`, `addr_id`, `enabled`)
VALUES (6, 'Nhat', 'Nguyen', '2003-02-21 00:00:00', '0810000003', 'nhatowner', 'nhatnguyen.owner@gmail.com', '$2a$10$7bHks1.nHhTIJkNyy4mPveQgtPiqW6jNzed072wUvKW904uVWfLZy', '0', '0', 4, true);
INSERT INTO `restaurant_management`.`owner`
(`id`, `branch`, `licen_business`) VALUES (6, 'Thanh Khe', 'Bistro Cheese License');
commit;

start transaction;
INSERT INTO `restaurant_management`.`user`
(`id`, `fst_name`, `lst_name`, `dob`, `phone_num`, `username`, `email`, `password`, `role`, `status`, `addr_id`, `enabled`)
VALUES (7, 'Long', 'Tran', '2003-09-22 00:00:00', '0810000007', 'longstaff', 'longtran.staff@gmail.com', '$2a$10$hi5/QcQ2EiPvTcz.NKFXz.q3PzQpNJPkCuZUpO0ULeC8aLTSypE2K', '2', '0', 1, true);
INSERT INTO `restaurant_management`.`staff`
(`id`, `acdmic_lv`, `frg_lg`)
VALUES(7, 'Senior', 'ThaiLand');

INSERT INTO `restaurant_management`.`user`
(`id`, `fst_name`, `lst_name`, `dob`, `phone_num`, `username`, `email`, `password`, `role`, `status`, `addr_id`, `enabled`)
VALUES (8, 'Quoc', 'Anh', '2003-10-22 00:00:00', '0810000009', 'quocstaff', 'quoctran.staff@gmail.com', '$2a$10$1/fQ17XKlMUz5J8j64OJe.HL5o0.peUTMxr.VBdHyrtZDX.kiEPYC', '2', '0', 4, true);
INSERT INTO `restaurant_management`.`staff`
(`id`, `acdmic_lv`, `frg_lg`)
VALUES(8, 'Fullstack', 'American');

INSERT INTO `restaurant_management`.`user`
(`id`, `fst_name`, `lst_name`, `dob`, `phone_num`, `username`, `email`, `password`, `role`, `status`, `addr_id`, `enabled`)
VALUES (9, 'Duy Van', 'Le', '2003-06-08 00:00:00', '0810000008', 'duystaff', 'duyle.staff@gmail.com', '$2a$10$J2ZrW4BlUM8YfH5wE/iXKOXe9jtsNcUL0RRnRu7NqWpWopr8xi2Fa', '2', '0', 3, true);
INSERT INTO `restaurant_management`.`staff`
(`id`, `acdmic_lv`, `frg_lg`)
VALUES(9, 'Cloud Native', 'Campuchian');
commit;

-- insert food --
-- appetizer --
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("30420338-8127-11", "Bánh mì nướng với Phô Mai Camembert", 1, "Bánh mì nướng giòn với lớp vỏ ngoài và phô mai Camembert nướng tan chảy bên trong. Được kèmtheo mứt dâu và hạt dẻ.", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777758/appetizer1_qmtpcx.jpg", 1, 40000);

INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("30420586-8127-11", "Salad Cà Chua Caprese", 1, "Cà chua tươi ngon, phô mai Mozzarella cắt lát mỏng, và lá bạc hà, tất cả được chế biến cùng với dầu ô-liu và nước cốt chanh", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777758/appetizer2_yukeyl.jpg", 1, 35000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("304206b2-8127-11", "Bánh Mì Sandwich Phô Mai Gruyère và Prosciutto", 1, "Bánh mì sandwich với lớp phô mai Gruyère thơm ngon và lớp Prosciutto mỏng, nướng vàng giòn.", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777758/appetizer3_ahte6i.jpg", 1, 49000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("304207d4", "Bánh mì nướng với Phô Mai Ricotta và Mứt Dâu", 1, "Bánh mì nướng với phô mai Ricotta mềm mịn và mứt dâu ngọt ngào", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777758/appetizer4_fylmuj.jpg", 1, 49000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("30420e46-8127-11", "Hộp Súp Hành Phô Mai", 1, "Súp hành trắng thơm ngon, phủ lớp phô mai Swiss nướng trên mặt", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777758/appetizer5_tq88yg.jpg", 1, 49000);
-- main course --
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("82a4522e-8128-11", "Bánh Mì Burger Phô Mai", 2, "Burger bò mỹ phẩm với phô mai Cheddar, hành tây, bơ rút, và rau sống trên bánh mì hấp", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/pizza1_ul8uos.jpg", 1, 109000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("82a4551c-8128-11", "Pizza Quattro Formaggi", 2, "Pizza với tổ hợp bốn loại phô mai: Mozzarella, Gorgonzola, Parmesan và Ricotta", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/pizza2_ffelxl.jpg", 1, 129000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("82a45652-8128-11", "Ravioli Phô Mai với Sốt Nấm Trắng", 2, "Ravioli nhân phô mai Ricotta, được phủ lớp sốt nấm trắng kem ngon", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777760/pizza3_kbwhai.jpg", 1, 139000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("82a45c10-8128-11", "Lasagna Bolognese với Phô Mai Parmesan", 2, "Lasagna cổ điển với lớp bò bolognese, mousse phô mai Ricotta và phủ lớp phô mai Parmesan nướng", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777760/pizza4_kj9l4r.jpg", 1, 139000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("82a45da0-8128-11", "Quiche Lorraine với Phô Mai Gruyère", 2, "Quiche với nhân bánh béo ngậy, bacon và phô mai Gruyère", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777758/pizza5_i1jtmq.jpg", 1, 139000);
-- INSERT DESSERT
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("31279a4a-8129-11", "Bánh Phô Mai New York Cheesecake", 3, "Cheesecake New York đậm đà với lớp phô mai kem trên đỉnh, được kết hợp với sốt dâu tây", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/dessert1_ow1xpt.jpg", 1, 79000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("31279e3c-8129-11", "Mousse Phô Mai với Hương Vị Cam", 3, "Mousse phô mai mềm mịn với hương vị cam tự nhiên và lớp kem sữa tươi", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/dessert2_citu5i.jpg", 1, 79000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("31279fa4-8129-11", "Bánh Roulade Phô Mai với Sốt Sô-cô-la", 3, "Bánh cuốn mềm mịn với nhân phô mai và phủ lớp sốt sô-cô-la đắng", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/dessert3_qthtc3.jpg", 1, 79000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("3127a0bc-8129-11", "Panna Cotta vị Phô Mai với Quả Dâu", 3, "Panna Cotta đặc biệt với hương vị phô mai, kèm theo quả dâu tươi ngon.", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/dessert4_xjvsg4.jpg", 1, 49000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("3127a22e-8129-11", "Tiramisu với Lớp Phô Mai Mascarpone", 3, "Tiramisu truyền thống với lớp phô mai Mascarpone thơm ngon và bột cacao", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/dessert5_qczscm.jpg", 1, 49000);
-- INSERT DRINK
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("25334440-812a-11", "Martini Phô Mai", 4, "Một phiên bản độc đáo của Martini với phô mai Blue Cheese và một lát hành vàng", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/drink1_nkrxcv.jpg", 1, 39000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("253346f2-812a-11", "Wine & Cheese Pairing", 4, "Menu chọn món ăn kèm với các loại rượu và phô mai, bao gồm Chardonnay và Gouda, Merlot và Brie, và Shiraz và Gorgonzola", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/drink2_gozuq1.jpg", 1, 39000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("25334800-812a-11", "Cappuccino Phô Mai", 4, "Cappuccino béo ngậy với lớp bọt sữa phô mai và bột cacao", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/drink3_m3yvt3.jpg", 1, 39000);

INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("25334d3c-812a-11", "Sữa Phô Mai Dâu", 4, "Sữa dâu thơm ngon kèm theo lớp phô mai cream trên đỉnh", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/drink4_yci0mm.jpg", 1, 39000);
INSERT INTO `restaurant_management`.`food`
(`id`, `name`, `category_id`, `description`, `image`, `status`, `price`)
VALUES
("25334e7c-812a-11", "Espresso Affogato", 4, "Espresso đen và nóng với một viên cà phê kem và lớp phô mai Mascarpone", "https://res.cloudinary.com/dc6io9an2/image/upload/v1699777759/drink5_ltn4zp.jpg", 1, 39000);



