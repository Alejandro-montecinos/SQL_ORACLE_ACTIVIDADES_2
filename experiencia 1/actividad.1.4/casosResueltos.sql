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