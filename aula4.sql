create table genero(
	id_genero serial primary key,
	nome varchar(45)
);

create table diretor(
	id_diretor serial primary key,
	nome varchar (50)
);

create table filme(
	id_filme serial primary key,
	nome_br varchar(45),
	nome_en varchar(45),
	ano_lancamento int,
	sinopse text,
	fk_diretor int not null,
	fk_genero int not null,
	foreign key (fk_diretor) references diretor(id_diretor),
	foreign key (fk_genero) references genero(id_genero)
);


create table premiacao(
	id_premiacao serial primary key,
	nome varchar(45),
	ano int
);

create table filme_has_premiacao(
	fk_filme int not null,
	fk_premiacao int not null,
	ganhou bool,
	foreign key (fk_filme) references filme(id_filme),
	foreign key (fk_premiacao) references premiacao(id_premiacao)
);

create table sala (
	id_sala serial primary key,
	nome varchar(45),
	capacidade int
);

create table horario (
	id_horario serial primary key,
	horario TIME
);

create table filme_exibido_sala (
	fk_filme int not null,
	fk_sala int not null,
	fk_horario int not null,
	foreign key (fk_filme) references filme(id_filme),
	foreign key (fk_sala) references sala(id_sala),
	foreign key (fk_horario) references horario(id_horario)
);

create table funcao (
	id_funcao serial primary key,
	nome varchar(45)
);

create table funcionario(
	id_funcionario serial primary key,
	nome varchar(45),
	carteira_de_trabalho int,
	data_da_contratacao date,
	salario decimal(10,2)
);

create table horario_trabalho_funcionario (
	fk_horario int not null,
	fk_funcionario int not null,
	fk_funcao int not null,
	foreign key (fk_horario) references horario(id_horario),
	foreign key (fk_funcionario) references funcionario(id_funcionario),
	foreign key (fk_funcao) references funcao(id_funcao)
);

insert into diretor (nome) values ('Alfred Hitchcock
');
insert into diretor (nome) values ('Orson Welles
');
insert into diretor (nome) values ('Akira Kurosawa
');
insert into diretor (nome) values ('Stanley Kubrick
');
insert into diretor (nome) values ('Federico Fellini
');
insert into diretor (nome) values ('Ingmar Bergman
');
insert into diretor (nome) values ('François Truffaut
');
insert into diretor (nome) values ('Jean-Luc Godard
');

INSERT INTO diretor (nome) VALUES 
('Alfred Hitchcock'),
('Stanley Kubrick'),
('Martin Scorsese'),
('Steven Spielberg'),
('Quentin Tarantino'),
('Christopher Nolan'),
('Denis Villeneuve'),
('Greta Gerwig');

INSERT INTO genero (nome) VALUES 
('Terror'),
('Ficção Científica'),
('Crime'),
('Aventura'),
('Suspense'),
('Cyberpunk'),
('Comédia');

INSERT INTO filme (nome_br, nome_en, ano_lancamento, sinopse, fk_diretor, fk_genero) VALUES 
('Psicose', 'Psycho', 1960, 'Um clássico do terror psicológico que acompanha a história de Norman Bates.', 1, 1),
('2001: Uma Odisseia no Espaço', '2001: A Space Odyssey', 1968, 'Uma jornada épica pelo espaço e a evolução da humanidade.', 2, 2),
('Os Bons Companheiros', 'Goodfellas', 1990, 'A história real de um gângster que sobe na máfia e enfrenta sua queda.', 3, 3),
('Jurassic Park: O Parque dos Dinossauros', 'Jurassic Park', 1993, 'Um parque de dinossauros clonados sai do controle.', 4, 4),
('Pulp Fiction: Tempo de Violência', 'Pulp Fiction', 1994, 'Histórias interligadas de crime, violência e cultura pop.', 5, 3),
('A Origem', 'Inception', 2010, 'Um ladrão de sonhos precisa implantar uma ideia na mente de alguém.', 6, 5),
('Blade Runner 2049', 'Blade Runner 2049', 2017, 'Um novo blade runner descobre um segredo que pode mudar tudo.', 7, 6),
('Barbie', 'Barbie', 2023, 'A boneca icônica embarca em uma jornada para o mundo real.', 8, 7);


INSERT INTO premiacao (nome, ano) VALUES 
('Oscar de Melhor Filme', 1994), 
('Oscar de Melhor Filme', 2010),
('Oscar de Melhores Efeitos Visuais', 2010),
('Oscar de Melhor Direção', 1960), 
('Oscar de Melhor Filme', 1968), 
('Oscar de Melhor Direção', 1990), 
('Oscar de Melhores Efeitos Visuais', 2017), 
('Oscar de Melhor Filme', 2023),  
('Globo de Ouro de Melhor Filme', 2023); 

INSERT INTO filme_has_premiacao (fk_filme, fk_premiacao, ganhou) VALUES 
(1, 4, FALSE),  
(2, 5, FALSE),
(3, 6, FALSE), 
(5, 1, FALSE), 
(6, 2, FALSE), 
(6, 3, TRUE),   
(7, 7, TRUE),  
(8, 8, FALSE), 
(8, 9, FALSE);  

INSERT INTO sala (nome, capacidade) VALUES 
('Sala 1', 150),
('Sala 2', 200),
('Sala 3', 100),
('Sala 4', 180),
('Sala 5', 250);


INSERT INTO horario (horario) VALUES 
('14:00:00'),
('16:00:00'),
('18:00:00'),
('20:00:00'),
('22:00:00');

INSERT INTO filme_exibido_sala (fk_filme, fk_sala, fk_horario) VALUES 
(1, 1, 1),
(2, 2, 2),  
(3, 3, 3),  
(4, 4, 4),  
(5, 5, 5),  
(6, 1, 2),  
(7, 2, 3),  
(8, 3, 4);  


INSERT INTO horario (horario) VALUES 
('08:00:00'),
('10:00:00'),
('12:00:00'),
('14:00:00'),
('16:00:00'),
('18:00:00');



INSERT INTO funcao (nome) VALUES 
('Gerente'),
('Atendente'),
('Operador de Projeção'),
('Recepcionista'),
('Segurança');


INSERT INTO funcionario (nome, carteira_de_trabalho, data_da_contratacao, salario) VALUES 
('Carlos Silva', 123456789, '2022-03-01', 2500.00),
('Ana Oliveira', 987654321, '2023-01-15', 1800.00),
('José Santos', 112233445, '2021-11-30', 3500.00),
('Mariana Costa', 223344556, '2020-07-19', 2000.00),
('Lucas Pereira', 334455667, '2022-06-10', 2200.00);

INSERT INTO funcionario (nome, carteira_de_trabalho, data_da_contratacao, salario) values ('Lucas Pedroso', 876345567, '2021-07-11', 2100.00);
INSERT INTO horario_trabalho_funcionario (fk_horario, fk_funcionario, fk_funcao) VALUES 
(1, 6, null);

select * from funcionario;

INSERT INTO horario_trabalho_funcionario (fk_horario, fk_funcionario, fk_funcao) VALUES 
(1, 1, 1),  
(2, 2, 2),  
(3, 3, 3),  
(4, 4, 4),  
(5, 5, 5); 

-- 1 
select avg(salario) from funcionario;

-- 2

  -- adicionando a exceção
INSERT INTO funcionario (nome, carteira_de_trabalho, data_da_contratacao, salario) values ('Lucas Pedroso', 876345567, '2021-07-11', 2100.00);
INSERT INTO horario_trabalho_funcionario (fk_horario, fk_funcionario, fk_funcao) VALUES 
(1, 6, null);


select fcr.nome, fnc.nome 
from horario_trabalho_funcionario h
join funcionario fcr on fcr.id_funcionario = h.fk_funcionario
left join funcao fnc on fnc.id_funcao = h.fk_funcao;

-- 3 dando erro!!!!
select distinct nome, horario from horario_trabalho_funcionario h
join funcionario f on f.id_funcionario = h.fk_funcionario
join horario ho on ho.id_horario = h.fk_horario
where horario = (select ho.horario from horario_trabalho_funcionario
				 where fk_funcionario = 1);


-- 4
select filme.nome_br, s.nome from filme_exibido_sala f
join filme on filme.id_filme = f.fk_filme
join sala s on s.id_sala = fk_sala
group by s.nome, filme.nome_br
having count(*) >= 2;



-- 5
select distinct f.nome_br, g.nome from filme f
join genero g on g.id_genero = fk_genero;

-- 6

SELECT DISTINCT filme.nome_br
FROM filme
JOIN filme_has_premiacao f_p ON filme.id_filme = f_p.fk_filme
JOIN premiacao p ON f_p.fk_premiacao = p.id_premiacao
JOIN filme_exibido_sala f_s ON filme.id_filme = f_s.fk_filme
WHERE f_p.ganhou = true;

-- 7
select filme.nome_br from filme
join filme_has_premiacao f_p on filme.id_filme = f_p.fk_filme
where f_p.ganhou = true;

-- 8
select d.nome from filme
join diretor d on d.id_diretor = fk_diretor
group by d.nome
having count(*) >= 2;

-- 9
select fun.nome, ho.horario from funcionario fun
join horario_trabalho_funcionario h on fun.id_funcionario = h.fk_funcionario
join horario ho on ho.id_horario = h.fk_horario
order by ho.horario asc;


-- 10
select fil.nome_br from filme_exibido_sala f
join filme fil on fil.id_filme = f.fk_filme
join horario h on h.id_horario = f.fk_horario
join sala s on s.id_sala = f.fk_sala
where fil; 






























