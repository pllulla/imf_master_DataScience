-- Diferentes consultas para analizar y tomar algunas decisiones en los apartados 1 y 4

-- Evolución del volumen de tickets general por fecha
SELECT DATE(fecha_creacion) AS Fecha, COUNT(*) AS Volumen
FROM staging_tickets
GROUP BY DATE(fecha_creacion)
ORDER BY DATE(fecha_creacion);


-- Evolución del volumen de incidencias y peticiones por fecha
SELECT DATE(fecha_creacion) AS Fecha,
       SUM(CASE WHEN tipo_servicio IN ('Restauración de infraestructura', 'Restauración de servicio a usuario') THEN 1 ELSE 0 END) AS Incidencias,
       SUM(CASE WHEN tipo_servicio = 'Petición de serv. por el usuario' THEN 1 ELSE 0 END) AS Peticiones
FROM staging_tickets
GROUP BY DATE(fecha_creacion)
ORDER BY DATE(fecha_creacion);


-- Paso 1: Calcular el número total de tickets para cada prioridad
SELECT prioridad, COUNT(*) AS TotalTickets
FROM staging_tickets
GROUP BY prioridad;


-- Paso 2: Calcular el porcentaje de cada prioridad en relación con el total de tickets
SELECT prioridad, COUNT(*) / (SELECT COUNT(*) FROM staging_tickets) * 100 AS Porcentaje
FROM staging_tickets
GROUP BY prioridad;


-- Calcular el número total de tickets por prioridad y mes
SELECT 
    DATE_FORMAT(fecha_creacion, '%Y-%m') AS mes,
    prioridad, 
    COUNT(*) AS TotalTickets
FROM staging_tickets
GROUP BY mes, prioridad
ORDER BY mes, FIELD(prioridad, 'Baja', 'Media', 'Alta', 'Crítica');


-- Calcular el porcentaje de cada prioridad en relación con el total de tickets por mes
SELECT 
    mes,
    prioridad, 
    TotalTickets / SUM(TotalTickets) OVER (PARTITION BY mes) * 100 AS porcentaje
FROM (
    SELECT 
        DATE_FORMAT(fecha_creacion, '%Y-%m') AS mes,
        prioridad, 
        COUNT(*) AS TotalTickets
    FROM staging_tickets
    GROUP BY mes, prioridad
) AS t
ORDER BY mes, FIELD(prioridad, 'Baja', 'Media', 'Alta', 'Crítica');


-- Para obtener los servicios que acumulan más tickets y de ellos los que menos cumplen los SLAs
SELECT
    s.nombre_servicio AS Servicio,
    COUNT(i.id_incidencia) AS TotalTickets,
    SUM(CASE WHEN ec.nombre_estado_cumplimiento_SLA = 'Dentro del Objetivo de servicio' THEN 1 ELSE 0 END) AS CumplenSLA,
    SUM(CASE WHEN ec.nombre_estado_cumplimiento_SLA = 'Objetivos de servicio incumplidos' THEN 1 ELSE 0 END) AS NoCumplenSLA
FROM f_incidencias i
INNER JOIN d_servicio s ON i.id_servicio = s.id_servicio
INNER JOIN d_estado_cumplimiento_SLA ec ON i.id_estado_cumplimiento_SLA = ec.id_estado_cumplimiento_SLA
GROUP BY s.nombre_servicio
ORDER BY NoCumplenSLA DESC;


-- Para obtener los servicios con más backlog acumulado, es decir, los servicios que tienen más tickets abiertos en la actualidad
SELECT
    s.servicio,
    COUNT(s.numero_incidente) AS BacklogAcumulado
FROM
    staging_tickets s
WHERE
    s.estado = 'Pendiente' OR s.estado = 'Asignado'
GROUP BY
    s.servicio
ORDER BY
    BacklogAcumulado DESC;


-- Cuáles son los servicios en que se resuelven más rápido y más lentos los tickets
SELECT
    s.servicio,
    AVG(s.duracion_dias) AS TiempoPromedioResolucion
FROM
    staging_tickets s
WHERE
    s.estado = 'Cerrado' OR s.estado = 'Resuelto'
GROUP BY
    s.servicio
ORDER BY
    TiempoPromedioResolucion;
    
    
 -- Volumetría de tickets en entornos productivos respecto a entornos no productivos
 SELECT
    CASE
        WHEN entorno LIKE '%PRO%' THEN 'Productivo'
        ELSE 'No Productivo'
    END AS tipo_entorno,
    COUNT(*) AS volumen_tickets
FROM
    staging_tickets
GROUP BY
    tipo_entorno;
    
    
-- Calcular el número total de incidencias con prioridad crítica en entornos de producción
SELECT 
    COUNT(*) AS TotalIncidenciasCriticas
FROM staging_tickets
WHERE prioridad = 'Crítica'
    AND entorno LIKE '%PRO%'
    AND tipo_servicio IN ('Restauración de infraestructura', 'Restauración de servicio a usuario'); 
       
    