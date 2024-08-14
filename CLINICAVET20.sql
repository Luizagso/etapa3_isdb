-- (a) Criação de todas as tabelas e de todas as restrições de integridade

-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS ClinicaVeterinaria DEFAULT CHARACTER SET utf8 ;
USE ClinicaVeterinaria ;

-- Criação da tabela Pessoa
CREATE TABLE IF NOT EXISTS Pessoa (
    idPessoa INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CRMV VARCHAR(20) UNIQUE NULL,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    nome VARCHAR(60) NOT NULL,
    bairro VARCHAR(60) NOT NULL,
    numero INT NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    estado VARCHAR(60) NOT NULL,
    rua VARCHAR(60) NOT NULL,
    complemento VARCHAR(10) NULL,
    tipo ENUM('Veterinario', 'Tutor') NOT NULL DEFAULT 'Tutor'
);

-- Criação da tabela Contatos
CREATE TABLE IF NOT EXISTS Contatos (
    idContato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    telefone VARCHAR(19) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    idPessoa INT NOT NULL,
    CONSTRAINT fk_Contatos_Pessoa
        FOREIGN KEY (idPessoa)
        REFERENCES Pessoa (idPessoa)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Criação da tabela Animal
CREATE TABLE IF NOT EXISTS Animal (
    idAnimal INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idPessoa INT NOT NULL,
    registro VARCHAR(20) UNIQUE NOT NULL,
    dataNasc DATE NOT NULL,
    nome VARCHAR(60) NOT NULL,
    raca VARCHAR(60) NOT NULL,
    especie VARCHAR(60) NOT NULL,
    sexo ENUM('Macho', 'Fêmea') NOT NULL DEFAULT 'Macho',
    CONSTRAINT fk_Animal_Pessoa
        FOREIGN KEY (idPessoa)
        REFERENCES Pessoa (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Criação da tabela Consulta
CREATE TABLE IF NOT EXISTS Consulta (
    idConsulta INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idAnimal INT NOT NULL,
    dataConsulta DATETIME NOT NULL,
    idPessoa INT NOT NULL,
    dataRealRetorno DATETIME NULL,
    dataLimiteRetorno DATE NOT NULL,
    UNIQUE KEY (dataConsulta, idAnimal),
    CONSTRAINT fk_Consulta_Animal
        FOREIGN KEY (idAnimal)
        REFERENCES Animal (idAnimal)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_Consulta_Pessoa
        FOREIGN KEY (idPessoa)
        REFERENCES Pessoa (idPessoa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Criação da tabela Medicamento
CREATE TABLE IF NOT EXISTS Medicamento (
    idMedicamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    registro VARCHAR(20) UNIQUE NOT NULL,
    descricao VARCHAR(60) NOT NULL DEFAULT 'Sem descrição'
);

-- Criação da tabela Exame
CREATE TABLE IF NOT EXISTS Exame (
    idExame INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    registro VARCHAR(20) UNIQUE NOT NULL,
    descricao VARCHAR(60) NOT NULL DEFAULT 'Sem descrição'
);

-- Criação da tabela Consulta_Prescreve
CREATE TABLE IF NOT EXISTS Consulta_prescreve (
    idMedicamento INT NOT NULL,
    idConsulta INT NOT NULL,
    dosagem VARCHAR(60) NOT NULL,
    PRIMARY KEY (idMedicamento, idConsulta),
    CONSTRAINT fk_prescreve_medicamento
        FOREIGN KEY (idMedicamento)
        REFERENCES Medicamento (idMedicamento)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_prescreve_consulta
        FOREIGN KEY (idConsulta)
        REFERENCES Consulta (idConsulta)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Criação da tabela Consulta_Solicita
CREATE TABLE IF NOT EXISTS Consulta_Solicita (
    idConsulta INT NOT NULL,
    idExame INT NOT NULL,
    resultado VARCHAR(60) NULL DEFAULT 'Pendente',
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
        ON UPDATE CASCADE
);

-- (b) Exemplos de ALTER TABLE e DROP TABLE

-- Adicionando uma nova coluna na tabela Pessoa
ALTER TABLE Pessoa ADD COLUMN telefone VARCHAR(15);

-- Removendo a coluna da tabela Pessoa
ALTER TABLE Pessoa DROP COLUMN telefone;

-- Modificando o tipo de dados da coluna CRMV na tabela Pessoa
ALTER TABLE Pessoa MODIFY COLUMN CRMV VARCHAR(25);

-- Adicionando uma restrição UNIQUE na coluna email da tabela Contatos
ALTER TABLE Contatos ADD UNIQUE (email);

-- Criação de uma tabela extra para exemplificação
CREATE TABLE Extra (
    idExtra INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

-- Removendo a tabela extra criada
DROP TABLE Extra;

-- (c) Inserção de dados em cada uma das tabelas
USE ClinicaVeterinaria;

-- Inserção na tabela Pessoa (25 registros)
INSERT INTO Pessoa (idPessoa, CRMV, CPF, nome, bairro, numero, cidade, estado, rua, complemento, tipo) VALUES
(1, '123456-SP', '111.222.333-44', 'Dr. João Silva', 'Centro', 10, 'Lisboa', 'LI', 'Rua A', '', 'Veterinario'),
(2, '234567-SP', '222.333.444-55', 'Dra. Maria Oliveira', 'Bairro Alto', 23, 'Lisboa', 'LI', 'Rua B', '', 'Veterinario'),
(3, '345678-SP', '333.444.555-66', 'Dr. Carlos Santos', 'Bela Vista', 45, 'Porto', 'PT', 'Rua C', '', 'Veterinario'),
(4, '456789-SP', '444.555.666-77', 'Ana Costa', 'Jardim Botânico', 56, 'Coimbra', 'CB', 'Rua D', 'Apto 101', 'Tutor'),
(5, '567890-SP', '555.666.777-88', 'João Pereira', 'Centro', 78, 'Faro', 'FA', 'Rua E', 'Casa 5', 'Tutor'),
(6, '678901-SP', '666.777.888-99', 'Pedro Almeida', 'São Bento', 12, 'Braga', 'BR', 'Rua F', 'Apto 201', 'Tutor'),
(7, '789012-SP', '777.888.999-00', 'José Silva', 'Alvalade', 34, 'Lisboa', 'LI', 'Rua G', '', 'Tutor'),
(8, '890123-SP', '888.999.000-11', 'Paula Mendes', 'Centro', 56, 'Faro', 'FA', 'Rua H', 'Apto 301', 'Veterinario'),
(9, '901234-SP', '999.000.111-22', 'Carla Ribeiro', 'Campanhã', 78, 'Porto', 'PT', 'Rua I', '', 'Tutor'),
(10, '012345-SP', '000.111.222-33', 'Antônio Sousa', 'Baixa', 90, 'Lisboa', 'LI', 'Rua J', 'Casa 2', 'Veterinario'),
(11, '123457-SP', '011.122.233-44', 'Rita Gomes', 'Vila Nova', 11, 'Braga', 'BR', 'Rua K', '', 'Tutor'),
(12, '234568-SP', '022.133.244-55', 'Bruno Marques', 'Campo Grande', 22, 'Lisboa', 'LI', 'Rua L', 'Apto 402', 'Tutor'),
(13, '345679-SP', '033.144.255-66', 'Letícia Faria', 'Centro', 33, 'Faro', 'FA', 'Rua M', '', 'Tutor'),
(14, '456780-SP', '044.155.266-77', 'Marcos Teixeira', 'Trindade', 44, 'Porto', 'PT', 'Rua N', 'Casa 3', 'Veterinario'),
(15, '567891-SP', '055.166.277-88', 'Fernanda Lima', 'Jardins', 55, 'Lisboa', 'LI', 'Rua O', 'Apto 503', 'Tutor'),
(16, '678902-SP', '066.177.288-99', 'Luís Neves', 'Sé', 66, 'Braga', 'BR', 'Rua P', '', 'Tutor'),
(17, '789013-SP', '077.188.299-00', 'Mariana Costa', 'Bairro Alto', 77, 'Lisboa', 'LI', 'Rua Q', '', 'Veterinario'),
(18, '890124-SP', '088.199.300-11', 'Tiago Freitas', 'Centro', 88, 'Faro', 'FA', 'Rua R', 'Apto 604', 'Tutor'),
(19, '901235-SP', '099.200.311-22', 'Inês Barbosa', 'Baixa', 99, 'Lisboa', 'LI', 'Rua S', '', 'Tutor'),
(20, '012346-SP', '100.211.322-33', 'Jorge Coelho', 'São Martinho', 10, 'Coimbra', 'CB', 'Rua T', '', 'Veterinario'),
(21, '123458-SP', '111.222.333-55', 'Carolina Duarte', 'Bela Vista', 12, 'Porto', 'PT', 'Rua U', '', 'Tutor'),
(22, '234569-SP', '122.233.344-66', 'Renato Nogueira', 'Alcântara', 14, 'Lisboa', 'LI', 'Rua V', '', 'Tutor'),
(23, '345680-SP', '133.244.355-77', 'Tatiana Rodrigues', 'São Bento', 16, 'Braga', 'BR', 'Rua W', '', 'Veterinario'),
(24, '456791-SP', '144.255.366-88', 'Luciana Matos', 'Campo Grande', 18, 'Lisboa', 'LI', 'Rua X', '', 'Tutor'),
(25, '567902-SP', '155.266.377-99', 'Diego Rocha', 'Centro', 20, 'Faro', 'FA', 'Rua Y', 'Casa 6', 'Tutor');

-- Inserção na tabela Pessoa (25 registros)
INSERT INTO Pessoa (idPessoa, CRMV, CPF, nome, bairro, numero, cidade, estado, rua, complemento, tipo) VALUES
(26, '678913-SP', '166.277.388-00', 'Simone Mendes', 'Vila Nova', 22, 'Braga', 'BR', 'Rua Z', '', 'Tutor'),
(27, '789024-SP', '177.288.399-11', 'Fábio Sousa', 'Jardim Botânico', 24, 'Coimbra', 'CB', 'Rua AA', '', 'Veterinario'),
(28, '890135-SP', '188.299.400-22', 'Nádia Fernandes', 'Campanhã', 26, 'Porto', 'PT', 'Rua BB', '', 'Tutor'),
(29, '901246-SP', '199.300.411-33', 'César Silva', 'Centro', 28, 'Lisboa', 'LI', 'Rua CC', 'Apto 703', 'Tutor'),
(30, '012357-SP', '200.311.422-44', 'Juliana Reis', 'Baixa', 30, 'Lisboa', 'LI', 'Rua DD', '', 'Veterinario'),
(31, '123459-SP', '211.322.433-55', 'Bruno Carvalho', 'Trindade', 32, 'Porto', 'PT', 'Rua EE', '', 'Tutor'),
(32, '234570-SP', '222.333.444-66', 'Marta Oliveira', 'Centro', 34, 'Faro', 'FA', 'Rua FF', '', 'Tutor'),
(33, '345681-SP', '233.344.455-77', 'Rodrigo Alves', 'Bairro Alto', 36, 'Lisboa', 'LI', 'Rua GG', 'Casa 7', 'Veterinario'),
(34, '456792-SP', '244.355.466-88', 'Daniela Santos', 'Alvalade', 38, 'Lisboa', 'LI', 'Rua HH', '', 'Tutor'),
(35, '567903-SP', '255.366.477-99', 'Lucas Martins', 'Centro', 40, 'Faro', 'FA', 'Rua II', '', 'Tutor'),
(36, '678914-SP', '266.377.488-00', 'Cláudia Pinto', 'Baixa', 42, 'Lisboa', 'LI', 'Rua JJ', '', 'Tutor'),
(37, '789025-SP', '277.388.499-11', 'Marcelo Gomes', 'Sé', 44, 'Braga', 'BR', 'Rua KK', '', 'Veterinario'),
(38, '890136-SP', '288.399.500-22', 'André Silva', 'Vila Nova', 46, 'Braga', 'BR', 'Rua LL', '', 'Tutor'),
(39, '901247-SP', '299.400.511-33', 'Patrícia Sousa', 'Centro', 48, 'Faro', 'FA', 'Rua MM', '', 'Tutor'),
(40, '012358-SP', '300.411.522-44', 'Roberta Teixeira', 'Baixa', 50, 'Lisboa', 'LI', 'Rua NN', '', 'Tutor'),
(41, '123460-SP', '311.422.533-55', 'Vinícius Oliveira', 'Alcântara', 52, 'Lisboa', 'LI', 'Rua OO', 'Casa 8', 'Veterinario'),
(42, '234571-SP', '322.433.544-66', 'Érica Costa', 'Jardins', 54, 'Lisboa', 'LI', 'Rua PP', '', 'Tutor'),
(43, '345682-SP', '333.444.555-77', 'Felipe Mendes', 'Bela Vista', 56, 'Porto', 'PT', 'Rua QQ', '', 'Tutor'),
(44, '456793-SP', '344.455.566-88', 'Renata Figueiredo', 'São Martinho', 58, 'Coimbra', 'CB', 'Rua RR', '', 'Veterinario'),
(45, '567904-SP', '355.466.577-99', 'Gustavo Lima', 'Campo Grande', 60, 'Lisboa', 'LI', 'Rua SS', 'Apto 804', 'Tutor'),
(46, '678915-SP', '366.477.588-00', 'Amanda Ferreira', 'Centro', 62, 'Faro', 'FA', 'Rua TT', '', 'Tutor'),
(47, '789026-SP', '377.488.599-11', 'Sérgio Almeida', 'Campanhã', 64, 'Porto', 'PT', 'Rua UU', '', 'Tutor'),
(48, '890137-SP', '388.499.600-22', 'Thais Rodrigues', 'Baixa', 66, 'Lisboa', 'LI', 'Rua VV', '', 'Tutor'),
(49, '901248-SP', '399.500.611-33', 'Eduardo Moreira', 'Centro', 68, 'Faro', 'FA', 'Rua WW', 'Apto 904', 'Veterinario'),
(50, '904247-SP', '399.540.611-33', 'Luiza Silva', 'Betânia', 68, 'Belo Horizonte', 'MG', 'Rua WW', 'Apto 904', 'Tutor');

-- Inserção na tabela Contatos (25 registros)
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
(1, 'AN-001', 1, 'Rex', '2020-01-01', 'Labrador', 'Cão', 'Macho'),
(2, 'AN-002', 2, 'Luna', '2019-05-15', 'Poodle', 'Cão', 'Fêmea'),
(3, 'AN-003', 3, 'Max', '2018-08-20', 'Golden Retriever', 'Cão', 'Macho'),
(4, 'AN-004', 4, 'Mia', '2020-10-30', 'Persa', 'Gato', 'Fêmea'),
(5, 'AN-005', 5, 'Bob', '2017-12-12', 'Bulldog', 'Cão', 'Macho'),
(6, 'AN-006', 6, 'Nina', '2019-04-18', 'Sphynx', 'Gato', 'Fêmea'),
(7, 'AN-007', 7, 'Zeus', '2016-06-22', 'Boxer', 'Cão', 'Macho'),
(8, 'AN-008', 8, 'Maggie', '2021-02-27', 'Beagle', 'Cão', 'Fêmea'),
(9, 'AN-009', 9, 'Simba', '2018-11-19', 'Maine Coon', 'Gato', 'Macho'),
(10, 'AN-010', 10, 'Chloe', '2017-03-05', 'Bengal', 'Gato', 'Fêmea'),
(11, 'AN-011', 11, 'Duke', '2019-07-07', 'Doberman', 'Cão', 'Macho'),
(12, 'AN-012', 12, 'Bella', '2018-09-12', 'Yorkshire', 'Cão', 'Fêmea'),
(13, 'AN-013', 13, 'Thor', '2020-12-15', 'Pastor Alemão', 'Cão', 'Macho'),
(14, 'AN-014', 14, 'Sasha', '2016-11-21', 'Rottweiler', 'Cão', 'Fêmea'),
(15, 'AN-015', 15, 'Rocky', '2018-02-25', 'Shih Tzu', 'Cão', 'Macho'),
(16, 'AN-016', 16, 'Lucy', '2019-03-29', 'Siamês', 'Gato', 'Fêmea'),
(17, 'AN-017', 17, 'Oscar', '2017-08-08', 'Bulldog Francês', 'Cão', 'Macho'),
(18, 'AN-018', 18, 'Lola', '2021-01-15', 'Chihuahua', 'Cão', 'Fêmea'),
(19, 'AN-019', 19, 'Bruno', '2020-04-22', 'Pug', 'Cão', 'Macho'),
(20, 'AN-020', 20, 'Maya', '2019-06-30', 'Scottish Fold', 'Gato', 'Fêmea'),
(21, 'AN-021', 21, 'Jade', '2020-07-04', 'Golden Retriever', 'Cão', 'Fêmea'),
(22, 'AN-022', 22, 'Sam', '2018-10-17', 'Akita', 'Cão', 'Macho'),
(23, 'AN-023', 23, 'Nala', '2020-11-20', 'Siberiano', 'Gato', 'Fêmea'),
(24, 'AN-024', 24, 'Leo', '2017-12-26', 'Bulldog Inglês', 'Cão', 'Macho');

-- Inserção na tabela Animal (25 registros)
INSERT INTO Animal (idAnimal, registro, idPessoa, nome, dataNasc, raca, especie, sexo) VALUES
(25, 'AN-025', 25, 'Juno', '2016-02-19', 'Poodle Toy', 'Cão', 'Fêmea'),
(26, 'AN-026', 26, 'Toby', '2019-05-09', 'Weimaraner', 'Cão', 'Macho'),
(27, 'AN-027', 27, 'Lily', '2021-03-01', 'Dachshund', 'Cão', 'Fêmea'),
(28, 'AN-028', 28, 'Buddy', '2018-04-14', 'Lhasa Apso', 'Cão', 'Macho'),
(29, 'AN-029', 29, 'Daisy', '2020-06-18', 'Bichon Frisé', 'Cão', 'Fêmea'),
(30, 'AN-030', 30, 'Teddy', '2017-07-23', 'Pomeranian', 'Cão', 'Macho'),
(31, 'AN-031', 31, 'Bailey', '2019-09-28', 'Border Collie', 'Cão', 'Macho'),
(32, 'AN-032', 32, 'Ginger', '2018-01-03', 'Poodle Miniatura', 'Cão', 'Fêmea'),
(33, 'AN-033', 33, 'Bentley', '2020-05-08', 'Buldogue Americano', 'Cão', 'Macho'),
(34, 'AN-034', 34, 'Zara', '2017-08-15', 'Bengal', 'Gato', 'Fêmea'),
(35, 'AN-035', 35, 'Charlie', '2016-11-27', 'Labradoodle', 'Cão', 'Macho'),
(36, 'AN-036', 36, 'Ruby', '2018-03-12', 'Maltês', 'Cão', 'Fêmea'),
(37, 'AN-037', 37, 'Harley', '2020-07-30', 'Terrier', 'Cão', 'Macho'),
(38, 'AN-038', 38, 'Ella', '2019-01-17', 'Buldogue Francês', 'Cão', 'Fêmea'),
(39, 'AN-039', 39, 'Jake', '2017-02-20', 'Dogue Alemão', 'Cão', 'Macho'),
(40, 'AN-040', 40, 'Sophie', '2021-04-05', 'Husky', 'Cão', 'Fêmea'),
(41, 'AN-041', 41, 'Jasper', '2020-09-10', 'Dálmata', 'Cão', 'Macho'),
(42, 'AN-042', 42, 'Coco', '2018-12-14', 'Pastor Australiano', 'Cão', 'Fêmea'),
(43, 'AN-043', 43, 'Bear', '2019-03-29', 'Bulldog Americano', 'Cão', 'Macho'),
(44, 'AN-044', 44, 'Lulu', '2017-06-01', 'Schnauzer', 'Cão', 'Fêmea'),
(45, 'AN-045', 45, 'Riley', '2016-08-03', 'Pit Bull', 'Cão', 'Macho'),
(46, 'AN-046', 46, 'Molly', '2018-10-20', 'Chow Chow', 'Cão', 'Fêmea'),
(47, 'AN-047', 47, 'Otis', '2019-12-25', 'Shar Pei', 'Cão', 'Macho'),
(48, 'AN-048', 48, 'Pepper', '2020-02-14', 'Whippet', 'Cão', 'Fêmea'),
(49, 'AN-049', 49, 'Sparky', '2017-09-12', 'Galgo', 'Cão', 'Macho'),
(50, 'AN-050', 49, 'Juju', '2020-01-01', 'Labrador', 'Cão', 'Macho');

-- Inserção na tabela Consulta (25 registros)
INSERT INTO Consulta (idConsulta, dataConsulta, idAnimal, idPessoa, dataLimiteRetorno, dataRealRetorno) VALUES
(1, '2024-01-01', 1, 1, '2024-01-15', NULL),
(2, '2024-01-05', 2, 2, '2024-01-20', NULL),
(3, '2024-01-10', 3, 3, '2024-01-25', NULL),
(4, '2024-01-15', 4, 4, '2024-01-30', NULL),
(5, '2024-01-20', 5, 5, '2024-02-05', NULL),
(6, '2024-01-25', 6, 6, '2024-02-10', NULL),
(7, '2024-01-30', 7, 7, '2024-02-15', NULL),
(8, '2024-02-01', 8, 8, '2024-02-20', NULL),
(9, '2024-02-05', 9, 9, '2024-02-25', NULL),
(10, '2024-02-10', 10, 10, '2024-03-01', NULL),
(11, '2024-02-15', 11, 11, '2024-03-05', NULL),
(12, '2024-02-20', 12, 12, '2024-03-10', NULL),
(13, '2024-02-25', 13, 13, '2024-03-15', NULL),
(14, '2024-03-01', 14, 14, '2024-03-20', NULL),
(15, '2024-03-05', 15, 15, '2024-03-25', NULL),
(16, '2024-03-10', 16, 16, '2024-04-01', NULL),
(17, '2024-03-15', 17, 17, '2024-04-05', NULL),
(18, '2024-03-20', 18, 18, '2024-04-10', NULL),
(19, '2024-03-25', 19, 19, '2024-04-15', NULL),
(20, '2024-04-01', 20, 20, '2024-04-20', NULL),
(21, '2024-04-05', 21, 21, '2024-04-25', NULL),
(22, '2024-04-10', 22, 22, '2024-05-01', NULL),
(23, '2024-04-15', 23, 23, '2024-05-05', NULL),
(24, '2024-04-20', 24, 24, '2024-05-10', NULL);

-- Inserção na tabela Consulta (25 registros)
INSERT INTO Consulta (idConsulta, dataConsulta, idAnimal, idPessoa, dataLimiteRetorno, dataRealRetorno) VALUES
(25, '2024-04-25', 25, 25, '2024-05-15', NULL),
(26, '2024-05-01', 26, 26, '2024-05-20', NULL),
(27, '2024-05-05', 27, 27, '2024-05-25', NULL),
(28, '2024-05-10', 28, 28, '2024-06-01', NULL),
(29, '2024-05-15', 29, 29, '2024-06-05', NULL),
(30, '2024-05-20', 30, 30, '2024-06-10', NULL),
(31, '2024-05-25', 31, 31, '2024-06-15', NULL),
(32, '2024-06-01', 32, 32, '2024-06-20', NULL),
(33, '2024-06-05', 33, 33, '2024-06-25', NULL),
(34, '2024-06-10', 34, 34, '2024-07-01', NULL),
(35, '2024-06-15', 35, 35, '2024-07-05', NULL),
(36, '2024-06-20', 36, 36, '2024-07-10', NULL),
(37, '2024-06-25', 37, 37, '2024-07-15', NULL),
(38, '2024-07-01', 38, 38, '2024-07-20', NULL),
(39, '2024-07-05', 39, 39, '2024-07-25', NULL),
(40, '2024-07-10', 40, 40, '2024-08-01', NULL),
(41, '2024-07-15', 41, 41, '2024-08-05', NULL),
(42, '2024-07-20', 42, 42, '2024-08-10', NULL),
(43, '2024-07-25', 43, 43, '2024-08-15', NULL),
(44, '2024-08-01', 44, 44, '2024-08-20', NULL),
(45, '2024-08-05', 45, 45, '2024-08-25', NULL),
(46, '2024-08-10', 46, 46, '2024-09-01', NULL),
(47, '2024-08-15', 47, 47, '2024-09-05', NULL),
(48, '2024-08-20', 48, 48, '2024-09-10', NULL),
(49, '2024-08-25', 49, 49, '2024-09-15', NULL),
(50, '2024-08-30', 50, 50, '2024-09-20', NULL);

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
(24, 'MED-024', 'Antidepressivo para animais com ansiedade');

-- Inserção na tabela Medicamento (25 registros)
INSERT INTO Medicamento (idMedicamento, registro, descricao) VALUES
(25, 'MED-025', 'Antiparasitário de uso externo'),
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
(50, 'MED-050', 'Comprimido para tratamento de obesidade');

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

-- Inserção na tabela Consulta_Prescreve (25 registros)
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
(50, 50, '1 comprimido 2x ao dia');

-- Inserção na tabela Consulta_Solicita (25 registros)
INSERT INTO Consulta_Solicita (idConsulta, idExame, resultado) VALUES
(1, 1, 'Normal'),
(2, 2, 'Leve dilatação abdominal'),
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

-- Inserção na tabela Consulta_Solicita (50 registros)
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

-- (d) Exemplos de modificação de dados em 5 tabelas
-- Atualizando dados na tabela Pessoa
UPDATE Pessoa SET nome = 'Dr. João da Silva' WHERE idPessoa = 1;

-- Atualizando dados na tabela Contatos
UPDATE Contatos SET telefone = '21987654322' WHERE idContatos = 2;

-- Atualizando dados na tabela Animal
UPDATE Animal SET raca = 'Golden Retriever' WHERE idAnimal = 1;

-- Atualizando dados na tabela Consulta
UPDATE Consulta SET dataRealRetorno = '2023-07-18' WHERE idConsulta = 1;

-- Atualizando dados na tabela Medicamento
UPDATE Medicamento SET descricao = 'Antibiótico de amplo espectro' WHERE idMedicamento = 1;

-- UPDATE aninhado 
UPDATE Pessoa p1
JOIN Pessoa p2 ON p2.idPessoa = 2
SET p1.bairro = p2.bairro
WHERE p1.idPessoa = 1;

-- (e) Exemplos de exclusão de dados em 5 tabelas SER MAIS CRIATIVA NAS EXCLUSÕES
-- Deletando dados na tabela Consulta_Prescreve
DELETE FROM Consulta_Prescreve WHERE idConsulta = 2;

-- Deletando dados na tabela Consulta_Solicita
DELETE FROM Consulta_Solicita WHERE idConsulta = 2;

-- Deletando dados na tabela Consulta
DELETE FROM Consulta WHERE idConsulta = 2;

-- Deletando dados na tabela Animal
DELETE FROM Animal WHERE idAnimal = 2;

-- Deletando dados na tabela Medicamento
DELETE FROM Medicamento WHERE idMedicamento = 2;

-- (f) Exemplos de consultas complexas
-- Consulta simples
SELECT * FROM Pessoa;

-- Consulta com JOIN
SELECT p.nome, c.telefone FROM Pessoa p JOIN Contatos c ON p.idPessoa = c.idPessoa;

-- Consulta com OUTER JOIN
SELECT p.nome, a.nome AS animal FROM Pessoa p LEFT JOIN Animal a ON p.idPessoa = a.idPessoa;

-- Consulta com UNION
SELECT nome FROM Pessoa WHERE tipo = 'Veterinario'
UNION
SELECT nome FROM Animal;

-- Consulta com AND e OR
SELECT * FROM Animal WHERE especie = 'Cachorro' AND (sexo = 'Masculino' OR raca = 'Golden Retriever');

-- Consulta com BETWEEN
SELECT * FROM Consulta WHERE dataConsulta BETWEEN '2023-07-01' AND '2023-07-31';

-- Consulta com IN
SELECT * FROM Pessoa WHERE cidade IN ('São Paulo', 'Rio de Janeiro');

-- Consulta com LIKE
SELECT * FROM Pessoa WHERE nome LIKE 'Dr.%';

-- Consulta com IS NULL
SELECT * FROM Consulta WHERE dataRealRetorno IS NULL;

-- Consulta com funções agregadas
SELECT COUNT(*) AS total_consultas FROM Consulta WHERE idPessoa = 1;

-- Consulta aninhada
SELECT nome FROM Pessoa WHERE idPessoa = (SELECT idPessoa FROM Animal WHERE nome = 'Rex');

-- Consulta com GROUP BY e HAVING
SELECT cidade, COUNT(*) AS total FROM Pessoa GROUP BY cidade HAVING total > 1;

