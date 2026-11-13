-- Čik Pogodi! seed: 14 dana od 2026-11-14. Cenovnik od 2026-11-13.
-- Napravljeno komandom: npm run seed -- 2026-11-14 14

-- Artikli (products.json). Postojeći se osvežavaju po barkodu.
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043000023', 'Plazma keks', '300 g', 'https://images.openfoodfacts.org/images/products/860/004/300/0023/front_en.57.400.jpg', 288.56, 279.99, 294.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043000016', 'Plazma keks', '150 g', 'https://images.openfoodfacts.org/images/products/860/004/300/0016/front_en.31.400.jpg', 158.19, 152.99, 159.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043039788', 'Plazma keks', '400 g', 'https://images.openfoodfacts.org/images/products/860/004/303/9788/front_sr.13.400.jpg', 387.71, 369.99, 401.66, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043001105', 'Plazma mlevena', '300 g', 'https://images.openfoodfacts.org/images/products/860/004/300/1105/front_en.45.400.jpg', 292.59, 279.99, 299.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043028263', 'Plazma Kocka napolitanke', '135 g', 'https://images.openfoodfacts.org/images/products/860/004/302/8263/front_fr.7.400.jpg', 205.77, 183.99, 219.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043029512', 'Plazma Stiksi', '125 g', 'https://images.openfoodfacts.org/images/products/860/004/302/9512/front_en.3.400.jpg', 250.19, 217.99, 270.67, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600043041484', 'Plazma Rolsi lešnik', '130 g', 'https://images.openfoodfacts.org/images/products/860/004/304/1484/front_fr.5.400.jpg', 185.59, 170.99, 212.49, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114000013', 'Jaffa keks', '150 g', 'https://images.openfoodfacts.org/images/products/860/011/400/0013/front_en.28.400.jpg', 143.62, 139.99, 146.66, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114000211', 'Jaffa keks', '300 g', 'https://images.openfoodfacts.org/images/products/860/011/400/0211/front_en.45.400.jpg', 252, 249.69, 258.32, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114000020', 'Munchmallow', '105 g', 'https://images.openfoodfacts.org/images/products/860/011/400/0020/front_en.46.400.jpg', 107.98, 102.99, 111.66, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600114006626', 'Jaffa napolitanke šlag i čokolada', '187 g', 'https://images.openfoodfacts.org/images/products/860/011/400/6626/front_fr.10.400.jpg', 122.33, 109.99, 139.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939313701', 'Najlepše želje mlečna čokolada', '200 g', 'https://images.openfoodfacts.org/images/products/860/093/931/3701/front_hr.25.400.jpg', 381.76, 364.99, 389.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939313602', 'Najlepše želje mlečna čokolada', '90 g', 'https://images.openfoodfacts.org/images/products/860/093/931/3602/front_fr.22.400.jpg', 192.96, 189.99, 198.32, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939334171', 'Najlepše želje crna sa bananicom', '184 g', 'https://images.openfoodfacts.org/images/products/860/093/933/4171/front_sr.3.400.jpg', 367.08, 349.99, 389.99, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939346082', 'Najlepše želje sa keksom', '170 g', 'https://images.openfoodfacts.org/images/products/860/093/934/6082/front_fr.3.400.jpg', 352.63, 349.99, 363.32, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('86006675', 'Štark Bananica', '25 g', 'https://images.openfoodfacts.org/images/products/000/008/600/6675/front_en.38.400.jpg', 27.19, 24.99, 29.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939366424', 'Štark Bananica', '250 g', 'https://images.openfoodfacts.org/images/products/860/093/936/6424/front_de.3.400.jpg', 255.99, 247.99, 269.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939365472', 'Štark Bananica 5 kom', '125 g', 'https://images.openfoodfacts.org/images/products/860/093/936/5472/front_en.22.400.jpg', 138.89, 134.99, 141.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939303115', 'Štark Menaž čokolada za kuvanje', '100 g', 'https://images.openfoodfacts.org/images/products/860/093/930/3115/front_sr.34.400.jpg', 201.92, 192.99, 211.66, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939841204', 'Štark Čajni keksići', '800 g', 'https://images.openfoodfacts.org/images/products/860/093/984/1204/front_en.17.400.jpg', 322.46, 309.99, 349.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939110454', 'Štark napolitanke sa čokoladom', '180 g', 'https://images.openfoodfacts.org/images/products/860/093/911/0454/front_en.17.400.jpg', 146.77, 128.99, 159.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900502032', 'Eurocrem Euro blok', '50 g', 'https://images.openfoodfacts.org/images/products/860/190/050/2032/front_sr.10.400.jpg', 66.79, 59.99, 74.99, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900502100', 'Eurocrem Euro blok', '100 g', 'https://images.openfoodfacts.org/images/products/860/190/050/2100/front_sr.14.400.jpg', 121.33, 99.99, 137.99, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601900503411', 'Eurocrem činija', '500 g', 'https://images.openfoodfacts.org/images/products/860/190/050/3411/front_en.3.400.jpg', 480.46, 399.99, 543.32, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600946442111', 'Swisslion Isleri sa Eurocremom', '125 g', 'https://images.openfoodfacts.org/images/products/860/094/644/2111/front_en.9.400.jpg', 155.19, 129.99, 184.99, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300236022', 'Pionir Medeno srce', '150 g', 'https://images.openfoodfacts.org/images/products/860/230/023/6022/front_en.10.400.jpg', 145.63, 139.99, 153.32, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300200245', 'Pionir zeleni mentol bombone', '100 g', 'https://images.openfoodfacts.org/images/products/860/230/020/0245/front_hr.10.400.jpg', 67.39, 59.99, 74.72, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300207305', 'Pionir karamele lešnik', '100 g', 'https://images.openfoodfacts.org/images/products/860/230/020/7305/front_en.3.400.jpg', 143.88, 132.99, 154.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8602300233229', 'Pionir Negro punjene bombone', '250 g', 'https://images.openfoodfacts.org/images/products/860/230/023/3229/front_de.3.400.jpg', 264.47, 252.99, 286.16, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600104004458', 'Medela štrudla', '240 g', 'https://images.openfoodfacts.org/images/products/860/010/400/4458/front_fr.37.400.jpg', 150.42, 139.99, 157.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939506912', 'Smoki', '50 g', 'https://images.openfoodfacts.org/images/products/860/093/950/6912/front_en.45.400.jpg', 47.66, 45.99, 49.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939508190', 'Smoki', '80 g', 'https://images.openfoodfacts.org/images/products/860/093/950/8190/front_en.3.400.jpg', 73.8, 69.99, 76.99, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939506936', 'Smoki', '150 g', 'https://images.openfoodfacts.org/images/products/860/093/950/6936/front_en.32.400.jpg', 129.26, 127.99, 129.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939507025', 'Smoki', '250 g', 'https://images.openfoodfacts.org/images/products/860/093/950/7025/front_en.23.400.jpg', 184.73, 171.99, 199.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600939375563', 'Čoko Smoki', '80 g', 'https://images.openfoodfacts.org/images/products/860/093/937/5563/front_en.34.400.jpg', 170.95, 149.99, 179.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017378495', 'Chipsy Classic', '140 g', 'https://images.openfoodfacts.org/images/products/860/601/737/8495/front_nl.3.400.jpg', 192.37, 171.49, 214.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606033742416', 'Chipsy Domaćinski kajmak', '145 g', 'https://images.openfoodfacts.org/images/products/860/603/374/2416/front_en.4.400.jpg', 194.88, 184.99, 199.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606033741495', 'Clipsy Mix flips', '150 g', 'https://images.openfoodfacts.org/images/products/860/603/374/1495/front_hr.4.400.jpg', 149.35, 144.99, 156.66, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017378822', 'Pardon štapići sa kikirikijem', '210 g', 'https://images.openfoodfacts.org/images/products/860/601/737/8822/front_en.3.400.jpg', 159.22, 137.99, 169.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606017370048', 'Pardon perece', '95 g', 'https://images.openfoodfacts.org/images/products/860/601/737/0048/front_en.4.400.jpg', 81.39, 74.99, 88.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037000312', 'Knjaz Miloš gazirana voda', '0,5 l', 'https://images.openfoodfacts.org/images/products/860/003/700/0312/front_fr.15.400.jpg', 54.78, 49.99, 57.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037005133', 'Knjaz Miloš gazirana voda', '1,75 l', 'https://images.openfoodfacts.org/images/products/860/003/700/5133/front_sr.18.400.jpg', 64.65, 62.99, 65.59, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600037008011', 'Knjaz Miloš staklo', '0,25 l', 'https://images.openfoodfacts.org/images/products/860/003/700/8011/front_fr.3.400.jpg', 82.99, 77.99, 89.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600169600022', 'Prolom voda', '1,5 l', 'https://images.openfoodfacts.org/images/products/860/016/960/0022/front_en.27.400.jpg', 86.23, 82.66, 99.99, 'Idea', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606030051702', 'Fruvita narandža 100%', '0,8 l', 'https://images.openfoodfacts.org/images/products/860/603/005/1702/front_en.4.400.jpg', 317.47, 297.99, 349.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600105001463', 'Jelen pivo limenka', '0,5 l', 'https://images.openfoodfacts.org/images/products/860/010/500/1463/front_en.8.400.jpg', 98.28, 90.99, 109.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('86027618', 'Jelen pivo flaša', '0,5 l', 'https://images.openfoodfacts.org/images/products/000/008/602/7618/front_en.7.400.jpg', 91.19, 89.99, 94.99, 'Gomex', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600649000427', 'Zaječarsko pivo limenka', '0,5 l', 'https://images.openfoodfacts.org/images/products/860/064/900/0427/front_de.3.400.jpg', 96.28, 89.99, 104.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600101521439', 'Doncafe Moment kafa', '200 g', 'https://images.openfoodfacts.org/images/products/860/010/152/1439/front_en.5.400.jpg', 471.34, 449.99, 483.32, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600103056250', 'Grand Gold kafa', '500 g', 'https://images.openfoodfacts.org/images/products/860/010/305/6250/front_sr.8.400.jpg', 1103.99, 999.99, 1159.99, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606018312276', 'Grand 3u1 Najlepše želje', '18 g', 'https://images.openfoodfacts.org/images/products/860/601/831/2276/front_sr.3.400.jpg', 32.92, 28.99, 39.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500116011', 'Moja Kravica mleko dugotrajno 2,8%', '1 l', 'https://images.openfoodfacts.org/images/products/860/150/011/6011/front_sr.23.400.jpg', 112.99, 99.99, 139.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500138655', 'Moja Kravica sveže mleko 2,8%', '1,75 l', 'https://images.openfoodfacts.org/images/products/860/150/013/8655/front_en.11.400.jpg', 226.79, 219.99, 230.62, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500138495', 'Moja Kravica jogurt 2,8%', '1,75 kg', 'https://images.openfoodfacts.org/images/products/860/150/013/8495/front_en.3.400.jpg', 232.61, 224.99, 240.09, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500115892', 'Moja Kravica jogurt čaša', '180 g', 'https://images.openfoodfacts.org/images/products/860/150/011/5892/front_fr.4.400.jpg', 38.46, 35.99, 39.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500110330', 'Moja Kravica čokoladno mleko', '0,25 l', 'https://images.openfoodfacts.org/images/products/860/150/011/0330/front_en.22.400.jpg', 67.56, 64.99, 69.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500112419', 'Moja Kravica kisela pavlaka 20%', '400 g', 'https://images.openfoodfacts.org/images/products/860/150/011/2419/front_en.15.400.jpg', 187.09, 179.99, 189.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500111122', 'Moja Kravica maslac', '125 g', 'https://images.openfoodfacts.org/images/products/860/150/011/1122/front_nl.3.400.jpg', 321.53, 315.99, 329.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500126492', 'Ella sveži sir', '400 g', 'https://images.openfoodfacts.org/images/products/860/150/012/6492/front_en.3.400.jpg', 281.62, 262.99, 299.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8601500133490', 'Imlek protein čoko šejk', '300 ml', 'https://images.openfoodfacts.org/images/products/860/150/013/3490/front_en.29.400.jpg', 180.06, 169.99, 189.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('86002783', 'Carnex jetrena pašteta', '75 g', 'https://images.openfoodfacts.org/images/products/000/008/600/2783/front_de.7.400.jpg', 88.94, 79.99, 99.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012700336', 'Carnex sarma', '400 g', 'https://images.openfoodfacts.org/images/products/860/001/270/0336/front_en.14.400.jpg', 495.72, 469.99, 521.66, 'Aman', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012700282', 'Carnex pasulj sa slaninom', '400 g', 'https://images.openfoodfacts.org/images/products/860/001/270/0282/front_hr.3.400.jpg', 359.45, 317.49, 403.32, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600012502510', 'Carnex delikates viršla', '205 g', 'https://images.openfoodfacts.org/images/products/860/001/250/2510/front_fr.3.400.jpg', 211.07, 196.99, 229.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600084005841', 'Yuhor Alpska kobasica', '350 g', 'https://images.openfoodfacts.org/images/products/860/008/400/5841/front_en.3.400.jpg', 302.85, 244.99, 339.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600084005612', 'Yuhor Levački štapići', '200 g', 'https://images.openfoodfacts.org/images/products/860/008/400/5612/front_en.3.400.jpg', 594.16, 557.99, 639.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600763655244', 'Neoplanta Pipi pileća viršla', '205 g', 'https://images.openfoodfacts.org/images/products/860/076/365/5244/front_en.3.400.jpg', 193.67, 182.99, 209.99, 'Super Vero', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606100145775', 'Zlatiborac kulen slajs', '100 g', 'https://images.openfoodfacts.org/images/products/860/610/014/5775/front_sr.18.400.jpg', 270.52, 207.49, 309.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606106822403', 'Zlatiborac čvarci', '150 g', 'https://images.openfoodfacts.org/images/products/860/610/682/2403/front_fr.3.400.jpg', 469.72, 436.99, 499.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498170029', 'Dijamant suncokretovo ulje', '1 l', 'https://images.openfoodfacts.org/images/products/860/049/817/0029/front_hu.6.400.jpg', 201.52, 195.66, 214.99, 'Univerexport', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498150083', 'Dijamant kečap blagi', '500 g', 'https://images.openfoodfacts.org/images/products/860/049/815/0083/front_en.6.400.jpg', 160.84, 147.99, 179.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498176359', 'Dijamant majonez', '285 ml', 'https://images.openfoodfacts.org/images/products/860/049/817/6359/front_sr.5.400.jpg', 191.65, 189.99, 199.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8600498172115', 'Dijamant stoni margarin', '250 g', 'https://images.openfoodfacts.org/images/products/860/049/817/2115/front_sr.14.400.jpg', 114.79, 104.99, 124.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080088', 'Frikom Kapri sladoled', '70 ml', 'https://images.openfoodfacts.org/images/products/860/600/608/0088/front_sr.30.400.jpg', 98.83, 89.99, 102.99, 'Lidl', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080040', 'Frikom Snesko', '46 g', 'https://images.openfoodfacts.org/images/products/860/600/608/0040/front_sr.4.400.jpg', 76.39, 65.99, 80.99, 'Maxi', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();
insert into public.products (barcode, name, size, image_url, price_avg, price_min, price_max, cheapest_chain, price_date)
  values ('8606006080095', 'Frikom Čoko Moko', '52 g', 'https://images.openfoodfacts.org/images/products/860/600/608/0095/front_sr.4.400.jpg', 80.39, 79.99, 81.99, 'Idea', '2026-11-13')
  on conflict (barcode) do update set name = excluded.name, size = excluded.size, image_url = excluded.image_url,
    price_avg = excluded.price_avg, price_min = excluded.price_min, price_max = excluded.price_max,
    cheapest_chain = excluded.cheapest_chain, price_date = excluded.price_date, active = true, updated_at = now();

-- Dnevni kviz: segment 2 (Pogodi cenu). Dan koji već ima stavke se ne dira.
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-14', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 1, id, '{"naziv":"Frikom Snesko","kolicina":"46 g","slika":"https://images.openfoodfacts.org/images/products/860/600/608/0040/front_sr.4.400.jpg","cena":76,"min":65.99,"max":80.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080040'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 2, id, '{"naziv":"Moja Kravica sveže mleko 2,8%","kolicina":"1,75 l","slika":"https://images.openfoodfacts.org/images/products/860/150/013/8655/front_en.11.400.jpg","cena":227,"min":219.99,"max":230.62,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500138655'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 3, id, '{"naziv":"Eurocrem činija","kolicina":"500 g","slika":"https://images.openfoodfacts.org/images/products/860/190/050/3411/front_en.3.400.jpg","cena":480,"min":399.99,"max":543.32,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900503411'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 4, id, '{"naziv":"Grand 3u1 Najlepše želje","kolicina":"18 g","slika":"https://images.openfoodfacts.org/images/products/860/601/831/2276/front_sr.3.400.jpg","cena":33,"min":28.99,"max":39.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606018312276'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 5, id, '{"naziv":"Carnex jetrena pašteta","kolicina":"75 g","slika":"https://images.openfoodfacts.org/images/products/000/008/600/2783/front_de.7.400.jpg","cena":89,"min":79.99,"max":99.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '86002783'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 6, id, '{"naziv":"Neoplanta Pipi pileća viršla","kolicina":"205 g","slika":"https://images.openfoodfacts.org/images/products/860/076/365/5244/front_en.3.400.jpg","cena":194,"min":182.99,"max":209.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600763655244'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 7, id, '{"naziv":"Jaffa keks","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/011/400/0013/front_en.28.400.jpg","cena":144,"min":139.99,"max":146.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000013'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 8, id, '{"naziv":"Jelen pivo limenka","kolicina":"0,5 l","slika":"https://images.openfoodfacts.org/images/products/860/010/500/1463/front_en.8.400.jpg","cena":98,"min":90.99,"max":109.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600105001463'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 9, id, '{"naziv":"Najlepše želje crna sa bananicom","kolicina":"184 g","slika":"https://images.openfoodfacts.org/images/products/860/093/933/4171/front_sr.3.400.jpg","cena":367,"min":349.99,"max":389.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939334171'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-14', 2, 10, id, '{"naziv":"Ella sveži sir","kolicina":"400 g","slika":"https://images.openfoodfacts.org/images/products/860/150/012/6492/front_en.3.400.jpg","cena":282,"min":262.99,"max":299.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500126492'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 1, id, '{"naziv":"Pardon perece","kolicina":"95 g","slika":"https://images.openfoodfacts.org/images/products/860/601/737/0048/front_en.4.400.jpg","cena":81,"min":74.99,"max":88.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017370048'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 2, id, '{"naziv":"Chipsy Classic","kolicina":"140 g","slika":"https://images.openfoodfacts.org/images/products/860/601/737/8495/front_nl.3.400.jpg","cena":192,"min":171.49,"max":214.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017378495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 3, id, '{"naziv":"Štark Čajni keksići","kolicina":"800 g","slika":"https://images.openfoodfacts.org/images/products/860/093/984/1204/front_en.17.400.jpg","cena":322,"min":309.99,"max":349.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939841204'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 4, id, '{"naziv":"Pionir zeleni mentol bombone","kolicina":"100 g","slika":"https://images.openfoodfacts.org/images/products/860/230/020/0245/front_hr.10.400.jpg","cena":67,"min":59.99,"max":74.72,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300200245'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 5, id, '{"naziv":"Carnex pasulj sa slaninom","kolicina":"400 g","slika":"https://images.openfoodfacts.org/images/products/860/001/270/0282/front_hr.3.400.jpg","cena":359,"min":317.49,"max":403.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012700282'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 6, id, '{"naziv":"Knjaz Miloš gazirana voda","kolicina":"1,75 l","slika":"https://images.openfoodfacts.org/images/products/860/003/700/5133/front_sr.18.400.jpg","cena":65,"min":62.99,"max":65.59,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600037005133'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 7, id, '{"naziv":"Plazma keks","kolicina":"400 g","slika":"https://images.openfoodfacts.org/images/products/860/004/303/9788/front_sr.13.400.jpg","cena":388,"min":369.99,"max":401.66,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043039788'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 8, id, '{"naziv":"Plazma mlevena","kolicina":"300 g","slika":"https://images.openfoodfacts.org/images/products/860/004/300/1105/front_en.45.400.jpg","cena":293,"min":279.99,"max":299.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043001105'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 9, id, '{"naziv":"Pardon štapići sa kikirikijem","kolicina":"210 g","slika":"https://images.openfoodfacts.org/images/products/860/601/737/8822/front_en.3.400.jpg","cena":159,"min":137.99,"max":169.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017378822'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-15', 2, 10, id, '{"naziv":"Knjaz Miloš staklo","kolicina":"0,25 l","slika":"https://images.openfoodfacts.org/images/products/860/003/700/8011/front_fr.3.400.jpg","cena":83,"min":77.99,"max":89.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600037008011'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 1, id, '{"naziv":"Štark Bananica","kolicina":"25 g","slika":"https://images.openfoodfacts.org/images/products/000/008/600/6675/front_en.38.400.jpg","cena":27,"min":24.99,"max":29.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '86006675'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 2, id, '{"naziv":"Eurocrem Euro blok","kolicina":"50 g","slika":"https://images.openfoodfacts.org/images/products/860/190/050/2032/front_sr.10.400.jpg","cena":67,"min":59.99,"max":74.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900502032'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 3, id, '{"naziv":"Yuhor Levački štapići","kolicina":"200 g","slika":"https://images.openfoodfacts.org/images/products/860/008/400/5612/front_en.3.400.jpg","cena":594,"min":557.99,"max":639.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600084005612'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 4, id, '{"naziv":"Štark Menaž čokolada za kuvanje","kolicina":"100 g","slika":"https://images.openfoodfacts.org/images/products/860/093/930/3115/front_sr.34.400.jpg","cena":202,"min":192.99,"max":211.66,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939303115'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 5, id, '{"naziv":"Moja Kravica mleko dugotrajno 2,8%","kolicina":"1 l","slika":"https://images.openfoodfacts.org/images/products/860/150/011/6011/front_sr.23.400.jpg","cena":113,"min":99.99,"max":139.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500116011'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 6, id, '{"naziv":"Chipsy Domaćinski kajmak","kolicina":"145 g","slika":"https://images.openfoodfacts.org/images/products/860/603/374/2416/front_en.4.400.jpg","cena":195,"min":184.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606033742416'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 7, id, '{"naziv":"Smoki","kolicina":"250 g","slika":"https://images.openfoodfacts.org/images/products/860/093/950/7025/front_en.23.400.jpg","cena":185,"min":171.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939507025'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 8, id, '{"naziv":"Prolom voda","kolicina":"1,5 l","slika":"https://images.openfoodfacts.org/images/products/860/016/960/0022/front_en.27.400.jpg","cena":86,"min":82.66,"max":99.99,"najjeftinije":"Idea","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600169600022'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 9, id, '{"naziv":"Štark napolitanke sa čokoladom","kolicina":"180 g","slika":"https://images.openfoodfacts.org/images/products/860/093/911/0454/front_en.17.400.jpg","cena":147,"min":128.99,"max":159.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939110454'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-16', 2, 10, id, '{"naziv":"Zlatiborac kulen slajs","kolicina":"100 g","slika":"https://images.openfoodfacts.org/images/products/860/610/014/5775/front_sr.18.400.jpg","cena":271,"min":207.49,"max":309.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606100145775'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 1, id, '{"naziv":"Najlepše želje mlečna čokolada","kolicina":"90 g","slika":"https://images.openfoodfacts.org/images/products/860/093/931/3602/front_fr.22.400.jpg","cena":193,"min":189.99,"max":198.32,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939313602'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 2, id, '{"naziv":"Smoki","kolicina":"80 g","slika":"https://images.openfoodfacts.org/images/products/860/093/950/8190/front_en.3.400.jpg","cena":74,"min":69.99,"max":76.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939508190'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 3, id, '{"naziv":"Grand Gold kafa","kolicina":"500 g","slika":"https://images.openfoodfacts.org/images/products/860/010/305/6250/front_sr.8.400.jpg","cena":1104,"min":999.99,"max":1159.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600103056250'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 4, id, '{"naziv":"Dijamant majonez","kolicina":"285 ml","slika":"https://images.openfoodfacts.org/images/products/860/049/817/6359/front_sr.5.400.jpg","cena":192,"min":189.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498176359'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 5, id, '{"naziv":"Fruvita narandža 100%","kolicina":"0,8 l","slika":"https://images.openfoodfacts.org/images/products/860/603/005/1702/front_en.4.400.jpg","cena":317,"min":297.99,"max":349.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606030051702'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 6, id, '{"naziv":"Zlatiborac čvarci","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/610/682/2403/front_fr.3.400.jpg","cena":470,"min":436.99,"max":499.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606106822403'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 7, id, '{"naziv":"Plazma Kocka napolitanke","kolicina":"135 g","slika":"https://images.openfoodfacts.org/images/products/860/004/302/8263/front_fr.7.400.jpg","cena":206,"min":183.99,"max":219.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043028263'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 8, id, '{"naziv":"Zaječarsko pivo limenka","kolicina":"0,5 l","slika":"https://images.openfoodfacts.org/images/products/860/064/900/0427/front_de.3.400.jpg","cena":96,"min":89.99,"max":104.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600649000427'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 9, id, '{"naziv":"Doncafe Moment kafa","kolicina":"200 g","slika":"https://images.openfoodfacts.org/images/products/860/010/152/1439/front_en.5.400.jpg","cena":471,"min":449.99,"max":483.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600101521439'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-17', 2, 10, id, '{"naziv":"Knjaz Miloš gazirana voda","kolicina":"0,5 l","slika":"https://images.openfoodfacts.org/images/products/860/003/700/0312/front_fr.15.400.jpg","cena":55,"min":49.99,"max":57.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600037000312'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 1, id, '{"naziv":"Moja Kravica kisela pavlaka 20%","kolicina":"400 g","slika":"https://images.openfoodfacts.org/images/products/860/150/011/2419/front_en.15.400.jpg","cena":187,"min":179.99,"max":189.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500112419'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 2, id, '{"naziv":"Medela štrudla","kolicina":"240 g","slika":"https://images.openfoodfacts.org/images/products/860/010/400/4458/front_fr.37.400.jpg","cena":150,"min":139.99,"max":157.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600104004458'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 3, id, '{"naziv":"Dijamant suncokretovo ulje","kolicina":"1 l","slika":"https://images.openfoodfacts.org/images/products/860/049/817/0029/front_hu.6.400.jpg","cena":202,"min":195.66,"max":214.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498170029'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 4, id, '{"naziv":"Dijamant stoni margarin","kolicina":"250 g","slika":"https://images.openfoodfacts.org/images/products/860/049/817/2115/front_sr.14.400.jpg","cena":115,"min":104.99,"max":124.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498172115'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 5, id, '{"naziv":"Moja Kravica jogurt 2,8%","kolicina":"1,75 kg","slika":"https://images.openfoodfacts.org/images/products/860/150/013/8495/front_en.3.400.jpg","cena":233,"min":224.99,"max":240.09,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500138495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 6, id, '{"naziv":"Imlek protein čoko šejk","kolicina":"300 ml","slika":"https://images.openfoodfacts.org/images/products/860/150/013/3490/front_en.29.400.jpg","cena":180,"min":169.99,"max":189.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500133490'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 7, id, '{"naziv":"Pionir karamele lešnik","kolicina":"100 g","slika":"https://images.openfoodfacts.org/images/products/860/230/020/7305/front_en.3.400.jpg","cena":144,"min":132.99,"max":154.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300207305'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 8, id, '{"naziv":"Frikom Kapri sladoled","kolicina":"70 ml","slika":"https://images.openfoodfacts.org/images/products/860/600/608/0088/front_sr.30.400.jpg","cena":99,"min":89.99,"max":102.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080088'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 9, id, '{"naziv":"Eurocrem Euro blok","kolicina":"100 g","slika":"https://images.openfoodfacts.org/images/products/860/190/050/2100/front_sr.14.400.jpg","cena":121,"min":99.99,"max":137.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900502100'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-18', 2, 10, id, '{"naziv":"Jaffa keks","kolicina":"300 g","slika":"https://images.openfoodfacts.org/images/products/860/011/400/0211/front_en.45.400.jpg","cena":252,"min":249.69,"max":258.32,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000211'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 1, id, '{"naziv":"Smoki","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/093/950/6936/front_en.32.400.jpg","cena":129,"min":127.99,"max":129.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939506936'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 2, id, '{"naziv":"Moja Kravica jogurt čaša","kolicina":"180 g","slika":"https://images.openfoodfacts.org/images/products/860/150/011/5892/front_fr.4.400.jpg","cena":38,"min":35.99,"max":39.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500115892'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 3, id, '{"naziv":"Čoko Smoki","kolicina":"80 g","slika":"https://images.openfoodfacts.org/images/products/860/093/937/5563/front_en.34.400.jpg","cena":171,"min":149.99,"max":179.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939375563'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 4, id, '{"naziv":"Pionir Negro punjene bombone","kolicina":"250 g","slika":"https://images.openfoodfacts.org/images/products/860/230/023/3229/front_de.3.400.jpg","cena":264,"min":252.99,"max":286.16,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300233229'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 5, id, '{"naziv":"Plazma Rolsi lešnik","kolicina":"130 g","slika":"https://images.openfoodfacts.org/images/products/860/004/304/1484/front_fr.5.400.jpg","cena":186,"min":170.99,"max":212.49,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043041484'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 6, id, '{"naziv":"Carnex delikates viršla","kolicina":"205 g","slika":"https://images.openfoodfacts.org/images/products/860/001/250/2510/front_fr.3.400.jpg","cena":211,"min":196.99,"max":229.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012502510'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 7, id, '{"naziv":"Clipsy Mix flips","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/603/374/1495/front_hr.4.400.jpg","cena":149,"min":144.99,"max":156.66,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606033741495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 8, id, '{"naziv":"Pionir Medeno srce","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/230/023/6022/front_en.10.400.jpg","cena":146,"min":139.99,"max":153.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300236022'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 9, id, '{"naziv":"Plazma keks","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/004/300/0016/front_en.31.400.jpg","cena":158,"min":152.99,"max":159.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043000016'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-19', 2, 10, id, '{"naziv":"Moja Kravica maslac","kolicina":"125 g","slika":"https://images.openfoodfacts.org/images/products/860/150/011/1122/front_nl.3.400.jpg","cena":322,"min":315.99,"max":329.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500111122'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 1, id, '{"naziv":"Frikom Čoko Moko","kolicina":"52 g","slika":"https://images.openfoodfacts.org/images/products/860/600/608/0095/front_sr.4.400.jpg","cena":80,"min":79.99,"max":81.99,"najjeftinije":"Idea","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080095'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 2, id, '{"naziv":"Munchmallow","kolicina":"105 g","slika":"https://images.openfoodfacts.org/images/products/860/011/400/0020/front_en.46.400.jpg","cena":108,"min":102.99,"max":111.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000020'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 3, id, '{"naziv":"Štark Bananica 5 kom","kolicina":"125 g","slika":"https://images.openfoodfacts.org/images/products/860/093/936/5472/front_en.22.400.jpg","cena":139,"min":134.99,"max":141.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939365472'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 4, id, '{"naziv":"Smoki","kolicina":"50 g","slika":"https://images.openfoodfacts.org/images/products/860/093/950/6912/front_en.45.400.jpg","cena":48,"min":45.99,"max":49.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939506912'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 5, id, '{"naziv":"Plazma Stiksi","kolicina":"125 g","slika":"https://images.openfoodfacts.org/images/products/860/004/302/9512/front_en.3.400.jpg","cena":250,"min":217.99,"max":270.67,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043029512'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 6, id, '{"naziv":"Plazma keks","kolicina":"300 g","slika":"https://images.openfoodfacts.org/images/products/860/004/300/0023/front_en.57.400.jpg","cena":289,"min":279.99,"max":294.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043000023'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 7, id, '{"naziv":"Yuhor Alpska kobasica","kolicina":"350 g","slika":"https://images.openfoodfacts.org/images/products/860/008/400/5841/front_en.3.400.jpg","cena":303,"min":244.99,"max":339.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600084005841'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 8, id, '{"naziv":"Dijamant kečap blagi","kolicina":"500 g","slika":"https://images.openfoodfacts.org/images/products/860/049/815/0083/front_en.6.400.jpg","cena":161,"min":147.99,"max":179.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498150083'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 9, id, '{"naziv":"Carnex sarma","kolicina":"400 g","slika":"https://images.openfoodfacts.org/images/products/860/001/270/0336/front_en.14.400.jpg","cena":496,"min":469.99,"max":521.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012700336'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-20', 2, 10, id, '{"naziv":"Jelen pivo flaša","kolicina":"0,5 l","slika":"https://images.openfoodfacts.org/images/products/000/008/602/7618/front_en.7.400.jpg","cena":91,"min":89.99,"max":94.99,"najjeftinije":"Gomex","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '86027618'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 1, id, '{"naziv":"Moja Kravica sveže mleko 2,8%","kolicina":"1,75 l","slika":"https://images.openfoodfacts.org/images/products/860/150/013/8655/front_en.11.400.jpg","cena":227,"min":219.99,"max":230.62,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500138655'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 2, id, '{"naziv":"Jaffa napolitanke šlag i čokolada","kolicina":"187 g","slika":"https://images.openfoodfacts.org/images/products/860/011/400/6626/front_fr.10.400.jpg","cena":122,"min":109.99,"max":139.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114006626'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 3, id, '{"naziv":"Štark Bananica","kolicina":"250 g","slika":"https://images.openfoodfacts.org/images/products/860/093/936/6424/front_de.3.400.jpg","cena":256,"min":247.99,"max":269.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939366424'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 4, id, '{"naziv":"Čoko Smoki","kolicina":"80 g","slika":"https://images.openfoodfacts.org/images/products/860/093/937/5563/front_en.34.400.jpg","cena":171,"min":149.99,"max":179.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939375563'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 5, id, '{"naziv":"Swisslion Isleri sa Eurocremom","kolicina":"125 g","slika":"https://images.openfoodfacts.org/images/products/860/094/644/2111/front_en.9.400.jpg","cena":155,"min":129.99,"max":184.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600946442111'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 6, id, '{"naziv":"Pardon štapići sa kikirikijem","kolicina":"210 g","slika":"https://images.openfoodfacts.org/images/products/860/601/737/8822/front_en.3.400.jpg","cena":159,"min":137.99,"max":169.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017378822'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 7, id, '{"naziv":"Najlepše želje sa keksom","kolicina":"170 g","slika":"https://images.openfoodfacts.org/images/products/860/093/934/6082/front_fr.3.400.jpg","cena":353,"min":349.99,"max":363.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939346082'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 8, id, '{"naziv":"Moja Kravica maslac","kolicina":"125 g","slika":"https://images.openfoodfacts.org/images/products/860/150/011/1122/front_nl.3.400.jpg","cena":322,"min":315.99,"max":329.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500111122'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 9, id, '{"naziv":"Doncafe Moment kafa","kolicina":"200 g","slika":"https://images.openfoodfacts.org/images/products/860/010/152/1439/front_en.5.400.jpg","cena":471,"min":449.99,"max":483.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600101521439'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-21', 2, 10, id, '{"naziv":"Moja Kravica čokoladno mleko","kolicina":"0,25 l","slika":"https://images.openfoodfacts.org/images/products/860/150/011/0330/front_en.22.400.jpg","cena":68,"min":64.99,"max":69.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500110330'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 1, id, '{"naziv":"Jaffa keks","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/011/400/0013/front_en.28.400.jpg","cena":144,"min":139.99,"max":146.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000013'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 2, id, '{"naziv":"Neoplanta Pipi pileća viršla","kolicina":"205 g","slika":"https://images.openfoodfacts.org/images/products/860/076/365/5244/front_en.3.400.jpg","cena":194,"min":182.99,"max":209.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600763655244'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 3, id, '{"naziv":"Najlepše želje mlečna čokolada","kolicina":"200 g","slika":"https://images.openfoodfacts.org/images/products/860/093/931/3701/front_hr.25.400.jpg","cena":382,"min":364.99,"max":389.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939313701'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 4, id, '{"naziv":"Dijamant suncokretovo ulje","kolicina":"1 l","slika":"https://images.openfoodfacts.org/images/products/860/049/817/0029/front_hu.6.400.jpg","cena":202,"min":195.66,"max":214.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498170029'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 5, id, '{"naziv":"Grand Gold kafa","kolicina":"500 g","slika":"https://images.openfoodfacts.org/images/products/860/010/305/6250/front_sr.8.400.jpg","cena":1104,"min":999.99,"max":1159.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600103056250'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 6, id, '{"naziv":"Dijamant majonez","kolicina":"285 ml","slika":"https://images.openfoodfacts.org/images/products/860/049/817/6359/front_sr.5.400.jpg","cena":192,"min":189.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498176359'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 7, id, '{"naziv":"Yuhor Levački štapići","kolicina":"200 g","slika":"https://images.openfoodfacts.org/images/products/860/008/400/5612/front_en.3.400.jpg","cena":594,"min":557.99,"max":639.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600084005612'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 8, id, '{"naziv":"Imlek protein čoko šejk","kolicina":"300 ml","slika":"https://images.openfoodfacts.org/images/products/860/150/013/3490/front_en.29.400.jpg","cena":180,"min":169.99,"max":189.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500133490'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 9, id, '{"naziv":"Štark napolitanke sa čokoladom","kolicina":"180 g","slika":"https://images.openfoodfacts.org/images/products/860/093/911/0454/front_en.17.400.jpg","cena":147,"min":128.99,"max":159.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939110454'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-22', 2, 10, id, '{"naziv":"Plazma Rolsi lešnik","kolicina":"130 g","slika":"https://images.openfoodfacts.org/images/products/860/004/304/1484/front_fr.5.400.jpg","cena":186,"min":170.99,"max":212.49,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043041484'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 1, id, '{"naziv":"Jelen pivo flaša","kolicina":"0,5 l","slika":"https://images.openfoodfacts.org/images/products/000/008/602/7618/front_en.7.400.jpg","cena":91,"min":89.99,"max":94.99,"najjeftinije":"Gomex","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '86027618'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 2, id, '{"naziv":"Frikom Snesko","kolicina":"46 g","slika":"https://images.openfoodfacts.org/images/products/860/600/608/0040/front_sr.4.400.jpg","cena":76,"min":65.99,"max":80.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080040'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 3, id, '{"naziv":"Prolom voda","kolicina":"1,5 l","slika":"https://images.openfoodfacts.org/images/products/860/016/960/0022/front_en.27.400.jpg","cena":86,"min":82.66,"max":99.99,"najjeftinije":"Idea","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600169600022'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 4, id, '{"naziv":"Zlatiborac čvarci","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/610/682/2403/front_fr.3.400.jpg","cena":470,"min":436.99,"max":499.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606106822403'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 5, id, '{"naziv":"Knjaz Miloš staklo","kolicina":"0,25 l","slika":"https://images.openfoodfacts.org/images/products/860/003/700/8011/front_fr.3.400.jpg","cena":83,"min":77.99,"max":89.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600037008011'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 6, id, '{"naziv":"Pionir Medeno srce","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/230/023/6022/front_en.10.400.jpg","cena":146,"min":139.99,"max":153.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300236022'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 7, id, '{"naziv":"Moja Kravica kisela pavlaka 20%","kolicina":"400 g","slika":"https://images.openfoodfacts.org/images/products/860/150/011/2419/front_en.15.400.jpg","cena":187,"min":179.99,"max":189.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500112419'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 8, id, '{"naziv":"Moja Kravica čokoladno mleko","kolicina":"0,25 l","slika":"https://images.openfoodfacts.org/images/products/860/150/011/0330/front_en.22.400.jpg","cena":68,"min":64.99,"max":69.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500110330'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 9, id, '{"naziv":"Jaffa keks","kolicina":"300 g","slika":"https://images.openfoodfacts.org/images/products/860/011/400/0211/front_en.45.400.jpg","cena":252,"min":249.69,"max":258.32,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000211'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-23', 2, 10, id, '{"naziv":"Eurocrem Euro blok","kolicina":"50 g","slika":"https://images.openfoodfacts.org/images/products/860/190/050/2032/front_sr.10.400.jpg","cena":67,"min":59.99,"max":74.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900502032'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 1, id, '{"naziv":"Carnex pasulj sa slaninom","kolicina":"400 g","slika":"https://images.openfoodfacts.org/images/products/860/001/270/0282/front_hr.3.400.jpg","cena":359,"min":317.49,"max":403.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012700282'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 2, id, '{"naziv":"Frikom Kapri sladoled","kolicina":"70 ml","slika":"https://images.openfoodfacts.org/images/products/860/600/608/0088/front_sr.30.400.jpg","cena":99,"min":89.99,"max":102.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080088'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 3, id, '{"naziv":"Moja Kravica mleko dugotrajno 2,8%","kolicina":"1 l","slika":"https://images.openfoodfacts.org/images/products/860/150/011/6011/front_sr.23.400.jpg","cena":113,"min":99.99,"max":139.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500116011'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 4, id, '{"naziv":"Najlepše želje mlečna čokolada","kolicina":"200 g","slika":"https://images.openfoodfacts.org/images/products/860/093/931/3701/front_hr.25.400.jpg","cena":382,"min":364.99,"max":389.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939313701'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 5, id, '{"naziv":"Zlatiborac kulen slajs","kolicina":"100 g","slika":"https://images.openfoodfacts.org/images/products/860/610/014/5775/front_sr.18.400.jpg","cena":271,"min":207.49,"max":309.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606100145775'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 6, id, '{"naziv":"Pardon perece","kolicina":"95 g","slika":"https://images.openfoodfacts.org/images/products/860/601/737/0048/front_en.4.400.jpg","cena":81,"min":74.99,"max":88.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017370048'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 7, id, '{"naziv":"Yuhor Alpska kobasica","kolicina":"350 g","slika":"https://images.openfoodfacts.org/images/products/860/008/400/5841/front_en.3.400.jpg","cena":303,"min":244.99,"max":339.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600084005841'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 8, id, '{"naziv":"Smoki","kolicina":"250 g","slika":"https://images.openfoodfacts.org/images/products/860/093/950/7025/front_en.23.400.jpg","cena":185,"min":171.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939507025'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 9, id, '{"naziv":"Pionir Negro punjene bombone","kolicina":"250 g","slika":"https://images.openfoodfacts.org/images/products/860/230/023/3229/front_de.3.400.jpg","cena":264,"min":252.99,"max":286.16,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300233229'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-24', 2, 10, id, '{"naziv":"Knjaz Miloš gazirana voda","kolicina":"0,5 l","slika":"https://images.openfoodfacts.org/images/products/860/003/700/0312/front_fr.15.400.jpg","cena":55,"min":49.99,"max":57.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600037000312'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 1, id, '{"naziv":"Eurocrem činija","kolicina":"500 g","slika":"https://images.openfoodfacts.org/images/products/860/190/050/3411/front_en.3.400.jpg","cena":480,"min":399.99,"max":543.32,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900503411'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 2, id, '{"naziv":"Zaječarsko pivo limenka","kolicina":"0,5 l","slika":"https://images.openfoodfacts.org/images/products/860/064/900/0427/front_de.3.400.jpg","cena":96,"min":89.99,"max":104.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600649000427'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 3, id, '{"naziv":"Grand 3u1 Najlepše želje","kolicina":"18 g","slika":"https://images.openfoodfacts.org/images/products/860/601/831/2276/front_sr.3.400.jpg","cena":33,"min":28.99,"max":39.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606018312276'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 4, id, '{"naziv":"Najlepše želje crna sa bananicom","kolicina":"184 g","slika":"https://images.openfoodfacts.org/images/products/860/093/933/4171/front_sr.3.400.jpg","cena":367,"min":349.99,"max":389.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939334171'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 5, id, '{"naziv":"Chipsy Domaćinski kajmak","kolicina":"145 g","slika":"https://images.openfoodfacts.org/images/products/860/603/374/2416/front_en.4.400.jpg","cena":195,"min":184.99,"max":199.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606033742416'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 6, id, '{"naziv":"Ella sveži sir","kolicina":"400 g","slika":"https://images.openfoodfacts.org/images/products/860/150/012/6492/front_en.3.400.jpg","cena":282,"min":262.99,"max":299.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500126492'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 7, id, '{"naziv":"Štark Bananica 5 kom","kolicina":"125 g","slika":"https://images.openfoodfacts.org/images/products/860/093/936/5472/front_en.22.400.jpg","cena":139,"min":134.99,"max":141.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939365472'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 8, id, '{"naziv":"Najlepše želje sa keksom","kolicina":"170 g","slika":"https://images.openfoodfacts.org/images/products/860/093/934/6082/front_fr.3.400.jpg","cena":353,"min":349.99,"max":363.32,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939346082'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 9, id, '{"naziv":"Smoki","kolicina":"50 g","slika":"https://images.openfoodfacts.org/images/products/860/093/950/6912/front_en.45.400.jpg","cena":48,"min":45.99,"max":49.99,"najjeftinije":"Maxi","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939506912'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-25', 2, 10, id, '{"naziv":"Moja Kravica jogurt 2,8%","kolicina":"1,75 kg","slika":"https://images.openfoodfacts.org/images/products/860/150/013/8495/front_en.3.400.jpg","cena":233,"min":224.99,"max":240.09,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500138495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 1, id, '{"naziv":"Chipsy Classic","kolicina":"140 g","slika":"https://images.openfoodfacts.org/images/products/860/601/737/8495/front_nl.3.400.jpg","cena":192,"min":171.49,"max":214.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606017378495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 2, id, '{"naziv":"Smoki","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/093/950/6936/front_en.32.400.jpg","cena":129,"min":127.99,"max":129.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939506936'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 3, id, '{"naziv":"Frikom Čoko Moko","kolicina":"52 g","slika":"https://images.openfoodfacts.org/images/products/860/600/608/0095/front_sr.4.400.jpg","cena":80,"min":79.99,"max":81.99,"najjeftinije":"Idea","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606006080095'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 4, id, '{"naziv":"Knjaz Miloš gazirana voda","kolicina":"1,75 l","slika":"https://images.openfoodfacts.org/images/products/860/003/700/5133/front_sr.18.400.jpg","cena":65,"min":62.99,"max":65.59,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600037005133'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 5, id, '{"naziv":"Swisslion Isleri sa Eurocremom","kolicina":"125 g","slika":"https://images.openfoodfacts.org/images/products/860/094/644/2111/front_en.9.400.jpg","cena":155,"min":129.99,"max":184.99,"najjeftinije":"Univerexport","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600946442111'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 6, id, '{"naziv":"Carnex sarma","kolicina":"400 g","slika":"https://images.openfoodfacts.org/images/products/860/001/270/0336/front_en.14.400.jpg","cena":496,"min":469.99,"max":521.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600012700336'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 7, id, '{"naziv":"Dijamant kečap blagi","kolicina":"500 g","slika":"https://images.openfoodfacts.org/images/products/860/049/815/0083/front_en.6.400.jpg","cena":161,"min":147.99,"max":179.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498150083'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 8, id, '{"naziv":"Munchmallow","kolicina":"105 g","slika":"https://images.openfoodfacts.org/images/products/860/011/400/0020/front_en.46.400.jpg","cena":108,"min":102.99,"max":111.66,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600114000020'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 9, id, '{"naziv":"Plazma keks","kolicina":"300 g","slika":"https://images.openfoodfacts.org/images/products/860/004/300/0023/front_en.57.400.jpg","cena":289,"min":279.99,"max":294.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043000023'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-26', 2, 10, id, '{"naziv":"Pionir zeleni mentol bombone","kolicina":"100 g","slika":"https://images.openfoodfacts.org/images/products/860/230/020/0245/front_hr.10.400.jpg","cena":67,"min":59.99,"max":74.72,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8602300200245'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 1, id, '{"naziv":"Fruvita narandža 100%","kolicina":"0,8 l","slika":"https://images.openfoodfacts.org/images/products/860/603/005/1702/front_en.4.400.jpg","cena":317,"min":297.99,"max":349.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606030051702'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 2, id, '{"naziv":"Plazma mlevena","kolicina":"300 g","slika":"https://images.openfoodfacts.org/images/products/860/004/300/1105/front_en.45.400.jpg","cena":293,"min":279.99,"max":299.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043001105'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 3, id, '{"naziv":"Plazma keks","kolicina":"400 g","slika":"https://images.openfoodfacts.org/images/products/860/004/303/9788/front_sr.13.400.jpg","cena":388,"min":369.99,"max":401.66,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600043039788'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 4, id, '{"naziv":"Eurocrem Euro blok","kolicina":"100 g","slika":"https://images.openfoodfacts.org/images/products/860/190/050/2100/front_sr.14.400.jpg","cena":121,"min":99.99,"max":137.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601900502100'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 5, id, '{"naziv":"Clipsy Mix flips","kolicina":"150 g","slika":"https://images.openfoodfacts.org/images/products/860/603/374/1495/front_hr.4.400.jpg","cena":149,"min":144.99,"max":156.66,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8606033741495'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 6, id, '{"naziv":"Štark Menaž čokolada za kuvanje","kolicina":"100 g","slika":"https://images.openfoodfacts.org/images/products/860/093/930/3115/front_sr.34.400.jpg","cena":202,"min":192.99,"max":211.66,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939303115'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 7, id, '{"naziv":"Smoki","kolicina":"80 g","slika":"https://images.openfoodfacts.org/images/products/860/093/950/8190/front_en.3.400.jpg","cena":74,"min":69.99,"max":76.99,"najjeftinije":"Aman","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600939508190'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 8, id, '{"naziv":"Dijamant stoni margarin","kolicina":"250 g","slika":"https://images.openfoodfacts.org/images/products/860/049/817/2115/front_sr.14.400.jpg","cena":115,"min":104.99,"max":124.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8600498172115'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 9, id, '{"naziv":"Moja Kravica jogurt čaša","kolicina":"180 g","slika":"https://images.openfoodfacts.org/images/products/860/150/011/5892/front_fr.4.400.jpg","cena":38,"min":35.99,"max":39.99,"najjeftinije":"Super Vero","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '8601500115892'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, product_id, snapshot)
  select '2026-11-27', 2, 10, id, '{"naziv":"Carnex jetrena pašteta","kolicina":"75 g","slika":"https://images.openfoodfacts.org/images/products/000/008/600/2783/front_de.7.400.jpg","cena":89,"min":79.99,"max":99.99,"najjeftinije":"Lidl","datumCenovnika":"2026-11-13"}'::jsonb
  from public.products where barcode = '86002783'
  on conflict (quiz_date, segment, position) do nothing;

-- Isto što i migracija 0002: ponovljeno ovde da seed radi i ako ona nije puštena.
create unique index if not exists trend_pairs_par_idx on public.trend_pairs (term_a, term_b, period);

-- Parovi pojmova (trends.json). Postojeći se osvežavaju.
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Ćevapi', 'Pljeskavica', 100, 89, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Ćevapi', 'Burek', 59, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Gibanica', 'Ćevapi', 60, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Burek', 'Pljeskavica', 100, 52, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pljeskavica', 'Gibanica', 100, 67, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Burek', 'Sarma', 100, 53, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Burek', 'Gibanica', 100, 35, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Gibanica', 'Sarma', 66, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Novi Sad', 'Kragujevac', 100, 29, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Subotica', 'Novi Sad', 21, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Novi Sad', 'Čačak', 100, 17, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kragujevac', 'Subotica', 100, 74, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Čačak', 'Kragujevac', 58, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kragujevac', 'Zaječar', 100, 15, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Subotica', 'Čačak', 100, 78, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Zaječar', 'Subotica', 21, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Čačak', 'Zaječar', 100, 26, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Zlatibor', 'Kopaonik', 100, 40, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Divčibare', 'Zlatibor', 17, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kopaonik', 'Divčibare', 100, 44, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Stara planina', 'Kopaonik', 17, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kopaonik', 'Fruška gora', 100, 22, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Divčibare', 'Stara planina', 100, 38, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Fruška gora', 'Divčibare', 50, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Stara planina', 'Fruška gora', 76, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Sokobanja', 'Vrnjačka Banja', 56, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Banja Koviljača', 'Vrnjačka Banja', 11, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Banja Koviljača', 'Sokobanja', 21, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Sokobanja', 'Prolom Banja', 100, 12, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Sokobanja', 'Ribarska Banja', 100, 16, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Banja Koviljača', 'Prolom Banja', 100, 59, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Banja Koviljača', 'Ribarska Banja', 100, 76, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Ribarska Banja', 'Prolom Banja', 100, 78, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Turska', 'Grčka', 100, 82, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Egipat', 'Grčka', 21, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Crna Gora', 'Turska', 83, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Crna Gora', 'Egipat', 100, 20, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Egipat', 'Turska', 17, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Hrvatska', 'Turska', 87, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Hrvatska', 'Egipat', 100, 20, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Nikola Jokić', 'Dušan Vlahović', 100, 53, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Nikola Jokić', 'Bogdan Bogdanović', 100, 48, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Košarka', 'Fudbal', 63, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Fudbal', 'Tenis', 100, 46, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Odbojka', 'Fudbal', 22, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vaterpolo', 'Fudbal', 30, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Košarka', 'Tenis', 100, 73, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Odbojka', 'Košarka', 35, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vaterpolo', 'Košarka', 47, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Tenis', 'Odbojka', 100, 48, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Tenis', 'Vaterpolo', 100, 64, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vaterpolo', 'Odbojka', 100, 74, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Ceca', 'Aca Lukas', 100, 36, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Ceca', 'Zdravko Čolić', 100, 34, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Lepa Brena', 'Ceca', 27, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Aca Lukas', 'Lepa Brena', 100, 75, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Željko Joksimović', 'Aca Lukas', 21, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Zdravko Čolić', 'Lepa Brena', 100, 77, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Željko Joksimović', 'Zdravko Čolić', 21, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Lepa Brena', 'Željko Joksimović', 100, 28, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kafa', 'Čaj', 78, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kafa', 'Pivo', 100, 78, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kafa', 'Rakija', 100, 71, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pivo', 'Čaj', 61, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vino', 'Čaj', 83, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Rakija', 'Čaj', 56, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vino', 'Pivo', 100, 74, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Rakija', 'Vino', 67, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('BMW', 'Audi', 100, 81, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Mercedes', 'BMW', 60, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Opel', 'BMW', 49, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Škoda', 'BMW', 31, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Audi', 'Mercedes', 100, 74, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Audi', 'Opel', 100, 61, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Audi', 'Škoda', 100, 38, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Opel', 'Mercedes', 83, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Škoda', 'Mercedes', 51, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Škoda', 'Opel', 62, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Halo oglasi', 'KupujemProdajem', 20, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('KupujemProdajem', 'Limundo', 100, 12, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Polovni automobili', 'Halo oglasi', 100, 18, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Limundo', 'Polovni automobili', 12, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Halo oglasi', 'Limundo', 100, 63, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Halo oglasi', 'Kupindo', 100, 35, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kupindo', 'Limundo', 54, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Palačinke', 'Krofne', 100, 32, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Baklava', 'Palačinke', 22, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vanilice', 'Krofne', 24, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krofne', 'Baklava', 100, 69, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vanilice', 'Baklava', 34, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Vanilice', 'Tulumbe', 100, 39, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Tulumbe', 'Baklava', 14, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Božić', 'Slava', 65, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Slava', 'Uskrs', 86, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Slava', 'Nova godina', 100, 89, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Božić', 'Uskrs', 56, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Božić', 'Nova godina', 74, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Nova godina', 'Uskrs', 77, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Loto', 'Vremenska prognoza', 10, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kurs evra', 'Horoskop', 43, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Horoskop', 'Loto', 87, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kurs evra', 'Loto', 37, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Jabuka', 'Šljiva', 100, 53, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Malina', 'Jabuka', 56, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Jabuka', 'Lubenica', 100, 21, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Jabuka', 'Grožđe', 100, 20, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Lubenica', 'Šljiva', 40, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Grožđe', 'Šljiva', 38, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Malina', 'Lubenica', 100, 38, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Malina', 'Grožđe', 100, 36, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('iPhone', 'Samsung', 100, 70, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Xiaomi', 'iPhone', 40, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Huawei', 'iPhone', 12, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Samsung', 'Xiaomi', 100, 57, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Samsung', 'Huawei', 100, 17, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Huawei', 'Xiaomi', 31, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Xiaomi', 'Nokia', 100, 13, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Huawei', 'Nokia', 100, 42, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Facebook', 'Instagram', 100, 64, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('TikTok', 'Instagram', 40, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Viber', 'Instagram', 11, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('WhatsApp', 'Instagram', 18, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('TikTok', 'Facebook', 26, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('WhatsApp', 'Facebook', 11, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Viber', 'TikTok', 27, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('WhatsApp', 'TikTok', 44, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('WhatsApp', 'Viber', 100, 60, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Paradajz', 'Krastavac', 100, 20, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Paradajz', 'Kupus', 100, 87, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krastavac', 'Paprika', 20, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kupus', 'Paprika', 86, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Kupus', 'Krastavac', 100, 23, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krompir', 'Krastavac', 100, 18, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Krompir', 'Kupus', 100, 80, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pasulj', 'Gulaš', 100, 54, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pasulj', 'Musaka', 100, 62, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Punjene paprike', 'Pasulj', 37, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Pasulj', 'Podvarak', 100, 26, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Musaka', 'Gulaš', 100, 87, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Gulaš', 'Punjene paprike', 100, 69, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Podvarak', 'Gulaš', 48, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Musaka', 'Punjene paprike', 100, 60, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Podvarak', 'Musaka', 42, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Punjene paprike', 'Podvarak', 100, 70, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Matematika', 'Srpski jezik', 100, 50, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Matematika', 'Engleski jezik', 100, 15, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Matematika', 'Istorija', 100, 76, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Matematika', 'Geografija', 100, 27, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Engleski jezik', 'Srpski jezik', 30, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Istorija', 'Srpski jezik', 100, 65, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Geografija', 'Srpski jezik', 55, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Istorija', 'Engleski jezik', 100, 20, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Geografija', 'Engleski jezik', 100, 56, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Geografija', 'Istorija', 35, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Klima', 'Frižider', 100, 37, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Klima', 'Veš mašina', 100, 31, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Klima', 'Šporet', 100, 27, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Klima', 'Usisivač', 100, 59, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Veš mašina', 'Frižider', 85, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Šporet', 'Frižider', 73, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Usisivač', 'Frižider', 100, 63, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Šporet', 'Veš mašina', 86, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Usisivač', 'Veš mašina', 100, 53, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Usisivač', 'Šporet', 100, 46, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Lala', 'Ruža', 25, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Orhideja', 'Ruža', 21, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Božur', 'Ruža', 25, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Orhideja', 'Lala', 83, 100, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;
insert into public.trend_pairs (term_a, term_b, index_a, index_b, period, fetched_on)
  values ('Božur', 'Orhideja', 100, 82, '13.11.2025 – 13.11.2026', '2026-11-13')
  on conflict (term_a, term_b, period) do update set index_a = excluded.index_a, index_b = excluded.index_b, fetched_on = excluded.fetched_on;

-- Dnevni kviz: segment 3 (Šta se više gugla).
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-14', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 1, id, '{"a":"Usisivač","b":"Šporet","indeksA":100,"indeksB":46,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Usisivač' and term_b = 'Šporet' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 2, id, '{"a":"Istorija","b":"Engleski jezik","indeksA":100,"indeksB":20,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Istorija' and term_b = 'Engleski jezik' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 3, id, '{"a":"BMW","b":"Audi","indeksA":100,"indeksB":81,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'BMW' and term_b = 'Audi' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 4, id, '{"a":"Gibanica","b":"Sarma","indeksA":66,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Gibanica' and term_b = 'Sarma' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 5, id, '{"a":"Košarka","b":"Fudbal","indeksA":63,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Košarka' and term_b = 'Fudbal' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 6, id, '{"a":"Limundo","b":"Polovni automobili","indeksA":12,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Limundo' and term_b = 'Polovni automobili' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 7, id, '{"a":"Musaka","b":"Punjene paprike","indeksA":100,"indeksB":60,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Musaka' and term_b = 'Punjene paprike' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-14', 3, 8, id, '{"a":"Kragujevac","b":"Zaječar","indeksA":100,"indeksB":15,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Kragujevac' and term_b = 'Zaječar' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-15', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 1, id, '{"a":"Ribarska Banja","b":"Prolom Banja","indeksA":100,"indeksB":78,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Ribarska Banja' and term_b = 'Prolom Banja' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 2, id, '{"a":"Veš mašina","b":"Frižider","indeksA":85,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Veš mašina' and term_b = 'Frižider' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 3, id, '{"a":"Vino","b":"Pivo","indeksA":100,"indeksB":74,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Vino' and term_b = 'Pivo' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 4, id, '{"a":"Odbojka","b":"Fudbal","indeksA":22,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Odbojka' and term_b = 'Fudbal' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 5, id, '{"a":"Zlatibor","b":"Kopaonik","indeksA":100,"indeksB":40,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Zlatibor' and term_b = 'Kopaonik' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 6, id, '{"a":"Samsung","b":"Xiaomi","indeksA":100,"indeksB":57,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Samsung' and term_b = 'Xiaomi' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 7, id, '{"a":"TikTok","b":"Facebook","indeksA":26,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'TikTok' and term_b = 'Facebook' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-15', 3, 8, id, '{"a":"Audi","b":"Škoda","indeksA":100,"indeksB":38,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Audi' and term_b = 'Škoda' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-16', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 1, id, '{"a":"Pasulj","b":"Podvarak","indeksA":100,"indeksB":26,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Pasulj' and term_b = 'Podvarak' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 2, id, '{"a":"Klima","b":"Šporet","indeksA":100,"indeksB":27,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Klima' and term_b = 'Šporet' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 3, id, '{"a":"Facebook","b":"Instagram","indeksA":100,"indeksB":64,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Facebook' and term_b = 'Instagram' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 4, id, '{"a":"Matematika","b":"Geografija","indeksA":100,"indeksB":27,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Matematika' and term_b = 'Geografija' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 5, id, '{"a":"Banja Koviljača","b":"Prolom Banja","indeksA":100,"indeksB":59,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Banja Koviljača' and term_b = 'Prolom Banja' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 6, id, '{"a":"Divčibare","b":"Stara planina","indeksA":100,"indeksB":38,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Divčibare' and term_b = 'Stara planina' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 7, id, '{"a":"Egipat","b":"Grčka","indeksA":21,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Egipat' and term_b = 'Grčka' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-16', 3, 8, id, '{"a":"Čačak","b":"Zaječar","indeksA":100,"indeksB":26,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Čačak' and term_b = 'Zaječar' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-17', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 1, id, '{"a":"Zdravko Čolić","b":"Lepa Brena","indeksA":100,"indeksB":77,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Zdravko Čolić' and term_b = 'Lepa Brena' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 2, id, '{"a":"Škoda","b":"Opel","indeksA":62,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Škoda' and term_b = 'Opel' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 3, id, '{"a":"Punjene paprike","b":"Pasulj","indeksA":37,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Punjene paprike' and term_b = 'Pasulj' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 4, id, '{"a":"Subotica","b":"Čačak","indeksA":100,"indeksB":78,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Subotica' and term_b = 'Čačak' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 5, id, '{"a":"WhatsApp","b":"Instagram","indeksA":18,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'WhatsApp' and term_b = 'Instagram' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 6, id, '{"a":"Ćevapi","b":"Pljeskavica","indeksA":100,"indeksB":89,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Ćevapi' and term_b = 'Pljeskavica' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 7, id, '{"a":"Fudbal","b":"Tenis","indeksA":100,"indeksB":46,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Fudbal' and term_b = 'Tenis' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-17', 3, 8, id, '{"a":"Jabuka","b":"Lubenica","indeksA":100,"indeksB":21,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Jabuka' and term_b = 'Lubenica' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-18', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 1, id, '{"a":"Željko Joksimović","b":"Zdravko Čolić","indeksA":21,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Željko Joksimović' and term_b = 'Zdravko Čolić' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 2, id, '{"a":"Vaterpolo","b":"Košarka","indeksA":47,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Vaterpolo' and term_b = 'Košarka' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 3, id, '{"a":"Grožđe","b":"Šljiva","indeksA":38,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Grožđe' and term_b = 'Šljiva' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 4, id, '{"a":"Božić","b":"Uskrs","indeksA":56,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Božić' and term_b = 'Uskrs' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 5, id, '{"a":"Kafa","b":"Čaj","indeksA":78,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Kafa' and term_b = 'Čaj' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 6, id, '{"a":"Paradajz","b":"Kupus","indeksA":100,"indeksB":87,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Paradajz' and term_b = 'Kupus' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 7, id, '{"a":"Geografija","b":"Istorija","indeksA":35,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Geografija' and term_b = 'Istorija' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-18', 3, 8, id, '{"a":"Musaka","b":"Gulaš","indeksA":100,"indeksB":87,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Musaka' and term_b = 'Gulaš' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-19', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 1, id, '{"a":"Audi","b":"Opel","indeksA":100,"indeksB":61,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Audi' and term_b = 'Opel' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 2, id, '{"a":"Jabuka","b":"Grožđe","indeksA":100,"indeksB":20,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Jabuka' and term_b = 'Grožđe' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 3, id, '{"a":"Kopaonik","b":"Divčibare","indeksA":100,"indeksB":44,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Kopaonik' and term_b = 'Divčibare' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 4, id, '{"a":"Kupindo","b":"Limundo","indeksA":54,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Kupindo' and term_b = 'Limundo' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 5, id, '{"a":"Xiaomi","b":"Nokia","indeksA":100,"indeksB":13,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Xiaomi' and term_b = 'Nokia' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 6, id, '{"a":"Zaječar","b":"Subotica","indeksA":21,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Zaječar' and term_b = 'Subotica' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 7, id, '{"a":"Usisivač","b":"Frižider","indeksA":100,"indeksB":63,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Usisivač' and term_b = 'Frižider' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-19', 3, 8, id, '{"a":"Turska","b":"Grčka","indeksA":100,"indeksB":82,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Turska' and term_b = 'Grčka' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-20', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 1, id, '{"a":"Pasulj","b":"Gulaš","indeksA":100,"indeksB":54,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Pasulj' and term_b = 'Gulaš' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 2, id, '{"a":"Geografija","b":"Engleski jezik","indeksA":100,"indeksB":56,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Geografija' and term_b = 'Engleski jezik' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 3, id, '{"a":"Klima","b":"Usisivač","indeksA":100,"indeksB":59,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Klima' and term_b = 'Usisivač' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 4, id, '{"a":"Ćevapi","b":"Burek","indeksA":59,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Ćevapi' and term_b = 'Burek' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 5, id, '{"a":"Rakija","b":"Čaj","indeksA":56,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Rakija' and term_b = 'Čaj' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 6, id, '{"a":"Viber","b":"Instagram","indeksA":11,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Viber' and term_b = 'Instagram' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 7, id, '{"a":"Audi","b":"Mercedes","indeksA":100,"indeksB":74,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Audi' and term_b = 'Mercedes' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-20', 3, 8, id, '{"a":"Vaterpolo","b":"Odbojka","indeksA":100,"indeksB":74,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Vaterpolo' and term_b = 'Odbojka' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-21', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 1, id, '{"a":"Tulumbe","b":"Baklava","indeksA":14,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Tulumbe' and term_b = 'Baklava' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 2, id, '{"a":"Gulaš","b":"Punjene paprike","indeksA":100,"indeksB":69,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Gulaš' and term_b = 'Punjene paprike' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 3, id, '{"a":"Malina","b":"Jabuka","indeksA":56,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Malina' and term_b = 'Jabuka' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 4, id, '{"a":"Huawei","b":"Nokia","indeksA":100,"indeksB":42,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Huawei' and term_b = 'Nokia' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 5, id, '{"a":"Banja Koviljača","b":"Ribarska Banja","indeksA":100,"indeksB":76,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Banja Koviljača' and term_b = 'Ribarska Banja' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 6, id, '{"a":"Pljeskavica","b":"Gibanica","indeksA":100,"indeksB":67,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Pljeskavica' and term_b = 'Gibanica' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 7, id, '{"a":"WhatsApp","b":"TikTok","indeksA":44,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'WhatsApp' and term_b = 'TikTok' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-21', 3, 8, id, '{"a":"Egipat","b":"Turska","indeksA":17,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Egipat' and term_b = 'Turska' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-22', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 1, id, '{"a":"Tenis","b":"Odbojka","indeksA":100,"indeksB":48,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Tenis' and term_b = 'Odbojka' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 2, id, '{"a":"Sokobanja","b":"Ribarska Banja","indeksA":100,"indeksB":16,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Sokobanja' and term_b = 'Ribarska Banja' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 3, id, '{"a":"Vanilice","b":"Krofne","indeksA":24,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Vanilice' and term_b = 'Krofne' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 4, id, '{"a":"Matematika","b":"Srpski jezik","indeksA":100,"indeksB":50,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Matematika' and term_b = 'Srpski jezik' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 5, id, '{"a":"Orhideja","b":"Ruža","indeksA":21,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Orhideja' and term_b = 'Ruža' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 6, id, '{"a":"TikTok","b":"Instagram","indeksA":40,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'TikTok' and term_b = 'Instagram' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 7, id, '{"a":"Rakija","b":"Vino","indeksA":67,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Rakija' and term_b = 'Vino' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-22', 3, 8, id, '{"a":"Kopaonik","b":"Fruška gora","indeksA":100,"indeksB":22,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Kopaonik' and term_b = 'Fruška gora' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-23', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 1, id, '{"a":"Krastavac","b":"Paprika","indeksA":20,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Krastavac' and term_b = 'Paprika' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 2, id, '{"a":"Škoda","b":"Mercedes","indeksA":51,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Škoda' and term_b = 'Mercedes' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 3, id, '{"a":"Klima","b":"Veš mašina","indeksA":100,"indeksB":31,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Klima' and term_b = 'Veš mašina' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 4, id, '{"a":"Ceca","b":"Zdravko Čolić","indeksA":100,"indeksB":34,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Ceca' and term_b = 'Zdravko Čolić' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 5, id, '{"a":"Novi Sad","b":"Kragujevac","indeksA":100,"indeksB":29,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Novi Sad' and term_b = 'Kragujevac' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 6, id, '{"a":"Podvarak","b":"Gulaš","indeksA":48,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Podvarak' and term_b = 'Gulaš' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 7, id, '{"a":"Nova godina","b":"Uskrs","indeksA":77,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Nova godina' and term_b = 'Uskrs' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-23', 3, 8, id, '{"a":"Halo oglasi","b":"KupujemProdajem","indeksA":20,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Halo oglasi' and term_b = 'KupujemProdajem' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-24', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 1, id, '{"a":"Matematika","b":"Engleski jezik","indeksA":100,"indeksB":15,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Matematika' and term_b = 'Engleski jezik' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 2, id, '{"a":"Paradajz","b":"Krastavac","indeksA":100,"indeksB":20,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Paradajz' and term_b = 'Krastavac' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 3, id, '{"a":"Čačak","b":"Kragujevac","indeksA":58,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Čačak' and term_b = 'Kragujevac' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 4, id, '{"a":"Vanilice","b":"Tulumbe","indeksA":100,"indeksB":39,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Vanilice' and term_b = 'Tulumbe' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 5, id, '{"a":"Halo oglasi","b":"Kupindo","indeksA":100,"indeksB":35,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Halo oglasi' and term_b = 'Kupindo' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 6, id, '{"a":"Aca Lukas","b":"Lepa Brena","indeksA":100,"indeksB":75,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Aca Lukas' and term_b = 'Lepa Brena' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 7, id, '{"a":"Šporet","b":"Veš mašina","indeksA":86,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Šporet' and term_b = 'Veš mašina' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-24', 3, 8, id, '{"a":"Kafa","b":"Rakija","indeksA":100,"indeksB":71,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Kafa' and term_b = 'Rakija' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-25', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 1, id, '{"a":"Hrvatska","b":"Turska","indeksA":87,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Hrvatska' and term_b = 'Turska' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 2, id, '{"a":"Stara planina","b":"Fruška gora","indeksA":76,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Stara planina' and term_b = 'Fruška gora' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 3, id, '{"a":"Kurs evra","b":"Loto","indeksA":37,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Kurs evra' and term_b = 'Loto' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 4, id, '{"a":"Malina","b":"Lubenica","indeksA":100,"indeksB":38,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Malina' and term_b = 'Lubenica' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 5, id, '{"a":"Krompir","b":"Kupus","indeksA":100,"indeksB":80,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Krompir' and term_b = 'Kupus' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 6, id, '{"a":"Kragujevac","b":"Subotica","indeksA":100,"indeksB":74,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Kragujevac' and term_b = 'Subotica' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 7, id, '{"a":"Samsung","b":"Huawei","indeksA":100,"indeksB":17,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Samsung' and term_b = 'Huawei' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-25', 3, 8, id, '{"a":"Geografija","b":"Srpski jezik","indeksA":55,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Geografija' and term_b = 'Srpski jezik' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-26', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 1, id, '{"a":"Istorija","b":"Srpski jezik","indeksA":100,"indeksB":65,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Istorija' and term_b = 'Srpski jezik' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 2, id, '{"a":"Kupus","b":"Paprika","indeksA":86,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Kupus' and term_b = 'Paprika' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 3, id, '{"a":"Lepa Brena","b":"Željko Joksimović","indeksA":100,"indeksB":28,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Lepa Brena' and term_b = 'Željko Joksimović' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 4, id, '{"a":"Klima","b":"Frižider","indeksA":100,"indeksB":37,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Klima' and term_b = 'Frižider' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 5, id, '{"a":"Krofne","b":"Baklava","indeksA":100,"indeksB":69,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Krofne' and term_b = 'Baklava' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 6, id, '{"a":"Crna Gora","b":"Turska","indeksA":83,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Crna Gora' and term_b = 'Turska' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 7, id, '{"a":"Odbojka","b":"Košarka","indeksA":35,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Odbojka' and term_b = 'Košarka' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-26', 3, 8, id, '{"a":"Huawei","b":"iPhone","indeksA":12,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Huawei' and term_b = 'iPhone' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz (quiz_date, status, published_at) values ('2026-11-27', 'published', now())
  on conflict (quiz_date) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 1, id, '{"a":"iPhone","b":"Samsung","indeksA":100,"indeksB":70,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'iPhone' and term_b = 'Samsung' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 2, id, '{"a":"Slava","b":"Uskrs","indeksA":86,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Slava' and term_b = 'Uskrs' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 3, id, '{"a":"Viber","b":"TikTok","indeksA":27,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Viber' and term_b = 'TikTok' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 4, id, '{"a":"Orhideja","b":"Lala","indeksA":83,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Orhideja' and term_b = 'Lala' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 5, id, '{"a":"Lubenica","b":"Šljiva","indeksA":40,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Lubenica' and term_b = 'Šljiva' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 6, id, '{"a":"Loto","b":"Vremenska prognoza","indeksA":10,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Loto' and term_b = 'Vremenska prognoza' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 7, id, '{"a":"Lepa Brena","b":"Ceca","indeksA":27,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Lepa Brena' and term_b = 'Ceca' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
insert into public.daily_quiz_items (quiz_date, segment, position, trend_pair_id, snapshot)
  select '2026-11-27', 3, 8, id, '{"a":"Vaterpolo","b":"Fudbal","indeksA":30,"indeksB":100,"period":"13.11.2025 – 13.11.2026","preuzeto":"2026-11-13"}'::jsonb
  from public.trend_pairs where term_a = 'Vaterpolo' and term_b = 'Fudbal' and period = '13.11.2025 – 13.11.2026'
  on conflict (quiz_date, segment, position) do nothing;
