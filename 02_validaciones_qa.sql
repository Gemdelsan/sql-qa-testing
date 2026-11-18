-- ============================================================================
-- SUITE DE VALIDACIONES SQL PARA QA
-- ============================================================================

-- TC-SQL-01: Verificar persistencia tras registro de usuario
SELECT *
FROM usuarios
WHERE email = 'gema.qa@correo.com';

-- TC-SQL-02: Detectar pedidos con usuario_id nulo o importes <= 0
SELECT *
FROM pedidos
WHERE usuario_id IS NULL
   OR total <= 0;

-- TC-SQL-03: Auditar formato de email en los últimos 5 usuarios registrados
SELECT *
FROM (
    SELECT *
    FROM usuarios
    ORDER BY fecha_registro DESC
    LIMIT 5
) AS ultimos_usuarios
WHERE email NOT LIKE '%@%';

-- TC-SQL-04: Detectar cuentas con correos electrónicos duplicados
SELECT email, COUNT(*) AS cantidad
FROM usuarios
GROUP BY email
HAVING COUNT(*) > 1;

-- TC-SQL-05: Métrica de distribución de pedidos por estado de pago
SELECT estado_pago, COUNT(*) AS cantidad_pedidos
FROM pedidos
GROUP BY estado_pago
ORDER BY cantidad_pedidos DESC;

-- TC-SQL-06: Detectar posibles cobros duplicados (mismo cliente, fecha e importe)
SELECT usuario_id,
       fecha_pedido,
       total,
       COUNT(*) AS veces_repetido
FROM pedidos
GROUP BY usuario_id, fecha_pedido, total
HAVING COUNT(*) > 1;

-- TC-SQL-07: Integridad referencial - Detectar pedidos huérfanos
SELECT p.id, p.usuario_id
FROM pedidos p
LEFT JOIN usuarios u ON p.usuario_id = u.id
WHERE p.usuario_id IS NOT NULL
  AND u.id IS NULL;

-- TC-SQL-08: Regla de negocio - Usuarios bloqueados con pagos completados
SELECT p.id, u.nombre, u.email
FROM usuarios u
INNER JOIN pedidos p ON u.id = p.usuario_id
WHERE u.estado = 'bloqueado'
  AND p.estado_pago = 'completado';

-- TC-SQL-09: Integridad de carrito - Pedidos sin líneas en detalles_pedido
SELECT p.id, p.fecha_pedido
FROM pedidos p
LEFT JOIN detalles_pedido d ON p.id = d.pedido_id
WHERE d.id IS NULL;
