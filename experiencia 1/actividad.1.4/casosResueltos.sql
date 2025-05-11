SELECT 
    REPLACE(TO_CHAR(c.numrun,'999G999G999'),',','.')||'-'||UPPER(c.dvrun) as "RUN CLIENTE",
    c.pnombre||' '||c.snombre||' '||c.appaterno||' '||c.appaterno AS "NOMBRE CLIENTE",
    TO_CHAR(c.fecha_nacimiento,'DD')||' de '||TO_CHAR(c.fecha_nacimiento,'month') as "DIA CUMPLEAÑOS",
    sr.direccion||'/'||r.nombre_region as "Direccion Sucursal/REGION SUCURSAL"
    
    
FROM cliente c JOIN sucursal_retail sr
ON( c.cod_comuna = sr.cod_comuna AND
    c.cod_region = sr.cod_region AND
    c.cod_provincia = sr.cod_provincia)
LEFT JOIN region r
ON(c.cod_region = r.cod_region)
WHERE extract(month from c.fecha_nacimiento) = extract(month from sysdate)+4;

//caso 2


select  

REPLACE(TO_CHAR(cl.numrun,'999G999G999'),',','.')||'-'||UPPER(cl.dvrun) as "RUN CLIENTE",
cl.pnombre||' '||cl.snombre||' '||cl.appaterno||' '||cl.apmaterno AS "NOMBRE CLIENTE",
REPLACE(TO_CHAR(sum(ttc.monto_transaccion),'$999G999G999'),',','.') AS "MONTO COMPRAS/AVANCESS/S.AVANCES",
REPLACE(TO_CHAR(trunc(sum(ttc.monto_transaccion)/10000)*250,'999G999G999'),',','.') as "TOTAL PUNTOS ACUMULADOS"



from Cliente cl 
LEFT join tarjeta_cliente tc on(tc.numrun = cl.numrun) 
join transaccion_tarjeta_cliente ttc on(ttc.nro_tarjeta = tc.nro_tarjeta)
WHERE extract(year from ttc.fecha_transaccion) = extract(year from sysdate)-1
group by cl.numrun,cl.dvrun,cl.pnombre,cl.snombre,cl.appaterno,cl.apmaterno
order by "TOTAL PUNTOS ACUMULADOS";



//caso3 



SELECT 
  TO_CHAR(ttc.fecha_transaccion, 'MMYYYY') AS "MES TRANSACCION",
  ttt.nombre_tptran_tarjeta,
  ttc.monto_total_transaccion,
  CASE
    WHEN ttc.monto_total_transaccion BETWEEN 100000 AND 1000000 THEN TO_CHAR(ttc.monto_total_transaccion * 0.01, '999G999G999D99')
    WHEN ttc.monto_total_transaccion BETWEEN 1000001 AND 2000000 THEN TO_CHAR(ttc.monto_total_transaccion * 0.02, '999G999G999D99')
    WHEN ttc.monto_total_transaccion BETWEEN 2000001 AND 4000000 THEN TO_CHAR(ttc.monto_total_transaccion * 0.03, '999G999G999D99')
    WHEN ttc.monto_total_transaccion BETWEEN 4000001 AND 6000000 THEN TO_CHAR(ttc.monto_total_transaccion * 0.04, '999G999G999D99')
    WHEN ttc.monto_total_transaccion >= 6000001 THEN TO_CHAR(ttc.monto_total_transaccion * 0.07, '999G999G999D99')
    ELSE 'NO entra dentro del rango '
  END AS "APORTE AL SBIF"

FROM transaccion_tarjeta_cliente ttc
LEFT JOIN tipo_transaccion_tarjeta ttt 
  ON ttt.cod_tptran_tarjeta = ttc.cod_tptran_tarjeta

WHERE EXTRACT(YEAR FROM ttc.fecha_transaccion) = EXTRACT(YEAR FROM SYSDATE) - 1

ORDER BY TO_CHAR(ttc.fecha_transaccion, 'MM') ASC, ttt.nombre_tptran_tarjeta;

// caso 4

SELECT 

cl.numrun||' '||cl.dvrun,
cl.pnombre||' '||cl.snombre||' '||cl.appaterno||' '||cl.apmaterno,
sum(ttc.monto_total_transaccion)


FROM cliente cl 
LEFT JOIN tarjeta_cliente tc on (tc.numrun = cl.numrun)
LEFT JOIN transaccion_tarjeta_cliente ttc on(tc.nro_tarjeta = ttc.nro_tarjeta)
group by cl.numrun,cl.dvrun,cl.pnombre,cl.snombre,cl.appaterno,cl.apmaterno;

