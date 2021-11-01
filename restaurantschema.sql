-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `restaurant` DEFAULT CHARACTER SET utf8 ;
USE `restaurant` ;

-- -----------------------------------------------------
-- Table `restaurant`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`Order` (
  `Order_id` INT NOT NULL,
  `totalprice` FLOAT NULL,
  `meal_id` INT NULL,
  `customer_id` INT NULL,
  `date` DATETIME NULL,
  `ordertype_id` INT NULL,
  PRIMARY KEY (`Order_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`Breakfast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`Breakfast` (
  `breakfast_key` INT NOT NULL,
  `meal_id` INT NOT NULL,
  `Breakfast_food_options` VARCHAR(4000) NULL,
  `Breakfast_drink_options` VARCHAR(4000) NULL,
  `breakfast_option_open` DATETIME NULL,
  `breakfast_option_closed` DATETIME NULL,
  PRIMARY KEY (`breakfast_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`Lunch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`Lunch` (
  `lunch_key` INT NOT NULL,
  `meal_id` INT NOT NULL,
  `lunch_food_options` VARCHAR(4000) NULL,
  `lunch_drink_options` VARCHAR(4000) NULL,
  `lunch_option_open` DATETIME NULL,
  `lunch_option_closed` DATETIME NULL,
  PRIMARY KEY (`lunch_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`Full Meal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`Full Meal` (
  `meal_id` INT NOT NULL,
  `order_id` INT NULL,
  `customer_id` INT NULL,
  `meal_price` FLOAT NULL,
  `breakfast_key` INT NULL,
  `lunch_key` INT NULL,
  `dinner_key` INT NULL,
  `Order_Order_id` INT NOT NULL,
  `Breakfast_breakfast_key` INT NOT NULL,
  `Lunch_lunch_key` INT NOT NULL,
  PRIMARY KEY (`meal_id`),
  INDEX `fk_Full Meal_Order1_idx` (`Order_Order_id` ASC) VISIBLE,
  INDEX `fk_Full Meal_Breakfast1_idx` (`Breakfast_breakfast_key` ASC) VISIBLE,
  INDEX `fk_Full Meal_Lunch1_idx` (`Lunch_lunch_key` ASC) VISIBLE,
  CONSTRAINT `fk_Full Meal_Order1`
    FOREIGN KEY (`Order_Order_id`)
    REFERENCES `restaurant`.`Order` (`Order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Full Meal_Breakfast1`
    FOREIGN KEY (`Breakfast_breakfast_key`)
    REFERENCES `restaurant`.`Breakfast` (`breakfast_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Full Meal_Lunch1`
    FOREIGN KEY (`Lunch_lunch_key`)
    REFERENCES `restaurant`.`Lunch` (`lunch_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`Customers` (
  `customer_id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  `email` VARCHAR(100) NULL,
  `address` VARCHAR(200) NULL,
  `ordertype_id` INT NULL,
  `order_id` INT NULL,
  `meal_id` INT NULL,
  `Full Meal_meal_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_Customers_Full Meal1_idx` (`Full Meal_meal_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customers_Full Meal1`
    FOREIGN KEY (`Full Meal_meal_id`)
    REFERENCES `restaurant`.`Full Meal` (`meal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`Payment` (
  `payment_id` INT NOT NULL,
  `order_id` INT NULL,
  `payment_date` DATETIME NULL,
  `Payment_type` VARCHAR(50) NULL,
  `total_amount` FLOAT NULL,
  `Order_Order_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_Payment_Order1_idx` (`Order_Order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Order1`
    FOREIGN KEY (`Order_Order_id`)
    REFERENCES `restaurant`.`Order` (`Order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`Order Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`Order Type` (
  `ordertype_id` INT NOT NULL,
  `delivery_date` DATETIME NULL,
  `pickup_date` DATETIME NULL,
  `order_id` INT NULL,
  `customer_id` INT NULL,
  `pickup` TINYINT NULL,
  `delivery` TINYINT NULL,
  `payment_id` INT NULL,
  `Payment_payment_id` INT NOT NULL,
  `Payment_payment_id1` INT NOT NULL,
  PRIMARY KEY (`ordertype_id`),
  INDEX `fk_Order Type_Customers_idx` (`payment_id` ASC) VISIBLE,
  INDEX `fk_Order Type_Payment1_idx` (`Payment_payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order Type_Customers`
    FOREIGN KEY (`payment_id`)
    REFERENCES `restaurant`.`Customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order Type_Payment1`
    FOREIGN KEY (`Payment_payment_id`)
    REFERENCES `restaurant`.`Payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`Categories` (
  `categorie_id` INT NOT NULL,
  `order_id` INT NULL,
  `customer_id` INT NULL,
  `Order_Order_id` INT NOT NULL,
  PRIMARY KEY (`categorie_id`),
  INDEX `fk_Categories_Order1_idx` (`Order_Order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Categories_Order1`
    FOREIGN KEY (`Order_Order_id`)
    REFERENCES `restaurant`.`Order` (`Order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`Dinner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`Dinner` (
  `dinner_key` INT NOT NULL,
  `meal_id` INT NOT NULL,
  `dinner_food_options` VARCHAR(4000) NULL,
  `dinner_drink_options` VARCHAR(4000) NULL,
  `dinner_option_open` DATETIME NULL,
  `dinner_option_closed` DATETIME NULL,
  `Full Meal_meal_id` INT NOT NULL,
  PRIMARY KEY (`dinner_key`),
  INDEX `fk_Dinner_Full Meal1_idx` (`Full Meal_meal_id` ASC) VISIBLE,
  CONSTRAINT `fk_Dinner_Full Meal1`
    FOREIGN KEY (`Full Meal_meal_id`)
    REFERENCES `restaurant`.`Full Meal` (`meal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
