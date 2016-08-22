insert into tse_data (
  cpf,
  born_at,
  "number",
  male,
  party_id,
  city_id,
  electoral_title,
  created_at,
  updated_at
)
select 
    can.cpf
    , can.nascimento
    , can.numero_candidato
    , can.sexo = 'MASCULINO'
    , can.numero_partido
    , (select c.id from cities c where c.name ilike can.cidade and c.state = can.uf ) as cidade
    , can.titulo_eleitoral as varchar
    , current_date
    , current_date
  from tse.candidate can
