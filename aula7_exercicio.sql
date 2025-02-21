-- 1
create table log_maquina (
	id serial primary key,
	maquina_id integer,
	acao varchar(20),
	data timestamp default current_timestamp
);


create or replace function log_partida_delete()
returns trigger as $$
begin
	delete from software where Fk_Maquina = old.Id_Maquina;
	insert into log_maquina(maquina_id, acao) values (old.Id_Maquina, 'DELETE');
	return old;
end;
$$ language plpgsql;

create or replace trigger log_partida_delete
before delete on Maquina
for each row
execute function log_partida_delete();
	
delete from maquina where Id_Maquina = 1;

select * from log_maquina;



-- 2
create or replace function trigger_senha_forte()
returns trigger as $$
begin
	if char_length(new.Password) < 6 then
		raise exception 'ERRO: A senha deve ter pelo menos 6 dígitos';
	end if;
	return new;
end;
$$ language plpgsql;

create or replace trigger trigger_senha_forte
before insert on Usuarios
for each row
execute function trigger_senha_forte();

insert into Usuarios values (5, '456', 'Felipe', 111, 'TI');