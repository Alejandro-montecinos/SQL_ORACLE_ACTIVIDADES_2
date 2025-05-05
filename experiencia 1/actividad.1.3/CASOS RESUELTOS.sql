// caso 1

SELECT * FROM cliente;
select * from profesion_oficio;

select 

c.numrun||'-'||c.dvrun,
c.pnombre||' '||c.snombre||' '||c.appaterno||' '||c.apmaterno,
po.nombre_prof_ofic,
to_char(c.fecha_nacimiento,'DD "de" month')


FROM cliente c  join profesion_oficio po 
USING(cod_prof_ofic)
where (extract(month from sysdate)+5) = extract (month from c.fecha_nacimiento)
order by extract(day from c.fecha_nacimiento);


//caso 2

select 
REPLACE(TO_CHAR(c.numrun,'999G999G999'),',','.')||'-'||UPPER(c.dvrun) as "RUN CLIENTE",
c.pnombre ||' '||c.snombre||' '||c.appaterno||' '||c.apmaterno as "NOMBRE CLIENTE",
REPLACE(TO_CHAR(cc.monto_solicitado,'999G999G999'),',','.') as "MONTO SOLICITADO CREDITOS",
REPLACE(TO_CHAR((cc.monto_solicitado/100000)*1200,'999G999G999'),',','.') as "TOTAL PESSO TODO SUMA"

from credito_cliente cc  join cliente c on(cc.nro_cliente = c.nro_cliente);


//CASO 3

SELECT 


TO_CHAR(cc.fecha_otorga_cred,'MM')||''||TO_CHAR(cc.fecha_otorga_cred,'YYYY'),
ct.nombre_credito,
cc.monto_solicitado AS "MONTO SOLICITADO CREDITO",

case
    when cc.monto_credito between 100000 and 1000000 then cc.monto_credito * 1.01
    when cc.monto_credito between 1000001 and 2000000 then cc.monto_credito * 1.02
    when cc.monto_credito between 2000001 and 4000000 then cc.monto_credito * 1.03
    when cc.monto_credito between 4000001 and 6000000 then cc.monto_credito * 1.04
    when cc.monto_credito >6000000 then cc.monto_credito * 1.07
    else cc.monto_credito 
end as "APORTE A LA SBIF"


FROM credito_cliente cc join credito ct on(cc.cod_credito = ct.cod_credito)
WHERE EXTRACT(YEAR FROM cc.fecha_otorga_cred) = EXTRACT(YEAR FROM SYSDATE)-1
ORDER BY cc.fecha_otorga_cred ASC;



