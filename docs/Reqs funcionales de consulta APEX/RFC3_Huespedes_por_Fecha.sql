-- ============================================================
-- RFC3 - Consultar Cantidad de Huespedes por Fechas y Ciudad
-- Muestra el total de huespedes (adultos + menores de 3 anios)
-- por fecha, ciudad y hotel en un rango de fechas dado.
-- Parametros: :P4_FECHA_INICIO, :P4_FECHA_FIN,
--             :P4_ID_CIUDAD, :P4_ID_HOTEL
-- ============================================================

SELECT 
    c.NOMBRE_CIUDAD                         AS "Ciudad",
    h.NOMBRE                                AS "Hotel",
    r.FECHA_INICIO                          AS "Fecha",
    SUM(r.ADULTOS + r.MENORES_3_ANIOS)      AS "Total Huespedes"
FROM DA_RESERVAS r
JOIN DA_HOTEL h 
    ON r.ID_HOTEL = h.ID_HOTEL
JOIN DA_CIUDAD c 
    ON h.ID_CIUDAD = c.ID_CIUDAD
WHERE r.FECHA_INICIO >= TO_DATE(:P4_FECHA_INICIO, 'MM/DD/YYYY')
  AND r.FECHA_INICIO <= TO_DATE(:P4_FECHA_FIN,    'MM/DD/YYYY')
  AND (:P4_ID_CIUDAD IS NULL OR c.ID_CIUDAD = :P4_ID_CIUDAD)
  AND (:P4_ID_HOTEL  IS NULL OR h.ID_HOTEL  = :P4_ID_HOTEL)
GROUP BY 
    c.NOMBRE_CIUDAD,
    h.NOMBRE,
    r.FECHA_INICIO
ORDER BY 
    r.FECHA_INICIO;
