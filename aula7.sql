CREATE TABLE time (
id INTEGER PRIMARY KEY,
nome VARCHAR(50)
);
CREATE TABLE partida (
id INTEGER PRIMARY KEY,
time_1 INTEGER,
time_2 INTEGER,
time_1_gols INTEGER,
time_2_gols INTEGER,
FOREIGN KEY(time_1) REFERENCES time(id),
FOREIGN KEY(time_2) REFERENCES time(id)
);
INSERT INTO time(id, nome) VALUES
(1,'CORINTHIANS'),
(2,'SÃO PAULO'),
(3,'CRUZEIRO'),
(4,'ATLETICO MINEIRO'),
(5,'PALMEIRAS');
INSERT INTO partida(id, time_1, time_2, time_1_gols, time_2_gols)
VALUES
(1,4,1,0,4),
(2,3,2,0,1),
(3,1,3,3,0),
(4,3,4,0,1),
(5,1,2,0,0),
(6,2,4,2,2),
(7,1,5,1,2),
(8,5,2,1,2);



-- As triggers são gatilhos automaticos que são executados 
-- antes ou depois de uma operação de insert, update ou dele

-- As trigger são muito utilzadas para garantir a integridade dos dados

-- Quando a trigger são necessarias?
-- 1 - Quando for necessario garantir a integridade dos dados
-- 2 - Quando for necessario garantir a consistencia dos dados
-- 3 - Para validar regras de negocio antes de inserir, atualizar ou deletar dados
-- 4 - Para automatizar tarefas que devem ser executadas

-- Para mostrar como acontece nas audiotrias vou fazer uma tabela que registra
-- os eventods das outras tabelas
create table log_partida(
	id serial primary key,
	partida_id integer,
	acao varchar(20),
	data timestamp default current_timestamp
);

-- em mysql se cria um trigger assim
create trigger log_partida_insert
after insert on partida
for each row
begin
	insert into log_partida(id, partida_id, acao) values (new.id, 'INSERT');
end;


-- no postgree a sintaxe é diferente:
create or replace function log_partida_insert()
returns trigger as $$
begin
	insert into log_partida(partida_id, acao) values (new.id, 'INSERT');
	return new;
end;
$$ language plpgsql;

create trigger log_partida_insert
after insert on partida
for each row
execute function log_partida_insert();

insert into partida(id, time_1, time_2, time_1_gols, time_2_gols) values (9,1,2,1,0);

select * from log_partida;

-- Criando trigger de restrição(mysql)
create trigger insert_partida
before insert on partida 
for each now
begin
	if new.time_1 = new.time_2 then
		signal sqlstate '45000' -- 45000 é um erro generico que pode ser usado para qualquer tipo de erro
		-- signal sqlstate é uma função que vai gerar um erro
		set message_text = 'Não é permitido jogos entre o mesmo time';
	end if;
end;


-- Criando trigger de restrição(postgree)
create function insert_partida()
returns trigger as $$
begin
	if new.time_1 = new.time_2 then
		raise exception 'Não é permitido jogos entre o mesmo time';
	end if;
	return new;
end;
$$ language plpgsql;

create trigger insert_partida
before insert on partida -- before quer dizer que acontece antes da operação nas tabelas
for each row -- para cada linha que for inserida
execute function insert_partida();

-- teste
insert into partida(id, time_1, time_2, time_1_gols, time_2_gols) values (10,1,1,1,0);

-- o instead of não é suportado pelo mysql porque ele não tem suporte para trigger de visão
-- o instead of é utilizado para fazer trigger em visões
-- no postgresql a sintaxe é a mesma
-- o istead of é utilizado para fazer trigger em visões

-- Exemplo de instead of no postgres que é unico que suporta
-- fazer uma visão
create or replace view partidas_v as
select id, time_1, time_2, time_1_gols, time_2_gols from partida;
--  agora queremos permitir inserções na partida_v, mas os dados reais devem ser armazenados na tabela partida,
-- Para isso utlizamos o instead of
create or replace function insert_partida_v()
returns trigger as $$
begin
	insert into partida(id, time_1, time_2, time_1_gols, time_2_gols)
	values (new.id, new.time_1, new.time_2, new.time_1_gols, new.time_2_gols);
	return null;
end;
$$ language plpgsql;

create trigger insert_partda_v
instead of insert on partidas_v
for each row
execute function insert_partida_v();

insert into partidas_v(id, time_1, time_2, time_1_gols, time_2_gols)
values (11,1,2,1,0);


-- update
-- Mysql
create trigger update_partida
after update on partida
for each row
begin
	insert into log_partida(partida_id, acao) values (new.id, 'UPDATE');
end;

-- postgresql

create or replace function update_partida()
returns trigger as $$
begin
	insert into log_partida(partida_id, acao) values (new.id, 'UPDATE');
	return new;
end;
$$ language plpgsql;

create trigger update_partida
after update on partida
for each row
execute function update_partida();


-- teste
update partida set time_1_gols = 2 where id = 11;
select * from log_partida;

-- Desafio

-- fazer uma trigger que impessa de fazer update em na tabela partida
create or replace function not_update_partida()
returns trigger as $$
begin
	raise exception 'ERRO: Não é permitido alterar dados na tabela de partidas.';
end;
$$ language plpgsql;

create trigger not_update_partida
before update on partida
execute function not_update_partida();

update partida
set time_1 = 3
where id = 2;



-- delete
-- postgres
create or replace function delete_partida()
returns trigger as $$
begin
	insert into log_partida(partida_id, acao) values (old.id, 'DELETE');
	return old;
	-- para impedir o delete
	-- raise exception 'Não é permitido deletar partdas';
end;
$$ language plpgsql;

create trigger delete_partida
before delete on partida
for each row
execute function delete_partida();


-- teste
delete from partida where id = 5;

select * from log_partida;