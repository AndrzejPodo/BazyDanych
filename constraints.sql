alter table Ceny
	add constraint Ceny_Dni_konferencji_id_fk
		foreign key (id_konferencji) references Dni_konferencji
go

alter table Dni_konferencji
	add constraint Dni_konferencji_Konferencje_id_fk
		foreign key (id_konferencji) references Konferencje
go

alter table Rezerwacje_konferencji
	add constraint Rezerwacje_konferencji_Konferencje_id_fk
		foreign key (id_konferencji) references Konferencje
go

alter table Rezerwacje_konferencji
    add constraint Rezerwacje_konferencji_Klienci_id_fk
        foreign key (id_klienta) references Klienci
go

alter table Klienci
	add constraint Klienci_Firmy_id_fk
		foreign key (id_firmy) references Firmy
go

alter table Klienci
	add constraint Klienci_Osoby_id_fk
		foreign key (id_osoby) references Osoby
go

alter table Zapisy_dnia
	add constraint Zapisy_dnia_Rezerwacje_dnia_id_fk
		foreign key (id_rezerwacji_dnia) references Rezerwacje_dnia
go

alter table Zapisy_dnia
	add constraint Zapisy_dnia_Osoby_id_fk
		foreign key (id_osoby) references Osoby
go

alter table Warsztaty
	add constraint Warsztaty_Dni_konferencji_id_fk
		foreign key (id_dnia) references Dni_konferencji
go

alter table Rezerwacje_warsztatu
	add constraint Rezerwacje_warsztatu_Rezerwacje_dnia_id_fk
		foreign key (id_rezerwacji_dnia) references Rezerwacje_dnia
go


alter table Rezerwacje_warsztatu
	add constraint Rezerwacje_warsztatu_Warsztaty_id_fk
		foreign key (id_warsztatu) references Warsztaty
go

alter table Rezerwacje_dnia
	add constraint Rezerwacje_dnia_Rezerwacje_konferencji_id_fk
		foreign key (id_rezerwacji_konferencji) references Rezerwacje_konferencji
go

alter table Rezerwacje_dnia
	add constraint Rezerwacje_dnia_Dni_konferencji_id_fk
		foreign key (id_dnia) references Dni_konferencji
go

alter table Zapisy_warsztatu
	add constraint Zapisy_warsztatu_Rezerwacje_warsztatu_id_fk
		foreign key (id_rezerwacji_warsztatu) references Rezerwacje_warsztatu
go

alter table Zapisy_warsztatu
	add constraint Zapisy_warsztatu_Zapisy_dnia_id_fk
		foreign key (id_zapisu_dnia) references Zapisy_dnia
go

alter table Platnosci
	add constraint Platnosci_Rezerwacje_konferencji_id_fk
		foreign key (id_rezerwacji) references Rezerwacje_konferencji
go

