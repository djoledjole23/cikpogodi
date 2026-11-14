# Čik Pogodi!

Dnevni kviz od 5 segmenata (www.cikpogodi.rs). Next.js (App Router) + TypeScript + Supabase, hosting na Vercelu.

> Ovo je radna verzija README-a. Gotovi su **osnova, nalozi, svih pet segmenata, čuvanje rezultata i rang lista**.
> Ostaju admin panel, završno poliranje i deploy (Supabase + Vercel + domen).

## Šta je gotovo

- Dizajn „Ajvar” (tamna podloga, ajvar crvena, kajmak krem; Baloo 2 + Nunito, fontovi su u paketu)
- Početna, registracija, prijava, Google/Apple dugmad, potvrda mejla, zaboravljena i nova šifra, nalog
  (promena imena, odjava, brisanje), pravila privatnosti i uslovi korišćenja (nacrti), 404
- Šema baze sa RLS-om i funkcijom za rang listu: `supabase/migrations/0001_init.sql`
- Mejlovi na srpskom: `supabase/email-templates/`
- Bodovanje i podešavanja: `src/config/quiz.config.ts`, `src/lib/scoring.ts`
- Zvukovi (Web Audio, bez fajlova), dugme za zvuk, baner za kolačiće, PWA manifest i ikonice
- **Igra** (`/igra`): jedna igra dnevno, nastavak posle osvežavanja, tajmer, bodovanje na serveru
- **Segment 1, Pogodi pesmu**: 5 pesama dnevno iz `data/songs.json` (165 pesama sa potvrđenim klipom na Deezeru),
  meri se preslušano vreme, odgovor se bira iz kataloga ili kuca (tolerantno poređenje)
- **Segment 2, Pogodi cenu**: 10 artikala dnevno iz `data/products.json`, seed za 14 dana, skripta `update-cene`
- **Segment 3, Šta se više gugla**: 8 duela dnevno iz `data/trends.json` (Google Trends, Srbija, 12 meseci).
  Pojmovi mogu biti iz različitih tema, a pobednik duela ostaje i dočekuje novog izazivača
- **Segment 4, Pogodi domaći film/seriju**: 3 kadra dnevno iz `data/films.json`, naslov se kuca bez ponuđenih
  odgovora (kvačice, ćirilica i sitne greške u kucanju se praštaju)
- **Efekti**: odbrojavanje „3, 2, 1, Čik!”, tačkice po pitanjima i niz pogodaka u zaglavlju, meta sa iglom
  kod cene, pečati, zvezdice na kraju segmenta, konfete (sve poštuje „smanjeno kretanje”)

## Pokretanje lokalno

```bash
npm install
cp .env.example .env.local   # pa popuni ključeve (vidi „Supabase” ispod)
npm run dev                  # http://localhost:3000
```

**Windows, bez kucanja komandi:** dvaput klikni `pokreni.bat`. Ako Node.js nije instaliran, skripta ga
instalira (zvanični LTS paket preko winget-a), zatim instalira pakete, pokreće sajt i otvara
`http://localhost:3000`.

Bez ključeva sajt radi, ali registracija i prijava javljaju da nalozi nisu povezani.

**Igra radi i bez Supabase-a.** Kad `DATABASE_URL` nije podešen, `npm run dev` sam napravi bazu u memoriji
(ista šema, isti seed, kviz za 14 dana od danas), pa `/igra` može da se igra kao gost. Ta baza se briše
kad ugasiš server.

Provere:

```bash
npm test            # bodovanje na granicama, korisnička imena, beogradsko vreme, šema baze + RLS
npm run typecheck
npm run lint
npm run build
```

## Env varijable

| Ime | Šta je |
|---|---|
| `NEXT_PUBLIC_SITE_URL` | Adresa sajta bez kose crte na kraju (`https://www.cikpogodi.rs`, lokalno `http://localhost:3000`) |
| `NEXT_PUBLIC_SUPABASE_URL` | Supabase → Project Settings → API → Project URL |
| `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` | „Publishable” ključ (ili stari „anon”). Sme da bude javan |
| `SUPABASE_SECRET_KEY` | „Secret” ključ (ili stari „service_role”). **Tajna**, samo na serveru |
| `DATABASE_URL` | Supabase → Connect → „Transaction pooler” adresa, sa šifrom baze. **Tajna**. Preko nje igra čita pitanja i upisuje odgovore |

## Supabase (jednom)

> Dok `.env.local` ne postoji ili je prazan, nalozi ne rade: na kraju igre ne piše forma za nalog nego poruka
> da nalozi nisu povezani. Fajl se pravi duplim klikom na `podesi.bat` (otvara ga u Notepad-u).

1. Na supabase.com napravi projekat (region što bliže Srbiji, npr. Frankfurt).
2. **SQL Editor** → nalepi ceo `supabase/migrations/0001_init.sql` → Run. Pa isto tako sve migracije po redu
   (`0002…`, `0003…`, `0004…`, `0005…`) i na kraju poslednji fajl iz `supabase/seed/` (to su pitanja).
3. **Project Settings → API Keys**: prepiši Project URL, „Publishable” i „Secret” ključ u `.env.local`
   (dupli klik na `podesi.bat`), a u **Connect → Transaction pooler** uzmi `DATABASE_URL`.
   Iste vrednosti kasnije idu i na Vercel.
4. **Authentication → URL Configuration**
   - Site URL: `https://www.cikpogodi.rs`
   - Redirect URLs: `https://www.cikpogodi.rs/**`, `https://cikpogodi.rs/**`, `http://localhost:3000/**`
5. **Authentication → Sign In / Providers → Email**: uključi „Confirm email”.
6. **Authentication → Emails → Templates**
   - „Confirm signup”: nalepi `supabase/email-templates/potvrda-naloga.html` (naslov je u komentaru na vrhu fajla)
   - „Reset password”: nalepi `supabase/email-templates/nova-sifra.html`
7. **Authentication → Emails → SMTP Settings**: ugrađeno slanje je samo za probu (par mejlova na sat).
   Za pravi sajt poveži svoj SMTP (npr. Resend) i u DNS za cikpogodi.rs dodaj zapise koje ti servis da.
8. **Google prijava**: Authentication → Sign In / Providers → Google. Treba OAuth klijent iz Google Cloud konzole;
   kao „Authorized redirect URI” ide adresa koju Supabase prikaže na toj strani.
9. **Apple prijava**: isto mesto → Apple. Traži plaćen Apple Developer nalog, može i kasnije.
   Dok nije podešeno, dugme postoji ali javlja grešku.
10. **Admin**: kad napraviš svoj nalog na sajtu, u SQL Editoru pokreni:
    ```sql
    insert into public.admins (user_id)
    select id from auth.users where email = 'TVOJ@MEJL';
    ```

## Dnevni sadržaj

Svaki dan ima svoj red u `daily_quiz` i svoja pitanja u `daily_quiz_items`. Dok ne stigne admin panel,
pitanja se prave skriptom:

```bash
npm run seed                    # 14 dana od sutra
npm run seed -- 2026-12-01 30   # 30 dana od 1. decembra
```

Skripta napravi fajl u `supabase/seed/`. Otvori ga, nalepi u Supabase → SQL Editor → Run.
Može da se pusti više puta: dan koji već ima pitanja se ne dira. Gotov fajl za prvih 14 dana
(14–27. novembar 2026) je `supabase/seed/seed-2026-11-14-14d.sql`.

Skripta puni svih pet segmenata (Joker samo za dane koji imaju pitanje u `data/joker.json`):

- **Pesma:** 5 pesama dnevno: po jedna folk, rok, pop i trep, a peta je svaki dan iz drugog žanra. U jednom danu
  se nijedan izvođač ne javlja dvaput (ni kao gost na tuđoj pesmi). Pesme sa oznakom `prioritet` idu pre ostalih,
  a pesma se ne ponavlja dok u njenom žanru ima neiskorišćenih (165 pesama pokriva 14 dana bez ponavljanja).
- **Cena:** 10 artikala dnevno, bez istog naziva dvaput u danu, najviše 4 iz iste kategorije, bez ponavljanja od juče.
- **Gugla:** lanac od 8 duela dnevno u kome pobednik ostaje. Pojam koji se više gugla ostaje na svom mestu
  (gore ili dole), a na mesto gubitnika dolazi novi izazivač. Svih 9 pojmova u danu je iz različitih tema,
  izazivač pobedi 3 do 5 puta dnevno (da „uvek tapni šampiona” ne bude taktika) i nijedan duel se ne ponavlja
  u celom periodu.

## Rezultat i rang lista

- **Posle poslednjeg pitanja** gost vidi ekran „Sačuvaj rezultat i uđi na rang listu”: Google / Apple, registracija
  mejlom, „Već imam nalog” i „Preskoči, samo mi pokaži rezultat”. Ko je već prijavljen taj ekran ne vidi.
- **Gde je rezultat** piše u `plays.leaderboard_status`: `none` (gost, nije na listi), `pending` (nalog postoji, mejl
  nije potvrđen) ili `counted` (na listi). Upisuje ga server čim se igra završi ili čim pređe na nalog.
- **Gost koji se posle igre prijavi**: igra sa tog uređaja postaje njegova. **Gost koji se registruje**: igra odmah
  prelazi na novi nalog i čeka potvrdu mejla; kad klikne na link iz mejla, okidač u bazi je stavlja na listu.
  Dok čeka, na uređaju na kom je igrao i dalje vidi svoj rezultat.
- **Rang lista** (`/rang-lista`): Danas / Ova nedelja (ponedeljak–nedelja) / Ukupno, prvih 50 i red igrača koji
  gleda, čak i kad nije među njima. Kod istog broja poena bolji je onaj ko je ukupno brže odgovarao; sve računa
  funkcija `public.leaderboard` u bazi. Na listi su samo nalozi sa potvrđenim mejlom i korisničkim imenom.
- **Avatar** je crtani lik koji se pravi iz oznake naloga (`src/components/Avatar.tsx`): isti nalog uvek dobija
  isti lik, ništa se ne bira i ne šalje.
- **Podeli** pravi tekst sa kvadratićima po segmentima, poenima i adresom, bez ijednog odgovora.
- Poznata rupa: gost koji obriše kolačiće i podatke sajta dobija novu oznaku uređaja, pa može da odigra ponovo
  pre nego što napravi nalog. Nalog može da ima samo jednu igru dnevno.
- Pregled izgleda liste na svom računaru: pokreni sa `CP_PROBNA_LISTA=1` (14 izmišljenih naloga za danas).
  Na pravom sajtu to ne postoji.

## Ista pitanja za sve

Pitanja za dan su redovi u tabeli `daily_quiz_items`, pa ih svaki igrač čita iste i istim redom. Pravi ih
`npm run seed` iz fajlova u `data/`, bez slučajnosti i bez zavisnosti od sata, a dan koji je već u bazi se ne
dira ni kad se seed pusti ponovo sa drugačijim podacima. Lokalna proba čita isti fajl iz `supabase/seed/` koji
ide u pravu bazu. Sve ovo proverava `tests/ista-pitanja.test.ts`, uključujući i to da fajl u `supabase/seed/`
odgovara podacima (posle svake izmene u `data/` pusti `npm run seed` ponovo, inače taj test pada).

Pitanja za dan koji je već počeo ne menjaj: ko je već igrao, igrao je stara.

## Joker pitanje

Peti segment je jedno pitanje dnevno za bonus (+50 preko osnovnih 300). Igrač kuca odgovor, ima 30 sekundi, a poredi
se tolerantno kao kod filmova (kvačice, ćirilica, jedna omaška, priznati oblici iz `alias`). Posle odgovora, tačnog
ili ne, iskoče fotografija i veliki broj sa natpisom (npr. „92 · body count”).

- `data/joker.json`: jedno pitanje po **datumu**. Dan bez pitanja nema Jokera (igra tada ima četiri segmenta).
  Polja: `datum`, `pitanje`, `odgovor`, `alias`, `slika`, `otkrice.broj`, `otkrice.natpis`, `izvor`.
- Pitanje, odgovor i podatak daje vlasnik sajta. `izvor` kaže odakle je podatak; ne upisuj ono što ne može da se proveri.
- Fotografija ide u `public/joker/` pod imenom koje **ne odaje odgovor** (otisak sadržaja, kao kod kadrova). U browser
  stiže tek sa ocenom, zajedno sa rešenjem i brojem. Učitavanje odbija ime fajla koje sadrži odgovor.
- Posle izmene fajla: `npm run seed`. Dan koji već ima Jokera u bazi se ne dira.
- Tabela `rebuses` iz prve migracije je ostala u bazi, ali se više ne koristi (migracija `0005_joker.sql`).

## Filmovi i serije

„Pogodi domaći film/seriju”: igrač vidi kadar i kuca naslov. Nema ponuđenih odgovora ni spiska filmova u
browseru; server poredi tolerantno (kvačice, ćirilica, jedna do dve greške u kucanju, kraći oblik naslova
iz `alias`). Tačno nosi 20 poena, sve ostalo 0.

- `data/films.json`: naslov, `alias` (npr. „Maratonci”) i adresa kadra.
- Kadrovi su u `public/kadrovi/` pod imenom koje **ne odaje naslov** (otisak sadržaja, npr. `9f2c….webp`),
  ponovo kodirani bez metapodataka i smanjeni na najviše 960 px. Fajl nazvan po filmu ne sme u taj folder:
  učitavanje ga odbija, jer igrač vidi adresu slike.
- Novi kadar: fotografiju nazovi po filmu, pretvori je u webp sa nasumičnim imenom, ubaci u `public/kadrovi/`,
  dodaj red u `films.json` i pusti `npm run seed`. (Unos kroz admin panel stiže sa adminom.)
- Raspored: 3 kadra dnevno, film se ne ponavlja dok ima neiskorišćenih i nikad dva dana zaredom.
  28 kadrova pokriva 9 dana bez ponavljanja.
- Kadrovi iz filmova pripadaju producentima. Koristi one za koje imaš dozvolu ili zvanični materijal za medije.

## Pesme

`data/songs.json` su pesme koje se **puštaju** u „Pogodi pesmu” (165 komada, mnogo više nego što treba za dve nedelje).

`data/katalog.json` je **spisak za biranje odgovora**: oko 6.700 pesama (do 30 najslušanijih od svakog izvođača
iz kviza i do 20 od još dvestotinak domaćih izvođača). Te pesme se nikad ne puštaju. Služe da izbor bude težak:
ko ukuca „Ceca” vidi tridesetak njenih pesama, a ne samo onu koja svira. Browser dobija jedan pomešan spisak
(`/api/pesme`), bez oznake koja je pesma iz kviza.

- Naslovi su sa Deezera, ne izmišljaju se. Osvežavanje spiska:
  `node scripts/katalog-pesama.mjs preuzmi` (oko 5 minuta, pravi `tmp/katalog-sirovo.json`), pa
  `node scripts/katalog-pesama.mjs napravi` (čisti verzije i duple, ujednačava pisanje i kvačice gde je sigurno).
- Iz spiska se izbacuje sve što bi se sudarilo sa pesmom iz kviza (isti izvođač i isti ili skoro isti naslov),
  da tačan odgovor bude samo jedan. To proverava i test `tests/katalog.test.ts`, pa ga pusti posle svake izmene
  `songs.json`.
- Izbor sa spiska je tačan samo ako je baš ta pesma (isti izvođač i naslov). Praštanje omaški važi samo kad igrač
  kuca naslov i pošalje ga bez biranja.
- Deo naslova sa Deezera je pisan bez kvačica („Hitna pomoc”). Skripta popravlja ono što je sigurno, ostalo ostaje.

O pesmama koje se puštaju (`songs.json`):

- Svaka pesma ima `deezer_id` numere koja je **pronađena na Deezeru sa klipom od 30 s** (`api.deezer.com/search`).
  ID se ne izmišlja: pesma bez njega ne ulazi ni u kviz ni u katalog. `nije_nadjeno` nabraja pesme koje su
  tražene, a nisu nađene (ili postoje samo uživo).
- `zanr` je `folk`, `rok`, `pop` ili `trep` i služi za dnevni miks. `izvodjaci` se navodi kad ih je više
  (duet, gost), da se isti izvođač ne javi dvaput u danu.
- `alias` su drugi oblici naslova koji se priznaju kad igrač kuca („Da li si ikada mene voljela”).
- `itunes_id` je rezerva: ako Deezer ostane bez klipa, klip se uzima sa iTunes-a.
- Audio se **ne čuva nigde**. Browser traži `/api/track/<broj pitanja>`, a server ga preusmeri na svež zvanični
  klip (Deezer linkovi ističu, pa se uzimaju tek kad pesma treba da se pusti). U adresi je broj pitanja, ne ID
  pesme, i radi samo za pitanje koje je tom igraču već poslato.
- Preslušano vreme meri i server (poruke „pušteno / pauzirano”), pa osvežavanje strane ne vraća sat na nulu.
  Plejeru u browseru se veruje samo unutar tolerancije od 1,5 s. Ko namerno izmeni kod igre u svom browseru
  može da sluša duže nego što prijavi; to ne može potpuno da se spreči dok se klip pušta direktno sa Deezera.
- Nova pesma: nađi je na Deezeru (u adresi numere je ID), dodaj red u fajl i pusti `npm run seed`. Unos kroz
  admin panel (pretraga po Deezeru) stiže sa adminom.

## Cene

`data/products.json` je jedini izvor cena. U igru ulaze samo artikli koji imaju i sliku i cenu
(trenutno svih 94). Cena u igri je `cena_rsd`: prosek redovnih cena između lanaca, zaokružen na dinar.

**Fotografije.** Za svaki artikal postoji fotografija pakovanja u `public/artikli/<barkod>.webp` (bela pozadina,
najviše 640 px). Preuzete su skriptom, isključivo po barkodu, pa slika ne može da bude od druge gramaže ili ukusa:

```bash
node scripts/slike-artikala.mjs     # → tmp/artikli/ + izveštaj šta je nađeno i gde
```

- 79 artikala je iz Maxi internet prodavnice. Za 15 kojih tamo nema, adresa fotografije je nađena pretragom po
  barkodu na Cenoteci i upisana u `data/slike-rucno.json` (Cenoteka ne pušta skripte na pretragu).
- Preuzete fajlove pregledaj, pa ih pretvori u webp i prebaci u `public/artikli/`. Posle toga `npm run seed`.
- **Fotografije su vlasništvo proizvođača i trgovaca.** Odluku da se koriste doneo je vlasnik sajta i on za nju
  odgovara. Ako neko zatraži uklanjanje, obriši fajl: artikal tada koristi `slika_url` iz `products.json`
  (Open Food Facts) ako ga ima, a inače ispada iz igre.
- Fajl u `public/artikli/` uvek ima prednost, pa tu možeš da ubaciš i sopstvenu fotografiju
  (uputstvo: `public/artikli/PROCITAJ.txt`).

```bash
npm run update-cene             # osveži cene iz cenovnika na data.gov.rs
npm run update-cene -- --suvo   # samo pokaži šta bi se promenilo
```

- Spisak artikala ostaje isti (po barkodu); novi artikal se dodaje ručno u fajl, sa barkodom, nazivom i gramažom.
- Artikal koji se ne nađe u bar 3 lanca se izbacuje i ispisuje u izveštaju. Cena se nikad ne dopunjava starom ni izmišlja.
- Cena koja skoči više od 40% se izbacuje kao sumnjiva, da se proveri ručno.
- Ako se ne preuzme dovoljno cenovnika, stari fajl ostaje netaknut.
- Posle osvežavanja pusti `npm run seed` za nove dane. Dani koji su već u bazi zadržavaju cenu sa kojom su napravljeni.

Skripta mora da se pokrene sa računara koji može do sajtova lanaca (tvoj računar, ne ovaj repo sam od sebe).

## Google Trends

`data/trends.json` drži prave brojeve iz Google Trends-a (Srbija, poslednjih 12 meseci). Javnog API-ja nema,
pa se brojevi unose u fajl, a dueli se prave iz njega.

- Fajl ima **grupe** do 5 pojmova. Jedna grupa = jedno poređenje u Trends-u, pa su pojmovi u njoj na
  zajedničkoj skali.
- **Tema ili tačan tekst.** `upit` koji počinje sa `/` je oznaka *teme* u Trends-u (npr. `/m/0110q02h` je
  košarkaš Nikola Jokić): broje se sve pretrage o tom pojmu, kako god da su ukucane („jokic”, „jokić mvp”).
  Ostali upiti su *tačan tekst* pretrage (`bmw`, `polovni automobili`). Za svaki pojam su izmerena oba načina
  i uzet je onaj koji hvata više: tema je pravilo, a tekst se koristi kad teme nema ili kad hvata manje od
  samog teksta (marke automobila, palačinke, pasulj). Pojam meren kao tekst traži veću razliku u duelu.
- **Mostovi** su poređenja u kojima su zajedno najjači pojmovi iz različitih grupa. Preko njih se sve grupe
  svode na jednu skalu, pa mogu da se porede i pojmovi koji nemaju veze jedan s drugim (čaj i Zlatibor).
  Tamo gde se mostovi preklapaju, merenja se slažu na oko 1%.
- `prosek` je prosečan nedeljni indeks (0–100) za cele nedelje u periodu.
- **Stvaran broj pretraga ne postoji u Trends-u**, samo odnosi. U igri se zato prikazuje odnos: pojam koji se
  više tražio dobija 100, drugi srazmerno manje, uz „koliko puta više”.
- Pojam sa prosekom ispod 2 u svojoj grupi ne ulazi u igru (pregrubo zaokruženo). Grupa koja ne može pouzdano
  da se veže za ostale takođe ispada (praznici: jedan veliki skok godišnje, pa je prosek premali).
- Duel se **ne pravi** kad je slabiji pojam iznad 80% jačeg (preblizu, a zajednička skala nosi grešku od par
  procenata), kad je ispod 20% (preočigledno) ili kad bi greška merenja mogla da promeni pobednika.

Nova grupa: otvori `trends.google.com/trends/explore?geo=RS&date=today 12-m`, uporedi do 5 pojmova (kad Trends
ponudi temu, na primer „Košarkaš”, izaberi nju umesto „Pojam za pretragu”), prepiši proseke u fajl. Zatim napravi bar jedan most: uporedi najjači pojam nove grupe sa pojmovima sličnog reda
veličine iz drugih grupa i dodaj to poređenje u `mostovi`. Promeni `period` i `datum_preuzimanja`, pa pusti
`npm run seed` (skripta ispisuje najveće neslaganje merenja; ako pređe par procenata, neki broj je pogrešno
prepisan). Ručni unos kroz admin panel stiže sa adminom.

## Kako je složeno

```
src/config/quiz.config.ts   limiti, pragovi, poeni: sve što se podešava
src/lib/scoring.ts          bodovanje (čiste funkcije, pokrivene testovima)
src/lib/game/engine.ts      srce igre: ko sme da igra, koje je pitanje, vreme, poeni (sve na serveru)
src/lib/game/segments/      po jedan fajl za svaki segment (šta ide u browser, kako se ocenjuje)
src/lib/content/            čitanje songs.json, products.json, trends.json i films.json, raspored pitanja po danima, sopstvene slike
src/lib/match.ts            tolerantno poređenje teksta i pretraga kataloga pesama
src/lib/audio.ts            svež link ka klipu od 30 s (Deezer, pa iTunes)
src/app/api/track/          zvuk za pitanje (preusmerenje na zvanični klip)
src/app/api/pesme/          katalog pesama za biranje odgovora
src/lib/db/                 veza sa bazom: Postgres (produkcija) ili baza u memoriji (razvoj i testovi)
src/app/api/igra/route.ts   jedina ulazna tačka igre za browser
src/components/game/        ekrani igre
src/lib/time.ts             beogradski datum, odbrojavanje do ponoći, početak nedelje
src/lib/username.ts         pravila za korisničko ime + filter psovki
src/lib/auth-actions.ts     registracija, prijava, šifra, ime, brisanje naloga (server actions)
src/lib/supabase/           Supabase klijenti za naloge
src/lib/sound.ts            zvukovi i haptika
src/proxy.ts                osvežava sesiju pre svake strane
scripts/                    seed, update-cene, ikonice
supabase/migrations/        šema baze
supabase/seed/              gotov SQL za dnevni sadržaj
tests/                      testovi
```

Pravila za fer igru:

- Tabele sa tačnim odgovorima nemaju nijednu RLS polisu za čitanje, pa ih browser ne može da pročita ni uz
  javni ključ. Čita ih samo server.
- Pitanje koje ide u browser sastavlja se polje po polje (`javno()` u `segments/`), bez cene i opsega.
- Vreme meri server, od slanja pitanja do prijema odgovora. Odgovor koji zakasni više od 1,5 s preko limita
  se ne prima.
- Jedna igra dnevno: po nalogu za ulogovane, po uređaju (kolačić + localStorage) za goste. Jedinstveni
  indeksi u bazi su poslednja odbrana.

Testovi (`npm test`) sve ovo proveravaju na pravom Postgresu u memoriji.

## Pre puštanja u javnost

- Popuni obeležena mesta u `src/app/pravila-privatnosti` i `src/app/uslovi-koriscenja` (ko upravlja sajtom,
  kontakt mejl, datum) i daj nekom pravniku da pogleda.
