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




SELECT 
    c.numrun || '-' || c.dvrun AS rut,
    c.pnombre || ' ' || c.snombre || ' ' || c.appaterno || ' ' || c.apmaterno AS nombre_completo,
    po.nombre_prof_ofic,
    TO_CHAR(c.fecha_inscripcion, 'DD "de" Month', 'NLS_DATE_LANGUAGE=SPANISH') AS fecha_inscripcion
FROM 
    cliente c
    JOIN profesion_oficio po USING(cod_prof_ofic)
WHERE 
    EXTRACT(MONTH FROM c.fecha_nacimiento) = EXTRACT(MONTH FROM SYSDATE)
ORDER BY 
    c.fecha_nacimiento;
