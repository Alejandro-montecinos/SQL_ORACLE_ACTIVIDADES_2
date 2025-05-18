SELECT 


tis.descripcion||','||sa.descripcion,
count(at.pac_run)


FROM atencion at 
left JOIN paciente pa on(pa.pac_run = at.pac_run)
left JOIN salud sa on(sa.sal_id = pa.sal_id)
LEFT join tipo_salud tis on(tis.tipo_sal_id = sa.tipo_sal_id)
where extract(year from at.fecha_atencion) = extract(year from sysdate)-1
group by tis.descripcion,sa.descripcion;



SELECT 
ts.descripcion||','||s.descripcion,
count(a.ate_id)
FROM atencion a LEFT JOIN paciente p
ON(a.pac_run = p.pac_run)
LEFT JOIN salud s
ON (p.sal_id = s.sal_id)
LEFT JOIN tipo_salud ts
ON(s.tipo_sal_id = ts.tipo_sal_id)
GROUP BY ts.descripcion||','||s.descripcion
HAVING  count(a.ate_id) >  (SELECT 
                            TRUNC(AVG(count(*)))
                            FROM atencion a LEFT JOIN paciente p
                            ON(a.pac_run = p.pac_run)
                            LEFT JOIN salud s
                            ON (p.sal_id = s.sal_id)
                            LEFT JOIN tipo_salud ts
                            ON(s.tipo_sal_id = ts.tipo_sal_id)
                            GROUP BY ts.descripcion||','||s.descripcion);
                            
//caso 2 

select 

esp.nombre,
med.med_run||'-'||med.dv_run,
med.pnombre||' '||med.snombre||' '||med.apaterno||' '||med.amaterno,
count(at.ate_id)

from atencion at 
join especialidad_medico espm  on (esm.esp_id = at.esp_id and esm.med_run = at.med_run)
JOIN medico med on (med.med_run = esm.med_run)
join especialidad esp on (esm.esp_id = esp.esp_id)
WHERE extract(year from at.fecha_atencion) = extract(year from sysdate)-1
group by esp.nombre, med.med_run ,med.dv_run, med.pnombre,med.snombre,med.apaterno,med.amaterno;




SELECT 
    esp.nombre AS especialidad,
    med.med_run || '-' || med.dv_run AS rut_medico,
    med.pnombre || ' ' || med.snombre || ' ' || med.apaterno || ' ' || med.amaterno AS nombre_completo,
    sub.total_atenciones
FROM (
    SELECT 
        at.med_run,
        at.esp_id,
        COUNT(DISTINCT at.ate_id) AS total_atenciones
    FROM atencion at
    WHERE EXTRACT(YEAR FROM at.fecha_atencion) = EXTRACT(YEAR FROM SYSDATE) - 1
    GROUP BY at.med_run, at.esp_id
    HAVING COUNT( at.ate_id) < 10
) sub
JOIN medico med ON med.med_run = sub.med_run
JOIN especialidad esp ON esp.esp_id = sub.esp_id
ORDER BY 
    esp.nombre ASC,
    med.apaterno ASC;
    
    
    
SELECT  

*

FROM atencion at
JOIN especialidad_medico espm on(espm.esp_id = at.esp_id and espm.med_run = at.med_run)
JOIN medico med on(med.med_run = espm.med_run)
join especialidad esp on(espm.esp_id = esp.esp_id);



SELECT 

esp.nombre,
med.med_run||'-'||med.dv_run,
med.pnombre||' '||med.snombre||' '||med.apaterno||' '||med.amaterno,
count(at.ate_id)

FROM atencion at
LEFT JOIN especialidad_medico espm on(espm.esp_id = at.esp_id and espm.med_run = at.med_run)
JOIN medico med on(med.med_run = espm.med_run)
join especialidad esp on(espm.esp_id = esp.esp_id)
where extract(year from at.fecha_atencion) = extract(year from sysdate)-1
group by esp.nombre, med.med_run ,med.dv_run, med.pnombre,med.snombre,med.apaterno,med.amaterno;




//
SELECT  
    med.med_run || '-' || med.dv_run AS run_medico,
    med.pnombre || ' ' || med.snombre || ' ' || med.apaterno || ' ' || med.amaterno AS nombre_medico,
    COUNT(at.ate_id) AS total_atenciones
FROM 
    atencion at
JOIN 
    medico med ON med.med_run = at.med_run
WHERE 
    EXTRACT(YEAR FROM at.fecha_atencion) = EXTRACT(YEAR FROM SYSDATE) - 1
GROUP BY 
    med.med_run, med.dv_run, med.pnombre, med.snombre, med.apaterno, med.amaterno;




SELECT 
    esp.NOMBRE AS nombre_especialidad,
    med.MED_RUN || '-' || med.DV_RUN AS rut_medico,
    med.PNOMBRE || ' ' || med.SNOMBRE || ' ' || med.APATERNO || ' ' || med.AMATERNO AS nombre_completo
FROM 
    ESPECIALIDAD_MEDICO espm
JOIN 
    MEDICO med ON med.MED_RUN = espm.MED_RUN
JOIN 
    ESPECIALIDAD esp ON esp.ESP_ID = espm.ESP_ID
WHERE 
    (
    SELECT COUNT(*) 
    FROM ATENCION at
    JOIN ESPECIALIDAD_MEDICO sub_espm
        ON at.MED_RUN = sub_espm.MED_RUN 
        AND at.ESP_ID = sub_espm.ESP_ID
    WHERE 
        sub_espm.MED_RUN = espm.MED_RUN
        AND sub_espm.ESP_ID = espm.ESP_ID
        AND EXTRACT(YEAR FROM at.FECHA_ATENCION) = EXTRACT(YEAR FROM SYSDATE) - 1
) < 10

ORDER BY 
    esp.NOMBRE,
    med.APATERNO;

