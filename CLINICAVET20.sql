-- (a) Criação de todas as tabelas e de todas as restrições de integridade
CREATE DATABASE ClinicaVeterinaria;
USE ClinicaVeterinaria;

-- Criação da tabela Pessoa
CREATE TABLE Pessoa (
    idPessoa INT AUTO_INCREMENT PRIMARY KEY,
    CRMV VARCHAR(20),
    CPF VARCHAR(14) UNIQUE,
    nome VARCHAR(100),
    bairro VARCHAR(100),
    numero INT,
    cidade VARCHAR(100),
    estado CHAR(2),
    rua VARCHAR(100),
    complemento VARCHAR(100),
    tipo ENUM('Veterinario', 'Tutor')
);

-- Criação da tabela Contatos
CREATE TABLE Contatos (
    idContatos INT AUTO_INCREMENT PRIMARY KEY,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    idPessoa INT,
    CONSTRAINT fk_contatos_pessoa FOREIGN KEY (idPessoa)
        REFERENCES Pessoa(idPessoa)
        ON DELETE CASCADE
);

-- Criação da tabela Animal
CREATE TABLE Animal (
    idAnimal INT AUTO_INCREMENT PRIMARY KEY,
    registro VARCHAR(20) UNIQUE,
    idPessoa INT,
    nome VARCHAR(100),
    dataNasc DATE,
    raca VARCHAR(50),
    especie VARCHAR(50),
    sexo ENUM('Masculino', 'Feminino'),
    CONSTRAINT fk_animal_pessoa FOREIGN KEY (idPessoa)
        REFERENCES Pessoa(idPessoa)
        ON DELETE CASCADE
);

-- Criação da tabela Consulta
CREATE TABLE Consulta (
    idConsulta INT AUTO_INCREMENT PRIMARY KEY,
    dataConsulta DATE,
    idAnimal INT,
    idPessoa INT,
    dataLimiteRetorno DATE,
    dataRealRetorno DATE,
    CONSTRAINT fk_consulta_animal FOREIGN KEY (idAnimal)
        REFERENCES Animal(idAnimal)
        ON DELETE CASCADE,
    CONSTRAINT fk_consulta_pessoa FOREIGN KEY (idPessoa)
        REFERENCES Pessoa(idPessoa)
        ON DELETE CASCADE
);

-- Criação da tabela Medicamento
CREATE TABLE Medicamento (
    idMedicamento INT AUTO_INCREMENT PRIMARY KEY,
    registro VARCHAR(20) UNIQUE,
    descricao TEXT
);

-- Criação da tabela Consulta_Prescreve
CREATE TABLE Consulta_Prescreve (
    idConsulta INT,
    idMedicamento INT,
    dosagem VARCHAR(50),
    PRIMARY KEY (idConsulta, idMedicamento),
    CONSTRAINT fk_prescreve_consulta FOREIGN KEY (idConsulta)
        REFERENCES Consulta(idConsulta)
        ON DELETE CASCADE,
    CONSTRAINT fk_prescreve_medicamento FOREIGN KEY (idMedicamento)
        REFERENCES Medicamento(idMedicamento)
        ON DELETE CASCADE
);

-- Criação da tabela Exame
CREATE TABLE Exame (
    idExame INT AUTO_INCREMENT PRIMARY KEY,
    registro VARCHAR(20) UNIQUE,
    descricao TEXT
);

-- Criação da tabela Consulta_Solicita
CREATE TABLE Consulta_Solicita (
    idConsulta INT,
    idExame INT,
    resultado TEXT,
    PRIMARY KEY (idConsulta, idExame),
    CONSTRAINT fk_solicita_consulta FOREIGN KEY (idConsulta)
        REFERENCES Consulta(idConsulta)
        ON DELETE CASCADE,
    CONSTRAINT fk_solicita_exame FOREIGN KEY (idExame)
        REFERENCES Exame(idExame)
        ON DELETE CASCADE
);


-- (b) Exemplos de ALTER TABLE e DROP TABLE

-- Adicionando uma nova coluna na tabela Pessoa
ALTER TABLE Pessoa ADD COLUMN telefone VARCHAR(15);

-- Modificando o tipo de dados da coluna CRMV na tabela Pessoa
ALTER TABLE Pessoa MODIFY COLUMN CRMV VARCHAR(30);

-- Adicionando uma restrição UNIQUE na coluna email da tabela Contatos
ALTER TABLE Contatos ADD CONSTRAINT UNIQUE (email);

-- Criação de uma tabela extra para exemplificação
CREATE TABLE Extra (
    idExtra INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

-- Removendo a tabela extra criada
DROP TABLE Extra;

-- (c) Inserção de dados em cada uma das tabelas

USE ClinicaVeterinaria;

-- Inserção na tabela Pessoa (50 registros)
INSERT INTO Pessoa (CRMV, CPF, nome, bairro, numero, cidade, estado, rua, complemento, tipo) VALUES
('123456-SP', '111.222.333-44', 'Dr. João Silva', 'Centro', 10, 'Lisboa', 'LI', 'Rua A', '', 'Veterinario'),
('234567-SP', '222.333.444-55', 'Dra. Maria Oliveira', 'Bairro Alto', 23, 'Lisboa', 'LI', 'Rua B', '', 'Veterinario'),
('345678-SP', '333.444.555-66', 'Dr. Carlos Santos', 'Bela Vista', 45, 'Porto', 'PT', 'Rua C', '', 'Veterinario'),
('456789-SP', '444.555.666-77', 'Ana Costa', 'Jardim Botânico', 56, 'Coimbra', 'CB', 'Rua D', 'Apto 101', 'Tutor'),
('567890-SP', '555.666.777-88', 'João Pereira', 'Centro', 78, 'Faro', 'FA', 'Rua E', 'Casa 5', 'Tutor'),
('678901-SP', '666.777.888-99', 'Pedro Almeida', 'São Bento', 12, 'Braga', 'BR', 'Rua F', 'Apto 201', 'Tutor'),
('789012-SP', '777.888.999-00', 'José Silva', 'Alvalade', 34, 'Lisboa', 'LI', 'Rua G', '', 'Tutor'),
('890123-SP', '888.999.000-11', 'Paula Mendes', 'Centro', 56, 'Faro', 'FA', 'Rua H', 'Apto 301', 'Veterinario'),
('901234-SP', '999.000.111-22', 'Carla Ribeiro', 'Campanhã', 78, 'Porto', 'PT', 'Rua I', '', 'Tutor'),
('012345-SP', '000.111.222-33', 'Antônio Sousa', 'Baixa', 90, 'Lisboa', 'LI', 'Rua J', 'Casa 2', 'Veterinario'),
('123457-SP', '011.122.233-44', 'Rita Gomes', 'Vila Nova', 11, 'Braga', 'BR', 'Rua K', '', 'Tutor'),
('234568-SP', '022.133.244-55', 'Bruno Marques', 'Campo Grande', 22, 'Lisboa', 'LI', 'Rua L', 'Apto 402', 'Tutor'),
('345679-SP', '033.144.255-66', 'Letícia Faria', 'Centro', 33, 'Faro', 'FA', 'Rua M', '', 'Tutor'),
('456780-SP', '044.155.266-77', 'Marcos Teixeira', 'Trindade', 44, 'Porto', 'PT', 'Rua N', 'Casa 3', 'Veterinario'),
('567891-SP', '055.166.277-88', 'Fernanda Lima', 'Jardins', 55, 'Lisboa', 'LI', 'Rua O', 'Apto 503', 'Tutor'),
('678902-SP', '066.177.288-99', 'Luís Neves', 'Sé', 66, 'Braga', 'BR', 'Rua P', '', 'Tutor'),
('789013-SP', '077.188.299-00', 'Mariana Costa', 'Bairro Alto', 77, 'Lisboa', 'LI', 'Rua Q', '', 'Veterinario'),
('890124-SP', '088.199.300-11', 'Tiago Freitas', 'Centro', 88, 'Faro', 'FA', 'Rua R', 'Apto 604', 'Tutor'),
('901235-SP', '099.200.311-22', 'Inês Barbosa', 'Baixa', 99, 'Lisboa', 'LI', 'Rua S', '', 'Tutor'),
('012346-SP', '100.211.322-33', 'Jorge Coelho', 'São Martinho', 10, 'Coimbra', 'CB', 'Rua T', '', 'Veterinario'),
('123458-SP', '111.222.333-55', 'Carolina Duarte', 'Bela Vista', 12, 'Porto', 'PT', 'Rua U', '', 'Tutor'),
('234569-SP', '122.233.344-66', 'Renato Nogueira', 'Alcântara', 14, 'Lisboa', 'LI', 'Rua V', '', 'Tutor'),
('345680-SP', '133.244.355-77', 'Tatiana Rodrigues', 'São Bento', 16, 'Braga', 'BR', 'Rua W', '', 'Veterinario'),
('456791-SP', '144.255.366-88', 'Luciana Matos', 'Campo Grande', 18, 'Lisboa', 'LI', 'Rua X', '', 'Tutor'),
('567902-SP', '155.266.377-99', 'Diego Rocha', 'Centro', 20, 'Faro', 'FA', 'Rua Y', 'Casa 6', 'Tutor'),
('678913-SP', '166.277.388-00', 'Simone Mendes', 'Vila Nova', 22, 'Braga', 'BR', 'Rua Z', '', 'Tutor'),
('789024-SP', '177.288.399-11', 'Fábio Sousa', 'Jardim Botânico', 24, 'Coimbra', 'CB', 'Rua AA', '', 'Veterinario'),
('890135-SP', '188.299.400-22', 'Nádia Fernandes', 'Campanhã', 26, 'Porto', 'PT', 'Rua BB', '', 'Tutor'),
('901246-SP', '199.300.411-33', 'César Silva', 'Centro', 28, 'Lisboa', 'LI', 'Rua CC', 'Apto 703', 'Tutor'),
('012357-SP', '200.311.422-44', 'Juliana Reis', 'Baixa', 30, 'Lisboa', 'LI', 'Rua DD', '', 'Veterinario'),
('123459-SP', '211.322.433-55', 'Bruno Carvalho', 'Trindade', 32, 'Porto', 'PT', 'Rua EE', '', 'Tutor'),
('234570-SP', '222.333.444-66', 'Marta Oliveira', 'Centro', 34, 'Faro', 'FA', 'Rua FF', '', 'Tutor'),
('345681-SP', '233.344.455-77', 'Rodrigo Alves', 'Bairro Alto', 36, 'Lisboa', 'LI', 'Rua GG', 'Casa 7', 'Veterinario'),
('456792-SP', '244.355.466-88', 'Daniela Santos', 'Alvalade', 38, 'Lisboa', 'LI', 'Rua HH', '', 'Tutor'),
('567903-SP', '255.366.477-99', 'Lucas Martins', 'Centro', 40, 'Faro', 'FA', 'Rua II', '', 'Tutor'),
('678914-SP', '266.377.488-00', 'Cláudia Pinto', 'Baixa', 42, 'Lisboa', 'LI', 'Rua JJ', '', 'Tutor'),
('789025-SP', '277.388.499-11', 'Marcelo Gomes', 'Sé', 44, 'Braga', 'BR', 'Rua KK', '', 'Veterinario'),
('890136-SP', '288.399.500-22', 'André Silva', 'Vila Nova', 46, 'Braga', 'BR', 'Rua LL', '', 'Tutor'),
('901247-SP', '299.400.511-33', 'Patrícia Sousa', 'Centro', 48, 'Faro', 'FA', 'Rua MM', '', 'Tutor'),
('012358-SP', '300.411.522-44', 'Roberta Teixeira', 'Baixa', 50, 'Lisboa', 'LI', 'Rua NN', '', 'Tutor'),
('123460-SP', '311.422.533-55', 'Vinícius Oliveira', 'Alcântara', 52, 'Lisboa', 'LI', 'Rua OO', 'Casa 8', 'Veterinario'),
('234571-SP', '322.433.544-66', 'Érica Costa', 'Jardins', 54, 'Lisboa', 'LI', 'Rua PP', '', 'Tutor'),
('345682-SP', '333.444.555-77', 'Felipe Mendes', 'Bela Vista', 56, 'Porto', 'PT', 'Rua QQ', '', 'Tutor'),
('456793-SP', '344.455.566-88', 'Renata Figueiredo', 'São Martinho', 58, 'Coimbra', 'CB', 'Rua RR', '', 'Veterinario'),
('567904-SP', '355.466.577-99', 'Gustavo Lima', 'Campo Grande', 60, 'Lisboa', 'LI', 'Rua SS', 'Apto 804', 'Tutor'),
('678915-SP', '366.477.588-00', 'Amanda Ferreira', 'Centro', 62, 'Faro', 'FA', 'Rua TT', '', 'Tutor'),
('789026-SP', '377.488.599-11', 'Sérgio Almeida', 'Campanhã', 64, 'Porto', 'PT', 'Rua UU', '', 'Tutor'),
('890137-SP', '388.499.600-22', 'Thais Rodrigues', 'Baixa', 66, 'Lisboa', 'LI', 'Rua VV', '', 'Tutor'),
('901248-SP', '399.500.611-33', 'Eduardo Moreira', 'Centro', 68, 'Faro', 'FA', 'Rua WW', 'Apto 904', 'Veterinario');

-- Inserção na tabela Contatos (50 registros)
INSERT INTO Contatos (telefone, email, idPessoa) VALUES
('911111111', 'joao.silva@exemplo.com',1),
('922222222', 'maria.oliveira@exemplo.com',2),
('933333333', 'carlos.santos@exemplo.com',3),
('944444444', 'ana.costa@exemplo.com',4),
('955555555', 'joao.pereira@exemplo.com',5),
('966666666', 'pedro.almeida@exemplo.com',6),
('977777777', 'jose.silva@exemplo.com',7),
('988888888', 'paula.mendes@exemplo.com',8),
('999999999', 'carla.ribeiro@exemplo.com',9),
('900000000', 'antonio.sousa@exemplo.com',10),
('911111112', 'rita.gomes@exemplo.com',11),
('922222223', 'bruno.marques@exemplo.com',12),
('933333334', 'leticia.faria@exemplo.com',13),
('944444445', 'marcos.teixeira@exemplo.com',14),
('955555556', 'fernanda.lima@exemplo.com',15),
('966666667', 'luis.neves@exemplo.com',16),
('977777778', 'mariana.costa@exemplo.com',17),
('988888889', 'tiago.freitas@exemplo.com',18),
('999999990', 'ines.barbosa@exemplo.com',19),
('900000001', 'jorge.coelho@exemplo.com',20),
('911111113', 'carolina.duarte@exemplo.com',21),
('922222224', 'renato.nogueira@exemplo.com',22),
('933333335', 'tatiana.rodrigues@exemplo.com',23),
('944444446', 'luciana.matos@exemplo.com',24),
('955555557', 'diego.rocha@exemplo.com', 25),
('966666668', 'simone.mendes@exemplo.com',26),
('977777779', 'fabio.sousa@exemplo.com',27),
('988888880', 'nadia.fernandes@exemplo.com',28),
('999999991', 'cesar.silva@exemplo.com',29),
('900000002', 'juliana.reis@exemplo.com',30),
('911111114', 'bruno.carvalho@exemplo.com',31),
('922222225', 'marta.oliveira@exemplo.com',32),
('933333336', 'rodrigo.alves@exemplo.com',33),
('944444447', 'daniela.santos@exemplo.com',34),
('955555558', 'lucas.martins@exemplo.com',35),
('966666669', 'claudia.pinto@exemplo.com',36),
('977777780', 'marcelo.gomes@exemplo.com',37),
('988888881', 'andre.silva@exemplo.com',38),
('999999992', 'patricia.sousa@exemplo.com',39),
('900000003', 'roberta.teixeira@exemplo.com',40),
('911111115', 'vinicius.oliveira@exemplo.com',41),
('922222226', 'erica.costa@exemplo.com',42),
('933333337', 'felipe.mendes@exemplo.com',43),
('944444448', 'renata.figueiredo@exemplo.com',44),
('955555559', 'gustavo.lima@exemplo.com',45),
('966666670', 'amanda.ferreira@exemplo.com',46),
('977777781', 'sergio.almeida@exemplo.com',47),
('988888882', 'thais.rodrigues@exemplo.com',48),
('999999993', 'eduardo.moreira@exemplo.com',49);

-- Inserção na tabela Animal (50 registros)
INSERT INTO Animal (registro, idPessoa, nome, dataNasc, raca, especie, sexo) VALUES
('AN-001', 1, 'Rex', '2020-01-01', 'Labrador', 'Cão', 'Masculino'),
('AN-002', 2, 'Luna', '2019-05-15', 'Poodle', 'Cão', 'Feminino'),
('AN-003', 3, 'Max', '2018-08-20', 'Golden Retriever', 'Cão', 'Masculino'),
('AN-004', 4, 'Mia', '2020-10-30', 'Persa', 'Gato', 'Feminino'),
('AN-005', 5, 'Bob', '2017-12-12', 'Bulldog', 'Cão', 'Masculino'),
('AN-006', 6, 'Nina', '2019-04-18', 'Sphynx', 'Gato', 'Feminino'),
('AN-007', 7, 'Zeus', '2016-06-22', 'Boxer', 'Cão', 'Masculino'),
('AN-008', 8, 'Maggie', '2021-02-27', 'Beagle', 'Cão', 'Feminino'),
('AN-009', 9, 'Simba', '2018-11-19', 'Maine Coon', 'Gato', 'Masculino'),
('AN-010', 10, 'Chloe', '2017-03-05', 'Bengal', 'Gato', 'Feminino'),
('AN-011', 11, 'Duke', '2019-07-07', 'Doberman', 'Cão', 'Masculino'),
('AN-012', 12, 'Bella', '2018-09-12', 'Yorkshire', 'Cão', 'Feminino'),
('AN-013', 13, 'Thor', '2020-12-15', 'Pastor Alemão', 'Cão', 'Masculino'),
('AN-014', 14, 'Sasha', '2016-11-21', 'Rottweiler', 'Cão', 'Feminino'),
('AN-015', 15, 'Rocky', '2018-02-25', 'Shih Tzu', 'Cão', 'Masculino'),
('AN-016', 16, 'Lucy', '2019-03-29', 'Siamês', 'Gato', 'Feminino'),
('AN-017', 17, 'Oscar', '2017-08-08', 'Bulldog Francês', 'Cão', 'Masculino'),
('AN-018', 18, 'Lola', '2021-01-15', 'Chihuahua', 'Cão', 'Feminino'),
('AN-019', 19, 'Bruno', '2020-04-22', 'Pug', 'Cão', 'Masculino'),
('AN-020', 20, 'Maya', '2019-06-30', 'Scottish Fold', 'Gato', 'Feminino'),
('AN-021', 21, 'Jade', '2020-07-04', 'Golden Retriever', 'Cão', 'Feminino'),
('AN-022', 22, 'Sam', '2018-10-17', 'Akita', 'Cão', 'Masculino'),
('AN-023', 23, 'Nala', '2020-11-20', 'Siberiano', 'Gato', 'Feminino'),
('AN-024', 24, 'Leo', '2017-12-26', 'Bulldog Inglês', 'Cão', 'Masculino'),
('AN-025', 25, 'Juno', '2016-02-19', 'Poodle Toy', 'Cão', 'Feminino'),
('AN-026', 26, 'Toby', '2019-05-09', 'Weimaraner', 'Cão', 'Masculino'),
('AN-027', 27, 'Lily', '2021-03-01', 'Dachshund', 'Cão', 'Feminino'),
('AN-028', 28, 'Buddy', '2018-04-14', 'Lhasa Apso', 'Cão', 'Masculino'),
('AN-029', 29, 'Daisy', '2020-06-18', 'Bichon Frisé', 'Cão', 'Feminino'),
('AN-030', 30, 'Teddy', '2017-07-23', 'Pomeranian', 'Cão', 'Masculino'),
('AN-031', 31, 'Bailey', '2019-09-28', 'Border Collie', 'Cão', 'Masculino'),
('AN-032', 32, 'Ginger', '2018-01-03', 'Poodle Miniatura', 'Cão', 'Feminino'),
('AN-033', 33, 'Bentley', '2020-05-08', 'Buldogue Americano', 'Cão', 'Masculino'),
('AN-034', 34, 'Zara', '2017-08-15', 'Bengal', 'Gato', 'Feminino'),
('AN-035', 35, 'Charlie', '2016-11-27', 'Labradoodle', 'Cão', 'Masculino'),
('AN-036', 36, 'Ruby', '2018-03-12', 'Maltês', 'Cão', 'Feminino'),
('AN-037', 37, 'Harley', '2020-07-30', 'Terrier', 'Cão', 'Masculino'),
('AN-038', 38, 'Ella', '2019-01-17', 'Buldogue Francês', 'Cão', 'Feminino'),
('AN-039', 39, 'Jake', '2017-02-20', 'Dogue Alemão', 'Cão', 'Masculino'),
('AN-040', 40, 'Sophie', '2021-04-05', 'Husky', 'Cão', 'Feminino'),
('AN-041', 41, 'Jasper', '2020-09-10', 'Dálmata', 'Cão', 'Masculino'),
('AN-042', 42, 'Coco', '2018-12-14', 'Pastor Australiano', 'Cão', 'Feminino'),
('AN-043', 43, 'Bear', '2019-03-29', 'Bulldog Americano', 'Cão', 'Masculino'),
('AN-044', 44, 'Lulu', '2017-06-01', 'Schnauzer', 'Cão', 'Feminino'),
('AN-045', 45, 'Riley', '2016-08-03', 'Pit Bull', 'Cão', 'Masculino'),
('AN-046', 46, 'Molly', '2018-10-20', 'Chow Chow', 'Cão', 'Feminino'),
('AN-047', 47, 'Otis', '2019-12-25', 'Shar Pei', 'Cão', 'Masculino'),
('AN-048', 48, 'Pepper', '2020-02-14', 'Whippet', 'Cão', 'Feminino'),
('AN-049', 49, 'Sparky', '2017-09-12', 'Galgo', 'Cão', 'Masculino');
INSERT INTO Animal (registro, idPessoa, nome, dataNasc, raca, especie, sexo) VALUES
('AN-050', 49, 'Juju', '2020-01-01', 'Labrador', 'Cão', 'Masculino');

-- Inserção na tabela Consulta (50 registros)
INSERT INTO Consulta (dataConsulta, idAnimal, idPessoa, dataLimiteRetorno, dataRealRetorno) VALUES
('2024-01-01', 1, 1, '2024-01-15', NULL),
('2024-01-05', 2, 2, '2024-01-20', NULL),
('2024-01-10', 3, 3, '2024-01-25', NULL),
('2024-01-15', 4, 4, '2024-01-30', NULL),
('2024-01-20', 5, 5, '2024-02-05', NULL),
('2024-01-25', 6, 6, '2024-02-10', NULL),
('2024-01-30', 7, 7, '2024-02-15', NULL),
('2024-02-01', 8, 8, '2024-02-20', NULL),
('2024-02-05', 9, 9, '2024-02-25', NULL),
('2024-02-10', 10, 10, '2024-03-01', NULL),
('2024-02-15', 11, 11, '2024-03-05', NULL),
('2024-02-20', 12, 12, '2024-03-10', NULL),
('2024-02-25', 13, 13, '2024-03-15', NULL),
('2024-03-01', 14, 14, '2024-03-20', NULL),
('2024-03-05', 15, 15, '2024-03-25', NULL),
('2024-03-10', 16, 16, '2024-04-01', NULL),
('2024-03-15', 17, 17, '2024-04-05', NULL),
('2024-03-20', 18, 18, '2024-04-10', NULL),
('2024-03-25', 19, 19, '2024-04-15', NULL),
('2024-04-01', 20, 20, '2024-04-20', NULL),
('2024-04-05', 21, 21, '2024-04-25', NULL),
('2024-04-10', 22, 22, '2024-05-01', NULL),
('2024-04-15', 23, 23, '2024-05-05', NULL),
('2024-04-20', 24, 24, '2024-05-10', NULL),
('2024-04-25', 25, 25, '2024-05-15', NULL),
('2024-05-01', 26, 26, '2024-05-20', NULL),
('2024-05-05', 27, 27, '2024-05-25', NULL),
('2024-05-10', 28, 28, '2024-06-01', NULL),
('2024-05-15', 29, 29, '2024-06-05', NULL),
('2024-05-20', 30, 30, '2024-06-10', NULL),
('2024-05-25', 31, 31, '2024-06-15', NULL),
('2024-06-01', 32, 32, '2024-06-20', NULL),
('2024-06-05', 33, 33, '2024-06-25', NULL),
('2024-06-10', 34, 34, '2024-07-01', NULL),
('2024-06-15', 35, 35, '2024-07-05', NULL),
('2024-06-20', 36, 36, '2024-07-10', NULL),
('2024-06-25', 37, 37, '2024-07-15', NULL),
('2024-07-01', 38, 38, '2024-07-20', NULL),
('2024-07-05', 39, 39, '2024-07-25', NULL),
('2024-07-10', 40, 40, '2024-08-01', NULL),
('2024-07-15', 41, 41, '2024-08-05', NULL),
('2024-07-20', 42, 42, '2024-08-10', NULL),
('2024-07-25', 43, 43, '2024-08-15', NULL),
('2024-08-01', 44, 44, '2024-08-20', NULL),
('2024-08-05', 45, 45, '2024-08-25', NULL),
('2024-08-10', 46, 46, '2024-09-01', NULL),
('2024-08-15', 47, 47, '2024-09-05', NULL),
('2024-08-20', 48, 48, '2024-09-10', NULL),
('2024-08-25', 49, 49, '2024-09-15', NULL);

-- Inserção na tabela Medicamento (50 registros)
INSERT INTO Medicamento (registro, descricao) VALUES
('MED-001', 'Antibiótico para infecção respiratória'),
('MED-002', 'Anti-inflamatório para dor muscular'),
('MED-003', 'Vacina polivalente para cães'),
('MED-004', 'Vermífugo para gatos'),
('MED-005', 'Suplemento vitamínico para animais idosos'),
('MED-006', 'Antipulgas de uso tópico'),
('MED-007', 'Analgésico para dores agudas'),
('MED-008', 'Pomada cicatrizante para feridas'),
('MED-009', 'Colírio para infecção ocular'),
('MED-010', 'Xarope expectorante para tosse'),
('MED-011', 'Vacina antirrábica'),
('MED-012', 'Remédio para controle de diabetes em cães'),
('MED-013', 'Antibiótico de amplo espectro'),
('MED-014', 'Antialérgico para tratamento de dermatite'),
('MED-015', 'Antifúngico para infecções de pele'),
('MED-016', 'Suplemento para fortalecimento ósseo'),
('MED-017', 'Antiparasitário de uso oral'),
('MED-018', 'Laxante para constipação em gatos'),
('MED-019', 'Pomada para tratamento de queimaduras'),
('MED-020', 'Spray cicatrizante para pequenos cortes'),
('MED-021', 'Comprimido para controle de convulsões'),
('MED-022', 'Vacina contra leptospirose'),
('MED-023', 'Suplemento alimentar para animais convalescentes'),
('MED-024', 'Antidepressivo para animais com ansiedade'),
('MED-025', 'Antiparasitário de uso externo'),
('MED-026', 'Pomada para tratamento de otite'),
('MED-027', 'Comprimido para prevenção de dirofilariose'),
('MED-028', 'Antibiótico para infecções urinárias'),
('MED-029', 'Comprimido para controle de epilepsia'),
('MED-030', 'Pomada para cicatrização de úlceras'),
('MED-031', 'Antitérmico para controle de febre'),
('MED-032', 'Spray antisséptico para feridas'),
('MED-033', 'Vacina para controle de giardíase'),
('MED-034', 'Pomada oftálmica para conjuntivite'),
('MED-035', 'Comprimido para controle de hipertensão'),
('MED-036', 'Spray repelente de insetos'),
('MED-037', 'Suplemento para ganho de massa muscular'),
('MED-038', 'Antibiótico para infecções bacterianas'),
('MED-039', 'Pomada para tratamento de dermatose'),
('MED-040', 'Comprimido para tratamento de gastrite'),
('MED-041', 'Vacina contra cinomose'),
('MED-042', 'Antiinflamatório de uso veterinário'),
('MED-043', 'Pomada para tratamento de calos'),
('MED-044', 'Comprimido para tratamento de hipotireoidismo'),
('MED-045', 'Antibiótico para infecções respiratórias'),
('MED-046', 'Suplemento para fortalecimento de articulações'),
('MED-047', 'Antipulgas oral para cães'),
('MED-048', 'Pomada para tratamento de eczema'),
('MED-049', 'Comprimido para controle de dores crônicas');

-- Inserção na tabela Exame (50 registros)
INSERT INTO Exame (registro, descricao) VALUES
('EX-001', 'Hemograma completo'),
('EX-002', 'Ultrassonografia abdominal'),
('EX-003', 'Radiografia torácica'),
('EX-004', 'Teste de função renal'),
('EX-005', 'Ecocardiograma'),
('EX-006', 'Exame de fezes'),
('EX-007', 'Exame de urina'),
('EX-008', 'Tomografia computadorizada'),
('EX-009', 'Biópsia de pele'),
('EX-010', 'Teste de alergia'),
('EX-011', 'Eletrocardiograma'),
('EX-012', 'Teste de função hepática'),
('EX-013', 'Exame de glicose'),
('EX-014', 'Exame de colesterol'),
('EX-015', 'Exame de triglicerídeos'),
('EX-016', 'Exame de ureia e creatinina'),
('EX-017', 'Teste de gravidez'),
('EX-018', 'Exame citológico'),
('EX-019', 'Exame histopatológico'),
('EX-020', 'Resonância magnética'),
('EX-021', 'Exame de cortisol'),
('EX-022', 'Exame de T4 livre'),
('EX-023', 'Teste de sorologia para leishmaniose'),
('EX-024', 'Teste de sorologia para dirofilariose'),
('EX-025', 'Exame de ácido úrico'),
('EX-026', 'Teste de função adrenal'),
('EX-027', 'Teste de função tireoidiana'),
('EX-028', 'Exame de eletrolíticos'),
('EX-029', 'Exame de urina tipo I'),
('EX-030', 'Exame de creatina'),
('EX-031', 'Teste de função pancreática'),
('EX-032', 'Teste de função muscular'),
('EX-033', 'Exame de proteínas totais'),
('EX-034', 'Exame de hematócrito'),
('EX-035', 'Teste de Coombs'),
('EX-036', 'Exame de reticulócitos'),
('EX-037', 'Exame de glicose pós-prandial'),
('EX-038', 'Exame de glicose de jejum'),
('EX-039', 'Exame de hemoglobina glicosilada'),
('EX-040', 'Exame de transferrina'),
('EX-041', 'Exame de ferritina'),
('EX-042', 'Teste de função hepática'),
('EX-043', 'Teste de função renal'),
('EX-044', 'Exame de bilirrubina'),
('EX-045', 'Exame de fosfatase alcalina'),
('EX-046', 'Exame de ácido láctico'),
('EX-047', 'Exame de amilase'),
('EX-048', 'Exame de lipase'),
('EX-049', 'Exame de aldosterona'),
('EX-050', 'Teste de função adrenal');



-- Inserção na tabela Consulta_Prescreve (50 registros)
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
(25, 25, 'Aplicar 1x ao dia'),
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
(49, 49, '1 comprimido 2x ao dia');

-- Inserção na tabela Consulta_Solicita (50 registros)
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
(25, 25, 'Ácido úrico elevado'),
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
(49, 49, 'Aldosterona normal');





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

