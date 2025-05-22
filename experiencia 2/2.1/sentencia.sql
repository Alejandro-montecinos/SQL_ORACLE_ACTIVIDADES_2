SELECT * FROM arriendo_camion;
SELECT * FROM camion;

SELECT 
    ac.fecha_ini_arriendo,
    e.numrun_emp,
    e.pnombre_emp||' '||e.snombre_emp||' '||e.appaterno_emp||' '|| e.apmaterno_emp as "NOMBRE EMPLEADO",
    e.sueldo_base
   
    
    
    

FROM arriendo_camion ac join camion c on(ac.nro_patente = c.nro_patente)
join empleado e on(c.numrun_emp = e.numrun_emp);


SELECT 
    ac.fecha_ini_arriendo,
    c.numrun_emp,
    e.pnombre_emp||' '||e.snombre_emp||' '||e.appaterno_emp||' '|| e.apmaterno_emp as "NOMBRE EMPLEADO",
    e.sueldo_base
   
    
    
    

FROM arriendo_camion ac join camion c on(ac.nro_patente = c.nro_patente)
join empleado e on(c.numrun_emp = e.numrun_emp);