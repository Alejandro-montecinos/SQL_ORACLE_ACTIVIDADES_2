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


TO_CHAR(cc.fecha_otorga_cred,'MM')||''||TO_CHAR(cc.fecha_otorga_cred,'YYYY') as "MES TRANSACCION",
ct.nombre_credito AS "TIPO CREDITO",
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
ORDER BY extract( month from cc.fecha_otorga_cred) asc , ct.nombre_credito asc ;

//caso 4
SELECT
REPLACE(TO_CHAR(c.numrun,'999G999G999'),',','.')||'-'||UPPER(c.dvrun) as "RUN CLIENTE",
c.pnombre ||' '||c.snombre||' '||c.appaterno||' '||c.apmaterno as "NOMBRE CLIENTE",
pic.monto_total_ahorrado,
case
    WHEN pic.monto_total_ahorrado between 100000 and 1000000 then  'BRONCE'
    WHEN pic.monto_total_ahorrado between 1000001 and 4000000 then  'PLATA'
    WHEN pic.monto_total_ahorrado between 4000001 and 8000000 then  'SILVER'
    WHEN pic.monto_total_ahorrado between 8000001 and 15000000 then  'GOLD'
    WHEN pic.monto_total_ahorrado > 15000000 then  'PLATINIUM'
    ELSE 'NO ENTRA DENTRO DEL RANGO'
END as "CATEGORIA CLIENTE"

 FROM cliente c join producto_inversion_cliente pic on(pic.nro_cliente = c.nro_cliente)
 order by c.appaterno asc , pic.monto_total_ahorrado desc;

// caso 5


SELECT 

EXTRACT(year from sysdate),
REPLACE(TO_CHAR(c.numrun,'909G999G999'),',','.')||'-'||UPPER(c.dvrun) as "RUN CLIENTE",
c.pnombre ||' '||substr(c.snombre,1,1)||'. '||c.appaterno||' '||c.apmaterno as "NOMBRE CLIENTE",
count(*),
pi.monto_total_ahorrado

FROM cliente c join producto_inversion_cliente pi on(pi.nro_cliente = c.nro_cliente)
group by pi.nro_cliente,c.pnombre,c.snombre,c.apmaterno,c.appaterno,c.numrun,c.dvrun,pi.monto_total_ahorrado
order by c.appaterno;

//caso 6

//informe 1
SELECT 

REPLACE(TO_CHAR(c.numrun,'909G999G999'),',','.')||'-'||UPPER(c.dvrun) as "RUN CLIENTE",
c.pnombre ||' '||c.snombre||' '||c.appaterno||' '||c.apmaterno as "NOMBRE CLIENTE",
count(cc.nro_cliente) as "TOTAL CREDITOS SOLICITADOS",
REPLACE(TO_CHAR(sum(cc.monto_credito),'$999G999G999'),',','.') AS "MONTO TOTAL CREDITOS"


FROM cliente c join credito_cliente cc on(cc.nro_cliente = c.nro_cliente)
WHERE extract(year from cc.fecha_otorga_cred) = extract(year from sysdate)-1
GROUP BY c.numrun,c.dvrun,c.pnombre,c.snombre,c.appaterno,c.apmaterno
order by c.appaterno;

//informe 2

SELECT 
    
REPLACE(TO_CHAR(c.numrun,'909G999G999'),',','.')||'-'||UPPER(c.dvrun) as "RUN CLIENTE",
c.pnombre ||' '||c.snombre||' '||c.appaterno||' '||c.apmaterno as "NOMBRE CLIENTE",

CASE 
    WHEN SUM(CASE WHEN m.cod_tipo_mov = 1 THEN m.monto_movimiento ELSE 0 END) = 0 
    THEN 'No realizado'
    ELSE TO_CHAR(SUM(CASE WHEN m.cod_tipo_mov = 1 THEN m.monto_movimiento ELSE 0 END))
END AS "TOTAL ABONOS",

CASE 
    WHEN SUM(CASE WHEN m.cod_tipo_mov = 2 THEN m.monto_movimiento ELSE 0 END) = 0 
    THEN 'No realizado'
    ELSE TO_CHAR(SUM(CASE WHEN m.cod_tipo_mov = 2 THEN m.monto_movimiento ELSE 0 END))
END AS "TOTAL GIROS"


FROM cliente c JOIN movimiento m on(m.nro_cliente = c.nro_cliente)
WHERE extract(year from m.fecha_movimiento) = extract(year from sysdate)
group by c.numrun,c.dvrun,c.pnombre,c.snombre,c.appaterno,c.apmaterno
order by c.appaterno,c.apmaterno;




