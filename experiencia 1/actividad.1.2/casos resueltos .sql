// caso 1
SELECT * FROM alumno;

SELECT 
    
    carreraid as "IDENTIFICACION DE LA CARRERA",
    COUNT(*) AS "TOTAL ALUMNOS MATRICULADOS",

      'le corresponden'||' '||to_char (COUNT(*)*30200,'$999g999g999')||' '||'del presupuesto total asignado para publicidad ' AS "MONTO POR PUBLICIDAD"
FROM alumno
group by carreraid
ORDER by "MONTO POR PUBLICIDAD" DESC;

// caso 2

select 
    
    carreraid as "carrera",
    count(*)as "conteo"

from alumno
group by carreraid
HAVING count(*) > 4
order by carreraid;

// caso 3

select * from empleado;

select 
    
    TO_CHAR(run_jefe,'999G999G999') AS "RUN JEFE SIN DV",
    count(run_jefe) as "TOTAL DE EMPLEADOS A SU CARGO ",
    TO_CHAR(max(salario),'999G999G999') AS "SALARIO MAXIMO ",

    (case
        when count(run_jefe) > 0 then  
        
        to_char(count(run_jefe)*10)||'% del salario maximo '
        
    else to_char('ERROR EN EL PORCENTAJE') end) as "PORCENTAJE DE BONIFICACION ",
    
     TO_CHAR((max(salario)*10)*(count(run_jefe)/100),'$999G999G999') AS "BONIFICACION"

from empleado
WHERE run_jefe is not NULL
group by run_jefe;

//caso 4

SELECT * FROM empleado;
SELECT * FROM escolaridad_emp;

SELECT 
em.id_escolaridad as "ESCOLARIDAD",
ep.desc_escolaridad as "DESCRIPCION ESCOLARIDAD" ,
count(em.id_escolaridad) as "TOTAL EMPLEADOS",
to_char(max(em.salario),'999g999g999') as "SALARIO MAXIMO",
to_char(min(em.salario),'999g999g999') as "SALARIO MINIMO ",
to_char(sum(em.salario),'999g999g999') as "SALARIO TOTAL",
to_char(avg(em.salario),'999g999g999') as "SALARIO TOTAL"

FROM empleado em JOIN escolaridad_emp ep ON(em.id_escolaridad = ep.id_escolaridad)
group by em.id_escolaridad,ep.desc_escolaridad
order by count(em.id_escolaridad) desc;

//caso 5

SELECT * FROM prestamo;

select 
tituloid as "CODIGO DEL LIBRO" ,
count(ejemplarid) AS "TOTAL DE VECES SOLICITADO",
(case 
    when count(ejemplarid) = 1 then 'No se requieren nuevos ejemplares'
    when count(ejemplarid) = 2 or count(ejemplarid) = 3 then 'Se requiere comprar 1 nuevos ejemplares'
    when count(ejemplarid) = 4 or count(ejemplarid) = 5 then 'Se requiere comprar 2 nuevos ejempalres'
    when count(ejemplarid) >5 then'Se requiere comprar 4 nuevos ejemplares'
    else 'no posee libros' end) AS "SUGERENCIA" 


from prestamo
where extract( year from fecha_ini_prestamo) = extract( year from sysdate) -1
group by tituloid
order by count(ejemplarid) desc;

//caso 6

