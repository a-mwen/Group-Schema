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
-- Table `restaurant`.`CUSTOMER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`CUSTOMER` (
  `Customer_id` INT NOT NULL,
  `First_name` VARCHAR(50) NOT NULL,
  `Last_name` VARCHAR(50) NOT NULL,
  `Contact` VARCHAR(45) NULL,
  `Email` VARCHAR(50) NULL,
  PRIMARY KEY (`Customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`BOOKING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`BOOKING` (
  `Booking_id` INT NOT NULL,
  `Date` DATETIME NULL,
  `Customer_id` INT NULL,
  PRIMARY KEY (`Booking_id`),
  INDEX `fk_BOOKING_CUSTOMER1_idx` (`Customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_BOOKING_CUSTOMER1`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `restaurant`.`CUSTOMER` (`Customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`HOME_DELIVERY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`HOME_DELIVERY` (
  `Delivery_id` INT NOT NULL,
  `Address` VARCHAR(100) NULL,
  `Contact` VARCHAR(45) NULL,
  `Booking_id` INT NULL,
  `BOOKING_Booking_id` INT NOT NULL,
  PRIMARY KEY (`Delivery_id`),
  INDEX `fk_HOME_DELIVERY_BOOKING1_idx` (`BOOKING_Booking_id` ASC) VISIBLE,
  CONSTRAINT `fk_HOME_DELIVERY_BOOKING1`
    FOREIGN KEY (`BOOKING_Booking_id`)
    REFERENCES `restaurant`.`BOOKING` (`Booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`RESTAURANT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`RESTAURANT` (
  `restaurant_name` VARCHAR(100) NOT NULL,
  `location` VARCHAR(100) NULL,
  `Contact` VARCHAR(100) NULL,
  `closing_time` DATETIME NULL,
  `opening_time` DATETIME NULL,
  `Details` VARCHAR(500) NULL,
  `HOME_DELIVERY_Delivery_id` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`restaurant_name`),
  INDEX `fk_RESTAURANT_HOME_DELIVERY1_idx` (`HOME_DELIVERY_Delivery_id` ASC) VISIBLE,
  CONSTRAINT `fk_RESTAURANT_HOME_DELIVERY1`
    FOREIGN KEY (`HOME_DELIVERY_Delivery_id`)
    REFERENCES `restaurant`.`HOME_DELIVERY` (`Delivery_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`MENU`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`MENU` (
  `Order_id` INT NOT NULL,
  `Name` VARCHAR(150) NULL,
  `Price` FLOAT NULL,
  `Type` VARCHAR(100) NULL,
  `Category` VARCHAR(100) NULL,
  `Customer_id` INT NOT NULL,
  PRIMARY KEY (`Order_id`),
  INDEX `fk_MENU_CUSTOMER1_idx` (`Customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_MENU_CUSTOMER1`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `restaurant`.`CUSTOMER` (`Customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`PAYMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`PAYMENT` (
  `payment_id` INT NOT NULL,
  `payment_type` VARCHAR(45) NULL,
  `payment_date` DATETIME NULL,
  `Customer_id` INT NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`.`TOTAL_BILL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`TOTAL_BILL` (
  `Bill_key` INT NOT NULL,
  `Order_id` INT NULL,
  `Customer_First_name` VARCHAR(50) NULL,
  `Customer_Last_name` VARCHAR(50) NULL,
  `Customer_id` INT NULL,
  `Total_amount` FLOAT NULL,
  PRIMARY KEY (`Bill_key`),
  INDEX `fk_TOTAL_BILL_MENU1_idx` (`Order_id` ASC) VISIBLE,
  INDEX `fk_TOTAL_BILL_PAYMENT1_idx` (`Total_amount` ASC) VISIBLE,
  CONSTRAINT `fk_TOTAL_BILL_MENU1`
    FOREIGN KEY (`Order_id`)
    REFERENCES `restaurant`.`MENU` (`Order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TOTAL_BILL_PAYMENT1`
    FOREIGN KEY (`Total_amount`)
    REFERENCES `restaurant`.`PAYMENT` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
