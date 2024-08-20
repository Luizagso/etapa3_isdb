-- (a) Criação de todas as tabelas e de todas as restrições de integridade

-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS ClinicaVeterinaria DEFAULT CHARACTER SET utf8 ;
-- Define que as próximas operações serão realizadas no banco de dados ClinicaVeterinaria
USE ClinicaVeterinaria ;

-- Criação da tabela Pessoa: Armazena informações sobre pessoas que podem ser veterinários, tutores de animais ou ambos.
CREATE TABLE IF NOT EXISTS Pessoa (
    idPessoa INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CRMV VARCHAR(20) NULL,
    CPF VARCHAR(14) NOT NULL,
    nome VARCHAR(60) NOT NULL,
    bairro VARCHAR(60) NOT NULL,
    numero INT NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    estado VARCHAR(60) NOT NULL,
    rua VARCHAR(60) NOT NULL,
    complemento VARCHAR(10) NULL,
    tipo ENUM('Veterinario', 'Tutor', 'Ambos') NOT NULL DEFAULT 'Tutor',
    UNIQUE INDEX CRMV_UNIQUE (CRMV ASC) VISIBLE,
    UNIQUE INDEX CPF_UNIQUE (CPF ASC) VISIBLE)
ENGINE = InnoDB;

-- Criação da tabela Contatos: Vinculado à tabela Pessoa, armazena os contato(telefone e e-mail) das pessoas.
CREATE TABLE IF NOT EXISTS Contatos (
    idContato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    telefone VARCHAR(19),
    email VARCHAR(50),
    idPessoa INT NOT NULL,
    INDEX fk_Contatos_Pessoa_idx (idPessoa ASC) VISIBLE,
    UNIQUE INDEX email_UNIQUE (email ASC) VISIBLE,
    CONSTRAINT fk_Contatos_Pessoa
        FOREIGN KEY (idPessoa)
        REFERENCES Pessoa (idPessoa)
        ON DELETE CASCADE
        ON UPDATE CASCADE)
ENGINE = InnoDB;

-- Criação da tabela Animal: Armazena informações sobre os animais, vinculados aos seus respectivos tutores na tabela Pessoa.
CREATE TABLE IF NOT EXISTS Animal (
    idAnimal INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idPessoa INT NOT NULL,
    registro VARCHAR(20) NOT NULL,
    dataNasc DATE NOT NULL,
    nome VARCHAR(60) NOT NULL,
    raca VARCHAR(60) NOT NULL,
    especie VARCHAR(60) NOT NULL,
    sexo ENUM('Macho', 'Fêmea') NOT NULL DEFAULT 'Macho',
    UNIQUE INDEX registro_UNIQUE (registro ASC) VISIBLE,
    CONSTRAINT fk_Animal_Pessoa
        FOREIGN KEY (idPessoa)
        REFERENCES Pessoa (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE)
ENGINE = InnoDB;

-- Criação da tabela Consulta: Armazena os dados das consultas realizadas para os animais, vinculando o animal e a pessoa responsável (veterinário ou tutor).
CREATE TABLE IF NOT EXISTS Consulta (
    idConsulta INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idAnimal INT NOT NULL,
    dataConsulta DATETIME NOT NULL,
    idPessoa INT NOT NULL,
    dataRealRetorno DATETIME NULL,
    dataLimiteRetorno DATE NOT NULL,
    INDEX fk_Consulta_Animal_idx (idAnimal ASC) VISIBLE,
    INDEX fk_Consulta_Pessoa_idx (idPessoa ASC) VISIBLE,
    INDEX uq_consulta (dataConsulta ASC, idAnimal ASC) VISIBLE,
    CONSTRAINT fk_Consulta_Animal
        FOREIGN KEY (idAnimal)
        REFERENCES Animal (idAnimal)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_Consulta_Pessoa
        FOREIGN KEY (idPessoa)
        REFERENCES Pessoa (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE)
ENGINE = InnoDB;

-- Criação da tabela Medicamento: Armazena informações sobre os medicamentos disponíveis para prescrição.
CREATE TABLE IF NOT EXISTS Medicamento (
    idMedicamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    registro VARCHAR(20) UNIQUE NOT NULL,
    descricao VARCHAR(60) NOT NULL DEFAULT 'Sem descrição')
ENGINE = InnoDB;

-- Criação da tabela Exame: Armazena informações sobre os exames disponíveis para solicitação.
CREATE TABLE IF NOT EXISTS Exame (
    idExame INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    registro VARCHAR(20) UNIQUE NOT NULL,
    descricao VARCHAR(60) NOT NULL DEFAULT 'Sem descrição')
ENGINE = InnoDB;

-- Criação da tabela Consulta_Prescreve: Armazena a relação entre consultas e medicamentos prescritos, vinculando os dois e armazenando a dosagem.
CREATE TABLE IF NOT EXISTS Consulta_prescreve (
    idMedicamento INT NOT NULL,
    idConsulta INT NOT NULL,
    dosagem VARCHAR(60) NOT NULL,
    PRIMARY KEY (idMedicamento, idConsulta),
    INDEX fk_Medicamento_has_Consulta_Consulta_idx (idConsulta ASC) VISIBLE,
    INDEX fk_Medicamento_has_Consulta_Medicamento_idx (idMedicamento ASC) VISIBLE,
    CONSTRAINT fk_prescreve_medicamento
        FOREIGN KEY (idMedicamento)
        REFERENCES Medicamento (idMedicamento)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_prescreve_consulta
        FOREIGN KEY (idConsulta)
        REFERENCES Consulta (idConsulta)
        ON DELETE CASCADE
        ON UPDATE CASCADE)
ENGINE = InnoDB;

-- Criação da tabela Consulta_Solicita: Armazena a relação entre consultas e exames solicitados, vinculando os dois e armazenando o resultado do exame.
CREATE TABLE IF NOT EXISTS Consulta_Solicita (
    idConsulta INT NOT NULL,
    idExame INT NOT NULL,
    resultado VARCHAR(60) NULL DEFAULT 'Pendente',
    INDEX fk_Consulta_has_Exame_Exame_idx (idExame ASC) VISIBLE,
    INDEX fk_Consulta_has_Exame_Consulta_idx (idConsulta ASC) VISIBLE,
    PRIMARY KEY (idConsulta, idExame),
    CONSTRAINT fk_solicita_consulta
        FOREIGN KEY (idConsulta)
        REFERENCES Consulta (idConsulta)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_solicita_exame
        FOREIGN KEY (idExame)
        REFERENCES Exame (idExame)
        ON DELETE CASCADE
        ON UPDATE CASCADE)
ENGINE = InnoDB;

-- (b) Exemplos de ALTER TABLE e DROP TABLE

-- Adicionando uma nova coluna na tabela Pessoa
ALTER TABLE Pessoa 
ADD COLUMN telefone VARCHAR(15);

-- Removendo a coluna da tabela Pessoa
ALTER TABLE Pessoa 
DROP COLUMN telefone;

-- Modificando o tipo de dados da coluna CRMV na tabela Pessoa
ALTER TABLE Pessoa 
MODIFY COLUMN CRMV VARCHAR(25);



-- Criação de uma tabela extra para exemplificação
CREATE TABLE Extra (
    idExtra INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

-- Removendo a tabela extra criada
DROP TABLE Extra;


-- (b) Exemplos de ALTER TABLE e DROP TABLE

-- Adicionando uma nova coluna na tabela Pessoa: Insere a coluna 'telefone' para armazenar números de telefone.
ALTER TABLE Pessoa ADD COLUMN telefone VARCHAR(15);

-- Removendo a coluna da tabela Pessoa: Exclui a coluna 'telefone' da tabela Pessoa.
ALTER TABLE Pessoa DROP COLUMN telefone;

-- Modificando o tipo de dados da coluna CRMV na tabela Pessoa: Altera o tipo de dados da coluna 'CRMV' para comportar um tamanho maior.
ALTER TABLE Pessoa MODIFY COLUMN CRMV VARCHAR(25);

-- Adicionando uma nova coluna na tabela Exame: Insere a coluna 'complexidade' para armazenar informações a respeito do nível de dificuldade do exame.
ALTER TABLE Exame 
ADD COLUMN complexidade VARCHAR(60);

-- Adicionando uma restrição UNIQUE na coluna 'complexidade' da tabela Exame: Garante que os valores na coluna 'complexidade' sejam únicos em toda a tabela.
ALTER TABLE Exame ADD UNIQUE (complexidade);

-- Removendo a coluna da tabela Exame
ALTER TABLE Exame 
DROP COLUMN complexidade;

-- Criação de uma tabela extra para exemplificação: Cria uma tabela 'Extra' para demonstrar a remoção de uma tabela.
CREATE TABLE Extra (
    idExtra INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

-- Removendo a tabela extra criada: Exclui a tabela 'Extra' do banco de dados.
DROP TABLE Extra;


-- (c) Inserção de dados em cada uma das tabelas
USE ClinicaVeterinaria;

-- Inserção na tabela Pessoa (25 registros)
INSERT INTO Pessoa (idPessoa, CRMV, CPF, nome, bairro, numero, cidade, estado, rua, complemento, tipo) VALUES
(1, '123456-SP', '111.222.333-44', 'Dr. João Silva', 'Centro', 10, 'Lisboa', 'LI', 'Rua A', '', 'Veterinario'),
(2, '234567-SP', '222.333.444-55', 'Dra. Maria Oliveira', 'Bairro Alto', 23, 'Lisboa', 'LI', 'Rua B', '', 'Veterinario'),
(3, '345678-SP', '333.444.555-66', 'Dr. Carlos Santos', 'Bela Vista', 45, 'Porto', 'PT', 'Rua C', '', 'Veterinario'),
(4, NULL, '444.555.666-77', 'Ana Costa', 'Jardim Botânico', 56, 'Coimbra', 'CB', 'Rua D', 'Apto 101', 'Tutor'),
(5, NULL, '555.666.777-88', 'João Pereira', 'Centro', 78, 'Faro', 'FA', 'Rua E', 'Casa 5', 'Tutor'),
(6, NULL, '666.777.888-99', 'Pedro Almeida', 'São Bento', 12, 'Braga', 'BR', 'Rua F', 'Apto 201', 'Tutor'),
(7, NULL, '777.888.999-00', 'José Silva', 'Alvalade', 34, 'Lisboa', 'LI', 'Rua G', '', 'Tutor'),
(8, '890123-SP', '888.999.000-11', 'Paula Mendes', 'Centro', 56, 'Faro', 'FA', 'Rua H', 'Apto 301', 'Veterinario'),
(9, NULL, '999.000.111-22', 'Carla Ribeiro', 'Campanhã', 78, 'Porto', 'PT', 'Rua I', '', 'Tutor'),
(10, '012345-SP', '000.111.222-33', 'Antônio Sousa', 'Baixa', 90, 'Lisboa', 'LI', 'Rua J', 'Casa 2', 'Veterinario'),
(11, NULL, '011.122.233-44', 'Rita Gomes', 'Vila Nova', 11, 'Braga', 'BR', 'Rua K', '', 'Tutor'),
(12, NULL, '022.133.244-55', 'Bruno Marques', 'Campo Grande', 22, 'Lisboa', 'LI', 'Rua L', 'Apto 402', 'Tutor'),
(13, NULL, '033.144.255-66', 'Letícia Faria', 'Centro', 33, 'Faro', 'FA', 'Rua M', '', 'Tutor'),
(14, '456780-SP', '044.155.266-77', 'Marcos Teixeira', 'Trindade', 44, 'Porto', 'PT', 'Rua N', 'Casa 3', 'Veterinario'),
(15, NULL, '055.166.277-88', 'Fernanda Lima', 'Jardins', 55, 'Lisboa', 'LI', 'Rua O', 'Apto 503', 'Tutor'),
(16, NULL, '066.177.288-99', 'Luís Neves', 'Sé', 66, 'Braga', 'BR', 'Rua P', '', 'Tutor'),
(17, '789013-SP', '077.188.299-00', 'Mariana Costa', 'Bairro Alto', 77, 'Lisboa', 'LI', 'Rua Q', '', 'Veterinario'),
(18, NULL, '088.199.300-11', 'Tiago Freitas', 'Centro', 88, 'Faro', 'FA', 'Rua R', 'Apto 604', 'Tutor'),
(19, NULL, '099.200.311-22', 'Inês Barbosa', 'Baixa', 99, 'Lisboa', 'LI', 'Rua S', '', 'Tutor'),
(20, '012346-SP', '100.211.322-33', 'Jorge Coelho', 'São Martinho', 10, 'Coimbra', 'CB', 'Rua T', '', 'Veterinario'),
(21, NULL, '111.222.333-55', 'Carolina Duarte', 'Bela Vista', 12, 'Porto', 'PT', 'Rua U', '', 'Tutor'),
(22, NULL, '122.233.344-66', 'Renato Nogueira', 'Alcântara', 14, 'Lisboa', 'LI', 'Rua V', '', 'Tutor'),
(23, '345680-SP', '133.244.355-77', 'Tatiana Rodrigues', 'São Bento', 16, 'Braga', 'BR', 'Rua W', '', 'Veterinario'),
(24, NULL, '144.255.366-88', 'Luciana Matos', 'Campo Grande', 18, 'Lisboa', 'LI', 'Rua X', '', 'Tutor'),
(25, NULL, '155.266.377-99', 'Diego Rocha', 'Centro', 20, 'Faro', 'FA', 'Rua Y', 'Casa 6', 'Tutor');

-- Inserção na tabela Pessoa (28 registros)
INSERT INTO Pessoa (idPessoa, CRMV, CPF, nome, bairro, numero, cidade, estado, rua, complemento, tipo) VALUES
(26, NULL, '166.277.388-00', 'Simone Mendes', 'Vila Nova', 22, 'Braga', 'BR', 'Rua Z', '', 'Tutor'),
(27, '789024-SP', '177.288.399-11', 'Fábio Sousa', 'Jardim Botânico', 24, 'Coimbra', 'CB', 'Rua AA', '', 'Veterinario'),
(28, NULL, '188.299.400-22', 'Nádia Fernandes', 'Campanhã', 26, 'Porto', 'PT', 'Rua BB', '', 'Tutor'),
(29, NULL, '199.300.411-33', 'César Silva', 'Centro', 28, 'Lisboa', 'LI', 'Rua CC', 'Apto 703', 'Tutor'),
(30, '012357-SP', '200.311.422-44', 'Juliana Reis', 'Baixa', 30, 'Lisboa', 'LI', 'Rua DD', '', 'Veterinario'),
(31, NULL, '211.322.433-55', 'Bruno Carvalho', 'Trindade', 32, 'Porto', 'PT', 'Rua EE', '', 'Tutor'),
(32, NULL, '222.333.444-66', 'Marta Oliveira', 'Centro', 34, 'Faro', 'FA', 'Rua FF', '', 'Tutor'),
(33, '345681-SP', '233.344.455-77', 'Rodrigo Alves', 'Bairro Alto', 36, 'Lisboa', 'LI', 'Rua GG', 'Casa 7', 'Veterinario'),
(34, NULL, '244.355.466-88', 'Daniela Santos', 'Alvalade', 38, 'Lisboa', 'LI', 'Rua HH', '', 'Tutor'),
(35, NULL, '255.366.477-99', 'Lucas Martins', 'Centro', 40, 'Faro', 'FA', 'Rua II', '', 'Tutor'),
(36, NULL, '266.377.488-00', 'Cláudia Pinto', 'Baixa', 42, 'Lisboa', 'LI', 'Rua JJ', '', 'Tutor'),
(37, '789025-SP', '277.388.499-11', 'Marcelo Gomes', 'Sé', 44, 'Braga', 'BR', 'Rua KK', '', 'Veterinario'),
(38, NULL, '288.399.500-22', 'André Silva', 'Vila Nova', 46, 'Braga', 'BR', 'Rua LL', '', 'Tutor'),
(39, NULL, '299.400.511-33', 'Patrícia Sousa', 'Centro', 48, 'Faro', 'FA', 'Rua MM', '', 'Tutor'),
(40, NULL, '300.411.522-44', 'Roberta Teixeira', 'Baixa', 50, 'Lisboa', 'LI', 'Rua NN', '', 'Tutor'),
(41, '123460-SP', '311.422.533-55', 'Vinícius Oliveira', 'Alcântara', 52, 'Lisboa', 'LI', 'Rua OO', 'Casa 8', 'Veterinario'),
(42, NULL, '322.433.544-66', 'Érica Costa', 'Jardins', 54, 'Lisboa', 'LI', 'Rua PP', '', 'Tutor'),
(43, NULL, '333.444.555-77', 'Felipe Mendes', 'Bela Vista', 56, 'Porto', 'PT', 'Rua QQ', '', 'Tutor'),
(44, '456793-SP', '344.455.566-88', 'Renata Figueiredo', 'São Martinho', 58, 'Coimbra', 'CB', 'Rua RR', '', 'Veterinario'),
(45, NULL, '355.466.577-99', 'Gustavo Lima', 'Campo Grande', 60, 'Lisboa', 'LI', 'Rua SS', 'Apto 804', 'Tutor'),
(46, NULL, '366.477.588-00', 'Amanda Ferreira', 'Centro', 62, 'Faro', 'FA', 'Rua TT', '', 'Tutor'),
(47, NULL, '377.488.599-11', 'Sérgio Almeida', 'Campanhã', 64, 'Porto', 'PT', 'Rua UU', '', 'Tutor'),
(48, NULL, '388.499.600-22', 'Thais Rodrigues', 'Baixa', 66, 'Lisboa', 'LI', 'Rua VV', '', 'Tutor'),
(49, '901248-SP', '399.500.611-33', 'Eduardo Moreira', 'Centro', 68, 'Faro', 'FA', 'Rua WW', 'Apto 904', 'Ambos'),
(50, NULL, '399.540.611-33', 'Luiza Silva', 'Betânia', 68, 'Belo Horizonte', 'MG', 'Rua WW', 'Apto 904', 'Tutor'),
(51, null, '111.925.333-44', 'Adrian Toomes', 'Centro', 10, 'Lisboa', 'LI', 'Rua A', '', 'tutor'),
(52, null, '222.863.444-55', 'Curt Connors', 'Bairro Alto', 23, 'Lisboa', 'LI', 'Rua B', '', 'tutor'),
(53, null, '333.201.555-66', 'Quentin Beck', 'Bela Vista', 45, 'Porto', 'PT', 'Rua C', '', 'tutor');

-- Inserção na tabela Contatos (24 registros)
INSERT INTO Contatos (idContato, telefone, email, idPessoa) VALUES
(1, '911111111', 'joao.silva@exemplo.com', 1),
(2, '922222222', 'maria.oliveira@exemplo.com', 2),
(3, '933333333', 'carlos.santos@exemplo.com', 3),
(4, '944444444', 'ana.costa@exemplo.com', 4),
(5, '955555555', 'joao.pereira@exemplo.com', 5),
(6, '966666666', 'pedro.almeida@exemplo.com', 6),
(7, '977777777', 'jose.silva@exemplo.com', 7),
(8, '988888888', 'paula.mendes@exemplo.com', 8),
(9, '999999999', 'carla.ribeiro@exemplo.com', 9),
(10, '900000000', 'antonio.sousa@exemplo.com', 10),
(11, '911111112', 'rita.gomes@exemplo.com', 11),
(12, '922222223', 'bruno.marques@exemplo.com', 12),
(13, '933333334', 'leticia.faria@exemplo.com', 13),
(14, '944444445', 'marcos.teixeira@exemplo.com', 14),
(15, '955555556', 'fernanda.lima@exemplo.com', 15),
(16, '966666667', 'luis.neves@exemplo.com', 16),
(17, '977777778', 'mariana.costa@exemplo.com', 17),
(18, '988888889', 'tiago.freitas@exemplo.com', 18),
(19, '999999990', 'ines.barbosa@exemplo.com', 19),
(20, '900000001', 'jorge.coelho@exemplo.com', 20),
(21, '911111113', 'carolina.duarte@exemplo.com', 21),
(22, '922222224', 'renato.nogueira@exemplo.com', 22),
(23, '933333335', 'tatiana.rodrigues@exemplo.com', 23),
(24, '944444446', 'luciana.matos@exemplo.com', 24);

-- Inserção na tabela Contatos (25 registros)
INSERT INTO Contatos (idContato, telefone, email, idPessoa) VALUES
(25, '955555557', 'diego.rocha@exemplo.com', 25),
(26, '966666668', 'simone.mendes@exemplo.com', 26),
(27, '977777779', 'fabio.sousa@exemplo.com', 27),
(28, '988888880', 'nadia.fernandes@exemplo.com', 28),
(29, '999999991', 'cesar.silva@exemplo.com', 29),
(30, '900000002', 'juliana.reis@exemplo.com', 30),
(31, '911111114', 'bruno.carvalho@exemplo.com', 31),
(32, '922222225', 'marta.oliveira@exemplo.com', 32),
(33, '933333336', 'rodrigo.alves@exemplo.com', 33),
(34, '944444447', 'daniela.santos@exemplo.com', 34),
(35, '955555558', 'lucas.martins@exemplo.com', 35),
(36, '966666669', 'claudia.pinto@exemplo.com', 36),
(37, '977777780', 'marcelo.gomes@exemplo.com', 37),
(38, '988888881', 'andre.silva@exemplo.com', 38),
(39, '999999992', 'patricia.sousa@exemplo.com', 39),
(40, '900000003', 'roberta.teixeira@exemplo.com', 40),
(41, '911111115', 'vinicius.oliveira@exemplo.com', 41),
(42, '922222226', 'erica.costa@exemplo.com', 42),
(43, '933333337', 'felipe.mendes@exemplo.com', 43),
(44, '944444448', 'renata.figueiredo@exemplo.com', 44),
(45, '955555559', 'gustavo.lima@exemplo.com', 45),
(46, '966666670', 'amanda.ferreira@exemplo.com', 46),
(47, '977777781', 'sergio.almeida@exemplo.com', 47),
(48, '988888882', 'thais.rodrigues@exemplo.com', 48),
(49, '999999993', 'eduardo.moreira@exemplo.com', 49),
(50, '958525555', 'eduardo.moreira2@exemplo.com', 49);

-- Inserção na tabela Animal (25 registros)
INSERT INTO Animal (idAnimal, registro, idPessoa, nome, dataNasc, raca, especie, sexo) VALUES
(1, 'AN-001', 4, 'Rex', '2020-01-01', 'Labrador', 'Cão', 'Macho'),
(2, 'AN-002', 5, 'Luna', '2019-05-15', 'Poodle', 'Cão', 'Fêmea'),
(3, 'AN-003', 6, 'Max', '2018-08-20', 'Golden Retriever', 'Cão', 'Macho'),
(4, 'AN-004', 7, 'Mia', '2020-10-30', 'Persa', 'Gato', 'Fêmea'),
(5, 'AN-005', 9, 'Bob', '2017-12-12', 'Bulldog', 'Cão', 'Macho'),
(6, 'AN-006', 11, 'Nina', '2019-04-18', 'Sphynx', 'Gato', 'Fêmea'),
(7, 'AN-007', 12, 'Zeus', '2016-06-22', 'Boxer', 'Cão', 'Macho'),
(8, 'AN-008', 13, 'Maggie', '2021-02-27', 'Beagle', 'Cão', 'Fêmea'),
(9, 'AN-009', 15, 'Simba', '2018-11-19', 'Maine Coon', 'Gato', 'Macho'),
(10, 'AN-010', 16, 'Chloe', '2017-03-05', 'Bengal', 'Gato', 'Fêmea'),
(11, 'AN-011', 18, 'Duke', '2019-07-07', 'Doberman', 'Cão', 'Macho'),
(12, 'AN-012', 19, 'Bella', '2018-09-12', 'Yorkshire', 'Cão', 'Fêmea'),
(13, 'AN-013', 21, 'Thor', '2020-12-15', 'Pastor Alemão', 'Cão', 'Macho'),
(14, 'AN-014', 22, 'Sasha', '2016-11-21', 'Rottweiler', 'Cão', 'Fêmea'),
(15, 'AN-015', 24, 'Rocky', '2018-02-25', 'Shih Tzu', 'Cão', 'Macho'),
(16, 'AN-016', 25, 'Lucy', '2019-03-29', 'Siamês', 'Gato', 'Fêmea'),
(17, 'AN-017', 26, 'Oscar', '2017-08-08', 'Bulldog Francês', 'Cão', 'Macho'),
(18, 'AN-018', 28, 'Lola', '2021-01-15', 'Chihuahua', 'Cão', 'Fêmea'),
(19, 'AN-019', 29, 'Bruno', '2020-04-22', 'Pug', 'Cão', 'Macho'),
(20, 'AN-020', 31, 'Maya', '2019-06-30', 'Scottish Fold', 'Gato', 'Fêmea'),
(21, 'AN-021', 32, 'Jade', '2020-07-04', 'Golden Retriever', 'Cão', 'Fêmea'),
(22, 'AN-022', 34, 'Sam', '2018-10-17', 'Akita', 'Cão', 'Macho'),
(23, 'AN-023', 35, 'Nala', '2020-11-20', 'Siberiano', 'Gato', 'Fêmea'),
(24, 'AN-024', 36, 'Leo', '2017-12-26', 'Bulldog Inglês', 'Cão', 'Macho'),
(25, 'AN-025', 38, 'Juno', '2016-02-19', 'Poodle Toy', 'Cão', 'Fêmea');

-- Inserção na tabela Animal (32 registros)
INSERT INTO Animal (idAnimal, registro, idPessoa, nome, dataNasc, raca, especie, sexo) VALUES
(26, 'AN-026', 39, 'Toby', '2019-05-09', 'Weimaraner', 'Cão', 'Macho'),
(27, 'AN-027', 40, 'Lily', '2021-03-01', 'Dachshund', 'Cão', 'Fêmea'),
(28, 'AN-028', 42, 'Buddy', '2018-04-14', 'Lhasa Apso', 'Cão', 'Macho'),
(29, 'AN-029', 43, 'Daisy', '2020-06-18', 'Bichon Frisé', 'Cão', 'Fêmea'),
(30, 'AN-030', 45, 'Teddy', '2017-07-23', 'Pomeranian', 'Cão', 'Macho'),
(31, 'AN-031', 46, 'Bailey', '2019-09-28', 'Border Collie', 'Cão', 'Macho'),
(32, 'AN-032', 47, 'Ginger', '2018-01-03', 'Poodle Miniatura', 'Cão', 'Fêmea'),
(33, 'AN-033', 48, 'Bentley', '2020-05-08', 'Buldogue Americano', 'Cão', 'Macho'),
(34, 'AN-034', 49, 'Zara', '2017-08-15', 'Bengal', 'Gato', 'Fêmea'),
(35, 'AN-035', 50, 'Charlie', '2016-11-27', 'Labradoodle', 'Cão', 'Macho'),
(36, 'AN-036', 31, 'Ruby', '2018-03-12', 'Maltês', 'Cão', 'Fêmea'),
(37, 'AN-037', 32, 'Harley', '2020-07-30', 'Terrier', 'Cão', 'Macho'),
(38, 'AN-038', 34, 'Ella', '2019-01-17', 'Buldogue Francês', 'Cão', 'Fêmea'),
(39, 'AN-039', 35, 'Jake', '2017-02-20', 'Dogue Alemão', 'Cão', 'Macho'),
(40, 'AN-040', 40, 'Sophie', '2021-04-05', 'Husky', 'Cão', 'Fêmea'),
(41, 'AN-041', 42, 'Jasper', '2020-09-10', 'Dálmata', 'Cão', 'Macho'),
(42, 'AN-042', 42, 'Coco', '2018-12-14', 'Pastor Australiano', 'Cão', 'Fêmea'),
(43, 'AN-043', 43, 'Bear', '2019-03-29', 'Bulldog Americano', 'Cão', 'Macho'),
(44, 'AN-044', 45, 'Lulu', '2017-06-01', 'Schnauzer', 'Cão', 'Fêmea'),
(45, 'AN-045', 46, 'Riley', '2016-08-03', 'Pit Bull', 'Cão', 'Macho'),
(46, 'AN-046', 46, 'Molly', '2018-10-20', 'Chow Chow', 'Cão', 'Fêmea'),
(47, 'AN-047', 47, 'Otis', '2019-12-25', 'Shar Pei', 'Cão', 'Macho'),
(48, 'AN-048', 48, 'Pepper', '2020-02-14', 'Whippet', 'Cão', 'Fêmea'),
(49, 'AN-049', 49, 'Sparky', '2017-09-12', 'Galgo', 'Cão', 'Macho'),
(50, 'AN-050', 49, 'Juju', '2020-01-01', 'Labrador', 'Cão', 'Macho'),
(51, 'AN-051', 4, 'Fumaça', '2020-01-01', 'Labrador', 'Cão', 'Macho'),
(52, 'AN-052', 5, 'Fofinha', '2019-05-15', 'Poodle', 'Cão', 'Fêmea'),
(53, 'AN-059', 4, 'Lulu', '2020-01-01', 'SRD', 'Porquinho da India', 'Macho'),
(54, 'AN-054', 5, 'Luna', '2019-05-15', 'SRD', 'Coelho', 'Fêmea'),
(55, 'AN-055', 6, 'Max', '2018-08-20', ' SRD', 'Coelho', 'Macho'),
(56, 'AN-056', 7, 'Mia', '2020-10-30', 'SRD', 'Hamster', 'Fêmea'),
(57, 'AN-057', 9, 'Bob', '2017-12-12', 'SRD', 'Hamster', 'Macho'),
(58, 'AN-058', 11, 'Nina', '2019-04-18', 'SRD', 'Coelho', 'Fêmea');

-- Inserção na tabela Consulta (25 registros)
INSERT INTO Consulta (idConsulta, dataConsulta, idAnimal, idPessoa, dataLimiteRetorno, dataRealRetorno) VALUES
(1, '2024-01-01', 3, 1, '2024-01-15', NULL),
(2, '2024-01-05', 3, 2, '2024-01-20', NULL),
(3, '2024-01-10', 3, 3, '2024-01-25', NULL),
(4, '2024-01-15', 4, 8, '2024-01-30', NULL),
(5, '2024-01-20', 5, 1, '2024-02-05', NULL),
(6, '2024-01-25', 6, 2, '2024-02-10', NULL),
(7, '2024-01-30', 7, 7, '2024-02-15', NULL),
(8, '2024-02-01', 8, 8, '2024-02-20', NULL),
(9, '2024-02-05', 9, 10, '2024-02-25', NULL),
(10, '2024-02-10', 10, 10, '2024-03-01', NULL),
(11, '2024-02-15', 11, 14, '2024-03-05', NULL),
(12, '2024-02-20', 12, 14, '2024-03-10', NULL),
(13, '2024-02-25', 13, 17, '2024-03-15', NULL),
(14, '2024-03-01', 14, 20, '2024-03-20', NULL),
(15, '2024-03-05', 15, 20, '2024-03-25', NULL),
(16, '2024-03-10', 16, 20, '2024-04-01', NULL),
(17, '2024-03-15', 17, 23, '2024-04-05', NULL),
(18, '2024-03-20', 18, 23, '2024-04-10', NULL),
(19, '2024-03-25', 19, 23, '2024-04-15', NULL),
(20, '2024-04-01', 20, 20, '2024-04-20', NULL),
(21, '2024-04-05', 21, 27, '2024-04-25', NULL),
(22, '2024-04-10', 22, 27, '2024-05-01', NULL),
(23, '2024-04-15', 23, 27, '2024-05-05', NULL),
(24, '2024-04-20', 24, 27, '2024-05-10', NULL),
(25, '2024-04-25', 25, 25, '2024-05-15', NULL);

-- Inserção na tabela Consulta (26 registros)
INSERT INTO Consulta (idConsulta, dataConsulta, idAnimal, idPessoa, dataLimiteRetorno, dataRealRetorno) VALUES
(26, '2024-05-01', 26, 25, '2024-05-20', NULL),
(27, '2024-05-05', 27, 27, '2024-05-25', NULL),
(28, '2024-05-10', 28, 30, '2024-06-01', NULL),
(29, '2024-05-15', 29, 30, '2024-06-05', NULL),
(30, '2024-05-20', 30, 49, '2024-06-10', NULL),
(31, '2024-05-25', 31, 49, '2024-06-15', NULL),
(32, '2024-06-01', 32, 33, '2024-06-20', NULL),
(33, '2024-06-05', 33, 33, '2024-06-25', NULL),
(34, '2024-06-10', 34, 37, '2024-07-01', NULL),
(35, '2024-06-15', 35, 33, '2024-07-05', NULL),
(36, '2024-06-20', 36, 33, '2024-07-10', NULL),
(37, '2024-06-25', 37, 33, '2024-07-15', NULL),
(38, '2024-07-01', 38, 33, '2024-07-20', NULL),
(39, '2024-07-05', 39, 37, '2024-07-25', NULL),
(40, '2024-07-10', 40, 41, '2024-08-01', NULL),
(41, '2024-07-15', 41, 41, '2024-08-05', NULL),
(42, '2024-07-20', 42, 44, '2024-08-10', NULL),
(43, '2024-07-25', 43, 44, '2024-08-15', NULL),
(44, '2024-08-01', 44, 44, '2024-08-20', NULL),
(45, '2024-08-05', 45, 41, '2024-08-25', NULL),
(46, '2024-08-10', 46, 41, '2024-09-01', NULL),
(47, '2024-08-15', 47, 41, '2024-09-05', NULL),
(48, '2024-08-20', 48, 41, '2024-09-10', NULL),
(49, '2024-08-25', 49, 41, '2024-09-15', NULL),
(50, '2024-08-30', 50, 1, '2024-09-20', NULL),
(51, '2022-01-05', 52, 2, '2023-01-08', NULL),
(52, '2022-01-05', 51, 2, '2022-01-08', NULL);

-- Inserção na tabela Medicamento (25 registros)
INSERT INTO Medicamento (idMedicamento, registro, descricao) VALUES
(1, 'MED-001', 'Antibiótico para infecção respiratória'),
(2, 'MED-002', 'Anti-inflamatório para dor muscular'),
(3, 'MED-003', 'Vacina polivalente para cães'),
(4, 'MED-004', 'Vermífugo para gatos'),
(5, 'MED-005', 'Suplemento vitamínico para animais idosos'),
(6, 'MED-006', 'Antipulgas de uso tópico'),
(7, 'MED-007', 'Analgésico para dores agudas'),
(8, 'MED-008', 'Pomada cicatrizante para feridas'),
(9, 'MED-009', 'Colírio para infecção ocular'),
(10, 'MED-010', 'Xarope expectorante para tosse'),
(11, 'MED-011', 'Vacina antirrábica'),
(12, 'MED-012', 'Remédio para controle de diabetes em cães'),
(13, 'MED-013', 'Antibiótico de amplo espectro'),
(14, 'MED-014', 'Antialérgico para tratamento de dermatite'),
(15, 'MED-015', 'Antifúngico para infecções de pele'),
(16, 'MED-016', 'Suplemento para fortalecimento ósseo'),
(17, 'MED-017', 'Antiparasitário de uso oral'),
(18, 'MED-018', 'Laxante para constipação em gatos'),
(19, 'MED-019', 'Pomada para tratamento de queimaduras'),
(20, 'MED-020', 'Spray cicatrizante para pequenos cortes'),
(21, 'MED-021', 'Comprimido para controle de convulsões'),
(22, 'MED-022', 'Vacina contra leptospirose'),
(23, 'MED-023', 'Suplemento alimentar para animais convalescentes'),
(24, 'MED-024', 'Antidepressivo para animais com ansiedade'),
(25, 'MED-025', 'Antiparasitário de uso externo');

-- Inserção na tabela Medicamento (26 registros)
INSERT INTO Medicamento (idMedicamento, registro, descricao) VALUES
(26, 'MED-026', 'Pomada para tratamento de otite'),
(27, 'MED-027', 'Comprimido para prevenção de dirofilariose'),
(28, 'MED-028', 'Antibiótico para infecções urinárias'),
(29, 'MED-029', 'Comprimido para controle de epilepsia'),
(30, 'MED-030', 'Pomada para cicatrização de úlceras'),
(31, 'MED-031', 'Antitérmico para controle de febre'),
(32, 'MED-032', 'Spray antisséptico para feridas'),
(33, 'MED-033', 'Vacina para controle de giardíase'),
(34, 'MED-034', 'Pomada oftálmica para conjuntivite'),
(35, 'MED-035', 'Comprimido para controle de hipertensão'),
(36, 'MED-036', 'Spray repelente de insetos'),
(37, 'MED-037', 'Suplemento para ganho de massa muscular'),
(38, 'MED-038', 'Antibiótico para infecções bacterianas'),
(39, 'MED-039', 'Pomada para tratamento de dermatose'),
(40, 'MED-040', 'Comprimido para tratamento de gastrite'),
(41, 'MED-041', 'Vacina contra cinomose'),
(42, 'MED-042', 'Antiinflamatório de uso veterinário'),
(43, 'MED-043', 'Pomada para tratamento de calos'),
(44, 'MED-044', 'Comprimido para tratamento de hipotireoidismo'),
(45, 'MED-045', 'Antibiótico para infecções respiratórias'),
(46, 'MED-046', 'Suplemento para fortalecimento de articulações'),
(47, 'MED-047', 'Antipulgas oral para cães'),
(48, 'MED-048', 'Pomada para tratamento de eczema'),
(49, 'MED-049', 'Comprimido para controle de dores crônicas'),
(50, 'MED-050', 'Comprimido para tratamento de obesidade'),
(51, 'MED-051', 'Ambroxol');

-- Inserção na tabela Exame (25 registros)
INSERT INTO Exame (idExame, registro, descricao) VALUES
(1, 'EX-001', 'Hemograma completo'),
(2, 'EX-002', 'Ultrassonografia abdominal'),
(3, 'EX-003', 'Radiografia torácica'),
(4, 'EX-004', 'Teste de função renal'),
(5, 'EX-005', 'Ecocardiograma'),
(6, 'EX-006', 'Exame de fezes'),
(7, 'EX-007', 'Exame de urina'),
(8, 'EX-008', 'Tomografia computadorizada'),
(9, 'EX-009', 'Biópsia de pele'),
(10, 'EX-010', 'Teste de alergia'),
(11, 'EX-011', 'Eletrocardiograma'),
(12, 'EX-012', 'Teste de função hepática'),
(13, 'EX-013', 'Exame de glicose'),
(14, 'EX-014', 'Exame de colesterol'),
(15, 'EX-015', 'Exame de triglicerídeos'),
(16, 'EX-016', 'Exame de ureia e creatinina'),
(17, 'EX-017', 'Teste de gravidez'),
(18, 'EX-018', 'Exame citológico'),
(19, 'EX-019', 'Exame histopatológico'),
(20, 'EX-020', 'Resonância magnética'),
(21, 'EX-021', 'Exame de cortisol'),
(22, 'EX-022', 'Exame de T4 livre'),
(23, 'EX-023', 'Teste de sorologia para leishmaniose'),
(24, 'EX-024', 'Teste de sorologia para dirofilariose'),
(25, 'EX-025', 'Exame de ácido úrico');

-- Inserção na tabela Exame (25 registros)
INSERT INTO Exame (idExame, registro, descricao) VALUES
(26, 'EX-026', 'Teste de função adrenal'),
(27, 'EX-027', 'Teste de função tireoidiana'),
(28, 'EX-028', 'Exame de eletrolíticos'),
(29, 'EX-029', 'Exame de urina tipo I'),
(30, 'EX-030', 'Exame de creatina'),
(31, 'EX-031', 'Teste de função pancreática'),
(32, 'EX-032', 'Teste de função muscular'),
(33, 'EX-033', 'Exame de proteínas totais'),
(34, 'EX-034', 'Exame de hematócrito'),
(35, 'EX-035', 'Teste de Coombs'),
(36, 'EX-036', 'Exame de reticulócitos'),
(37, 'EX-037', 'Exame de glicose pós-prandial'),
(38, 'EX-038', 'Exame de glicose de jejum'),
(39, 'EX-039', 'Exame de hemoglobina glicosilada'),
(40, 'EX-040', 'Exame de transferrina'),
(41, 'EX-041', 'Exame de ferritina'),
(42, 'EX-042', 'Teste de função hepática'),
(43, 'EX-043', 'Teste de função renal'),
(44, 'EX-044', 'Exame de bilirrubina'),
(45, 'EX-045', 'Exame de fosfatase alcalina'),
(46, 'EX-046', 'Exame de ácido láctico'),
(47, 'EX-047', 'Exame de amilase'),
(48, 'EX-048', 'Exame de lipase'),
(49, 'EX-049', 'Exame de aldosterona'),
(50, 'EX-050', 'Teste de função adrenal');

-- Inserção na tabela Consulta_Prescreve (25 registros)
INSERT INTO Consulta_Prescreve (idConsulta, idMedicamento, dosagem) VALUES
(1, 1, '1 comprimido ao dia'),
(2, 2, '2 comprimidos ao dia'),
(3, 3, '1 dose a cada 3 semanas'),
(4, 4, '1 comprimido a cada 6 meses'),
(5, 5, '5 ml ao dia'),
(6, 6, 'Aplicação tópica semanal'),
(7, 7, '2 comprimidos ao dia'),
(8, 8, 'Aplicar na ferida 3x ao dia'),
(9, 9, '1 gota em cada olho 2x ao dia'),
(10, 10, '5 ml 2x ao dia'),
(11, 11, '1 dose anual'),
(12, 12, '1 comprimido ao dia'),
(13, 13, '1 comprimido a cada 12 horas'),
(14, 14, '1 comprimido ao dia'),
(15, 15, 'Aplicar 2x ao dia'),
(16, 16, '1 comprimido ao dia'),
(17, 17, '1 comprimido mensal'),
(18, 18, 'Aplicar 3x ao dia'),
(19, 19, 'Aplicar 3x ao dia'),
(20, 20, 'Aplicar 2x ao dia'),
(21, 21, '1 comprimido 2x ao dia'),
(22, 22, '1 dose anual'),
(23, 23, '5 ml 2x ao dia'),
(24, 24, '1 comprimido ao dia'),
(25, 25, 'Aplicar 1x ao dia');

-- Inserção na tabela Consulta_Prescreve (29 registros)
INSERT INTO Consulta_Prescreve (idConsulta, idMedicamento, dosagem) VALUES
(26, 26, 'Aplicar 2x ao dia'),
(27, 27, '1 comprimido ao mês'),
(28, 28, '1 comprimido a cada 12 horas'),
(29, 29, '1 comprimido 2x ao dia'),
(30, 30, 'Aplicar 2x ao dia'),
(31, 31, '1 comprimido ao dia'),
(32, 32, 'Aplicar 2x ao dia'),
(33, 33, '1 dose anual'),
(34, 34, 'Aplicar 3x ao dia'),
(35, 35, '1 comprimido ao dia'),
(36, 36, 'Aplicar semanalmente'),
(37, 37, '5 ml ao dia'),
(38, 38, '1 comprimido ao dia'),
(39, 39, 'Aplicar 3x ao dia'),
(40, 40, '1 comprimido ao dia'),
(41, 41, '1 dose anual'),
(42, 42, '1 comprimido ao dia'),
(43, 43, 'Aplicar 2x ao dia'),
(44, 44, '1 comprimido ao dia'),
(45, 45, '1 comprimido 2x ao dia'),
(46, 46, 'Aplicar 1x ao dia'),
(47, 47, '1 comprimido ao mês'),
(48, 48, 'Aplicar 2x ao dia'),
(49, 49, '1 comprimido 2x ao dia'),
(50, 50, '1 comprimido 2x ao dia'),
(51, 33, '1 vez ao ano'),
(52, 33, 'dose anual'),
(51, 51, '0.5 mg'),
(52, 51, '5 mg');

-- Inserção na tabela Consulta_Solicita (25 registros)
INSERT INTO Consulta_Solicita (idConsulta, idExame, resultado) VALUES
(1, 1, 'Normal'),
(1, 2, 'Leve dilatação abdominal'),
(3, 3, 'Infiltrado pulmonar'),
(4, 4, 'Creatinina elevada'),
(5, 5, 'Ecocardiograma normal'),
(6, 6, 'Parasitas encontrados'),
(7, 7, 'Urina clara, sem anormalidades'),
(8, 8, 'Tomografia sem alterações'),
(9, 9, 'Lesão inflamatória crônica'),
(10, 10, 'Alergia a pólen detectada'),
(11, 11, 'Ritmo cardíaco normal'),
(12, 12, 'Enzimas hepáticas elevadas'),
(13, 13, 'Glicose normal'),
(14, 14, 'Colesterol elevado'),
(15, 15, 'Triglicerídeos elevados'),
(16, 16, 'Função renal comprometida'),
(17, 17, 'Gravidez confirmada'),
(18, 18, 'Células epiteliais normais'),
(19, 19, 'Histopatologia indica neoplasia'),
(20, 20, 'Ressonância normal'),
(21, 21, 'Cortisol elevado'),
(22, 22, 'T4 livre normal'),
(23, 23, 'Sorologia positiva para leishmaniose'),
(24, 24, 'Sorologia negativa para dirofilariose'),
(25, 25, 'Ácido úrico elevado');

-- Inserção na tabela Consulta_Solicita (25 registros)
INSERT INTO Consulta_Solicita (idConsulta, idExame, resultado) VALUES
(26, 26, 'Função adrenal normal'),
(27, 27, 'Função tireoidiana normal'),
(28, 28, 'Eletrolíticos normais'),
(29, 29, 'Urina com densidade aumentada'),
(30, 30, 'Creatina normal'),
(31, 31, 'Função pancreática normal'),
(32, 32, 'Função muscular normal'),
(33, 33, 'Proteínas totais normais'),
(34, 34, 'Hematócrito normal'),
(35, 35, 'Teste de Coombs negativo'),
(36, 36, 'Reticulócitos aumentados'),
(37, 37, 'Glicose pós-prandial elevada'),
(38, 38, 'Glicose de jejum normal'),
(39, 39, 'Hemoglobina glicosilada normal'),
(40, 40, 'Transferrina normal'),
(41, 41, 'Ferritina elevada'),
(42, 42, 'Função hepática normal'),
(43, 43, 'Função renal normal'),
(44, 44, 'Bilirrubina elevada'),
(45, 45, 'Fosfatase alcalina elevada'),
(46, 46, 'Ácido láctico normal'),
(47, 47, 'Amilase normal'),
(48, 48, 'Lipase elevada'),
(49, 49, 'Aldosterona normal'),
(50, 50, 'Função adrenal elevada');


-- (d) Exemplos de modificação de dados em 5 tabelas, uma delas sendo um exemplo de UPDATE aninhado.

-- Atualizando dados na tabela Pessoa
-- Altera o nome e o bairro da pessoa com o CPF igual ao valor inserido.
UPDATE Pessoa
SET nome = 'Ana Paula Souza', bairro = 'Jardim das Flores'
WHERE CPF = '000.111.222-33';

-- Atualizando dados na tabela Animal
-- Ajusta o nome e raça do animal associado a uma pessoa específica.
UPDATE Animal
SET nome = 'Salem', raca = 'vira-lata preto'
WHERE idPessoa = (SELECT idPessoa FROM Pessoa WHERE nome = 'José Silva');

-- Atualizando dados na tabela Animal (2º exemplo)
-- Ajusta o nome, raça e espécie do animal com um registro específico.
UPDATE Animal
SET nome = 'Thor', raca = 'Persa', especie = 'Gato'
WHERE registro = 'AN-001';

-- Atualizando dados na tabela Consulta
-- Ajusta a data de retorno em uma consulta específica.
UPDATE Consulta
SET dataRealRetorno = '2024-08-15 10:00:00'
WHERE idConsulta = 5;

-- Exemplo de UPDATE aninhado
-- Ajusta o tutor do animal na tabela Animal utilizando uma subconsulta.
SET SQL_SAFE_UPDATES = 0;

UPDATE Animal a
SET idPessoa = (
    SELECT idPessoa
    FROM Pessoa p
    WHERE p.nome = 'Patrícia Sousa'
)
WHERE a.nome = 'Zeus';

SET SQL_SAFE_UPDATES = 1;


-- (e) Exemplos de exclusão de dados em 5 tabelas, uma delas sendo um exemplo de DELETE aninhado.

-- Deletando dados na tabela Pessoa
-- Remove uma consulta associada a uma pessoa com um CPF específico.
DELETE FROM Consulta
WHERE idPessoa = (SELECT idPessoa FROM Pessoa WHERE CPF = '111.222.333-44');


-- Deletando dados na tabela Animal
-- Remove um registro específico de um animal com base em seu registro.
DELETE FROM Animal
WHERE registro = 'AN-001';

-- Deletando dados na tabela Consulta
-- Remove consultas onde a data limite de retorno já foi alcançada e a data de retorno ainda não foi registrada.
-- Desativa o modo seguro para permitir atualizações sem chave primária.
SET SQL_SAFE_UPDATES = 0;

-- Executa a exclusão dos registros que atendem às condições.
DELETE FROM Consulta
WHERE dataRealRetorno < '2024-01-01'
    OR dataLimiteRetorno < '2024-01-02';

-- Reativa o modo seguro para proteger contra atualizações sem chave primária.
SET SQL_SAFE_UPDATES = 1;

-- Deletando dados na tabela Animal
-- Remove um animal específico com base em seu ID.
DELETE FROM Animal
WHERE idAnimal = 2;

-- Deletando dados na tabela Exame (Exemplo de DELETE aninhado)
-- o comando exclui da consulata todos os registros cujos idAnimal são de animais
-- da pessoa com CPF 144.255.366-88
DELETE FROM Consulta
WHERE idAnimal IN (
    SELECT idAnimal FROM Animal
    WHERE idPessoa = (SELECT idPessoa FROM Pessoa WHERE CPF = '144.255.366-88')
);

-- (f) Exemplos de consultas complexas
-- F1
-- Recupera os medicamentos e suas respectivas dosagens referentes à consulta realizada pelo animal de id 7 no dia 30 de janeiro de 2024.
SELECT 
    M.descricao AS Medicamento, 
    CP.dosagem AS Dosagem
FROM 
    Consulta C
NATURAL JOIN 
    Consulta_prescreve CP
NATURAL JOIN 
    Medicamento M
WHERE 
    C.dataConsulta = '2024-01-30'
    AND C.idAnimal = 7;
    
-- F2
-- Recupera a descrição do evento (consulta ou exame), a data e o id das consultas ou exames realizados entre 1º e 15 de agosto de 2024, ordenados da data mais recente para a mais antiga.
SELECT idConsulta AS idEvento, dataConsulta AS dataEvento, 'Consulta' AS tipoEvento
FROM Consulta
WHERE dataConsulta BETWEEN '2024-08-01' AND '2024-08-15'
UNION
-- Seleciona todos os exames com a data e a descrição "Exame"
SELECT idExame AS idEvento, dataConsulta AS dataEvento, 'Exame' AS tipoEvento
FROM Exame
NATURAL JOIN Consulta_Solicita
NATURAL JOIN Consulta
WHERE dataConsulta BETWEEN '2024-08-01' AND '2024-08-15'
-- Ordena pela data do evento da mais próxima para a mais antiga
ORDER BY dataEvento DESC;

-- F3
-- Recupera o nome e a quantidade de consultas realizadas por cada veterinário no mês de agosto de 2024.
SELECT P.nome AS NomeVeterinario, COUNT(C.idConsulta) AS NumeroConsultas
FROM Consulta C
JOIN Pessoa P ON C.idPessoa = P.idPessoa
WHERE P.tipo IN ('Veterinário', 'Ambos')
AND MONTH(C.dataConsulta) = 8 AND YEAR(C.dataConsulta) = 2024
GROUP BY P.nome;

-- F4
-- Recupera o nome dos tutores e a quantidade de animais que cada um possui, desde que o tutor tenha mais de um animal.
SELECT P.nome AS NomeTutor, COUNT(A.idAnimal) AS QuantidadeAnimais
FROM Pessoa P
JOIN Animal A ON P.idPessoa = A.idPessoa
WHERE P.tipo IN ('Tutor', 'Ambos')
GROUP BY P.nome
HAVING COUNT(A.idAnimal) > 1;

-- F5
-- Recupera os próximos animais que precisarão de reaplicação de dose, retornando o nome do tutor, seus números de telefone, o nome do animal, o medicamento prescrito, sua dosagem, a data da consulta e o ID da consulta em que a última dose anual foi prescrita há mais de 11 meses, ordenados da data mais distante para a mais próxima.
-- Foram utilizados três operadores não vistos em sala: GROUP_CONCAT(), que concatena todos os telefones do tutor em uma única tupla
-- date_sub(), usado para subtrair 11 meses da data atual
-- curdate(), retorna a data atual
SELECT 
    C.idConsulta AS IdConsulta, 
    A.nome AS NomeAnimal, 
    M.descricao AS Medicamento, 
    CP.dosagem AS DosagemPrescrita,
    C.dataConsulta AS DataConsulta,   
    P.nome AS NomeTutor,
    GROUP_CONCAT(Ct.telefone SEPARATOR ', ') AS Telefones 
FROM 
    Consulta C
JOIN 
    Animal A ON C.idAnimal = A.idAnimal
JOIN 
    Consulta_prescreve CP ON C.idConsulta = CP.idConsulta
JOIN 
    Medicamento M ON CP.idMedicamento = M.idMedicamento
JOIN 
    Pessoa P ON A.idPessoa = P.idPessoa
LEFT JOIN 
    Contatos Ct ON P.idPessoa = Ct.idPessoa
WHERE 
    (CP.dosagem LIKE '%anual%' OR CP.dosagem LIKE '%1% %ano%') -- tratamento para encontrar doses anuais
    AND C.dataConsulta <= DATE_SUB(CURDATE(), INTERVAL 11 MONTH)
GROUP BY 
    C.idConsulta, A.nome, M.descricao, CP.dosagem, C.dataConsulta, P.nome
ORDER BY 
    C.dataConsulta ASC;


-- F6
-- Recupera as dosagens do medicamento 'Xarope expectorante para tosse' onde existe pelo menos uma dosagem maior que 4 ou menor que 1 registrada em qualquer consulta.
SELECT 
    CP.dosagem AS DosagemPrescrita
FROM 
    Consulta_prescreve CP
JOIN 
    Medicamento M ON CP.idMedicamento = M.idMedicamento
WHERE 
    M.descricao = 'Xarope expectorante para tosse'
    AND (
        EXISTS (
            SELECT *
            FROM Consulta_prescreve CP_sub
            WHERE CP_sub.idMedicamento = M.idMedicamento
            AND (CP_sub.dosagem > 4 OR CP_sub.dosagem < 1)  -- Verifica se existe qualquer dosagem que atenda às condições
        )
    );
    
-- F7 
-- Recupera o id da consulta, o nome do animal, a data da consulta, a data limite de retorno, o nome do tutor e os telefones do tutor onde a consulta ainda não teve retorno, ordenados da mais antiga para a mais nova.
SELECT 
    C.idConsulta AS IdConsulta,
    A.nome AS NomeAnimal,
    C.dataConsulta AS DataConsulta,
    C.dataLimiteRetorno AS DataLimiteRetorno,
    P.nome AS NomeTutor,
    GROUP_CONCAT(Ct.telefone SEPARATOR ', ') AS TelefonesTutor
FROM 
    Consulta C
JOIN 
    Animal A ON C.idAnimal = A.idAnimal
JOIN 
    Pessoa P ON A.idPessoa = P.idPessoa
LEFT JOIN 
    Contatos Ct ON P.idPessoa = Ct.idPessoa
WHERE 
    C.dataRealRetorno IS NULL  -- Verifica se a dataRealRetorno ainda não foi preenchida
GROUP BY 
    IdConsulta, NomeAnimal, DataConsulta, DataLimiteRetorno, NomeTutor
ORDER BY 
    C.dataConsulta ASC;
    
-- F8
-- Recupera o nome de todos os veterinários que prescreveram medicamentos em todas as consultas nas quais participaram.
SELECT nome
FROM Pessoa p
WHERE tipo = 'Veterinario'
  AND idPessoa = ALL (
        SELECT c.idPessoa
        FROM Consulta c
        JOIN Consulta_prescreve cp ON c.idConsulta = cp.idConsulta
        WHERE c.idPessoa = p.idPessoa
    );
    
-- F9
-- Recupera o nome, espécie, data de nascimento e raça de todos os animais que sejam porquinho-da-índia, hamster ou coelho.
SELECT nome, especie, raca, dataNasc
FROM Animal
WHERE especie IN ('porquinho da índia', 'hamster', 'coelho')
Order BY especie, nome;

-- F10
-- Recupera a dosagem, o nome do animal, a espécie, o id da consulta e o nome do veterinário onde a dosagem do medicamento Ambroxol foi superior a alguma dosagem aplicada pelo veterinário de id 3.
-- Foi utilizada a função CAST para garantir a comparação entre as dosagens, a função está responsável por converter as strings em valores decimais
SELECT 
    CAST(CP.dosagem AS DECIMAL(10, 2)) DosagemPrescrita,
    A.nome NomeAnimal,
    A.especie Especie,
    C.idConsulta IdConsulta,
    P.nome NomeVeterinario
FROM 
    Consulta_prescreve CP
JOIN 
    Medicamento M ON CP.idMedicamento = M.idMedicamento
JOIN 
    Consulta C ON CP.idConsulta = C.idConsulta
JOIN 
    Animal A ON C.idAnimal = A.idAnimal
JOIN 
    Pessoa P ON C.idPessoa = P.idPessoa
WHERE 
    M.descricao = 'Ambroxol'
    AND CAST(CP.dosagem AS DECIMAL(10, 2)) > SOME (
        SELECT CAST(CP2.dosagem AS DECIMAL(10, 2))
        FROM Consulta_prescreve CP2
        JOIN Consulta C2 ON CP2.idConsulta = C2.idConsulta
        WHERE CP2.idMedicamento = M.idMedicamento
        AND C2.idPessoa = 3  
    );
    
-- F11
-- Recupera o id e o nome dos tutores que não possuem nenhum animal cadastrado na clínica.
SELECT 
    P.idPessoa, 
    P.nome AS NomeTutor
FROM 
    Pessoa P
WHERE 
    P.tipo = 'Tutor'
    AND NOT EXISTS (
        SELECT 1 
        FROM Animal A
        WHERE A.idPessoa = P.idPessoa
    );
    
-- F12
-- Recupera o nome dos veterinários, a descrição dos exames e a quantidade de cada exame solicitado por veterinário.
SELECT 
    P.nome AS NomeVeterinario,
    E.descricao AS DescricaoExame,
    COUNT(*) AS QuantidadeExamesSolicitados
FROM 
    Consulta C
JOIN 
    Pessoa P ON C.idPessoa = P.idPessoa
JOIN 
    Consulta_Solicita CS ON C.idConsulta = CS.idConsulta
JOIN 
    Exame E ON CS.idExame = E.idExame
WHERE 
    P.tipo = 'Veterinário'
GROUP BY 
    P.nome, E.descricao
ORDER BY 
    P.nome, QuantidadeExamesSolicitados DESC;
    
-- F13
-- Recupera o nome dos tutores ou ambos e a quantidade de animais que cada um possui, ordenados pela quantidade de animais em ordem decrescente.
SELECT 
    P.nome AS NomeTutor,
    COUNT(A.idAnimal) AS QuantidadeAnimais
FROM 
    Pessoa P
JOIN 
    Animal A ON P.idPessoa = A.idPessoa
GROUP BY 
    P.nome
ORDER BY 
    QuantidadeAnimais DESC;


-- (g) Exemplos de Criação de 3 Visões (Views)
-- 1. Visão: View_Animal_Consulta
-- Esta visão combina informações sobre animais e suas respectivas consultas veterinárias.
-- Inclui o nome, raça e espécie do animal, além da data da consulta, data limite de retorno e o nome do veterinário responsável.
CREATE VIEW View_Animal_Consulta AS
SELECT 
    a.nome AS NomeAnimal,
    a.raca AS Raca,
    a.especie AS Especie,
    c.dataConsulta AS DataConsulta,
    c.dataLimiteRetorno AS DataLimiteRetorno,
    p.nome AS NomeVeterinario
FROM 
    Animal a
JOIN 
    Consulta c ON a.idAnimal = c.idAnimal
JOIN 
    Pessoa p ON c.idPessoa = p.idPessoa
WHERE 
    p.tipo = 'Veterinario';
-- Como Usar:
-- Seleciona todos os registros da visão View_Animal_Consulta.
SELECT * FROM View_Animal_Consulta;

-- 2. Visão: View_Contato_Pessoa
-- Esta visão combina informações sobre pessoas e seus contatos associados.
-- Inclui o nome da pessoa, o tipo de pessoa (por exemplo, Tutor), telefone e e-mail.
CREATE VIEW View_Contato_Pessoa AS
SELECT 
    p.nome AS NomePessoa,
    p.tipo AS TipoPessoa,
    c.telefone AS Telefone,
    c.email AS Email
FROM 
    Pessoa p
JOIN 
    Contatos c ON p.idPessoa = c.idPessoa;
-- Como Usar:
-- Seleciona todos os registros da visão View_Contato_Pessoa onde o tipo de pessoa é 'Tutor'.
SELECT * FROM View_Contato_Pessoa WHERE TipoPessoa = 'Tutor';

-- 3. Visão: View_Consulta_Prescricao
-- Esta visão reúne informações sobre prescrições médicas durante consultas.
-- Inclui o nome do veterinário, o nome do animal, a descrição do medicamento, dosagem prescrita e a data da consulta.
CREATE VIEW View_Consulta_Prescricao AS
SELECT 
    p.nome AS NomeVeterinario,
    a.nome AS NomeAnimal,
    m.descricao AS Medicamento,
    cp.dosagem AS Dosagem,
    c.dataConsulta AS DataConsulta
FROM 
    Consulta c
JOIN 
    Pessoa p ON c.idPessoa = p.idPessoa
JOIN 
    Animal a ON c.idAnimal = a.idAnimal
JOIN 
    Consulta_Prescreve cp ON c.idConsulta = cp.idConsulta
JOIN 
    Medicamento m ON cp.idMedicamento = m.idMedicamento;
-- Como Usar:
-- Seleciona todos os registros da visão View_Consulta_Prescricao onde o nome do veterinário é 'Vinícius Oliveira'.
SELECT * FROM View_Consulta_Prescricao WHERE NomeVeterinario = 'Vinícius Oliveira';


-- (h) Exemplos de Criação de Usuários, Concessão (GRANT) e Revogação (REVOKE) de Permissão de Acesso
-- 1. Criação de Usuários
SET SQL_SAFE_UPDATES = 0;

CREATE USER 'usuario_vet'@'localhost' IDENTIFIED BY 'senha123';
CREATE USER 'usuario_admin'@'localhost' IDENTIFIED BY 'admin123';

-- 2. Concessão de Permissões
GRANT SELECT, INSERT, UPDATE ON ClinicaVeterinaria.* TO 'usuario_vet'@'localhost';
GRANT ALL PRIVILEGES ON ClinicaVeterinaria.* TO 'usuario_admin'@'localhost';

-- 3. Revogação de Permissões
REVOKE UPDATE ON ClinicaVeterinaria.* FROM 'usuario_vet'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'usuario_admin'@'localhost';


-- (i) Exemplos de 3 Procedimentos/Funções
-- Procedimento Sem Parâmetros
-- Primeiro, certifique-se de estar usando o banco de dados correto
USE clinicaveterinaria;

-- 1. Procedimento Sem Parâmetros
-- Este procedimento lista todos os veterinários registrados na tabela Pessoa.
DELIMITER //
CREATE PROCEDURE ListarVeterinarios()
BEGIN
    SELECT nome FROM Pessoa WHERE tipo = 'Veterinario';
END //
-- Restaure o delimitador para o padrão
DELIMITER ;
-- Como Usar:
-- Chame o procedimento para listar os veterinários.
CALL ListarVeterinarios();

-- 2. Exemplo de Procedimento Sem Parâmetros de Saída
-- Neste exemplo, o procedimento listarConsultasDoAno simplesmente 
-- lista todas as consultas de um determinado ano, sem precisar de parâmetros de saída.
DELIMITER $$
CREATE PROCEDURE listarConsultasDoAno(
    IN p_ano INT
)
BEGIN
    SELECT idConsulta, idPessoa, dataConsulta
    FROM Consulta
    WHERE YEAR(dataConsulta) = p_ano;
END$$
DELIMITER ;
-- Como Usar:
-- Chame o procedimento passando o ano desejado como parâmetro.
CALL listarConsultasDoAno(2024);

-- 3. Função para Calcular a Idade de um Animal
-- Esta função calcula a idade de um animal com base na sua data de nascimento.
-- (com parâmetros de entrada e saída)
DELIMITER $$
CREATE FUNCTION calcularIdade(dataNasc DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idade INT;
    -- Calcula a diferença em anos entre a data de nascimento e a data atual.
    SET idade = TIMESTAMPDIFF(YEAR, dataNasc, CURDATE());
    
    RETURN idade;
END$$
DELIMITER ;
-- Como Usar:
-- Use a função para calcular a idade de um animal fornecendo sua data de nascimento.
SELECT calcularIdade('2018-08-20');

-- 4. Procedimento para Atualizar a Dosagem de um Medicamento Prescrito
-- Este procedimento atualiza a dosagem de um medicamento prescrito em uma consulta específica.
-- (com parâmetros de entrada)
DELIMITER $$
CREATE PROCEDURE atualizarDosagem(
    IN p_idConsulta INT, 
    IN p_idMedicamento INT, 
    IN novaDosagem VARCHAR(60)
)
BEGIN
    DECLARE dosagemAtual VARCHAR(60);
    -- Busca a dosagem atual do medicamento prescrito.
    SELECT dosagem INTO dosagemAtual
    FROM Consulta_prescreve
    WHERE idConsulta = p_idConsulta AND idMedicamento = p_idMedicamento;
    -- Se a dosagem atual for encontrada, ela é atualizada.
    IF dosagemAtual IS NOT NULL THEN
        UPDATE Consulta_prescreve
        SET dosagem = novaDosagem
        WHERE idConsulta = p_idConsulta AND idMedicamento = p_idMedicamento;
    ELSE
        -- Caso contrário, um erro é lançado.
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Medicamento não encontrado para esta consulta.';
    END IF;
END$$
DELIMITER ;
-- Como Usar:
-- Chame o procedimento para atualizar a dosagem de um medicamento específico em uma consulta.
CALL atualizarDosagem(45, 45, '500mg 2x ao dia');


-- (j) Exemplos de 3 Triggers
-- 1. Trigger Para Inserção
-- Este trigger insere automaticamente um contato padrão quando uma nova pessoa é criada na tabela Pessoa.
DELIMITER //
CREATE TRIGGER InserirContatoPadrao AFTER INSERT ON Pessoa
FOR EACH ROW
BEGIN
    -- Insere um contato padrão para a nova pessoa adicionada.
    INSERT INTO Contatos (telefone, email, idPessoa) 
    VALUES ('0000-111', 'semeil@dominio.com', NEW.idPessoa);
END //
DELIMITER ;
-- Como Disparar:
-- Insira uma nova pessoa para acionar o trigger e adicionar automaticamente o contato padrão.
INSERT INTO Pessoa (CRMV, CPF, nome, bairro, numero, cidade, estado, rua, complemento, tipo)
VALUES ('0 ', '13345678900', 'Novo Tutor', 'Centro', 10, 'Lisboa', 'PT', 'Rua A', '', 'Tutor');

-- 2. Trigger Para Alteração
-- Este trigger atualiza automaticamente a data limite de retorno ao modificar a data real de retorno em uma consulta.
DELIMITER //
CREATE TRIGGER AtualizarDataRetorno BEFORE UPDATE ON Consulta
FOR EACH ROW
BEGIN
    -- Se a data real de retorno for alterada, a data limite de retorno é ajustada para 30 dias após a nova data.
    IF NEW.dataRealRetorno IS NOT NULL THEN
        SET NEW.dataLimiteRetorno = NEW.dataRealRetorno + INTERVAL 30 DAY;
    END IF;
END //
DELIMITER ;
-- Como Disparar:
-- Atualize a data real de retorno de uma consulta para acionar o trigger.
UPDATE Consulta SET dataRealRetorno = '2024-08-14' WHERE idConsulta = 1;

-- 3. Trigger Para Exclusão
-- Este trigger registra a exclusão de um animal em uma tabela de log.
DELIMITER //
CREATE TRIGGER LogExclusaoAnimal AFTER DELETE ON Animal
FOR EACH ROW
BEGIN
    -- Insere um registro de log com a descrição e a data/hora da exclusão do animal.
    INSERT INTO LogExclusoes (descricao, dataHora) 
    VALUES (CONCAT('Animal ', OLD.nome, ' excluído.'), NOW());
END //
DELIMITER ;
-- Como Disparar:
-- Exclua um animal para acionar o trigger e registrar a exclusão no log.
DELETE FROM Animal WHERE idAnimal = 1;

-- Trigger para garantir que dataLimiteRetorno seja até 30 dias após dataConsulta durante a inserção.
DELIMITER //
CREATE TRIGGER trg_check_dataLimiteRetorno
BEFORE INSERT ON Consulta
FOR EACH ROW
BEGIN
    -- Verifica se a data limite de retorno não ultrapassa 30 dias após a data da consulta.
    IF NEW.dataLimiteRetorno > DATE_ADD(NEW.dataConsulta, INTERVAL 30 DAY) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'dataLimiteRetorno deve ser até 30 dias após dataConsulta';
    END IF;
END//
DELIMITER ;
