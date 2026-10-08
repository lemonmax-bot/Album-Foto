-- Jalankan SEKALI di Supabase > SQL Editor (setelah setup.sql)
alter table photos add constraint photos_path_key unique(path);
create index if not exists photos_guest_idx on photos(guest_id);
create index if not exists photos_created_idx on photos(created_at);

create or replace function check_quota() returns trigger
language plpgsql security definer set search_path = public as $$
declare m int; n int;
begin
  select max_shots into m from settings where id=1;
  select count(*) into n from photos where guest_id=new.guest_id;
  if n >= m then raise exception 'jatah foto habis'; end if;
  return new;
end $$;
create trigger photos_quota before insert on photos for each row execute function check_quota();

-- 5 foto per tamu, album langsung terbuka
update settings set max_shots=5, reveal_at=now() where id=1;
