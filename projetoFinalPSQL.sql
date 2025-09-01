--create schema odonto

-- Criando tabela paciente
create table odonto.paciente(
	idpaciente serial primary key,
	nome_completo varchar(100) not null,
	cpf varchar(20) unique not null,
	data_nascimento date not null,
	telefone varchar(15),
	email varchar(20),
	endereco varchar(150)
);

--Criando tabela dentista
create table odonto.dentista(
	iddentista serial primary key,
	nome varchar(100) not null,
	especialidade varchar(100) not null,
	cpf varchar(20) unique not null,
	cro varchar(10) unique not null
);

create table if not exists odonto.horario (
    idhorario serial primary key,
    iddentista int references odonto.dentista (iddentista),
    horario_atendimento time not null,
    dia_semana varchar(20)
);

--Criando tabela de procedimento
create table odonto.procedimento(
	idprocedimento serial primary key,
	nm_procedimento varchar(100),
	descricao varchar,
	duracao_md time not null
);

-- Criando tabela de consulta e status
create type odonto.status_consulta as ENUM('ativo', 'desativado');
create table odonto.consulta(
	idconsulta serial primary key,
	id_paciente int references odonto.paciente(idpaciente) on delete cascade,
	id_dentista int references odonto.dentista(iddentista) on delete cascade,
	prescricao text,
	data_hora timestamp,
	descricao_atend varchar(100),
	status odonto.status_consulta not null default 'ativo'
);

--Criando tabela relacionada de consulta_proced
create table odonto.consulta_proced (
	idconsulta int references odonto.consulta(idconsulta)on delete cascade,
	idprocedimento int references odonto.procedimento(idprocedimento)on delete cascade,
	primary key (idconsulta, idprocedimento),
	observacao text
);

----------------------------inserçao--------------------------------

-- Inserindo informações na tabela dentista
insert into odonto.dentista (nome, cpf,cro,especialidade) values
	('Dr Marcela Amaral','25636522823','CRO1258', 'Odontopediatria'),
    ('Dr Julia Barros','66536562885','CRO5689', 'Endodontia' ),
    ('Dr Rodrigo Santos','65312398821','CRO5896', 'Ortodontia'),
    ('Dr Cirilo Braga','16563512846','CRO56958', 'Implantodontia'),
    ('Dr Felipe Nascimento','16511165523','CRO5622', 'Cirurgia e Traumatologia Buco-Maxilo_faciais'),
    ('Dr Olga Rodrigues','12736525807','CRO3636', 'Periodontia' ),
    ('Dr Fernanda Paiva','16588965873','CRO1524', 'Odontogeriatria'),
    ('Dr Vitor Santos','56236512823','CRO2565', 'Protese Dentária'),
    ('Dr Juliana Santos','12326565423','CRO5522', 'Radiologia Odontológica'),
    ('Dr Hilda Hull','23622569814','CRO1165', 'Dentística');

-- Inserindo informações na tabela de horario de atendimento do dentista
insert into odonto.horario (iddentista, horario_atendimento, dia_semana) values
	(4, '11:00:00', 'Quarta-feira'),
	(10, '09:00:00', 'Quinta-feira'),
	(6, '13:00:00', 'Quarta-feira'),
	(3, '08:00:00', 'Sábado'),
	(8, '16:00:00', 'Quarta-feira'),
	(2, '09:00:00', 'Terça-feira'),
	(1, '14:00:00', 'Quinta-feira'),
	(5, '09:00:00', 'Sexta-feira'),
	(7, '14:00:00', 'Sexta-feira'),
	(6, '09:00:00', 'Sábado');

-- Inserindo informações na tabela procedimento
insert into odonto.procedimento(nm_procedimento, descricao, duracao_md) values
    ('Limpeza Dental', 'Remoção de placa e tártaro dos dentes', '00:30:00'),
    ('Tratamento de Canal', 'Remoção da polpa infectada e selamento do canal', '00:50:00'),
    ('Extração Dentária', 'Remoção de dentes comprometidos', '00:40:00'),
    ('Aplicação de Flúor', 'Proteção dos dentes com flúor', '00:15:00'),
    ('Restauração', 'Reparo de dentes com cárie', '00:40:00'),
    ('Clareamento Dental', 'Clareamento estético dos dentes', '00:50:00'),
    ('Ortodontia - Aparelho', 'Colocação ou ajuste de aparelho ortodôntico', '00:50:00'),
    ('Implante Dentário', 'Colocação de implante para substituição de dente perdido', '00:30:00'),
    ('Profilaxia Infantil', 'Procedimentos preventivos para crianças', '00:20:00'),
    ('Periodontia', 'Tratamento de gengivas inflamadas ou doentes', '00:45:00');

-- Inserindo informações na tabela paciente
insert into odonto.paciente (nome_completo, cpf,email, data_nascimento, telefone, endereco)  values
	('Hugo Carvalho', '11111111111', 'hugo@gmail.com', '11-05-1994', '11111-1111', 'Rua A, 1'),
    ('Thais Nubia', '22222222222', 'thais@gmail.com', '02-03-1994', '22222-2222', 'Rua b, 2'), 
    ('Nelio Ramos', '33333333333', 'nelio@gmail.com', '01-02-1999', '33333-3333', 'Rua c, 3'), 
    ('Alex José', '44444444444', 'alex@gmail.com', '04-04-1999', '44444-4444', 'Rua d, 5'), 
    ('Nicolle Parisi', '55555555555', 'nicolle@gmail.com', '05-05-1995', '55555-5555', 'Rua e, 6'), 
    ('Gabriel Marochi', '66666666666', 'gabriel@gmail.com', '06-06-1998', '66666-6666', 'Rua f, 7'), 
    ('Pedro Henrique', '77777777777', 'pedro@gmail.com', '07-07-2000', '77777-7777', 'Rua g, 9'), 
    ('José Silva', '88888888888', 'jose@gmail.com', '08-08-1998', '88888-8888', 'Rua h, 8'), 
    ('Maria Santos', '12345678900', 'maria@gmail.com', '09-09-2001', '99999-9999', 'Rua i, 9'), 
    ('Ana Oliveira', '12112313100', 'ana@gmail.com', '10-01-2003', '12345-6789', 'Rua j, 10');

-- Inserindo informações na tabela consulta
insert into odonto.consulta (id_paciente, id_dentista, data_hora, descricao_atend, prescricao, status) values
	(5, 6, '2025-08-30 / 09:00:00' ,'Limpeza Dental', 'Uso de enxaguante bucal por 7 dias', 'ativo'),
    (2, 7, '2025-08-29 / 14:00:00' ,'Avaliação Inicial', 'Exame clínico', 'ativo'),
    (9, 5, '2025-08-29 / 09:00:00' ,'Extração do dente 18', 'Analgésico por 3 dias', 'ativo'),
    (4, 1, '2025-08-28 / 14:00:00' ,'Aplicação de Flúor', NULL, 'ativo'),
    (1, 2, '2025-08-26 / 09:00:00' ,'Tratamento de canal iniciado', 'Antibiótico por 5 dias', 'ativo'),
    (6, 8, '2025-08-27 / 16:00:00' ,'Ajuste de prótese dentária', NULL, 'ativo'), 
    (10, 3,'2025-08-23 / 08:00:00' , 'Consulta para avaliação ortodôntica', 'Solicitou radiografia panorâmica', 'ativo'),
    (8, 6, '2025-08-20 / 13:00:00' ,'Limpeza e raspagem periodontal', 'Clorexidina 0.12% por 10 dias', 'ativo'),
    (3, 10, '2025-08-21 / 09:00:00' , 'Clareamento dental', 'Evitar alimentos pigmentados por 3 dias', 'ativo'),
    (7, 4, '2025-08-20 / 11:00:00' ,'Consulta de rotina', NULL, 'ativo');
	
-- Inserindo informações na tabela relacionda consulta_proced
insert into odonto.consulta_proced (idconsulta, idprocedimento, observacao) values
	(1,1, ''), (2,5,''), (3,3,''), (4,4,''), (5,2,''), (6,2,''), (7,8,''), (8,10,''), (9,6,''), (10,5,'');

------------------------------------------indice---------------------------

create index idx_nome_dentista on odonto.dentista(nome);
create index idx_status on odonto.consulta(status);
select * from odonto.consulta where status = 'ativo';

------------------------------------sql------------------------------------
-- SQL de 3 atualizações de registros com condições em alguma tabela.
update odonto.paciente set telefone = '021940028922' where idpaciente = 1;
update odonto.consulta set status = 'desativado' where idconsulta = 4;
update odonto.dentista set cro = 'CRO-021931' where iddentista = 6;

-- Verificando se o telefone do paciente 1, foi alterado
select idpaciente, telefone 
from odonto.paciente 
where idpaciente = 1;

-- Verificando se o status da consulta 4 foi alterado
select idconsulta, status 
from odonto.consulta 
where idconsulta = 4;

-- Verificando se o CRO do dentista 6, foi alterado
select iddentista, cro
from odonto.dentista
where iddentista = 6;

-- SQL de 3 exclusão de registros com condições em alguma tabela.
delete from odonto.paciente where idpaciente = 7;
delete from odonto.paciente where idpaciente = 2;
delete from odonto.paciente where idpaciente = 1;

-- Se os deletes funcionarem, essas consultas devem retornar 0 linhas
SELECT * FROM odonto.paciente WHERE idpaciente = 7;
SELECT * FROM odonto.paciente WHERE idpaciente = 2;
SELECT * FROM odonto.paciente WHERE idpaciente = 1;

-- Verificando se os ID's aparecem na tabela após o delete
select * from odonto.consulta

------------------------------------consulta-------------------------------

-- 1 - Quantidade de consultas por especialidade: selecione todas as especialidades
-- dos dentistas e faça um COUNT para contar o número total de consultas realizadas por
-- cada especialidade.

SELECT
    d.especialidade as especialidade,
    count(c.idconsulta) as qtd_consultas
FROM odonto.consulta c
left join odonto.dentista d on c.id_dentista = d.iddentista
GROUP BY especialidade;

-- 2a - Quantidade de consultas realizadas por cada dentista: selecione o nome de todos
-- os dentistas e faça um COUNT para contar a quantidade de consultas realizadas por
-- cada um e exiba em ordem decrescente pela quantidade de consultas.

select d.nome, count(c.idconsulta) as total_consultas
from odonto.dentista d
left join odonto.consulta c on d.iddentista = c.id_dentista
group by d.nome
order by total_consultas desc;
	

-- 3 - Pacientes com maior número de consultas: liste os pacientes e a quantidade de
-- consultas que cada um realizou, ordenando em ordem decrescente pelo número de
-- consultas.

SELECT 
    p.nome_completo as nome,
    count(c.id_paciente) as qtd_consultas
FROM odonto.paciente p
JOIN odonto.consulta c on 
    p.idpaciente = c.id_paciente
GROUP BY nome
ORDER BY qtd_consultas DESC;

-- 4a - View com lista de consultas ordenadas por data: crie uma VIEW que selecione os
-- seguintes campos: id_consulta, nome_paciente, nome_dentista, data_consulta,
-- procedimentos_realizados e ordene em ordem decrescente pela data da consulta.

CREATE VIEW odonto.view_dados_consulta AS
SELECT 
    c.idconsulta as id_consulta,
    p.nome_completo as nome_paciente,
    d.nome as nome_dentista,
    c.data_hora as data_consulta,
    pr.nm_procedimento as procedimentos_realizados
FROM odonto.consulta c
LEFT JOIN odonto.paciente p ON c.id_paciente = p.idpaciente
LEFT JOIN odonto.dentista d ON c.id_dentista = d.iddentista
LEFT JOIN odonto.consulta_proced cp ON c.idconsulta = cp.idconsulta
LEFT JOIN odonto.procedimento pr ON cp.idprocedimento = pr.idprocedimento
ORDER BY data_consulta DESC;

-- 5a - Média de consultas por dentista: calcule a média de consultas realizadas por
-- dentista.

select avg(total_consultas) as media_consultas
from (
    select d.nome, count(c.idconsulta) as total_consultas
    from odonto.dentista d
    left join odonto.consulta c on d.iddentista = c.id_dentista
    group by d.nome
) as consultas;