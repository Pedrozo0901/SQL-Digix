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