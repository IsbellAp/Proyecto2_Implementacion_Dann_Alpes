-- ============================================================
-- RFC2 - Consultar Reservas a Traves del Tiempo
-- Muestra la evolucion mensual de reservas en un rango de
-- fechas, filtrable por ciudad y hotel.
-- Parametros: :P3_FECHA_INICIO, :P3_FECHA_FIN,
--             :P3_ID_CIUDAD, :P3_ID_HOTEL
-- ============================================================

SELECT 
    c.NOMBRE_CIUDAD                         AS "Ciudad",
    h.NOMBRE                                AS "Hotel",
    TO_CHAR(r.FECHA_INICIO, 'MM/YYYY')      AS "Mes",
    COUNT(*)                                AS "Total Reservas"
FROM DA_RESERVAS r
JOIN DA_HOTEL h 
    ON r.ID_HOTEL = h.ID_HOTEL
JOIN DA_CIUDAD c 
    ON h.ID_CIUDAD = c.ID_CIUDAD
WHERE r.FECHA_INICIO BETWEEN 
        TO_DATE(:P3_FECHA_INICIO, 'MM/DD/YYYY')
    AND TO_DATE(:P3_FECHA_FIN,    'MM/DD/YYYY')
  AND (:P3_ID_CIUDAD IS NULL OR c.ID_CIUDAD = :P3_ID_CIUDAD)
  AND (:P3_ID_HOTEL  IS NULL OR h.ID_HOTEL  = :P3_ID_HOTEL)
GROUP BY 
    c.NOMBRE_CIUDAD,
    h.NOMBRE,
    TO_CHAR(r.FECHA_INICIO, 'MM/YYYY')
ORDER BY 
    TO_CHAR(r.FECHA_INICIO, 'MM/YYYY');
