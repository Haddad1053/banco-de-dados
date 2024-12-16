-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DB_HugoRodrigo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DB_HugoRodrigo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DB_HugoRodrigo` DEFAULT CHARACTER SET utf8 ;
USE `DB_HugoRodrigo` ;

-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`fazenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`fazenda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `endereco` POINT NOT NULL,
  `nome` VARCHAR(100) NULL,
  `sigla_uf` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_fazenda_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`armazenamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`armazenamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qntd` FLOAT NOT NULL,
  `data_entrada` DATE NOT NULL,
  `data_saida` DATE NOT NULL,
  UNIQUE INDEX `id_armazenamento_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`colaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`colaborador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `salario` FLOAT NOT NULL,
  `nome` VARCHAR(250) NOT NULL,
  `nascimento` DATE NOT NULL,
  `fazenda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_colaborador_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_colaborador_fazenda1_idx` (`fazenda_id` ASC) VISIBLE,
  CONSTRAINT `fk_colaborador_fazenda1`
    FOREIGN KEY (`fazenda_id`)
    REFERENCES `DB_HugoRodrigo`.`fazenda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`processamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`processamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qntd` FLOAT NOT NULL,
  `temperatura` FLOAT NOT NULL,
  `qldd` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_processamento_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`colheita` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `qntd` FLOAT NOT NULL,
  `umidade` FLOAT NOT NULL,
  `armazenamento_id` INT NOT NULL,
  `processamento_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_colheita_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_colheita_armazenamento1_idx` (`armazenamento_id` ASC) VISIBLE,
  INDEX `fk_colheita_processamento1_idx` (`processamento_id` ASC) VISIBLE,
  CONSTRAINT `fk_colheita_armazenamento1`
    FOREIGN KEY (`armazenamento_id`)
    REFERENCES `DB_HugoRodrigo`.`armazenamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_colheita_processamento1`
    FOREIGN KEY (`processamento_id`)
    REFERENCES `DB_HugoRodrigo`.`processamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`engenheiro_agronomo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`engenheiro_agronomo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `crea` VARCHAR(15) NOT NULL,
  `colaborador_id` INT NOT NULL,
  PRIMARY KEY (`id`, `colaborador_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_engenheiro_agronomo_colaborador1_idx` (`colaborador_id` ASC) VISIBLE,
  CONSTRAINT `fk_engenheiro_agronomo_colaborador1`
    FOREIGN KEY (`colaborador_id`)
    REFERENCES `DB_HugoRodrigo`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`transporte` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_partida` DATE NOT NULL,
  `data_chegada` DATE NULL,
  `trajeto` LINESTRING NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_transporte_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`ferroviario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`ferroviario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `empresa_operadora` VARCHAR(4) NOT NULL,
  `qtnd_vagao` INT NOT NULL,
  `transporte_id` INT NOT NULL,
  PRIMARY KEY (`id`, `transporte_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_ferroviario_transporte1_idx` (`transporte_id` ASC) VISIBLE,
  CONSTRAINT `fk_ferroviario_transporte1`
    FOREIGN KEY (`transporte_id`)
    REFERENCES `DB_HugoRodrigo`.`transporte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`loja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`loja` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `razao_social` VARCHAR(100) NOT NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `transporte_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_loja_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_loja_transporte1_idx` (`transporte_id` ASC) VISIBLE,
  CONSTRAINT `fk_loja_transporte1`
    FOREIGN KEY (`transporte_id`)
    REFERENCES `DB_HugoRodrigo`.`transporte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`plantacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`plantacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `altura` FLOAT NOT NULL,
  `area` POLYGON NOT NULL,
  `especie_cafe` VARCHAR(9) NOT NULL,
  `fazenda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_plantacao_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_plantacao_fazenda1_idx` (`fazenda_id` ASC) VISIBLE,
  CONSTRAINT `fk_plantacao_fazenda1`
    FOREIGN KEY (`fazenda_id`)
    REFERENCES `DB_HugoRodrigo`.`fazenda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`prorietario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`prorietario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `cpf` VARCHAR(16) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_prorietario_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`rodoviario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`rodoviario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `placa_veiculo` VARCHAR(8) NOT NULL,
  `nome_motorista` VARCHAR(200) NOT NULL,
  `transporte_id` INT NOT NULL,
  PRIMARY KEY (`id`, `transporte_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_rodoviario_transporte1_idx` (`transporte_id` ASC) VISIBLE,
  CONSTRAINT `fk_rodoviario_transporte1`
    FOREIGN KEY (`transporte_id`)
    REFERENCES `DB_HugoRodrigo`.`transporte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`tecnico_agricola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`tecnico_agricola` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cfta` VARCHAR(15) NOT NULL,
  `colaborador_id` INT NOT NULL,
  PRIMARY KEY (`id`, `colaborador_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_tecnico_agricola_colaborador1_idx` (`colaborador_id` ASC) VISIBLE,
  CONSTRAINT `fk_tecnico_agricola_colaborador1`
    FOREIGN KEY (`colaborador_id`)
    REFERENCES `DB_HugoRodrigo`.`colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`venda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `valor_total` FLOAT NOT NULL,
  `pagamento` VARCHAR(15) NOT NULL,
  `produto_vendido` VARCHAR(8) NOT NULL,
  `transporte_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idvenda_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_venda_transporte1_idx` (`transporte_id` ASC) VISIBLE,
  CONSTRAINT `fk_venda_transporte1`
    FOREIGN KEY (`transporte_id`)
    REFERENCES `DB_HugoRodrigo`.`transporte` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`plantacao_has_colheita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`plantacao_has_colheita` (
  `plantacao_id` INT NOT NULL,
  `colheita_id` INT NOT NULL,
  PRIMARY KEY (`plantacao_id`, `colheita_id`),
  INDEX `fk_plantacao_has_colheita_colheita1_idx` (`colheita_id` ASC) VISIBLE,
  INDEX `fk_plantacao_has_colheita_plantacao1_idx` (`plantacao_id` ASC) VISIBLE,
  CONSTRAINT `fk_plantacao_has_colheita_plantacao1`
    FOREIGN KEY (`plantacao_id`)
    REFERENCES `DB_HugoRodrigo`.`plantacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plantacao_has_colheita_colheita1`
    FOREIGN KEY (`colheita_id`)
    REFERENCES `DB_HugoRodrigo`.`colheita` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`fazenda_has_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`fazenda_has_venda` (
  `fazenda_id` INT NOT NULL,
  `venda_id` INT NOT NULL,
  PRIMARY KEY (`fazenda_id`, `venda_id`),
  INDEX `fk_fazenda_has_venda_venda1_idx` (`venda_id` ASC) VISIBLE,
  INDEX `fk_fazenda_has_venda_fazenda1_idx` (`fazenda_id` ASC) VISIBLE,
  CONSTRAINT `fk_fazenda_has_venda_fazenda1`
    FOREIGN KEY (`fazenda_id`)
    REFERENCES `DB_HugoRodrigo`.`fazenda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fazenda_has_venda_venda1`
    FOREIGN KEY (`venda_id`)
    REFERENCES `DB_HugoRodrigo`.`venda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_HugoRodrigo`.`fazenda_has_prorietario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_HugoRodrigo`.`fazenda_has_prorietario` (
  `fazenda_id` INT NOT NULL,
  `prorietario_id` INT NOT NULL,
  PRIMARY KEY (`fazenda_id`, `prorietario_id`),
  INDEX `fk_fazenda_has_prorietario_prorietario1_idx` (`prorietario_id` ASC) VISIBLE,
  INDEX `fk_fazenda_has_prorietario_fazenda1_idx` (`fazenda_id` ASC) VISIBLE,
  CONSTRAINT `fk_fazenda_has_prorietario_fazenda1`
    FOREIGN KEY (`fazenda_id`)
    REFERENCES `DB_HugoRodrigo`.`fazenda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fazenda_has_prorietario_prorietario1`
    FOREIGN KEY (`prorietario_id`)
    REFERENCES `DB_HugoRodrigo`.`prorietario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
