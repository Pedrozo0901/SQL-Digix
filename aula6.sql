CREATE TABLE Maquina (
Id_Maquina INT PRIMARY KEY NOT NULL,
Tipo VARCHAR(255),
Velocidade INT,
HardDisk INT,
Placa_Rede INT,
Memoria_Ram INT,
Fk_Usuario INT,
FOREIGN KEY(Fk_Usuario) REFERENCES Usuarios(ID_Usuario)
);
CREATE TABLE Usuarios (
ID_Usuario INT PRIMARY KEY NOT NULL,
Password VARCHAR(255),
Nome_Usuario VARCHAR(255),
Ramal INT,
Especialidade VARCHAR(255)
);
CREATE TABLE Software (
Id_Software INT PRIMARY KEY NOT NULL,
Produto VARCHAR(255),
HardDisk INT,
Memoria_Ram INT,
Fk_Maquina INT,
FOREIGN KEY(Fk_Maquina) REFERENCES Maquina(Id_Maquina)
);
insert into Maquina values (1, 'Desktop', 2, 500, 1, 4, 1);
insert into Maquina values (2, 'Notebook', 1, 250, 1, 2, 2);
insert into Maquina values (3, 'Desktop', 3, 1000, 1, 8, 3);
insert into Maquina values (4, 'Notebook', 2, 500, 1, 4, 4);
insert into Maquina values (5, 'Desktop', 2, 0, 1, 4, 4);
insert into Maquina values (6, 'Desktop', 2, 0, 1, 4, 4);
insert into Usuarios values (1, '123', 'Joao', 123, 'TI');
insert into Usuarios values (2, '456', 'Maria', 456, 'RH');
insert into Usuarios values (3, '789', 'Jose', 789, 'Financeiro');
insert into Usuarios values (4, '101', 'Ana', 101, 'TI');
insert into Software values (1, 'Windows', 100, 2, 1);
insert into Software values (2, 'Linux', 50, 1, 2);
insert into Software values (3, 'Windows', 200, 4, 3);
insert into Software values (4, 'Linux', 100, 2, 4);
insert into Software values (3, 'Windows', 200, 4, 3);
insert into Software values (5, 'Linux', 20, 2, 5);
insert into Software values (6, 'Linux', 20, 2, 6);

-- 1
create or replace function espaco_disponivel(v_idMaquina integer) returns bool as $$
declare memoria integer;
begin
	select HardDisk into memoria from Maquina where Id_Maquina = v_idMaquina;
	if memoria > 0 then
		return true;
	elsif not found id then
		raise exception 'ERRO: Máquina não encontrada!';
	end if;
end;
$$ language plpgsql;	
		
select espaco_disponivel(2);

-- 2
create or replace procedure instalar_software(v_idMaquina integer) as $$
declare memoria integer;
begin
	select HardDisk into memoria from Maquina where Id_Maquina = v_idMaquina;
	if memoria > 0 then
		raise notice 'Há espaço para instalar um software';
	else 
		raise exception 'Não há espaço para instalar um novo software';
	end if;
end;
$$ language plpgsql;

call instalar_software(6);


-- 3
create or replace function maquinas_do_usuario(v_id_user integer) returns setof integer as $$
declare v_id_maquina integer;
begin
	return query
	select Id_Maquina from maquina where Fk_Usuario = v_id_user;
	raise notice 'Id da máquina: %', v_id_maquina;
end;
$$ language plpgsql;

DROP FUNCTION maquinas_do_usuario(integer);

select maquinas_do_usuario(4);

-- 4
create or replace procedure atualizar_recursos_maquina(v_id_maquina integer, new_HardDisk integer) as $$
begin
	update maquina
	set HardDisk = new_HardDisk
	where Id_Maquina = v_id_maquina;
	if not found Id_Maquina then
		raise exception 'Máquina não encontrada';
	end if;
end;
$$ language plpgsql;

call atualizar_recursos_maquina(16, 700);

-- 5
create or replace procedure transferir_software(v_idMaquinaOrigem integer, v_idMaquinaDestino integer) as $$
begin
	if (select HardDisk from software
		where Id_Software = v_idMaquinaOrigem) >
		(select HardDisk from maquina
		where Id_Maquina = v_idMaquinaDestino) then 
			raise exception 'Espaço insuficiente';
	end if;
	update Software s1
	set Fk_Maquina = (select s2.Fk_Maquina from software s2
					  where s2.Id_Software = v_idMaquinaOrigem)
	where Id_Software = v_idMaquinaDestino ;
	raise notice 'Transfência bem sucessedida!';
end;
$$ language plpgsql;
	
select * from software;
call transferir_software(3,5);


-- 6
create or replace function media_recursos() returns table(media_ram float, media_hardisk float) as $$
begin
 	return query
	select avg(Memoria_Ram)::float as media_ram, avg(HardDisk)::float as media_hardisk
	from Maquina;
end;
$$ language plpgsql;

select * from media_recursos();


-- 7 
create or replace procedure diagnostico_maquina()