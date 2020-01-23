create nonclustered index IDX_Klienci_osoby
    on Klienci (id_osoby)
go

create nonclustered index IDX_Klienci_firmy
    on Klienci (id_firmy)
go

create nonclustered index IDX_Rezerwacja_konferencji_konferencja
    on Rezerwacje_konferencji (id_konferencji)
go

create nonclustered index IDX_Rezerwacja_konferencji_klienci
    on Rezerwacje_konferencji (id_klienta)
go

create nonclustered index IDX_Dni_konferencji_konferencja
    on Dni_konferencji (id_konferencji)
go

create nonclustered index IDX_Ceny_dzien_konferencji
    on Ceny (id_dnia_konferencji)
go

create nonclustered index IDX_Warsztaty_dzien_konferencji
    on Warsztaty (id_dnia)
go

create nonclustered index IDX_Rezerwacje_dnia_dzien_konferencji
    on Rezerwacje_dnia (id_dnia)
go

create nonclustered index IDX_Rezerwacje_dnia_rezerwacja_konferencji
    on Rezerwacje_dnia (id_rezerwacji_konferencji)
go

create nonclustered index IDX_Zapisy_dnia_rezerwacja_dnia
    on Zapisy_dnia (id_rezerwacji_dnia)
go

create nonclustered index IDX_Zapisy_dnia_osoby
    on Zapisy_dnia (id_osoby)
go

create nonclustered index IDX_Rezerwacje_warsztatu_rezerwacja_dnia
    on Rezerwacje_warsztatu (id_rezerwacji_dnia)
go

create nonclustered index IDX_Rezerwacje_warsztatu_warsztaty
    on Rezerwacje_warsztatu (id_warsztatu)
go

create nonclustered index IDX_Zapisy_warsztatu_rezerwacje_warsztatu
    on Zapisy_warsztatu (id_rezerwacji_warsztatu)
go

create nonclustered index IDX_Zapisy_warsztatu_zapisy_dnia
    on Zapisy_warsztatu (id_zapisu_dnia)
go