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








