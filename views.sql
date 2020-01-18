create view Uczestnicy_dni_konferencji as
  select id_osoby, imie, nazwisko, czy_student, id_dnia 
  from Dni_konferencji
    inner join Rezerwacje_dnia Rd on Dni_konferencji.id = Rd.id_dnia
    inner join Zapisy_dnia Zd on Rd.id = Zd.id_rezerwacji_dnia
    inner join Osoby O on Zd.id_osoby = O.id
go

create view Uczestnicy_warsztatow as
  select id_osoby, imie, nazwisko, czy_student, id_warsztatu 
  from Warsztaty
    inner join Rezerwacje_warsztatu Rw on Warsztaty.id = Rw.id_warsztatu
    inner join Zapisy_warsztatu Zw on Rw.id = Zw.id_rezerwacji_warsztatu
    inner join Zapisy_dnia Zd on Zw.id_zapisu_dnia = Zd.id
    inner join Osoby O on Zd.id_osoby = O.id
go

create view Uczestnicy_konferencji as
  select distinct id_osoby, imie, nazwisko, id_konferencji
  from Konferencje
    inner join Dni_konferencji Dk on Konferencje.id = Dk.id_konferencji
    inner join Uczestnicy_dni_konferencji on id_dnia = Dk.id
go