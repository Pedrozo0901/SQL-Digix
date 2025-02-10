create table pessoa (
	id_pessoa serial primary key,
	nome varchar(100),
	cpf varchar(11)
);

create table engenheiro (
	id_engenheiro serial primary key,
	crea varchar(10),
	fk_pessoa int not null,
	foreign key (fk_pessoa) references pessoa(id_pessoa)
);

create table edificacao (
	id_edificacao serial primary key,
	metragem_total double precision,
	endereco varchar(100)
);

create table unidade_residencial (
	id_unidade serial primary key,
	metragem_unidade double precision,
	num_quartos int,
	num_banheiros int,
	fk_pessoa int not null,
	foreign key (fk_pessoa) references pessoa(id_pessoa),
	fk_eficacao int not null,
	foreign key (fk_eficacao) references edificacao(id_edificacao)
);

create table edificacao_engenheiro (
	fk_engenheiro int not null,
	fk_eficacao int not null,
	foreign key (fk_engenheiro) references engenheiro(id_engenheiro),
	foreign key (fk_eficacao) references edificacao(id_edificacao)
);



create table casa (
	id_casa serial primary key,
	num_andares int,
	fk_eficacao int not null,
	foreign key (fk_eficacao) references edificacao(id_edificacao)
);

create table predio (
	id_predio serial primary key,
	nome varchar(100),
	num_andares int,
	ap_por_andar int,
	fk_eficacao int not null,
	foreign key (fk_eficacao) references edificacao(id_edificacao)
);


-- Inserindo pessoas
INSERT INTO pessoa (nome, cpf) VALUES
('Carlos Andrade', '12345678901'),
('Mariana Silva', '23456789012'),
('Roberto Lima', '34567890123'),
('Fernanda Costa', '45678901234'),
('Eduardo Santos', '56789012345');

-- Inserindo engenheiros (associados às pessoas)
INSERT INTO engenheiro (crea, fk_pessoa) VALUES
('CREA12345', 1),
('CREA23456', 2);

-- Inserindo edificações
INSERT INTO edificacao (metragem_total, endereco) VALUES
(500.5, 'Rua A, 100'),
(750.3, 'Rua B, 200'),
(1200.8, 'Rua C, 300'),
(680.2, 'Rua D, 400'),
(950.7, 'Rua E, 500');

-- Inserindo unidades residenciais (associadas a pessoas e edificações)
INSERT INTO unidade_residencial (metragem_unidade, num_quartos, num_banheiros, fk_pessoa, fk_eficacao) VALUES
(80.2, 2, 1, 1, 1),
(100.5, 3, 2, 2, 2),
(65.3, 1, 1, 3, 3),
(120.8, 4, 3, 4, 4),
(90.4, 3, 2, 5, 5);

-- Associando engenheiros às edificações
INSERT INTO edificacao_engenheiro (fk_engenheiro, fk_eficacao) VALUES
(1, 1),
(2, 2),
(1, 3),
(2, 4),
(1, 5);

-- Inserindo casas (cada uma ligada a uma edificação)
INSERT INTO casa (num_andares, fk_eficacao) VALUES
(1, 1),
(2, 2),
(1, 3),
(3, 4),
(2, 5);

-- Inserindo prédios (cada um ligado a uma edificação)
INSERT INTO predio (nome, num_andares, ap_por_andar, fk_eficacao) VALUES
('Residencial Aurora', 10, 4, 1),
('Edifício Solar', 15, 6, 2),
('Torre Azul', 20, 8, 3),
('Palazzo Verde', 12, 5, 4),
('Skyline Tower', 25, 10, 5);



-- 1. Listar todas as unidades residenciais com
-- seus proprietários e endereços

select u.id_unidade, p.nome,e.endereco from unidade_residencial u
join pessoa p on p.id_pessoa = u.fk_pessoa
join edificacao e on e.id_edificacao = u.fk_eficacao;



-- 2. Listar todas as unidades residenciais com
-- seus proprietários e endereços, ordenados por metragem da unidade

select u.id_unidade, p.nome,e.endereco, e.metragem_total from unidade_residencial u
join pessoa p on p.id_pessoa = u.fk_pessoa
join edificacao e on e.id_edificacao = u.fk_eficacao
order by e.metragem_total desc;



