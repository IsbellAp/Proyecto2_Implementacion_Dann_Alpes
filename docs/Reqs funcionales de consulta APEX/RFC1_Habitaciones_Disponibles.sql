-- ============================================================
-- RFC1 - Consultar Habitaciones Disponibles
-- Muestra las habitaciones disponibles en un hotel para un
-- intervalo de fechas dado.
-- Parametros: :P2_FECHA_INICIO, :P2_FECHA_FIN, :P2_ID_HOTEL
-- ============================================================

SELECT 
    h.NOMBRE                                        AS "Hotel",
    th.NOMBRE_TIPO                                  AS "Tipo Habitacion",
    thph.CANTIDAD_HABITACIONES_DISPONIBLES          AS "Total Disponibles",
    COUNT(r.ID_RESERVA)                             AS "Reservas en el Periodo",
    thph.CANTIDAD_HABITACIONES_DISPONIBLES 
        - COUNT(r.ID_RESERVA)                       AS "Habitaciones Libres"
FROM DA_TIPO_HABITACION_POR_HOTEL thph
JOIN DA_HOTEL h 
    ON thph.ID_HOTEL = h.ID_HOTEL
JOIN DA_TIPO_HABITACION th 
    ON thph.ID_TIPO_HABITACION = th.ID_TIPO_HABITACION
LEFT JOIN DA_RESERVAS r
    ON  thph.ID_HOTEL            = r.ID_HOTEL
    AND thph.ID_TIPO_HABITACION  = r.ID_TIPO_HABITACION
    AND r.FECHA_INICIO           < :P2_FECHA_FIN
    AND r.FECHA_FINAL            > :P2_FECHA_INICIO
WHERE thph.ID_HOTEL = :P2_ID_HOTEL
GROUP BY 
    h.NOMBRE,
    th.NOMBRE_TIPO,
    thph.CANTIDAD_HABITACIONES_DISPONIBLES
HAVING 
    thph.CANTIDAD_HABITACIONES_DISPONIBLES > COUNT(r.ID_RESERVA);
