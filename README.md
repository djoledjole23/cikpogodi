# Čik Pogodi!

Dnevni kviz od 5 segmenata (www.cikpogodi.rs). Next.js (App Router) + TypeScript + Supabase, hosting na Vercelu.

> Ovo je radna verzija README-a. Gotovi su **osnova, auth, segment 2 (Pogodi cenu) i segment 3 (Šta se više gugla)**.
> Ostali segmenti, rezultat, rang lista, admin i deploy stižu redom.

## Šta je gotovo

- Dizajn „Ajvar” (tamna podloga, ajvar crvena, kajmak krem; Baloo 2 + Nunito, fontovi su u paketu)
- Početna, registracija, prijava, Google/Apple dugmad, potvrda mejla, zaboravljena i nova šifra, nalog
  (promena imena, odjava, brisanje), pravila privatnosti i uslovi korišćenja (nacrti), 404
- Šema baze sa RLS-om i funkcijom za rang listu: `supabase/migrations/0001_init.sql`
- Mejlovi na srpskom: `supabase/email-templates/`
- Bodovanje i podešavanja: `src/config/quiz.config.ts`, `src/lib/scoring.ts`
- Zvukovi (Web Audio, bez fajlova), dugme za zvuk, baner za kolačiće, PWA manifest i ikonice
- **Igra** (`/igra`): jedna igra dnevno, nastavak posle osvežavanja, tajmer, bodovanje na serveru
- **Segment 2, Pogodi cenu**: 10 artikala dnevno iz `data/products.json`, seed za 14 dana, skripta `update-cene`
- **Segment 3, Šta se više gugla**: 8 duela dnevno iz `data/trends.json` (Google Trends, Srbija, 12 meseci).
  Pojmovi mogu biti iz različitih tema, a pobednik duela ostaje i dočekuje novog izazivača
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

1. Na supabase.com napravi projekat (region što bliže Srbiji, npr. Frankfurt).
2. **SQL Editor** → nalepi ceo `supabase/migrations/0001_init.sql` → Run.
3. **Project Settings → API**: prepiši URL i oba ključa u `.env.local` (kasnije i na Vercel).
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

Za sada skripta puni segmente 2 i 3:

- **Cena:** 10 artikala dnevno, bez istog naziva dvaput u danu, najviše 4 iz iste kategorije, bez ponavljanja od juče.
- **Gugla:** lanac od 8 duela dnevno u kome pobednik ostaje. Pojam koji se više gugla ostaje na svom mestu
  (gore ili dole), a na mesto gubitnika dolazi novi izazivač. Svih 9 pojmova u danu je iz različitih tema,
  izazivač pobedi 3 do 5 puta dnevno (da „uvek tapni šampiona” ne bude taktika) i nijedan duel se ne ponavlja
  u celom periodu.

## Cene

`data/products.json` je jedini izvor cena. U igru ulaze samo artikli koji imaju i sliku i cenu
(trenutno 76 od 94). Cena u igri je `cena_rsd`: prosek redovnih cena između lanaca, zaokružen na dinar.

**Fotografije.** Slike su za sada sa Open Food Facts (slikaju ih korisnici, pa su neujednačene). Sopstvena
fotografija ima prednost: ubaci fajl nazvan po barkodu u `public/artikli/` (npr. `public/artikli/8600043000023.jpg`)
i pusti `npm run seed`. Artikal koji u fajlu nema sliku, a ovde je ima, ulazi u igru. Uputstvo je u
`public/artikli/PROCITAJ.txt`. Koristi samo fotografije koje smeš (svoje ili uz dozvolu proizvođača ili trgovca).

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
- **Mostovi** su poređenja u kojima su zajedno pojmovi iz različitih grupa (najjači pojam svake grupe je u
  bar jednom mostu). Preko njih se sve grupe svode na jednu skalu, pa mogu da se porede i pojmovi koji nemaju
  veze jedan s drugim (čaj i Zlatibor). Tamo gde se dva mosta preklapaju, merenja se slažu na manje od 1%.
- `prosek` je prosečan nedeljni indeks (0–100) za 52 cele nedelje. To je broj koji Trends prikazuje kao
  „prosek” pored grafikona, samo sa dve decimale.
- `upit` je tačno ono što je ukucano u Trends: bez kvačica, kako ljudi najčešće kucaju (`cevapi`, ne `ćevapi`).
- U igri se duel prikazuje kao odnos: pojam koji se više tražio dobija 100, drugi srazmerno manje.
- Pojam sa prosekom ispod 2 u svojoj grupi ne ulazi u igru (pregrubo zaokruženo).
- Duel se **ne pravi** kad je slabiji pojam iznad 80% jačeg (preblizu, a zajednička skala nosi grešku od par
  procenata), kad je ispod 20% (preočigledno) ili kad bi greška zaokruživanja malih brojeva mogla da
  promeni pobednika.

Nova grupa: otvori `trends.google.com/trends/explore?geo=RS&date=today 12-m`, uporedi do 5 pojmova, prepiši
proseke u fajl. Zatim napravi bar jedan most: uporedi najjači pojam nove grupe sa pojmovima sličnog reda
veličine iz drugih grupa i dodaj to poređenje u `mostovi`. Promeni `period` i `datum_preuzimanja`, pa pusti
`npm run seed` (skripta ispisuje najveće neslaganje merenja; ako pređe par procenata, neki broj je pogrešno
prepisan). Ručni unos kroz admin panel stiže sa adminom.

## Kako je složeno

```
src/config/quiz.config.ts   limiti, pragovi, poeni: sve što se podešava
src/lib/scoring.ts          bodovanje (čiste funkcije, pokrivene testovima)
src/lib/game/engine.ts      srce igre: ko sme da igra, koje je pitanje, vreme, poeni (sve na serveru)
src/lib/game/segments/      po jedan fajl za svaki segment (šta ide u browser, kako se ocenjuje)
src/lib/content/            čitanje products.json i trends.json, raspored pitanja po danima, sopstvene slike
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
