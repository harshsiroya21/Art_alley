-- Artisan Alley Database Schema

-- Create database
CREATE DATABASE IF NOT EXISTS artisan_alley;
USE artisan_alley;

-- Users table (Customer, Seller, Admin)
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('CUSTOMER', 'SELLER', 'ADMIN') NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE', 'PENDING') DEFAULT 'ACTIVE',
    delivery_address TEXT,
    shop_name VARCHAR(100),
    contact_info VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    seller_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(500),
    status ENUM('PENDING', 'ACTIVE', 'REJECTED', 'SOLD_OUT') DEFAULT 'PENDING',
    quantity INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Orders table
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT DEFAULT 1,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('NEW_ORDER', 'PROCESSING', 'OUT_FOR_DELIVERY', 'COMPLETED', 'CANCELED') DEFAULT 'NEW_ORDER',
    delivery_address TEXT,
    payment_method ENUM('CASH_ON_DELIVERY') DEFAULT 'CASH_ON_DELIVERY',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Cart table (for customers to add products before checkout)
CREATE TABLE cart (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_cart_item (customer_id, product_id)
);

-- Insert hardcoded admin user
INSERT INTO users (name, email, password, role, status) VALUES
('Admin', 'admin@artisanalley.com', 'admin123', 'ADMIN', 'ACTIVE');

-- Insert sample customers
INSERT INTO users (name, email, password, role, status, delivery_address) VALUES
('John Doe', 'john@example.com', 'password123', 'CUSTOMER', 'ACTIVE', '123 Main St, City, State 12345'),
('Jane Smith', 'jane@example.com', 'password123', 'CUSTOMER', 'ACTIVE', '456 Oak Ave, City, State 67890');

-- Insert sample sellers
INSERT INTO users (name, email, password, role, status, shop_name, contact_info) VALUES
('Bob Artisan', 'bob@artisan.com', 'password123', 'SELLER', 'ACTIVE', 'Bob\'s Crafts', 'Phone: 123-456-7890'),
('Alice Potter', 'alice@pottery.com', 'password123', 'SELLER', 'ACTIVE', 'Alice\'s Pottery', 'Phone: 987-654-3210'),
('Charlie Woodwork', 'charlie@wood.com', 'password123', 'SELLER', 'PENDING', 'Charlie\'s Woodworks', 'Phone: 555-123-4567');

-- Insert sample products
INSERT INTO products (seller_id, title, description, price, image_url, status, quantity) VALUES
(4, 'Handcrafted Wooden Bowl', 'Beautiful handcrafted wooden bowl made from oak wood.', 45.99, 'bowl.jpg', 'ACTIVE', 1),
(4, 'Custom Cutting Board', 'Personalized cutting board with engraved name.', 35.50, 'board.jpg', 'ACTIVE', 1),
(5, 'Ceramic Mug Set', 'Set of 4 hand-painted ceramic mugs.', 28.99, 'mugs.jpg', 'ACTIVE', 1),
(5, 'Decorative Vase', 'Elegant ceramic vase for home decoration.', 65.00, 'vase.jpg', 'ACTIVE', 1),
(6, 'Wooden Toy Car', 'Handcrafted wooden toy car for children.', 15.99, 'toy_car.jpg', 'PENDING', 1);

-- Insert sample orders
INSERT INTO orders (customer_id, product_id, quantity, total_price, status, delivery_address) VALUES
(2, 1, 1, 45.99, 'COMPLETED', '123 Main St, City, State 12345'),
(3, 3, 1, 28.99, 'OUT_FOR_DELIVERY', '456 Oak Ave, City, State 67890');
