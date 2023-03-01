-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema employeedb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema employeedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `employeedb` DEFAULT CHARACTER SET utf8 ;
USE `employeedb` ;

-- -----------------------------------------------------
-- Table `employeedb`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeedb`.`departments` (
  `deptID` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deptID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeedb`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeedb`.`roles` (
  `roleID` INT NOT NULL,
  `title` VARCHAR(30) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`roleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeedb`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeedb`.`employees` (
  `empID` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `roleID` INT NOT NULL,
  `deptID` INT NULL,
  PRIMARY KEY (`empID`),
  UNIQUE INDEX `id_UNIQUE` (`empID` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_employees_department1_idx` (`deptID` ASC) VISIBLE,
  INDEX `fk_employees_roles1_idx` (`roleID` ASC) VISIBLE,
  CONSTRAINT `fk_employees_department1`
    FOREIGN KEY (`deptID`)
    REFERENCES `employeedb`.`departments` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_roles1`
    FOREIGN KEY (`roleID`)
    REFERENCES `employeedb`.`roles` (`roleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeedb`.`managers_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeedb`.`managers_employee` (
  `employees_empID` INT NOT NULL,
  `employees_empID1` INT NOT NULL,
  PRIMARY KEY (`employees_empID`, `employees_empID1`),
  INDEX `fk_employees_has_employees_employees2_idx` (`employees_empID1` ASC) VISIBLE,
  INDEX `fk_employees_has_employees_employees1_idx` (`employees_empID` ASC) VISIBLE,
  CONSTRAINT `fk_employees_has_employees_employees1`
    FOREIGN KEY (`employees_empID`)
    REFERENCES `employeedb`.`employees` (`empID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_has_employees_employees2`
    FOREIGN KEY (`employees_empID1`)
    REFERENCES `employeedb`.`employees` (`empID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeedb`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeedb`.`projects` (
  `projectID` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `budget` DECIMAL(10,2) NOT NULL,
  `start_date` DATE NOT NULL,
  PRIMARY KEY (`projectID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeedb`.`project_employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeedb`.`project_employees` (
  `projects_projectID` INT NOT NULL,
  `employees_empID` INT NOT NULL,
  PRIMARY KEY (`projects_projectID`, `employees_empID`),
  INDEX `fk_projects_has_employees_employees1_idx` (`employees_empID` ASC) VISIBLE,
  INDEX `fk_projects_has_employees_projects1_idx` (`projects_projectID` ASC) VISIBLE,
  CONSTRAINT `fk_projects_has_employees_projects1`
    FOREIGN KEY (`projects_projectID`)
    REFERENCES `employeedb`.`projects` (`projectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_has_employees_employees1`
    FOREIGN KEY (`employees_empID`)
    REFERENCES `employeedb`.`employees` (`empID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeedb`.`project_departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeedb`.`project_departments` (
  `departments_deptID` INT NOT NULL,
  `projects_projectID` INT NOT NULL,
  PRIMARY KEY (`departments_deptID`, `projects_projectID`),
  INDEX `fk_departments_has_projects_projects1_idx` (`projects_projectID` ASC) VISIBLE,
  INDEX `fk_departments_has_projects_departments1_idx` (`departments_deptID` ASC) VISIBLE,
  CONSTRAINT `fk_departments_has_projects_departments1`
    FOREIGN KEY (`departments_deptID`)
    REFERENCES `employeedb`.`departments` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departments_has_projects_projects1`
    FOREIGN KEY (`projects_projectID`)
    REFERENCES `employeedb`.`projects` (`projectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
