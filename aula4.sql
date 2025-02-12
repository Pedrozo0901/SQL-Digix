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

create view vpartida as
select p.id as jogo, p.time_1 as id_time_1, t1.nome as nome1,time_1_gols as gols_time1,
time_2_gols as gols_time2, t2.nome as nome2, time_2 as id_time_2
from partida p
join time t1 on t1.id = p.time_1
join time t2 on t2.id = p.time_2;



select * from vpartida
where nome1 ilike 'a%' or nome1 like 'c%' 
or nome2 like 'a%' or nome2 like 'c%';



create view resultado_partida as
select jogo, nome1, gols_time1, gols_time2, nome2, 
case 
	when gols_time1 > gols_time2 then nome1
	when gols_time2 > gols_time1 then nome2
	else 'EMPATE'
end as classificacao_vencedor
from vpartida
order by classificacao_vencedor desc;

select * from resultado_partida;




-- 4. Crie uma view vtime que retorne a tabela de time adicionando as colunas partidas, vitorias,
--  derrotas, empates e pontos.
-- Colunas esperadas:  id, nome, partidas, vitorias, derrotas, empates, pontos 
-- Ordenação:  pontos descendente
create or replace view vtime as
select t.id, t.nome
-- Partidas
(select count(time_1) from partida where time_1 = t.id) + (select count(time_2) from partida where time_2 = t.id) as partidas
-- Vitorias
(select sum(case when time_2_gols > time_1_gols then 1 else 0 end) from partida where time_2 = t.id) +
(select sum(case when time_1_gols > time_2_gols then 1 else 0 end) from partida where time_1 = t.id)
-- Empates
(select sum(case when time_2_gols = time_1_gols then 1 else 0 end) from partida where time_2 = t.id) +
(select sum(case when time_1_gols = time_2_gols then 1 else 0 end) from partida where time_1 = t.id)
-- Derrota
(select sum(case when time_2_gols < time_1_gols then 1 else 0 end) from partida where time_2 = t.id) +
(select sum(case when time_1_gols < time_2_gols then 1 else 0 end) from partida where time_1 = t.id)
-- Pontos
(select sum(case when time_2_gols > time_1_gols then 3 when time_2_gols = time_1_gols then 1 else 0 end)
from partida where time_2 = t.id) + 
(select sum(case when time_2_gols < time_1_gols then 3 when time_2_gols = time_1_gols then 1 else 0 end)
from partida where time_1 = t.id) as pontos
from time t
order by pontos desc;