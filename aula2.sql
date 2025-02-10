create table atividade (
	id_atividade serial primary key,
	nome varchar(100)
);

create table instrutor (
	id_instrutor serial primary key,
	nome varchar(100),
	rg int,
	nascimento date,
	titulacao int
);

create table telefone_instrutor (
	id_telefone serial primary key,
	numero int,
	tipo varchar(45),
	fk_instrutor int not null,
	foreign key (fk_instrutor) references instrutor(id_instrutor)
);

create table turma (
	id_turma serial primary key,
	horario time,
	duracao int,
	data_inicio date,
	data_fim date,
	fk_atividade int not null,
	fk_instrutor int not null,
	foreign key (fk_atividade) references atividade (id_atividade),
	foreign key (fk_instrutor) references instrutor (id_instrutor)
);


create table aluno (
	cod_matricula serial primary key,
	fk_turma int not null,
	data_matricula date,
	nome varchar(45),
	endereco text,
	telefone int,
	data_nascimento date,
	altura decimal(10,2),
	peso decimal(10,2),
	foreign key (fk_turma) references turma (id_turma)
);

create table chamada (
	id_chamada serial primary key,
	data date,
	presenca bool,
	fk_aluno int null,
	foreign key (fk_aluno) references aluno (cod_matricula)
);


INSERT INTO atividade (nome) VALUES
('Natação'), ('Musculação'), ('Pilates'), ('Ioga'), ('Crossfit'),
('Boxe'), ('Judô'), ('Dança'), ('Ciclismo'), ('Corrida'),
('Basquete'), ('Futebol'), ('Vôlei'), ('Tênis'), ('Artes Marciais'),
('Escalada'), ('Parkour'), ('Ginástica'), ('Remo'), ('Skate');

INSERT INTO instrutor (nome, rg, nascimento, titulacao) VALUES
('Carlos Silva', 123456789, '1985-07-15', 5),
('Mariana Costa', 987654321, '1990-02-20', 4),
('Roberto Souza', 456789123, '1982-09-30', 6),
('Fernanda Lima', 321654987, '1995-04-12', 3),
('Eduardo Pereira', 741852963, '1980-12-05', 7),
('Patrícia Mendes', 852963741, '1988-06-22', 5),
('Lucas Rocha', 369258147, '1993-03-18', 4)
;


INSERT INTO telefone_instrutor (numero, tipo, fk_instrutor) VALUES
(11987651, 'Celular', 1),
(11976510, 'Celular', 2),
(11345690, 'Fixo', 3),
(119234789, 'Celular', 4),
(11876321, 'Celular', 5),
(11967823, 'Celular', 5),
(1136712, 'Fixo', 7);


INSERT INTO turma (horario, duracao, data_inicio, data_fim, fk_atividade, fk_instrutor) VALUES
('08:00:00', 60, '2024-01-15', '2024-06-15', 1, 1),
('09:30:00', 45, '2024-01-20', '2024-07-20', 2, 2),
('10:00:00', 90, '2024-02-10', '2024-08-10', 3, 3),
('11:30:00', 50, '2024-03-05', '2024-09-05', 4, 4),
('13:00:00', 40, '2024-04-01', '2024-10-01', 4, 5),
('14:30:00', 60, '2024-05-15', '2024-11-15', 6, 6),
('16:00:00', 75, '2024-06-01', '2024-12-01', 7, 7),
('17:30:00', 55, '2024-07-10', '2025-01-10', 8, 7),
('19:00:00', 90, '2024-08-15', '2025-02-15', 9, 3),
('20:30:00', 50, '2024-09-05', '2025-03-05', 9, 2);


INSERT INTO aluno (fk_turma, data_matricula, nome, endereco, telefone, data_nascimento, altura, peso) VALUES
(11, '2024-01-15', 'João Silva', 'Rua A, 100', 11987651, '2000-05-10', 1.75, 70.5),
(12, '2024-02-01', 'Maria Souza', 'Rua B, 200', 11976543, '1998-07-22', 1.65, 60.2),
(13, '2024-03-10', 'Carlos Lima', 'Rua C, 300', 11345678, '1995-11-05', 1.80, 75.0),
(14, '2024-03-10', 'Mario Gonçalves', 'Rua D, 300', 54345670, '1995-11-05', 1.82, 81.0),
(15, '2024-03-10', 'Joseane Lima', 'Rua E, 300', 78345670, '1995-11-05', 1.72, 74.0),
(16, '2024-03-10', 'Carlos Pedroso', 'Rua F, 300', 54345670, '1996-11-05', 1.82, 68.0),
(17, '2024-03-10', 'Pedro Pereira', 'Rua G, 300', 66345670, '1996-12-05', 1.79, 81.0),
(18, '2024-03-10', 'Jona Stones', 'Rua H, 300', 67345678, '1993-10-12', 1.78, 80.0),
(19, '2024-03-10', 'Henrrique Demetrio', 'Rua I, 300', 34709670, '1993-11-13', 1.76, 67.0),
(20, '2024-03-10', 'Carla Albuquerque', 'Rua J, 300', 43645678, '2004-01-13', 1.82, 73.0);

INSERT INTO aluno (fk_turma, data_matricula, nome, endereco, telefone, data_nascimento, altura, peso) 
VALUES(20, '2024-03-10', 'Maria Albuquerque', 'Rua J, 300', 43645678, '2004-01-13', 1.82, 73.0);

INSERT INTO aluno (fk_turma, data_matricula, nome, endereco, telefone, data_nascimento, altura, peso) 
VALUES(20, '2024-03-10', 'Gabriel Albuquerque', 'Rua J, 300', 43645678, '2004-01-13', 1.82, 73.0);


INSERT INTO chamada (data, presenca, fk_aluno) VALUES
('2024-02-01', TRUE, 42),
('2024-02-01', FALSE, 43),
('2024-02-02', TRUE, 45),
('2024-02-02', TRUE, 46),
('2024-02-03', FALSE, 47),
('2024-02-03', TRUE, 48),
('2024-02-04', TRUE, 49),
('2024-02-04', FALSE, 50),
('2024-02-05', TRUE, 51),
('2024-02-05', TRUE, 42),
('2024-02-06', FALSE, 43),
('2024-02-06', TRUE, 42),
('2024-02-07', TRUE, 43),
('2024-02-07', FALSE, 44),
('2024-02-08', TRUE, 45),
('2024-02-08', TRUE, 46),
('2024-02-09', FALSE, 47),
('2024-02-09', TRUE, 48),
('2024-02-10', TRUE, 49),
('2024-02-10', FALSE, 51),
('2024-02-01', TRUE, 50),
('2024-02-02', TRUE, 50),
('2024-02-03', TRUE, 50),
('2024-02-04', TRUE, 50),
('2024-02-05', TRUE, 50),
('2024-02-06', TRUE, 50),
('2024-02-07', TRUE, 50),
('2024-02-08', TRUE, 50),
('2024-02-08', TRUE, 50),
('2024-02-09', TRUE, 50),
('2024-02-10', TRUE, 50);


-- 3
select avg(age(data_nascimento)) from aluno
group  by fk_turma;

-- 4
select fk_turma from aluno
group by fk_turma
having count(*) >= 2;

-- 6
select max(a.nome), count(presenca) as "total de presenças" from chamada c
join aluno a on c.fk_aluno = a.cod_matricula
where presenca = true;

-- 8
select nome, count(fk_turma) from aluno
group by nome
having (count(fk_turma) > 1);

-- 10
select distinct a.nome from chamada c
join aluno a on a.cod_matricula = c.fk_aluno
where presenca not in (true);

select * from aluno;








