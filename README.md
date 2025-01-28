# Entrega de proyecto final
Simulación de base de datos de tienda virtual Buscalibre.

# Proyecto de Base de Datos para Plataforma de Comercio Electrónico

## Introducción
Este proyecto define una base de datos relacional en MySQL diseñada para gestionar una plataforma de comercio electrónico similar a **Buscalibre**. 

La plataforma se especializa en la venta de libros, productos electrónicos, juegos de mesa y otros artículos provenientes de diferentes partes del mundo, ofreciendo envíos a domicilio tanto dentro de Chile como a otros países. Además, es reconocida por su amplia variedad de títulos y por facilitar la importación de productos difíciles de encontrar en el mercado local.

La base de datos organiza información clave sobre clientes, productos, categorías, pedidos, promociones, envíos, pagos y más, asegurando integridad referencial y escalabilidad.

## Objetivo
El objetivo principal de este proyecto es diseñar e implementar una base de datos relacional en MySQL que sirva como soporte fundamental para la gestión integral de una plataforma de comercio electrónico, inspirada en Buscalibre. Este sistema busca optimizar y organizar de manera eficiente las operaciones relacionadas con la venta de libros, productos electrónicos, juegos de mesa y otros artículos, garantizando una experiencia de usuario fluida y confiable.

La base de datos está diseñada para cubrir múltiples aristas funcionales y cross-funcionales que son esenciales para el éxito de una plataforma de este tipo, incluyendo:

- **Gestión de Información Contable:** Registrar transacciones financieras, controlar ingresos asociados a las ventas, y asegurar un seguimiento adecuado de los pagos realizados por los clientes.

- **Logística y Envíos:** Manejar el flujo de envíos nacionales e internacionales, facilitando la integración de información sobre pedidos, direcciones de entrega y estados de los envíos, optimizando la cadena de suministro.

- **Análisis y Toma de Decisiones:** Proveer una estructura de datos que permita realizar análisis detallados sobre el comportamiento de los clientes, los productos más vendidos, la efectividad de las promociones y otros indicadores clave que contribuyan al crecimiento estratégico del negocio.

- **Gestión de Promociones:** Administrar descuentos, campañas promocionales y ofertas especiales de forma dinámica, ajustándolas a las necesidades del mercado y las preferencias de los clientes.

## Situación problemática

En la actualidad, las plataformas de comercio electrónico enfrentan múltiples desafíos para satisfacer las demandas de los consumidores y gestionar sus operaciones de manera eficiente. Entre estos desafíos destacan:

- **Desorganización en el manejo de datos:** Sin una estructura de base de datos adecuada, la información clave sobre productos, clientes, pedidos y envíos se encuentra dispersa, lo que dificulta el acceso, la actualización y el análisis.

- **Falta de integridad referencial:** La ausencia de un modelo relacional puede llevar a errores de datos, duplicaciones o inconsistencias que afectan la experiencia del cliente y las decisiones del negocio.

- **Dificultad para gestionar múltiples categorías de productos y envíos internacionales:** Empresas como Buscalibre deben manejar una amplia variedad de productos y servicios asociados con procesos complejos de importación y logística.

- **Limitaciones en el análisis de datos:** Sin un sistema centralizado, resulta complicado generar reportes analíticos sobre ventas, comportamiento del cliente y desempeño de las promociones.

- **Problemas de escalabilidad:** La falta de un diseño que soporte el crecimiento del negocio puede derivar en sistemas que no se adaptan al aumento de la demanda ni a la expansión a nuevos mercados.

La implementación de una base de datos relacional en MySQL permite resolver estas brechas al proporcionar una solución estructurada, escalable y eficiente para gestionar todas las operaciones de la plataforma. Además, facilita la integración de datos clave, mejorando la toma de decisiones estratégicas, la satisfacción del cliente y la competitividad del negocio.

## Modelo de negocio

La plataforma está diseñada para conectar consumidores con una amplia variedad de productos, destacando libros difíciles de conseguir, productos electrónicos y juegos de mesa. Ofrece envíos nacionales e internacionales con foco en la experiencia del cliente y la eficiencia logística.

- **Propuesta de Valor:** Amplia oferta de productos, envíos confiables y promociones personalizadas.

- **Canales:** Página web y aplicación móvil, integrados con sistemas de pago y logística.

- **Segmentos de Clientes:** Lectores y consumidores interesados en productos únicos o importados.

- **Fuentes de Ingreso:** Venta de productos y campañas promocionales.

- **Procesos Internos:** Gestión centralizada de datos (productos, pedidos, clientes y envíos) mediante la base de datos MySQL, permitiendo análisis y escalabilidad.

---

## Diagrama Relacional

![Diagrama](./images/diagrama/diagrama_buscalibre.png)

---

## Relaciones Principales
1. **Customers ↔ Countries:** Un cliente pertenece a un país.
2. **Customers ↔ Reviews:** Un cliente puede realizar muchas reseñas.
3. **Reviews ↔ Products:** Un producto puede tener muchas reseñas.
4. **Publishers ↔ Products:** Una editorial puede proveer muchos productos.
5. **Categories ↔ Products:** Las categorías contienen muchos productos.
6. **Wishlist ↔ Customers:** Un cliente tiene una lista de deseos.
7. **Products ↔ Orders:** Muchos productos pueden estar en muchas órdenes.
8. **Orders ↔ Shipments:** Una orden puede tener muchos envíos.
9. **Orders ↔ Payments:** Una orden tiene un pago.
10. **Promotions ↔ Products:** Muchas promociones pueden aplicarse a un producto.

---

## Estructura de Tablas

### 1. Countries
Guarda información de los países en los que opera la plataforma.
- **Campos:**
  - `CountryID`: Identificador único (PK).
  - `Name`: Nombre del país.
  - `Currency`: Moneda del país.
  - `Language`: Idioma principal.
  - `TaxRate`: Tasa de impuestos aplicada.

### 2. Publishers
Registra a las editoriales como proveedores.
- **Campos:**
  - `PublisherID`: Identificador único (PK).
  - `Name`: Nombre de la editorial.
  - `ContactEmail`: Correo de contacto.
  - `PhoneNumber`: Número de teléfono.
  - `Address`: Dirección de la editorial.

### 3. Categories
Define las categorías de los productos.
- **Campos:**
  - `CategoryID`: Identificador único (PK).
  - `Name`: Nombre de la categoría.

### 4. Customers
Almacena la información de los clientes.
- **Campos:**
  - `CustomerID`: Identificador único (PK).
  - `Name`: Nombre del cliente.
  - `Email`: Correo electrónico (único).
  - `PhoneNumber`: Número de teléfono.
  - `CountryID`: FK hacia `Countries`.
  - `Address`: Dirección del cliente.

### 5. Products
Gestiona los productos que se ofrecen en la plataforma.
- **Campos:**
  - `ProductID`: Identificador único (PK).
  - `Name`: Nombre del producto.
  - `Description`: Descripción del producto.
  - `BasePrice`: Precio base.
  - `Stock`: Cantidad disponible.
  - `CountryID`: FK hacia `Countries` (país de origen o distribución).

### 6. Promotions
Administra las promociones activas en la plataforma.
- **Campos:**
  - `PromotionID`: Identificador único (PK).
  - `Name`: Nombre de la promoción.
  - `DiscountPercentage`: Porcentaje de descuento.
  - `StartDate`: Fecha de inicio.
  - `EndDate`: Fecha de finalización.

### 7. Reviews
Permite a los clientes dejar reseñas sobre los productos.
- **Campos:**
  - `ReviewID`: Identificador único (PK).
  - `CustomerID`: FK hacia `Customers`.
  - `ProductID`: FK hacia `Products`.
  - `Rating`: Calificación (1-5).
  - `Comment`: Comentario del cliente.
  - `ReviewDate`: Fecha de la reseña.

### 8. Orders
Registra los pedidos realizados por los clientes.
- **Campos:**
  - `OrderID`: Identificador único (PK).
  - `CustomerID`: FK hacia `Customers`.
  - `OrderDate`: Fecha del pedido.
  - `TotalAmount`: Monto total.

### 9. Shipments
Rastrea los envíos asociados a los pedidos.
- **Campos:**
  - `ShipmentID`: Identificador único (PK).
  - `OrderID`: FK hacia `Orders`.
  - `ShipmentDate`: Fecha de envío.
  - `TrackingNumber`: Número de rastreo.
  - `Status`: Estado del envío.

### 10. Payments
Guarda los detalles de los pagos realizados por los pedidos.
- **Campos:**
  - `PaymentID`: Identificador único (PK).
  - `OrderID`: FK hacia `Orders`.
  - `PaymentDate`: Fecha de pago.
  - `Amount`: Monto pagado.
  - `PaymentMethod`: Método de pago.

### 11. Wishlist
Permite a los clientes guardar productos como favoritos.
- **Campos:**
  - `WishlistID`: Identificador único (PK).
  - `CustomerID`: FK hacia `Customers`.

---

## Tablas Intermedias

### 1. ProductCategories
Relaciona productos con categorías (muchos a muchos).
- **Campos:**
  - `ProductCategoryID`: Identificador único (PK).
  - `ProductID`: FK hacia `Products`.
  - `CategoryID`: FK hacia `Categories`.

### 2. WishlistProducts
Asocia productos a listas de deseos (muchos a muchos).
- **Campos:**
  - `WishlistProductID`: Identificador único (PK).
  - `WishlistID`: FK hacia `Wishlist`.
  - `ProductID`: FK hacia `Products`.

### 3. ProductPromotions
Vincula productos con promociones (muchos a muchos).
- **Campos:**
  - `ProductPromotionID`: Identificador único (PK).
  - `ProductID`: FK hacia `Products`.
  - `PromotionID`: FK hacia `Promotions`.

### 4. OrderDetails
Registra los productos comprados en cada pedido(tabla de hechos).
- **Campos:**
  - `OrderDetailID`: Identificador único (PK).
  - `OrderID`: FK hacia `Orders`.
  - `ProductID`: FK hacia `Products`.
  - `Quantity`: Cantidad de productos.
  - `PriceAtPurchase`: Precio al momento de la compra.

---

## Views

### 1. v_top_products
Lista los productos con mayor cantidad de ventas y sus detalles.
  - Objetivo: Facilitar el análisis de los productos más vendidos.
  - Tablas Compuestas: products, order_details.

### 2. v_top_rated_books
Esta vista muestra los libros con mejor calificación promedio basados en las reseñas de los usuarios.
  - Objetivo: Ayuda a identificar los libros más populares entre los clientes, lo cual es útil para promociones.
  - Tablas Compuestas: products, reviews.

### 3. v_sales_summary
Esta vista resume las ventas realizadas, mostrando el total de ingresos generados y el número de productos vendidos por pedido.
  - Objetivo: Ofrece un resumen de las ventas totales para analizar el rendimiento comercial.
  - Tablas Compuestas: orders, order_details.

### 4. v_customer_wishlists
Muestra las listas de deseos de los clientes, junto con los productos agregados a cada lista.
  - Objetivo: Permite a los administradores conocer las preferencias de los clientes y planificar inventarios o promociones.
  - Tablas Compuestas: customers, wishlist, wishlist_products, products.

### 5. v_promotions_active
Muestra todas las promociones activas, junto con los productos que están incluidos en ellas.
  - Objetivo: Facilita la identificación de promociones vigentes y sus productos relacionados para campañas de marketing.
  - Tablas Compuestas: promotions, product_promotions, products.

### 6. v_shipments_status
Muestra un resumen del estado de los envíos realizados, junto con la fecha y el número de seguimiento.
  - Objetivo: Proporciona un informe sobre el estado actual de los envíos para mejorar la logística.
  - Tablas Compuestas: shipments, orders, customers.

### 7. v_country_tax_rates
Muestra la tasa de impuestos de cada país y los productos asociados que pertenecen a esos países.
  - Objetivo: Es útil para calcular el precio total de los productos con impuestos incluidos según su país de origen.
  - Tablas Compuestas: countries, products.


## Functions

### 1. get_product_count_by_category
Devuelve el número total de productos asociados a una categoría específica.
  - Objetivo: Identificar cuántos productos pertenecen a una categoría dada.
  - Tablas Compuestas: products, product_categories, categories.

### 2. get_total_sales_by_customer
Calcula el total de dinero gastado por un cliente específico en función de sus pedidos.
  - Objetivo: Obtener el monto total de ventas asociadas a un cliente para análisis de ingresos o comportamiento.
  - Tablas Compuestas: orders, order_details.


## Stored Procedure

### 1. sp_create_promotion
Permite agregar una nueva promoción a la tabla promotions, con un porcentaje de descuento y un rango de fechas.
  - Objetivo: Crear una nueva promoción con el nombre, porcentaje de descuento, fecha de inicio y fecha de finalización.
  - Tablas Compuestas: promotions.

### 2. sp_sales_report
Obtiene un informe de ventas de productos, mostrando el total vendido de cada producto.
  - Objetivo: Generar un informe de ventas, mostrando el nombre del producto, la cantidad total vendida y los ingresos totales generados por cada producto.
  - Tablas Compuestas: order_details, products.


## Triggers

### 1. trg_update_total_amount
Actualiza automáticamente el campo total_amount en la tabla orders cada vez que se inserta, actualiza o elimina un detalle de pedido en la tabla order_details.
  - Objetivo: Mantener sincronizado el total del pedido con los detalles asociados, calculando la suma total en tiempo real.
  - Tablas Compuestas: orders, order_details.

### 2. trg_reduce_stock
Reduce automáticamente el stock disponible de un producto en la tabla products cuando se inserta un nuevo detalle en order_details.
  - Objetivo: Controlar y actualizar el inventario en tiempo real para evitar inconsistencias.
  - Tablas Compuestas: products, order_details.

---

## Proceso detallado de inserción de datos en tablas

![1](./images/proceso/1.png)

![2](./images/proceso/2.png)

![3](./images/proceso/3.png)

![4](./images/proceso/4.png)

![5](./images/proceso/5.png)

![6](./images/proceso/6.png)

![7](./images/proceso/7.png)

![8](./images/proceso/8.png)

![9](./images/proceso/9.png)

---

## Herramientas y tecnologías usadas

- **DBeaver**: Lo utilicé como la herramienta principal para la gestión de bases de datos y la ejecución de scripts SQL.

- **Visual Studio Code:** Lo utilicé para gestionar el control de versiones y subir el proyecto a GitHub.

- **Docker:** Lo utilicé como contenedor para mi base de datos. Así garantizo la consistencia del entorno de desarrollo y facilito el despliegue y la portabilidad del proyecto.