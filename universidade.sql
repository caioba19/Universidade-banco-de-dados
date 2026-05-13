-- codigo 1 
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


-- codigo 2;

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

create index idx_nomeAluno
on aluno(nomeAluno);

create table curso(
	codCurso int auto_increment primary key,
    nomeCurso varchar(60) not null,
    cargaHoraria int not null,
    modalidade enum("Presencial", "Hibrido","EAD")
);

create table professor(
	matProf int auto_increment primary key,
    nomeProf varchar(100) not null,
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
    FK_codCurso int not null,
    turno enum("Matutino","Vespertino","Noturno"),
    ano int,
    semestre int,
    foreign key(FK_codCurso) references curso(codCurso) 
);

create table disciplina(
	codDisc int auto_increment primary key,
    nomeDisc varchar(60) not null,
    cargaHoraria int not null,
    FK_codCurso int not null,
    FK_preRequisito int,
    foreign key(FK_codCurso) references curso(codCurso),
    foreign key(FK_preRequisito) references disciplina(codDisc)
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
    FK_codCurso int not null,
    FK_codTurma int not null,
    dataMatricula date,
    situacao enum("Ativa","Trancada","Concluída","Cancelada"),
    foreign key(FK_cpf) references aluno(cpf),
    foreign key(FK_codCurso) references curso(codCurso),
    foreign key(FK_codTurma) references turma(codTurma)
);

create table boletim(
    RA bigint not null,
    FK_codCurso int not null,
    FK_codDisc int not null,
    av1 double,
    av2 double,
    av3 double,
    av4 double,
    sav1 double,
    sav2 double,
    sav3 double,
    frequencia double,
    
    primary key(RA, FK_codDisc),

    constraint fk_boletim_matricula
    foreign key(RA)
    references matricula(RA)
    on update cascade
    on delete cascade,

    constraint fk_boletim_curso
    foreign key(FK_codCurso)
    references curso(codCurso)
    on update cascade
    on delete restrict,

    constraint fk_boletim_disciplina
    foreign key(FK_codDisc)
    references disciplina(codDisc)
    on update cascade
    on delete restrict
);

create view vw_media_alunos as
select
    b.RA,
    d.nomeDisc,
    (
        ifnull(av1,0) +
        ifnull(av2,0) +
        ifnull(av3,0) +
        ifnull(av4,0)
    ) / 4 as mediaFinal,
    frequencia
from boletim b
join disciplina d
on b.FK_codDisc = d.codDisc;

-- codigo 3 

CREATE DATABASE UNIVERSIDADE;
USE UNIVERSIDADE;
CREATE TABLE ALUNO(
cpf VARCHAR (11) NOT NULL PRIMARY KEY,
NOMEALUNO VARCHAR (50) NOT NULL,
dtnascimneto date not null,
estadoCivil enum ("casado", "divorciado", "viuvo", "solteiro"),
genero enum ("masculino", "feminino", "outros"),
endereco varchar (100),
numero varchar (10),
complemento varchar (100) 
);
alter table CURSO add column modalidade enum ("presencial", "hibrido", "EAD");


CREATE TABLE CURSO(
CodCurso int auto_increment primary key,
nomeCurso varchar (50),
cargaHoraria int 

);

create table grade_curricular(
FK_codCurso int, 
FK_codDisc int,
semestre_ideal int,
Primary key (FK_codCurso, FK_codDisc),
foreign key (FK_codCurso) references CURSO(codCurso),
foreign key (FK_CodDisc) references disciplina(codDisc)
);

Create table oferta_disciplina (
id_oferta int, 
FK_codCurso int, 
FK_codDisc int,
ano YEAR,
Semestre_letivo int, 
foreign key (FK_codCurso) references CURSO(codCurso),
foreign key (FK_CodDisc) references disciplina(codDisc)

);

create table turma(
codTurma int auto_increment primary key,
FK_codCurso int,
turno enum ("matutino", "vespertino", "noturno"),
modalidade enum ("presencial", "hibrido", "EAD"),
foreign key (FK_codCurso) references curso(codCurso)
);

create table professor (
matprof int auto_increment primary key,
nomeprof varchar (50),
admissao date,
professorEsc varchar(50)
);

create table disciplina(
CodDisc int auto_increment primary key,
NomeDisc varchar (50),
Cargahoraria int,
preRequisito varchar (100)

);



create table horario (
FK_codTurma int,
FK_CodDisc int ,
FK_matProf int,
dia_semana  enum ('segunda' , 'terca', 'quarta' , 'quinta' , 'sexta', 'sabado'),
hora_inicio TIME,
hora_fim TIME,
ano_letivo YEAR,
semestre_letivo INT,
PRIMARY KEY (fk_codTurma, fk_codDisc, ano_letivo, semestre_letivo),
    FOREIGN KEY (fk_matProf) REFERENCES professor(matprof)
    );
    
    create table matricula(
    RA bigint not null primary key,
    FK_cpf varchar (15) not null,
    FK_codCurso int, 
    FK_codTurma int,
    FOREIGN KEY (Fk_cpf) REFERENCES aluno(cpf),
    FOREIGN KEY (FK_Codcurso) REFERENCES curso(codcurso),
    FOREIGN KEY (FK_codTurma) REFERENCES turma(codTurma)
    );
    
    Create table boletim(
    RA bigint not null primary key,
    FK_codCurso int,
    FK_codDisc int,
    av1 double, 
    av2 double,
    av3 double,
    av4 double,
    sav1 double,
    sav2 double,
    sav3 double,
  foreign key (FK_Codcurso) references curso (codCurso),
  foreign key (FK_CodDisc) references disciplina (codDisc)
    );
    
    

    
    SELECT @@autocommit;
