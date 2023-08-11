-- Tablas Listas --
-- Procedimientos: 20 de 25 --
-- Vistas: 10 --
-- Triggers: 5 --
-- Funciones: 15 --
-- Paquetes: 10 --
-- Cursores: 4 de 15 --


--- CREACION DE LA TABLA PRODUCTO ---


CREATE TABLE producto 
( id_producto NUMBER PRIMARY KEY, 
nombre VARCHAR2(100) NOT NULL, 
categoria VARCHAR2(50), 
descripcion VARCHAR2(255), 
precio NUMBER(10, 2) );

INSERT INTO producto 
(id_producto, nombre, categoria, descripcion, precio) 
VALUES (1, 'Producto 1', 'Electrónica', 'Descripción del Producto 1', 499.99);

SELECT * FROM producto;

UPDATE producto
SET precio = 599.99
WHERE id_producto = 1;

DELETE FROM producto WHERE id_producto = 1;


--- CREACION DE LA TABLA CLIENTES ---


CREATE TABLE clientes 
( id_clientes NUMBER PRIMARY KEY, 
nombre VARCHAR2(100) NOT NULL, 
apellidos VARCHAR2(100) NOT NULL, 
correo_electronico VARCHAR2(100) UNIQUE NOT NULL );


INSERT INTO clientes (id_clientes, nombre, apellidos, correo_electronico)
VALUES (1, 'NombreClientes', 'ApellidosClientes', 'clientes@example.com');

SELECT * FROM clientes;

UPDATE clientes
SET correo_electronico = 'nuevo_correo@example.com'
WHERE id_clientes = 1;

DELETE FROM clientes
WHERE id_clientes = 1;


--- CREACION DE LA TABLA VENTA ---


CREATE TABLE venta (
    id_venta NUMBER PRIMARY KEY,
    fecha DATE NOT NULL,
    total NUMBER(10, 2) NOT NULL
);


INSERT INTO venta (id_venta, fecha, total)
VALUES (1, TO_DATE('2023-07-24', 'YYYY-MM-DD'), 150.00);

SELECT * FROM venta;

UPDATE venta
SET total = 200.00
WHERE id_venta = 1;

DELETE FROM venta
WHERE id_venta = 1;


--- CREACION DE LA TABLA ADMINISTRADOR ---


CREATE TABLE administrador (
    id_administrador NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    correo_electronico VARCHAR2(100) UNIQUE NOT NULL,
    contrasena VARCHAR2(100) NOT NULL
);

INSERT INTO administrador (id_administrador, nombre, apellidos, correo_electronico, contrasena)
VALUES (1, 'NombreAdmin', 'ApellidosAdmin', 'admin@example.com', 'contraseña123');

SELECT * FROM administrador;

UPDATE administrador
SET contrasena = 'nueva_contraseña456'
WHERE id_administrador = 1;

DELETE FROM administrador
WHERE id_administrador = 1;


--- PROCEDIMIENTOS ---


//Insertar un Nuevo Producto

CREATE OR REPLACE PROCEDURE insertar_producto(
    p_nombre VARCHAR2,
    p_categoria VARCHAR2,
    p_descripcion VARCHAR2,
    p_precio NUMBER
) AS
BEGIN
    INSERT INTO producto (id_producto, nombre, categoria, descripcion, precio)
    VALUES (secuencia_producto.NEXTVAL, p_nombre, p_categoria, p_descripcion, p_precio);
    COMMIT;
END;

//Actualizar Informacion de un Producto

CREATE OR REPLACE PROCEDURE actualizar_producto(
    p_id_producto NUMBER,
    p_nombre VARCHAR2,
    p_categoria VARCHAR2,
    p_descripcion VARCHAR2,
    p_precio NUMBER
) AS
BEGIN
    UPDATE producto
    SET nombre = p_nombre,
        categoria = p_categoria,
        descripcion = p_descripcion,
        precio = p_precio
    WHERE id_producto = p_id_producto;
    COMMIT;
END;

//Eliminar un Producto

CREATE OR REPLACE PROCEDURE eliminar_producto(
    p_id_producto NUMBER
) AS
BEGIN
    DELETE FROM producto
    WHERE id_producto = p_id_producto;
    COMMIT;
END;

//Insertar un Cliente

CREATE OR REPLACE PROCEDURE insertar_clientes(
    p_nombre VARCHAR2,
    p_apellidos VARCHAR2,
    p_correo_electronico VARCHAR2
) AS
BEGIN
    INSERT INTO clientes (id_clientes, nombre, apellidos, correo_electronico)
    VALUES (secuencia_clientes.NEXTVAL, p_nombre, p_apellidos, p_correo_electronico);
    COMMIT;
END;

//Actualizar Informacion de un Cliente

CREATE OR REPLACE PROCEDURE actualizar_clientes(
    p_id_clientes NUMBER,
    p_nombre VARCHAR2,
    p_apellidos VARCHAR2,
    p_correo_electronico VARCHAR2
) AS
BEGIN
    UPDATE clientes
    SET nombre = p_nombre,
        apellidos = p_apellidos,
        correo_electronico = p_correo_electronico
    WHERE id_clientes = p_id_clientes;
    COMMIT;
END;

//Eliminar un Cliente

CREATE OR REPLACE PROCEDURE eliminar_clientes(
    p_id_clientes NUMBER
) AS
BEGIN
    DELETE FROM clientes
    WHERE id_clientes = p_id_clientes;
    COMMIT;
END;

//Insertar una Nueva Venta

CREATE OR REPLACE PROCEDURE insertar_venta(
    p_fecha DATE,
    p_total NUMBER
) AS
BEGIN
    INSERT INTO venta (id_venta, fecha, total)
    VALUES (secuencia_venta.NEXTVAL, p_fecha, p_total);
    COMMIT;
END;

//Actualizar una Venta

CREATE OR REPLACE PROCEDURE actualizar_venta(
    p_id_venta NUMBER,
    p_fecha DATE,
    p_total NUMBER
) AS
BEGIN
    UPDATE venta
    SET fecha = p_fecha,
        total = p_total
    WHERE id_venta = p_id_venta;
    COMMIT;
END;

//Eliminar una Venta

CREATE OR REPLACE PROCEDURE eliminar_venta(
    p_id_venta NUMBER
) AS
BEGIN
    DELETE FROM venta
    WHERE id_venta = p_id_venta;
    COMMIT;
END;

//Obtener Info de un Producto por ID

CREATE OR REPLACE PROCEDURE obtener_producto_por_id(
    p_id_producto NUMBER,
    p_nombre OUT VARCHAR2,
    p_categoria OUT VARCHAR2,
    p_descripcion OUT VARCHAR2,
    p_precio OUT NUMBER
) AS
BEGIN
    SELECT nombre, categoria, descripcion, precio
    INTO p_nombre, p_categoria, p_descripcion, p_precio
    FROM producto
    WHERE id_producto = p_id_producto;
END;

//Obtener Info de un Cliente por ID

CREATE OR REPLACE PROCEDURE obtener_clientes_por_id(
    p_id_clientes NUMBER,
    p_nombre OUT VARCHAR2,
    p_apellidos OUT VARCHAR2,
    p_correo_electronico OUT VARCHAR2
) AS
BEGIN
    SELECT nombre, apellidos, correo_electronico
    INTO p_nombre, p_apellidos, p_correo_electronico
    FROM clientes
    WHERE id_clientes = p_id_clientes;
END;

//Obtener Info de Venta por ID

CREATE OR REPLACE PROCEDURE obtener_venta_por_id(
    p_id_venta NUMBER,
    p_fecha OUT DATE,
    p_total OUT NUMBER
) AS
BEGIN
    SELECT fecha, total
    INTO p_fecha, p_total
    FROM venta
    WHERE id_venta = p_id_venta;
END;

//Obtener Todos los Productos

CREATE OR REPLACE PROCEDURE obtener_todos_los_productos(
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM producto;
END;

//Obtener todos los Clientes

CREATE OR REPLACE PROCEDURE obtener_todos_los_clientes(
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM clientes;
END;

//Obtener Todas las Ventas

CREATE OR REPLACE PROCEDURE obtener_todas_las_ventas(
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM venta;
END;

//Obtener el Total de Ventas

CREATE OR REPLACE PROCEDURE obtener_total_ventas(
    p_total OUT NUMBER
) AS
BEGIN
    SELECT SUM(total)
    INTO p_total
    FROM venta;
END;

//Obtener el Promedio del Precio de los Productos

CREATE OR REPLACE PROCEDURE obtener_promedio_precio_productos(
    p_promedio OUT NUMBER
) AS
BEGIN
    SELECT AVG(precio)
    INTO p_promedio
    FROM producto;
END;

//Obtener Numero de Clientes

CREATE OR REPLACE PROCEDURE obtener_numero_clientes(
    p_num_clientes OUT NUMBER
) AS
BEGIN
    SELECT COUNT(*)
    INTO p_num_clientes
    FROM clientes;
END;

//Obtener Total de Ventas por Clientes

CREATE OR REPLACE PROCEDURE obtener_total_ventas_por_clientes(
    p_id_clientes NUMBER,
    p_total OUT NUMBER
) AS
BEGIN
    SELECT SUM(total)
    INTO p_total
    FROM venta
    WHERE id_clientes = p_id_clientes;
END;

//Obtener los Productos de una Categoria Especifica

CREATE OR REPLACE PROCEDURE obtener_productos_por_categoria(
    p_categoria VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM producto
    WHERE categoria = p_categoria;
END;



//CREATE OR REPLACE


--- VISTAS ---


//Vista de Productos con Información BSsica 

CREATE VIEW vista_productos AS SELECT id_producto, nombre, categoria, precio FROM producto;

SELECT * FROM vista_productos;

//Vista de Clientes con Informacion Completa

CREATE VIEW vista_clientes AS SELECT id_clientes, nombre, apellidos, correo_electronico FROM clientes;

SELECT * FROM vista_clientes;

//Vista de ventas con Detalles de los Productos

CREATE VIEW vista_ventas AS SELECT v.id_venta, v.fecha, v.total, p.nombre AS nombre_producto, p.precio AS precio_producto FROM venta v JOIN producto p ON v.id_venta = p.id_producto;

SELECT * FROM vista_ventas;

//Vista de Productos Agrupados por Categoria

CREATE VIEW vista_productos_por_categoria AS SELECT categoria, COUNT(*) AS cantidad_productos FROM producto GROUP BY categoria;

SELECT * FROM vista_productos_por_categoria;

//Vista de Clientes con sus Compras Realizadas

CREATE VIEW vista_compras_clientes AS
SELECT c.id_clientes, c.nombre, c.apellidos, c.correo_electronico, COUNT(v.id_venta) AS total_compras
FROM clientes c
LEFT JOIN venta v ON c.id_clientes = v.id_venta
GROUP BY c.id_clientes, c.nombre, c.apellidos, c.correo_electronico;

SELECT * FROM vista_compras_clientes

//Vista de Ventas Realizadas en un Rango de Fechas

CREATE VIEW vista_ventas_por_fecha AS
SELECT id_venta, fecha, total
FROM venta
WHERE fecha BETWEEN '2023-01-01' AND '2023-12-31';

SELECT * FROM vista_ventas_por_fecha;

//Vista de Administradores con Información Basica

CREATE VIEW vista_administradores AS
SELECT id_administrador, nombre, apellidos, correo_electronico
FROM administrador;

SELECT * FROM vista_administradores;

//Vista de Ventas con Información Detallada del Cliente

CREATE VIEW vista_ventas_con_cliente AS
SELECT v.id_venta, v.fecha, v.total, c.nombre AS nombre_cliente, c.apellidos AS apellidos_cliente, c.correo_electronico AS correo_cliente
FROM venta v
JOIN clientes c ON v.id_venta = c.id_clientes;

SELECT * FROM vista_ventas_con_cliente;

//Vista de Productos con Precios Mayores a $100

CREATE VIEW vista_productos_precio_mayor AS
SELECT id_producto, nombre, categoria, precio
FROM producto
WHERE precio > 100;

SELECT * FROM vista_productos_precio_mayor;

//Vista de Ventas con Total Ordenado de Mayor a Menor

CREATE VIEW vista_ventas_ordenadas AS
SELECT id_venta, fecha, total
FROM venta
ORDER BY total DESC;

SELECT * FROM vista_ventas_ordenadas;

--- FUNCIONES ---

//Funcion para Obtener el Precio de un Producto por su ID

CREATE FUNCTION obtener_precio_producto(id_prod NUMBER) RETURN NUMBER IS
    precio_prod NUMBER;
BEGIN
    SELECT precio INTO precio_prod FROM producto WHERE id_producto = id_prod;
    RETURN precio_prod;
END;

//Funcion para Contar el Numero Total de Productos en una Categoria Especifica

CREATE FUNCTION contar_productos_categoria(categ VARCHAR2) RETURN NUMBER IS
    total NUMBER;
BEGIN
    SELECT COUNT(*) INTO total FROM producto WHERE categoria = categ;
    RETURN total;
END;

//Funcion para Calcular el Total Gastado por un Cliente en Compras

CREATE FUNCTION total_gastado_cliente(id_cliente NUMBER) RETURN NUMBER IS
    total_gastado NUMBER;
BEGIN
    SELECT SUM(total) INTO total_gastado FROM venta WHERE id_venta = id_cliente;
    RETURN total_gastado;
END;

//Funcion para Obtener la Lista de Clientes que no han Realizado Compras

CREATE FUNCTION clientes_sin_compras RETURN VARCHAR2 IS
    lista_clientes VARCHAR2(1000);
BEGIN
    SELECT LISTAGG(nombre || ' ' || apellidos, ', ') WITHIN GROUP (ORDER BY apellidos) INTO lista_clientes
    FROM clientes c
    LEFT JOIN venta v ON c.id_clientes = v.id_venta
    WHERE v.id_venta IS NULL;
    RETURN lista_clientes;
END;

//Funcion para Obtener el Nombre Completo de un Administrador por su Correo Electronico

CREATE FUNCTION obtener_nombre_administrador(correo VARCHAR2) RETURN VARCHAR2 IS
    nombre_admin VARCHAR2(100);
BEGIN
    SELECT nombre || ' ' || apellidos INTO nombre_admin FROM administrador WHERE correo_electronico = correo;
    RETURN nombre_admin;
END;

//Funcion para Calcular el Promedio de Precios de Todos los Productos 

CREATE FUNCTION promedio_precios RETURN NUMBER IS
    promedio NUMBER;
BEGIN
    SELECT AVG(precio) INTO promedio FROM producto;
    RETURN promedio;
END;

//Funcion para Obtener la Fecha de la Ultima Venta Realizada

CREATE FUNCTION ultima_fecha_venta RETURN DATE IS
    ultima_fecha DATE;
BEGIN
    SELECT MAX(fecha) INTO ultima_fecha FROM venta;
    RETURN ultima_fecha;
END;

//Funcion para Obtener el Numero Total de Ventas Realizadas en un Dia Especifico

CREATE FUNCTION contar_ventas_dia(fecha_venta DATE) RETURN NUMBER IS
    total_ventas NUMBER;
BEGIN
    SELECT COUNT(*) INTO total_ventas FROM venta WHERE fecha = fecha_venta;
    RETURN total_ventas;
END;

//Funcion para Obtener el Cliente que mas ha Gastado en Compras

CREATE FUNCTION cliente_mayor_gasto RETURN VARCHAR2 IS
    cliente_gasto VARCHAR2(100);
BEGIN
    SELECT c.nombre || ' ' || c.apellidos INTO cliente_gasto
    FROM clientes c
    JOIN venta v ON c.id_clientes = v.id_venta
    WHERE v.total = (SELECT MAX(total) FROM venta);
    RETURN cliente_gasto;
END;

//Funcion para Obtener el Nombre del Cliente que ha Realizado la Ultima Compra

CREATE FUNCTION ultimo_cliente_compra RETURN VARCHAR2 IS
    nombre_cliente VARCHAR2(100);
BEGIN
    SELECT c.nombre || ' ' || c.apellidos INTO nombre_cliente
    FROM clientes c
    JOIN venta v ON c.id_clientes = v.id_venta
    WHERE v.fecha = (SELECT MAX(fecha) FROM venta);
    RETURN nombre_cliente;
END;


--- PAQETES CON FUNCIONES ---


//Paquete para hacer Operaciones Basicas con Productos

CREATE OR REPLACE PACKAGE paquete_productos AS
FUNCTION obtener_precio_producto(id_prod NUMBER) RETURN NUMBER;
FUNCTION contar_productos_categoria(categ VARCHAR2) RETURN NUMBER;
    -- Posible agregar otras funciones y procedimientos relacionados con productos
END paquete_productos;

//Paquete para Operaciones con Clientes

CREATE OR REPLACE PACKAGE paquete_clientes AS
    FUNCTION total_gastado_cliente(id_cliente NUMBER) RETURN NUMBER;
    FUNCTION clientes_sin_compras RETURN VARCHAR2;
    -- Posible agregar otras funciones y procedimientos relacionados con clientes
END paquete_clientes;

//Paquete para Operaciones con Ventas

CREATE OR REPLACE PACKAGE paquete_ventas AS
    FUNCTION ultima_fecha_venta RETURN DATE;
    FUNCTION contar_ventas_dia(fecha_venta DATE) RETURN NUMBER;
    -- Posible agregar otras funciones y procedimientos relacionados con ventas
END paquete_ventas;

//Paquete para Operaciones con Administradores

CREATE OR REPLACE PACKAGE paquete_administradores AS
    FUNCTION obtener_nombre_administrador(correo VARCHAR2) RETURN VARCHAR2;
    -- Posible agregar otras funciones y procedimientos relacionados con administradores
END paquete_administradores;

//Paquete para Estadisticas Generales

CREATE OR REPLACE PACKAGE paquete_estadisticas AS
    FUNCTION promedio_precios RETURN NUMBER;
    FUNCTION cliente_mayor_gasto RETURN VARCHAR2;
    -- Posible agregar otras funciones y procedimientos relacionados con estadísticas
END paquete_estadisticas;

//Paquete para Operaciones con Fechas

CREATE OR REPLACE PACKAGE paquete_fechas AS
    FUNCTION obtener_dia_semana(fecha DATE) RETURN VARCHAR2;
    -- Posible agregar otras funciones y procedimientos relacionados con fechas
END paquete_fechas;

//Paquete para Reportes de Ventas

CREATE OR REPLACE PACKAGE paquete_reportes_ventas AS
    PROCEDURE generar_reporte_ventas(fecha_inicio DATE, fecha_fin DATE);
    -- Posible agregar otras funciones y procedimientos para reportes de ventas
END paquete_reportes_ventas;

//Paquete para Operaciones Matematicas

CREATE OR REPLACE PACKAGE paquete_operaciones_matematicas AS
    FUNCTION calcular_impuesto(precio NUMBER) RETURN NUMBER;
    -- Posible agregar otras funciones y procedimientos matemáticos
END paquete_operaciones_matematicas;

//Paquete para Funciones de Seguridad

CREATE OR REPLACE PACKAGE paquete_seguridad AS
    FUNCTION validar_contrasena(correo VARCHAR2, contrasena VARCHAR2) RETURN BOOLEAN;
    -- Posible agregar otras funciones y procedimientos de seguridad
END paquete_seguridad;

//Paquete para Operaciones Generales del Sistema

CREATE OR REPLACE PACKAGE paquete_sistema AS
    FUNCTION obtener_version_sistema RETURN VARCHAR2;
    FUNCTION obtener_fecha_actual RETURN DATE;
    -- Posible agregar otras funciones y procedimientos generales del sistema
END paquete_sistema;


--- TRIGGERS ---

//Trigger para mantener actualizado el Total Gastado por un Cliente

CREATE OR REPLACE TRIGGER actualiza_total_gastado
AFTER INSERT OR UPDATE ON venta
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE clientes SET total_gastado = total_gastado + :NEW.total WHERE id_clientes = :NEW.id_venta;
    ELSIF UPDATING THEN
        UPDATE clientes SET total_gastado = total_gastado - :OLD.total + :NEW.total WHERE id_clientes = :NEW.id_venta;
    END IF;
END;

//Trigger para Verificar el Precio Minimo de los Productos Antes de una Inserción

CREATE OR REPLACE TRIGGER precio_minimo_producto
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
    IF :NEW.precio < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El precio no puede ser negativo.');
    END IF;
END;

//Trigger para Mantener Actualizado el Contador de Ventas de un Cliente

CREATE OR REPLACE TRIGGER actualizar_contador_ventas
AFTER INSERT ON venta
FOR EACH ROW
BEGIN
    UPDATE clientes SET num_ventas = num_ventas + 1 WHERE id_clientes = :NEW.id_venta;
END;

//Trigger para Auditar Cambios en la Tabla de Productos

CREATE OR REPLACE TRIGGER auditoria_productos
AFTER INSERT OR UPDATE OR DELETE ON producto
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO auditoria_productos (id_producto, accion, fecha) VALUES (:NEW.id_producto, 'INSERT', SYSDATE);
    ELSIF UPDATING THEN
        INSERT INTO auditoria_productos (id_producto, accion, fecha) VALUES (:OLD.id_producto, 'UPDATE', SYSDATE);
    ELSIF DELETING THEN
        INSERT INTO auditoria_productos (id_producto, accion, fecha) VALUES (:OLD.id_producto, 'DELETE', SYSDATE);
    END IF;
END;

//Trigger para Evitar Duplicados en la Tabla de Administradores

CREATE OR REPLACE TRIGGER evitar_duplicados_administradores
BEFORE INSERT OR UPDATE ON administrador
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF EXISTS (SELECT 1 FROM administrador WHERE correo_electronico = :NEW.correo_electronico AND id_administrador != :NEW.id_administrador) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Ya existe un administrador con el mismo correo electrónico.');
        END IF;
    ELSIF UPDATING THEN
        IF EXISTS (SELECT 1 FROM administrador WHERE correo_electronico = :NEW.correo_electronico AND id_administrador != :NEW.id_administrador) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Ya existe otro administrador con el mismo correo electrónico.');
        END IF;
    END IF;
END;



 







