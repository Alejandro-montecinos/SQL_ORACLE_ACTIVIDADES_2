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