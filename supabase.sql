-- Ejecutá este script en Supabase > SQL Editor > New query.
create table if not exists public.movements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  kind text not null check (kind in ('income','expense')),
  amount numeric(12,2) not null check (amount > 0),
  category text,
  note text,
  entry_date date not null default current_date,
  created_at timestamptz not null default now()
);

alter table public.movements enable row level security;

drop policy if exists "Users can read their own movements" on public.movements;
create policy "Users can read their own movements"
on public.movements for select to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists "Users can insert their own movements" on public.movements;
create policy "Users can insert their own movements"
on public.movements for insert to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own movements" on public.movements;
create policy "Users can delete their own movements"
on public.movements for delete to authenticated
using ((select auth.uid()) = user_id);

grant select, insert, delete on public.movements to authenticated;
