CREATE TABLE Avaliacao (
    `ID` INTEGER(11) PRIMARY KEY,
    `NotaMedia` FLOAT(3,2),
    `DiaProva` DATE
);

CREATE TABLE Diretor (
	`ID` INTEGER(11) PRIMARY KEY,
    `Nome` VARCHAR(30),
    `CPF` VARCHAR(11)
);

CREATE TABLE Faculdade (
    `CNPJ` VARCHAR(45) PRIMARY KEY,
    `Nome` VARCHAR(30),
    `Rua` VARCHAR(45),
    `Bairro` VARCHAR(30),
    `Estado` VARCHAR(30),
    `IdDiretor` INTEGER(11),
    Constraint `fk_ID_Diretor` FOREIGN KEY (`IdDiretor`) REFERENCES `Diretor` (ID)
);

CREATE TABLE Aluno (
	`ID` INTEGER(11) PRIMARY KEY,
    `Nome` VARCHAR(30),
    `CPF` VARCHAR(11),
    `Matricula` INTEGER(11)
);

CREATE TABLE Funcionario (
	`ID` INTEGER(11) PRIMARY KEY,
    `Cargo` VARCHAR(30),
    `Nome` VARCHAR(30),
    `CPF` VARCHAR(11),
    `Salario` FLOAT(7,2)
);

CREATE TABLE Professor (
	`ID` INTEGER(11) PRIMARY KEY,
    `Nome` VARCHAR(30),
    `CPF` VARCHAR(11)
);

CREATE TABLE Disciplina (
    `ID` INTEGER(11) PRIMARY KEY,
    `Nome` VARCHAR(30),
   `Media` FLOAT,
    `IdProfessor` INTEGER(11),
    Constraint `fk_Professor_Disciplina` FOREIGN KEY (`IdProfessor`) REFERENCES `Professor` (ID)
);

CREATE TABLE Trabalho (
	`IdAvaliacaoTrab` INTEGER(11),
   `Apresentacao` BOOLEAN,
    PRIMARY KEY (IdAvaliacaoTrab),
    CONSTRAINT `fk_Trabalho_Ava` FOREIGN KEY (`IdAvaliacaoTrab`) REFERENCES `Avaliacao` (`ID`)
);

CREATE TABLE Seminario (
    `IdAvaliacaoSem` INTEGER(11),
    PRIMARY KEY (IdAvaliacaoSem),
    CONSTRAINT `fk_Seminario_Ava` FOREIGN KEY (`IdAvaliacaoSem`) REFERENCES `Avaliacao` (`ID`)
);
	
CREATE TABLE Prova (
    `IdAvaliacaoPro` INTEGER(11),
    `Presencial` BOOLEAN,
    PRIMARY KEY (`IdAvaliacaoPro`),
    CONSTRAINT `fk_Prova_Ava` FOREIGN KEY (`IdAvaliacaoPro`) REFERENCES `Avaliacao` (`ID`)
);

CREATE TABLE Pagamento (
    `IdFuncionarioFinanceiro` INTEGER(11),
    `IdFuncionario` INTEGER(11),
    PRIMARY KEY (`IdFuncionarioFinanceiro`, `IdFuncionario`),
    CONSTRAINT `fk_Pagamento_Fin` FOREIGN KEY (`IdFuncionarioFinanceiro`) REFERENCES `Funcionario` (`ID`),
    CONSTRAINT `fk_Pagamento` FOREIGN KEY (`IdFuncionario`) REFERENCES `Funcionario` (`ID`)
);

CREATE TABLE Trabalha (
    `IdFuncionario` INTEGER(11),
    `CNPJ` VARCHAR(45),
    PRIMARY KEY (`IdFuncionario`, `CNPJ`),
    CONSTRAINT `fk_Trabalha_ID` FOREIGN KEY (`IdFuncionario`) REFERENCES `Funcionario` (`ID`),
    CONSTRAINT `fk_Trabalha_CNPJ` FOREIGN KEY (`CNPJ`) REFERENCES `Faculdade` (`CNPJ`)
);

CREATE TABLE Ensina (
    `CNPJ` VARCHAR(45),
    `IdProfessor` INTEGER(11),
    PRIMARY KEY (`CNPJ`, `IdProfessor`),
    CONSTRAINT `fk_Ensina_ID` FOREIGN KEY (`IdProfessor`) REFERENCES `Professor` (`ID`),
    CONSTRAINT `fk_Ensina_CNPJ` FOREIGN KEY (`CNPJ`) REFERENCES `Faculdade` (`CNPJ`)
);

CREATE TABLE Possui (
    `CNPJ` VARCHAR(45),
    `IdDisciplina` INTEGER(11),
    PRIMARY KEY (`CNPJ`, `IdDisciplina`),
    CONSTRAINT `fk_Possui_Faculdade` FOREIGN KEY (`CNPJ`) REFERENCES `Faculdade` (`CNPJ`),
    CONSTRAINT `fk_Possui_Disciplina` FOREIGN KEY (`IdDisciplina`) REFERENCES `Disciplina` (`ID`)
);

CREATE TABLE Matricula (
    `IdDisciplina` INTEGER(11),
    `IdALuno` INTEGER(11),
    PRIMARY KEY (`IdDisciplina`, `IdALuno`),
    CONSTRAINT `fk_Matricula_Aluno` FOREIGN KEY (`IdAluno`) REFERENCES `Aluno` (`ID`),
    CONSTRAINT `fk_Matricula_Disciplina` FOREIGN KEY (`IdDisciplina`) REFERENCES `Disciplina` (`ID`)
);

CREATE TABLE Aplica (
    `IdProfessor` INTEGER(11),
    `IdAvaliacao` INTEGER(11),
    PRIMARY KEY (`IdProfessor`, `IdAvaliacao`),
    CONSTRAINT `fk_Aplica_Professor` FOREIGN KEY (`IdProfessor`) REFERENCES `Professor` (`ID`),
    CONSTRAINT `fk_Aplica_Avaliacao` FOREIGN KEY (`IdAvaliacao`) REFERENCES `Avaliacao` (`ID`)
);

CREATE TABLE Realiza (
    `IdALuno` INTEGER(11),
    `IdAvaliacao` INTEGER(11),
    PRIMARY KEY (`IdALuno`, `IdAvaliacao`),
	CONSTRAINT `fk_Realiza_Aluno` FOREIGN KEY (`IdAluno`) REFERENCES `Aluno` (`ID`),
    CONSTRAINT `fk_Realiza_Avaliacao` FOREIGN KEY (`IdAvaliacao`) REFERENCES `Avaliacao` (`ID`)
);

CREATE TABLE Estuda (
    `IdAluno` INTEGER(11),
    `CNPJ` VARCHAR(45),
    PRIMARY KEY (`CNPJ`, `IdAluno`),
    CONSTRAINT `fk_Estuda_Aluno` FOREIGN KEY (`IdAluno`) REFERENCES `Aluno` (`ID`),
    CONSTRAINT `fk_Estuda_Faculdade` FOREIGN KEY (`CNPJ`) REFERENCES `Faculdade` (`CNPJ`)
);
