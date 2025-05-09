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

select * 

from transaccion_tarjeta_cliente ttc JOIN ; 
