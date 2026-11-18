# 🗄️ SQL Testing para QA - Validación e Integridad de Datos

Suite de consultas SQL diseñadas para validar la persistencia de datos, reglas de negocio e integridad referencial tras operaciones CRUD en un entorno de comercio electrónico.

## 🎯 Objetivo del proyecto
Complementar las pruebas de interfaz (UI) y de API verificando directamente en base de datos que no existan fallos silenciosos como registros duplicados, datos huérfanos o incumplimientos de reglas de negocio.

## 📂 Estructura del repositorio
* `01_schema_y_datos_prueba.sql`: Script DDL/DML para levantar las tablas (`usuarios`, `pedidos`, `detalles_pedido`) con un dataset que incluye casos válidos y anomalías controladas.
* `02_validaciones_qa.sql`: Batería de 9 consultas de auditoría organizadas por caso de prueba (`TC-SQL-01` a `TC-SQL-09`).

## 🔍 Casos de prueba cubiertos

| ID | Escenario QA | Técnicas SQL empleadas |
| :--- | :--- | :--- |
| `TC-SQL-01` | Verificación de alta de usuario tras petición `POST` | `SELECT`, `WHERE` |
| `TC-SQL-02` | Detección de pedidos corruptos (`usuario_id` nulo o `total <= 0`) | `IS NULL`, operadores lógicos |
| `TC-SQL-03` | Auditoría de formato de email en los últimos 5 registros | Subconsultas, `ORDER BY`, `LIMIT`, `NOT LIKE` |
| `TC-SQL-04` | Detección de correos electrónicos duplicados | `GROUP BY`, `HAVING COUNT(*) > 1` |
| `TC-SQL-05` | Informe de distribución de estados de pago | `COUNT`, `GROUP BY`, `ORDER BY` |
| `TC-SQL-06` | Detección de posibles cobros duplicados | Agrupación compuesta (`GROUP BY` múltiple) |
| `TC-SQL-07` | Búsqueda de pedidos huérfanos sin usuario existente | `LEFT JOIN ... WHERE id IS NULL` |
| `TC-SQL-08` | Regla de negocio: usuarios bloqueados con compras completadas | `INNER JOIN` con filtros cruzados |
| `TC-SQL-09` | Auditoría de pedidos sin líneas de producto asociadas | `LEFT JOIN` entre cabecera y detalle |
