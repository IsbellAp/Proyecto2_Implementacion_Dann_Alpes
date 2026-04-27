-- ============================================================
-- RFC5 - Consultar Servicios y Tipos de Habitacion Populares
-- Identifica los tipos de habitacion mas reservados por hotel
-- en un rango de fechas dado.
-- Parametros: :P6_FECHA_INICIO, :P6_FECHA_FIN
-- ============================================================

-- Tipos de habitacion mas reservados por sede
SELECT 
    h.NOMBRE                AS "Hotel",
    th.NOMBRE_TIPO          AS "Tipo de Habitacion",
    COUNT(*)                AS "Veces Reservada"
FROM DA_RESERVAS r
JOIN DA_HOTEL h 
    ON r.ID_HOTEL = h.ID_HOTEL
JOIN DA_TIPO_HABITACION th 
    ON r.ID_TIPO_HABITACION = th.ID_TIPO_HABITACION
WHERE r.FECHA_INICIO BETWEEN :P6_FECHA_INICIO AND :P6_FECHA_FIN
GROUP BY 
    h.NOMBRE,
    th.NOMBRE_TIPO
ORDER BY 
    COUNT(*) DESC;
