

create table Osoby
(
	id int identity
		constraint Osoby_pk
			primary key nonclustered,
	imie varchar(30) not null,
	nazwisko varchar(30) not null,
	email varchar(50)
)
create unique index Osoby_email_uindex
	on Osoby (email)
go


create table Klienci
(
	id int identity
        constraint Klienci_pk
            primary key nonclustered,
	id_osoby int,
	telefon varchar(12) not null,
	id_firmy int
)
go

create table Firmy
(
	id int identity
		constraint Firmy_pk
			primary key nonclustered,
	nazwa text not null,
	email varchar(50) not null
)
create unique index Firmy_email_uindex
	on Firmy (email)
go

create table Rezerwacje_konferencji
(
	id int identity
		constraint Rezerwacje_konferencji_pk
			primary key nonclustered,
	id_konferencji int not null,
	id_klienta int not null,
	data_rezerwacji date not null,
	anulowano bit default 0 not null
)
go

create table Platnosci
(
	id int identity
		constraint Platnosci_pk
			primary key nonclustered,
	id_rezerwacji int not null,
	dzien date not null,
	wartosc decimal(19,4) not null
)
go
alter table Platnosci add default getdate() for dzien
go


create table Rezerwacje_dnia
(
	id int identity
		constraint Rezerwacje_dnia_pk
			primary key nonclustered,
	id_dnia int not null,
	id_rezerwacji_konferencji int not null,
	miejsca int not null,
	miejsca_studentow int not null,
	anulowano bit default 0 not null
)
go

create table Zapisy_dnia
(
	id int identity
		constraint Zapisy_dnia_pk
			primary key nonclustered,
	id_rezerwacji_dnia int not null,
	id_osoby int not null,
	czy_student bit default 0 not null
)
go

create table Konferencje
(
	id int identity
		constraint Konferencje_pk
			primary key nonclustered,
	nazwa text,
	poczatek date not null,
	znizka_studencka decimal(19,4) default 0 not null
)
go

create table Dni_konferencji
(
	id int identity
		constraint Dni_konferencji_pk
			primary key nonclustered,
	id_konferencji int not null,
	dzien date not null,
	miejsca int not null
)
go

create table Ceny
(
	od_dnia date not null,
	cena decimal(19,4) not null,
	id_dnia_konferencji int not null
)
go

create table Warsztaty
(
	id int identity
		constraint Warsztaty_pk
			primary key nonclustered,
	id_dnia int not null,
	nazwa text not null,
	poczatek time not null,
	koniec time not null,
	miejsca int not null,
	cena decimal(19,4) not null
)
go

create table Rezerwacje_warsztatu
(
	id int identity
		constraint Rezerwacje_warsztatu_pk
			primary key nonclustered,
	id_rezerwacji_dnia int not null,
	id_warsztatu int not null,
	miejsca int not null,
	anulowano bit default 0 not null
)
go

create table Zapisy_warsztatu
(
	id int identity
		constraint Zapisy_warsztatu_pk
			primary key nonclustered,
	id_rezerwacji_warsztatu int not null,
	id_zapisu_dnia int not null
)
go

