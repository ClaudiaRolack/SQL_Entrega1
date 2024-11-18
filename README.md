# SQL_Entrega1
Simulación de base de datos de tienda virtual Buscalibre.

# Proyecto de Base de Datos para Plataforma de Comercio Electrónico

## Descripción General
Este proyecto define una base de datos relacional en MySQL diseñada para gestionar una plataforma de comercio electrónico similar a **Buscalibre**. 

La plataforma se especializa en la venta de libros, productos electrónicos, juegos de mesa y otros artículos provenientes de diferentes partes del mundo, ofreciendo envíos a domicilio tanto dentro de Chile como a otros países. Además, es reconocida por su amplia variedad de títulos y por facilitar la importación de productos difíciles de encontrar en el mercado local.

La base de datos organiza información clave sobre clientes, productos, categorías, pedidos, promociones, envíos, pagos y más, asegurando integridad referencial y escalabilidad.

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
Registra los productos comprados en cada pedido.
- **Campos:**
  - `OrderDetailID`: Identificador único (PK).
  - `OrderID`: FK hacia `Orders`.
  - `ProductID`: FK hacia `Products`.
  - `Quantity`: Cantidad de productos.
  - `PriceAtPurchase`: Precio al momento de la compra.

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

## Diagrama Relacional

![Diagrama](./images/diagrama.png)

