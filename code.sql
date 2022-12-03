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

INSERT INTO inventory (id, balance) VALUES
    (1, 5000.00);

INSERT INTO user (id, username, password, inventory_id) VALUES
    (1, 'coffeshop', 'admin', 1);

INSERT INTO category (id, name) VALUES
    (1, 'Ingredients'),
    (2, 'Tea leaves'),
    (3, 'Toppings');

INSERT INTO supplier (id, name, country) VALUES
    (1, 'Acme Coffee', 'US'),
    (2, 'Bean Brothers', 'Colombia'),
    (3, 'Cup O Joe', 'France'),
    (4, 'Tea Bags', 'US');

INSERT INTO item (id, name, description, price, quantity, supplier_id, category_id, inventory_id) VALUES
	(1, 'Espresso beans', 'dark brown beans that are roasted to perfection',
	1.49, 15, 1, 1, 1);

INSERT INTO item (id, name, description, price, quantity, supplier_id, category_id, inventory_id) VALUES
	(2, 'Coconut milk', 'dairy-free milk alternative',
	2.99, 35, 2, 1, 1);

INSERT INTO item (id, name, description, price, quantity, supplier_id, category_id, inventory_id) VALUES
	(3, 'Cinnamon', 'fragrant spice that adds a warm aroma',
	3.49, 4, 3, 1, 1);

INSERT INTO item (id, name, description, price, quantity, supplier_id, category_id, inventory_id) VALUES
	(4, 'Whipped cream', 'a light topping that adds sweet texture',
	3.99, 3, 3, 2, 1);

INSERT INTO item (id, name, description, price, quantity, supplier_id, category_id, inventory_id) VALUES
	(5, 'Chocolate chips', 'sweet pieces of chocolate',
	2.99, 53, 4, 2, 1);

INSERT INTO item (id, name, description, price, quantity, supplier_id, category_id, inventory_id) VALUES
	(6, 'Cinnamon sugar', 'a mixture of ground cinnamon and sugar',
	3.39, 44, 4, 2, 1);

INSERT INTO item (id, name, description, price, quantity, supplier_id, category_id, inventory_id) VALUES
	(7, 'Earl Grey', 'a classic black tea',
	3.49, 62, 4, 3, 1);

INSERT INTO item (id, name, description, price, quantity, supplier_id, category_id, inventory_id) VALUES
	(8, 'Darjeeling tea', 'a delicate and aromatic tea',
	1.39, 53, 2, 3, 1);

INSERT INTO item (id, name, description, price, quantity, supplier_id, category_id, inventory_id) VALUES
	(9, 'White tea', 'a rare and delicate tea',
	5.39, 33, 3, 3, 1);

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