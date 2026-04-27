-- ============================================================
-- RFC4 - Consultar Ingreso Total por Hotel por Rango de Fechas
-- Calcula los ingresos generados por cada hotel durante un
-- rango de fechas, ordenados de mayor a menor ingreso.
-- Parametros: :P5_FECHA_INICIO, :P5_FECHA_FIN
-- ============================================================

SELECT 
    h.NOMBRE                            AS "Hotel",
    c.NOMBRE_CIUDAD                     AS "Ciudad",
    SUM(r.PRECIO_TOTAL_RESERVA)         AS "Ingresos Totales"
FROM DA_RESERVAS r
JOIN DA_HOTEL h 
    ON r.ID_HOTEL = h.ID_HOTEL
JOIN DA_CIUDAD c 
    ON h.ID_CIUDAD = c.ID_CIUDAD
WHERE r.FECHA_INICIO BETWEEN :P5_FECHA_INICIO AND :P5_FECHA_FIN
GROUP BY 
    h.NOMBRE,
    c.NOMBRE_CIUDAD
ORDER BY 
    SUM(r.PRECIO_TOTAL_RESERVA) DESC;
