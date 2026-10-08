-- Jalankan di Supabase > SQL Editor
create table settings(
  id int primary key default 1 check (id=1),
  event_name text not null default 'Pernikahan Kami',
  reveal_at timestamptz not null default now() + interval '7 days',
  max_shots int not null default 8
);
insert into settings default values;

create table photos(
  id uuid primary key default gen_random_uuid(),
  guest_id text not null,
  guest_name text not null,
  path text not null,
  created_at timestamptz not null default now()
);

alter table settings enable row level security;
alter table photos enable row level security;

create policy "tamu baca settings" on settings for select using (true);
create policy "admin kelola settings" on settings for all to authenticated using (true) with check (true);
create policy "tamu tambah foto" on photos for insert to anon with check (true);
create policy "tamu lihat foto setelah reveal" on photos for select to anon
  using (now() >= (select reveal_at from settings where id=1));
create policy "admin kelola foto" on photos for all to authenticated using (true) with check (true);

insert into storage.buckets(id,name,public) values('photos','photos',true);
create policy "tamu upload" on storage.objects for insert to anon with check (bucket_id='photos');
create policy "admin kelola storage" on storage.objects for all to authenticated
  using (bucket_id='photos') with check (bucket_id='photos');
