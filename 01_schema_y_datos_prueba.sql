-- ============================================================================
-- ENTORNO DE PRUEBAS QA: E-COMMERCE DATABASE
-- Incluye registros válidos y anomalías intencionadas para validar aserciones
-- ============================================================================

CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_registro DATETIME NOT NULL
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    usuario_id INT,
    total DECIMAL(10, 2),
    estado_pago VARCHAR(20) NOT NULL,
    fecha_pedido DATETIME NOT NULL
);

CREATE TABLE detalles_pedido (
    id INT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto VARCHAR(100) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL
);

-- Inserción de Usuarios (incluye email duplicado, formato inválido y usuario bloqueado)
INSERT INTO usuarios VALUES
(1, 'Leanne Graham', 'leanne@correo.com', 'activo', '2026-10-01 10:00:00'),
(2, 'Gema QA', 'gema.qa@correo.com', 'activo', '2026-10-15 12:30:00'),
(3, 'Usuario Duplicado', 'gema.qa@correo.com', 'activo', '2026-10-15 12:31:00'),
(4, 'Carlos Bloqueado', 'carlos@correo.com', 'bloqueado', '2026-10-20 09:15:00'),
(5, 'Sin Arroba', 'correo_invalido.com', 'activo', '2026-11-18 10:00:00');

-- Inserción de Pedidos (incluye total <= 0, usuario_id NULL, pedido huérfano, cobro duplicado y compra de usuario bloqueado)
INSERT INTO pedidos VALUES
(101, 1, 59.90, 'completado', '2026-11-01 14:00:00'),
(102, 2, 120.00, 'completado', '2026-11-10 16:00:00'),
(103, 2, 120.00, 'completado', '2026-11-10 16:00:00'), -- Bug: Doble cobro mismo día/importe
(104, NULL, 45.00, 'pendiente', '2026-11-12 11:20:00'), -- Bug: Sin usuario asignado
(105, 1, -15.00, 'rechazado', '2026-11-13 18:05:00'),  -- Bug: Importe negativo
(106, 999, 80.00, 'completado', '2026-11-14 09:40:00'), -- Bug: Pedido huérfano (usuario 999 no existe)
(107, 4, 210.00, 'completado', '2026-11-15 20:10:00'),  -- Bug: Usuario bloqueado con pago completado
(108, 1, 35.00, 'pendiente', '2026-11-18 10:15:00');    -- Bug: Pedido sin líneas de detalle

-- Inserción de Detalles de Pedido (el pedido 108 queda vacío intencionadamente)
INSERT INTO detalles_pedido VALUES
(1, 101, 'Teclado Mecánico', 1, 59.90),
(2, 102, 'Monitor 24 pulgadas', 1, 120.00),
(3, 103, 'Monitor 24 pulgadas', 1, 120.00),
(4, 107, 'Silla Ergonómica', 1, 210.00);
