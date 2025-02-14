create table Empregado (
Nome varchar(50),
Endereco varchar(500),
CPF int primary key not null,
DataNasc date,
Sexo char(10),
CartTrab int,
Salario float,
NumDep int,
CPFSup int
);

alter table Empregado add foreign key (CPFSup) references Empregado(CPF);

create table Departamento (
NomeDep varchar(50),
NumDep int primary key not null,
CPFGer int,
DataInicioGer date,
foreign key (CPFGer) references Empregado(CPF)
);
create table Projeto (
NomeProj varchar(50),
NumProj int primary key not null,
Localizacao varchar(50),
NumDep int,
foreign key (NumDep) references Departamento(NumDep)
);
create table Dependente (
idDependente int primary key not null,
CPFE int,
NomeDep varchar(50),
Sexo char(10),
Parentesco varchar(50),
foreign key (CPFE) references Empregado(CPF)
);
create table Trabalha_Em (
CPF int,
NumProj int,
HorasSemana int,
foreign key (CPF) references Empregado(CPF),
foreign key (NumProj) references Projeto(NumProj)
);
-- Inserir os dados
insert into Departamento values ('Dep1', 1, null, '1990-01-01');
insert into Departamento values ('Dep2', 2, null, '1990-01-01');
insert into Departamento values ('Dep3', 3, null, '1990-01-01');
insert into Empregado values ('Joao', 'Rua 1', 123, '1990-01-01', 'M', 123, 1000, 1, null);
insert into Empregado values ('Maria', 'Rua 2', 456, '1990-01-01', 'F', 456, 2000, 2, null);
insert into Empregado values ('Jose', 'Rua 3', 789, '1990-01-01', 'M', 789, 3000, 3, null);
update Departamento set CPFGer = 123 where NumDep = 1;
update Departamento set CPFGer = 456 where NumDep = 2;
update Departamento set CPFGer = 789 where NumDep = 3;
insert into Projeto values ('Proj1', 1, 'Local1', 1);
insert into Projeto values ('Proj2', 2, 'Local2', 2);
insert into Projeto values ('Proj3', 3, 'Local3', 3);
insert into Dependente values (1, 123, 'Dep1', 'M', 'Filho');
insert into Dependente values (2, 456, 'Dep2', 'F', 'Filha');
insert into Dependente values (3, 789, 'Dep3', 'M', 'Filho');
insert into Trabalha_Em values (123, 1, 40);
insert into Trabalha_Em values (456, 2, 40);
insert into Trabalha_Em values (789, 3, 40);



-- exercicios

-- 1
create or replace function obter_salario(vCPF int) returns float as $$
declare
	v_salario float;
begin
	select Salario into v_salario from empregado where CPF = vCPF;
	raise notice 'Salario: %', v_salario;
	return v_salario;
end;
$$ language plpgsql;

select * from obter_salario(123);

-- 2
create or replace function obter_departamento(vCPF int) returns varchar as $$
declare
	v_nomeDep varchar;
begin
	select NomeDep into v_nomeDep from departamento where CPFGer = vCPF;
	return v_nomeDep;
end;
$$ language plpgsql;

select * from obter_departamento(123);


-- 3
create or replace function obter_nome_gerente(v_numDep int) returns varchar as $$
declare v_nomeGer varchar;
	begin
		select e.Nome into v_nomeGer from Empregado e 
		join Departamento d on d.NumDep = e.NumDep;
	return v_nomeGer;
end;
$$ language plpgsql;

select obter_nome_gerente(1);


-- 4
create or replace function retorna_ger_proj(v_cpf int) returns varchar as $$
declare v_nome_proj varchar;
	begin
		select p.NomeProj into v_nome_proj from Projeto p
		join Departamento d on d.NumDep = p.NumDep
		join Empregado e on d.CPFGer = e.CPF
		where e.CPF = d.CPFGer;
	return v_nome_proj;
end;
$$ language plpgsql;
		
select retorna_ger_proj(123);


-- 5
create or replace function obetr_nome_dependente(v_cpf int) returns varchar as $$
declare parentesco varchar;
	begin
		select d.Parentesco into parentesco from Dependente d
		join Empregado e on e.CPF = d.CPFE
		where CPF = v_cpf;
		return parentesco;
	end;
$$ language plpgsql;

select obetr_nome_dependente(123);