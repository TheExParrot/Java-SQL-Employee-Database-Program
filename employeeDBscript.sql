SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema employeeDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema employeeDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `employeeDB` DEFAULT CHARACTER SET utf8 ;
USE `employeeDB` ;

-- -----------------------------------------------------
-- Table `employeeDB`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeeDB`.`departments` (
  `deptID` INT NOT NULL,
  `deptName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deptID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeeDB`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeeDB`.`roles` (
  `roleID` INT NOT NULL,
  `title` VARCHAR(30) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`roleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeeDB`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeeDB`.`employees` (
  `empID` INT NOT NULL,
  `empName` VARCHAR(45) NOT NULL,
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
    REFERENCES `employeeDB`.`departments` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_roles1`
    FOREIGN KEY (`roleID`)
    REFERENCES `employeeDB`.`roles` (`roleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeeDB`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeeDB`.`projects` (
  `projectID` INT NOT NULL,
  `projectName` VARCHAR(45) NOT NULL,
  `budget` DECIMAL(10,2) NOT NULL,
  `start_date` DATE NOT NULL,
  PRIMARY KEY (`projectID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeeDB`.`project_employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeeDB`.`project_employees` (
  `projectID` INT NOT NULL,
  `empID` INT NOT NULL,
  PRIMARY KEY (`projectID`, `empID`),
  INDEX `fk_projects_has_employees_employees1_idx` (`empID` ASC) VISIBLE,
  INDEX `fk_projects_has_employees_projects1_idx` (`projectID` ASC) VISIBLE,
  CONSTRAINT `fk_projects_has_employees_projects1`
    FOREIGN KEY (`projectID`)
    REFERENCES `employeeDB`.`projects` (`projectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_has_employees_employees1`
    FOREIGN KEY (`empID`)
    REFERENCES `employeeDB`.`employees` (`empID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employeeDB`.`project_departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employeeDB`.`project_departments` (
  `deptID` INT NOT NULL,
  `projectID` INT NOT NULL,
  PRIMARY KEY (`deptID`, `projectID`),
  INDEX `fk_departments_has_projects_projects1_idx` (`projectID` ASC) VISIBLE,
  INDEX `fk_departments_has_projects_departments1_idx` (`deptID` ASC) VISIBLE,
  CONSTRAINT `fk_departments_has_projects_departments1`
    FOREIGN KEY (`deptID`)
    REFERENCES `employeeDB`.`departments` (`deptID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departments_has_projects_projects1`
    FOREIGN KEY (`projectID`)
    REFERENCES `employeeDB`.`projects` (`projectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
