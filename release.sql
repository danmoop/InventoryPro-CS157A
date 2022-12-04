CREATE TABLE category (
    id INTEGER PRIMARY KEY,
    name VARCHAR(128)
);

CREATE TABLE supplier (
    id INTEGER PRIMARY KEY,
    name VARCHAR(128),
    country VARCHAR(128)
);

CREATE TABLE inventory (
    id INTEGER PRIMARY KEY,
    balance DECIMAL
);

CREATE TABLE item (
    id INTEGER PRIMARY KEY,
    name VARCHAR(128),
    description VARCHAR(128),
    price DECIMAL,
    quantity INTEGER,
    supplier_id INTEGER,
    category_id INTEGER,
    inventory_id INTEGER,
    FOREIGN KEY (supplier_id) REFERENCES supplier(id),
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (inventory_id) REFERENCES inventory(id)
);

CREATE TABLE user (
    id INTEGER PRIMARY KEY,
    username VARCHAR(128),
    password VARCHAR(128),
    inventory_id INTEGER,
    FOREIGN KEY (inventory_id) REFERENCES inventory(id),
    UNIQUE (username)
);

CREATE VIEW inventoryExpenseStatement AS
    SELECT supplier.name AS supplier_name, SUM(item.price * item.quantity) AS total_cost
    FROM item
    INNER JOIN supplier
    ON item.supplier_id = supplier.id
    GROUP BY supplier.name;

CREATE VIEW lowQuantityItemsStatement AS
    SELECT *
    FROM item
    WHERE quantity < 10;

CREATE VIEW importedItemsStatement AS
    SELECT item.id, item.name, item.description, item.price, item.quantity, item.category_id, item.supplier_id, supplier.country
    FROM item
    INNER JOIN supplier
    ON item.supplier_id = supplier.id
    WHERE supplier.country != 'US';