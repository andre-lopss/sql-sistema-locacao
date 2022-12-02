use turma11;

create schema locacao;

create table locacao.classificacao(
	cd_classificacao int primary key identity(1,1),
	vl_locacao_diaria money not null,
	nm_classificacao varchar(50) not null
);

create table locacao.categoria(
	sg_categoria char(1) primary key,
	nm_categoria varchar(30) not null
);

create table locacao.filme(
	cd_filme int primary key identity(1,1),
	nm_filme varchar(50) not null,
	sg_categoria char(1),
	cd_classificacao int,
	foreign key(sg_categoria) references locacao.categoria(sg_categoria)
	on delete set null
	on update cascade,
	foreign key(cd_classificacao) references locacao.classificacao(cd_classificacao)
	on delete set null
	on update cascade
);  

create table locacao.cliente(
	cd_cliente int primary key identity(1,1),
	nm_cliente varchar(50) not null
);

create table locacao.solicitacao(
	cd_solicitacao int primary key identity(1,1),
	cd_cliente int not null,
	dt_solicitacao date not null,
	foreign key(cd_cliente) references locacao.cliente(cd_cliente)
	on delete cascade
	on update cascade
);

create table locacao.solicitacao_filme(
	cd_filme int not null,
	cd_solicitacao int not null,
	dt_devolucao_prevista date not null,
	dt_devolucao_real date,
	primary key(cd_filme, cd_solicitacao),
	foreign key(cd_filme) references locacao.filme(cd_filme)
	on delete cascade
	on update cascade,
	foreign key(cd_solicitacao) references locacao.solicitacao(cd_solicitacao)
	on delete cascade
	on update cascade
);

begin transaction;
insert into locacao.cliente(nm_cliente)
values  ('André Lopes'), 
		('Matheus Lopes'),
		('Maria Lopes'),
		('Raphael Lopes'),
		('João Lopes');
commit;
select * from locacao.cliente;

begin transaction;
insert into locacao.classificacao(vl_locacao_diaria, nm_classificacao )
values  (2.55,'Livre'), 
		(3.50,'Não recomendado para menores de 12'),
		(4.55, 'Não recomendado para menores de 16')
commit;
select * from locacao.classificacao;

begin transaction;
insert into locacao.categoria(sg_categoria, nm_categoria)
values  ('D', 'Drama'), 
		('T', 'Terror'), 
		('S', 'Suspense'), 
		('C', 'Comédia'), 
		('R', 'Romântico'),
		('F', 'Ficção');
commit;
select * from locacao.categoria;

begin transaction;
insert into locacao.filme(nm_filme, sg_categoria )
values  ('Chegada', 'F'), 
		('Saida', 'D'),
		('Entrada', 'C'),
		('Os tres porquinhos', 'T'),
		('Branca de Neve', 'R');
commit;
select * from locacao.filme;

begin transaction;
insert into locacao.solicitacao(cd_cliente, dt_solicitacao)
values  
	(1, '20221202'),
	(1, '20221102'),
	(2, '20221202'),
	(2, '20221102'),
	(3, '20221202'),
	(3, '20221102'),
	(4, '20221202'),
	(4, '20221102'),
	(5, '20221202'),
	(5, '20221102')
commit;
select * from locacao.solicitacao;

begin transaction;
insert into locacao.solicitacao_filme(cd_filme, cd_solicitacao, dt_devolucao_prevista, dt_devolucao_real)
values
	(1, 1, '20221203', '20221204'),
	(2, 1, '20221203', '20221205'),
	(3, 2, '20221103', '20221105'),
	(4, 2, '20221103', '20221104'),
	(5, 3, '20221202', '20221204'),
	(1, 3, '20221202', '20221205'),
	(2, 4, '20221103', '20221105'),
	(3, 4, '20221103', '20221104'),
	(1, 5, '20221203', '20221204'),
	(2, 5, '20221203', '20221205'),
	(3, 6, '20221103', '20221105'),
	(4, 6, '20221103', '20221104'),
	(1, 7, '20221203', '20221204'),
	(2, 7, '20221203', '20221205'),
	(3, 8, '20221103', '20221105'),
	(4, 8, '20221103', '20221104'),
	(1, 9, '20221203', '20221204'),
	(2, 9, '20221203', '20221205'),
	(3, 10, '20221103', '20221105'),
	(4, 10, '20221103', '20221104')	
commit;
select * from locacao.solicitacao_filme;