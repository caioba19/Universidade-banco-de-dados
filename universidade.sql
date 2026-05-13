create database universidade;
use universidade;
create table aluno(
	cpf varchar(15) not null primary key,
    nomeAluno varchar(50) not null,
    dtNasc date not null,
    estadoCivil enum("Casado","Solteiro","Viúvo","Divorciado"),
    genero enum("Masculino","Feminino","Outros"),
    endereco varchar(100),
    numero varchar(10),
    complemento varchar(100),
    bairro varchar(50),
    cidade varchar(30),
    UF varchar(2),
    email varchar(100),
    telefone varchar(15) not null,
    whatsApp bool    
);

-- alter table curso add column modalidade enum("Presencial", "Hibrido","EAD") after cargaHoraria;

create table curso(
	codCurso int auto_increment primary key,
    nomeCurso varchar(60),
    cargaHoraria int,
    modalidade enum("Presencial", "Hibrido","EAD")
);

create table professor(
	matProf int auto_increment primary key,
    nomeProf varchar(100),
    admissao date,
    escolaridade varchar(60),
    dtNasc date not null,
    estadoCivil enum("Casado","Solteiro","Viúvo","Divorciado"),
    genero enum("Masculino","Feminino","Outros"),
    endereco varchar(100),
    numero varchar(10),
    complemento varchar(100),
    bairro varchar(50),
    cidade varchar(30),
    UF varchar(2),
    email varchar(100),
    telefone varchar(15) not null,
    whatsApp bool    
);

create table turma(
	codTurma int auto_increment primary key,
    FK_codCurso int,
    turno enum("Matutino","Vespertino","Noturno"),
    foreign key(FK_codCurso) references curso(codCurso) 
);

create table disciplina(
	codDisc int auto_increment primary key,
    NomeDisc varchar(60),
    cargaHoraria int,
    preRequisito varchar(100)
);

create table horario(
	FK_codDisc int,
    FK_codTurma int,
    FK_matProf int,
    foreign key(FK_codDisc) references disciplina(codDisc),
    foreign key(FK_codTurma) references turma(codTurma),
    foreign key(FK_matProf) references professor(matProf),
    primary key(FK_codDisc,FK_codTurma,FK_matProf)
);

create table matricula(
	RA bigint not null primary key,
    FK_cpf varchar(15) not null,
    FK_codCurso int,
    FK_codTurma int,
    foreign key(FK_cpf) references aluno(cpf),
    foreign key(FK_codCurso) references curso(codCurso),
    foreign key(FK_codTurma) references turma(codTurma)
);

create table boletim(
    RA bigint not null primary key ,
    FK_codCurso int,
    FK_codDisc int,
    av1 double,
    av2 double,
    av3 double,
    av4 double,
    sav1 double,
    sav2 double,
    sav3 double,
    foreign key(FK_codCurso) references curso(codCurso),
    foreign key(FK_codDisc) references disciplina(codDisc)
);
