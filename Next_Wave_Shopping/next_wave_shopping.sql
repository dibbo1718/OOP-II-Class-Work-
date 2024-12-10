-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 10, 2024 at 05:15 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `next_wave_shopping`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrderDetails` (IN `orderID` INT)   BEGIN
    SELECT 
        Orders.order_id, 
        Orders.order_date, 
        Users.name AS customer_name, 
        Products.name AS product_name, 
        Order_Items.quantity, 
        Order_Items.price
    FROM 
        Orders
    JOIN 
        Order_Items ON Orders.order_id = Order_Items.order_id
    JOIN 
        Products ON Order_Items.product_id = Products.product_id
    JOIN 
        Users ON Orders.user_id = Users.user_id
    WHERE 
        Orders.order_id = orderID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrderPaymentDetails` (IN `orderID` INT)   BEGIN
    SELECT 
        Orders.order_id, 
        Orders.total_amount, 
        Payment_Transactions.payment_method, 
        Payment_Transactions.status AS payment_status,
        Products.name AS product_name, 
        Order_Items.quantity, 
        Order_Items.price
    FROM 
        Orders
    JOIN 
        Payment_Transactions ON Orders.order_id = Payment_Transactions.order_id
    JOIN 
        Order_Items ON Orders.order_id = Order_Items.order_id
    JOIN 
        Products ON Order_Items.product_id = Products.product_id
    WHERE 
        Orders.order_id = orderID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin_logs`
--

CREATE TABLE `admin_logs` (
  `log_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `action_type` varchar(100) NOT NULL,
  `action_details` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_logs`
--

INSERT INTO `admin_logs` (`log_id`, `admin_id`, `action_type`, `action_details`, `created_at`) VALUES
(1, 4, 'Product Approval', 'Approved product ID 3', '2024-11-25 02:35:18'),
(2, 4, 'User Ban', 'Banned user ID 5 for policy violations', '2024-11-25 02:35:18');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `product_id`, `quantity`, `added_at`) VALUES
(1, 1, 4, 1, '2024-11-25 02:35:04'),
(2, 2, 2, 2, '2024-11-25 02:35:04');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `parent_category_id`, `created_at`) VALUES
(1, 'Electronics', NULL, '2024-11-25 02:34:00'),
(2, 'Smartphones', 1, '2024-11-25 02:34:00'),
(3, 'Fashion', NULL, '2024-11-25 02:34:00'),
(4, 'Men', 3, '2024-11-25 02:34:00');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `product_id`, `supplier_id`, `quantity`, `last_updated`) VALUES
(1, 1, 1, 50, '2024-11-25 02:34:44'),
(2, 2, 1, 100, '2024-11-25 02:34:44'),
(3, 3, 2, 30, '2024-11-25 02:34:44'),
(4, 4, 2, 75, '2024-11-25 02:34:44');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message_text` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `sender_id`, `receiver_id`, `message_text`, `sent_at`) VALUES
(1, 1, 3, 'Can I get a discount on bulk orders?', '2024-11-25 02:35:12'),
(2, 3, 1, 'Yes, we offer discounts for orders over 10 items.', '2024-11-25 02:35:12');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','shipped','delivered','cancelled') DEFAULT 'pending',
  `shipping_address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_amount`, `status`, `shipping_address`) VALUES
(1, 1, '2024-11-25 02:34:17', 749.98, 'pending', '789 Customer Lane, Cityville'),
(2, 2, '2024-11-25 02:34:17', 99.98, 'shipped', '456 Another Street, Townsville');

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `NotifyCustomerOnShip` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    -- Check if the order status has been updated to 'shipped'
    IF NEW.status = 'shipped' AND OLD.status <> 'shipped' THEN
        -- Log a simulated email notification (in reality, you would send an actual email)
        INSERT INTO Notifications (user_id, message, sent_at)
        VALUES (NEW.user_id, CONCAT('Your order ID ', NEW.order_id, ' has been shipped. Track it using the provided tracking number.'), NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 1, 1, 699.99),
(2, 1, 2, 1, 49.99),
(3, 2, 3, 2, 59.99);

--
-- Triggers `order_items`
--
DELIMITER $$
CREATE TRIGGER `PreventNegativeStock` BEFORE INSERT ON `order_items` FOR EACH ROW BEGIN
    DECLARE available_stock INT;

    -- Check available stock for the product being ordered
    SELECT quantity INTO available_stock
    FROM Inventory
    WHERE product_id = NEW.product_id;

    -- If there is insufficient stock, raise an error
    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for this product.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UpdateInventoryAfterOrder` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN
    -- Update inventory by reducing the stock based on the quantity ordered
    UPDATE Inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_routing`
--

CREATE TABLE `order_routing` (
  `routing_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `status` enum('pending','forwarded','completed') DEFAULT 'pending',
  `forwarded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_routing`
--

INSERT INTO `order_routing` (`routing_id`, `order_id`, `supplier_id`, `status`, `forwarded_at`) VALUES
(1, 1, 1, 'forwarded', '2024-11-25 02:35:59'),
(2, 2, 2, 'completed', '2024-11-25 02:35:59');

-- --------------------------------------------------------

--
-- Table structure for table `payment_transactions`
--

CREATE TABLE `payment_transactions` (
  `transaction_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_method` enum('credit_card','paypal','bank_transfer','other') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('success','failed','pending') DEFAULT 'pending',
  `transaction_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_transactions`
--

INSERT INTO `payment_transactions` (`transaction_id`, `order_id`, `payment_method`, `amount`, `status`, `transaction_date`) VALUES
(2, 1, 'credit_card', 749.98, 'success', '2024-11-25 02:34:30'),
(3, 2, 'paypal', 99.98, 'success', '2024-11-25 02:34:30');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `supplier_id`, `name`, `description`, `price`, `stock`, `status`, `created_at`) VALUES
(1, 1, 'Smartphone X', 'Latest model with cutting-edge features', 699.99, 50, 'active', '2024-11-25 02:34:08'),
(2, 1, 'Wireless Earbuds', 'Noise-canceling earbuds with long battery life', 49.99, 100, 'active', '2024-11-25 02:34:08'),
(3, 2, 'Denim Jacket', 'Stylish and comfortable for all seasons', 59.99, 30, 'active', '2024-11-25 02:34:08'),
(4, 2, 'Sneakers', 'Durable and trendy shoes for daily wear', 39.99, 75, 'active', '2024-11-25 02:34:08');

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `LogAdminAction` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
    -- Insert an admin log entry after a product update
    INSERT INTO Admin_Logs (admin_id, action_type, action_details)
    VALUES (1, 'Product Update', CONCAT('Product ID ', OLD.product_id, ' was updated.'));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `LogPriceChanges` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
    IF OLD.price <> NEW.price THEN
        -- Log the price change into Admin_Logs
        INSERT INTO Admin_Logs (admin_id, action_type, action_details)
        VALUES (1, 'Price Update', CONCAT('Product ID ', OLD.product_id, ' price changed from ', OLD.price, ' to ', NEW.price));
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `PreventProductDeletion` BEFORE DELETE ON `products` FOR EACH ROW BEGIN
    DECLARE order_count INT;

    -- Check if there are any orders with the product
    SELECT COUNT(*) INTO order_count
    FROM Order_Items
    WHERE product_id = OLD.product_id;

    -- If the product is part of any order, prevent deletion
    IF order_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete product, it has active orders.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_moderation`
--

CREATE TABLE `product_moderation` (
  `moderation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `moderator_id` int(11) NOT NULL,
  `status` enum('approved','rejected','pending') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_moderation`
--

INSERT INTO `product_moderation` (`moderation_id`, `product_id`, `moderator_id`, `status`, `notes`, `updated_at`) VALUES
(1, 1, 4, 'approved', 'Meets quality standards', '2024-11-25 02:35:26'),
(2, 4, 4, 'rejected', 'Description too vague', '2024-11-25 02:35:26');

-- --------------------------------------------------------

--
-- Table structure for table `promotions`
--

CREATE TABLE `promotions` (
  `promotion_id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `discount_percent` decimal(5,2) NOT NULL CHECK (`discount_percent` between 0 and 100),
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `applies_to` enum('all','category','product') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `promotions`
--

INSERT INTO `promotions` (`promotion_id`, `code`, `discount_percent`, `start_date`, `end_date`, `applies_to`) VALUES
(1, 'NEWUSER10', 10.00, '2024-11-01', '2024-11-30', 'all'),
(2, 'FASHION20', 20.00, '2024-11-15', '2024-12-15', 'category');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `rating` decimal(2,1) NOT NULL CHECK (`rating` between 0 and 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `reviews`
--
DELIMITER $$
CREATE TRIGGER `UpdateProductRating` AFTER INSERT ON `reviews` FOR EACH ROW BEGIN
    DECLARE avg_rating DECIMAL(3,2);

    -- Calculate the new average rating for the product
    SELECT AVG(rating) INTO avg_rating
    FROM Reviews
    WHERE product_id = NEW.product_id;

    -- Update the product's rating in the Products table
    UPDATE Products
    SET rating = avg_rating
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales_reports`
--

CREATE TABLE `sales_reports` (
  `report_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `total_sales` int(11) NOT NULL,
  `revenue` decimal(10,2) NOT NULL,
  `date_range` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales_reports`
--

INSERT INTO `sales_reports` (`report_id`, `product_id`, `total_sales`, `revenue`, `date_range`) VALUES
(1, 1, 10, 6999.90, '2024-11-01 to 2024-11-10'),
(2, 3, 15, 899.85, '2024-11-01 to 2024-11-10');

-- --------------------------------------------------------

--
-- Table structure for table `shipping`
--

CREATE TABLE `shipping` (
  `shipping_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `shipping_address` text NOT NULL,
  `shipping_method` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(50) DEFAULT NULL,
  `status` enum('in_transit','delivered','returned','cancelled') DEFAULT 'in_transit'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shipping`
--

INSERT INTO `shipping` (`shipping_id`, `order_id`, `shipping_address`, `shipping_method`, `tracking_number`, `status`) VALUES
(1, 1, '789 Customer Lane, Cityville', 'Standard', 'TRACK12345', 'in_transit'),
(2, 2, '456 Another Street, Townsville', 'Express', 'TRACK67890', 'delivered');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `name`, `email`, `contact_number`, `address`, `rating`) VALUES
(1, 'Gadget World', 'supplier1@example.com', '1234567890', '123 Tech Street', 4.50),
(2, 'Fashion Hub', 'supplier2@example.com', '9876543210', '456 Style Avenue', 4.00);

-- --------------------------------------------------------

--
-- Table structure for table `supplier_pricing`
--

CREATE TABLE `supplier_pricing` (
  `pricing_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier_pricing`
--

INSERT INTO `supplier_pricing` (`pricing_id`, `supplier_id`, `product_id`, `price`, `last_updated`) VALUES
(1, 1, 1, 500.00, '2024-11-25 02:35:53'),
(2, 2, 3, 40.00, '2024-11-25 02:35:53');

-- --------------------------------------------------------

--
-- Table structure for table `traffic_analytics`
--

CREATE TABLE `traffic_analytics` (
  `analytics_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `page_visited` varchar(255) DEFAULT NULL,
  `visit_duration` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `traffic_analytics`
--

INSERT INTO `traffic_analytics` (`analytics_id`, `user_id`, `page_visited`, `visit_duration`, `timestamp`) VALUES
(1, 1, 'Product Page: Smartphone X', 120, '2024-11-25 02:35:40'),
(2, 2, 'Category: Fashion', 90, '2024-11-25 02:35:40');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('customer','admin','supplier') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password_hash`, `role`, `created_at`) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'hashed_password1', 'customer', '2024-11-25 02:33:43'),
(2, 'Bob Smith', 'bob@example.com', 'hashed_password2', 'customer', '2024-11-25 02:33:43'),
(3, 'Charlie Brown', 'charlie@example.com', 'hashed_password3', 'supplier', '2024-11-25 02:33:43'),
(4, 'Admin User', 'admin@example.com', 'hashed_password4', 'admin', '2024-11-25 02:33:43');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `wishlist_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`wishlist_id`, `user_id`, `product_id`, `created_at`) VALUES
(1, 1, 2, '2024-11-25 02:34:50'),
(2, 2, 3, '2024-11-25 02:34:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `parent_category_id` (`parent_category_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `order_routing`
--
ALTER TABLE `order_routing`
  ADD PRIMARY KEY (`routing_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `product_moderation`
--
ALTER TABLE `product_moderation`
  ADD PRIMARY KEY (`moderation_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `moderator_id` (`moderator_id`);

--
-- Indexes for table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`promotion_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sales_reports`
--
ALTER TABLE `sales_reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `shipping`
--
ALTER TABLE `shipping`
  ADD PRIMARY KEY (`shipping_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `supplier_pricing`
--
ALTER TABLE `supplier_pricing`
  ADD PRIMARY KEY (`pricing_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `traffic_analytics`
--
ALTER TABLE `traffic_analytics`
  ADD PRIMARY KEY (`analytics_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`wishlist_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `order_routing`
--
ALTER TABLE `order_routing`
  MODIFY `routing_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_moderation`
--
ALTER TABLE `product_moderation`
  MODIFY `moderation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `promotion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sales_reports`
--
ALTER TABLE `sales_reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `shipping`
--
ALTER TABLE `shipping`
  MODIFY `shipping_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `supplier_pricing`
--
ALTER TABLE `supplier_pricing`
  MODIFY `pricing_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `traffic_analytics`
--
ALTER TABLE `traffic_analytics`
  MODIFY `analytics_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `wishlist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD CONSTRAINT `admin_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `order_routing`
--
ALTER TABLE `order_routing`
  ADD CONSTRAINT `order_routing_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_routing_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);

--
-- Constraints for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  ADD CONSTRAINT `payment_transactions_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);

--
-- Constraints for table `product_moderation`
--
ALTER TABLE `product_moderation`
  ADD CONSTRAINT `product_moderation_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `product_moderation_ibfk_2` FOREIGN KEY (`moderator_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `sales_reports`
--
ALTER TABLE `sales_reports`
  ADD CONSTRAINT `sales_reports_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `shipping`
--
ALTER TABLE `shipping`
  ADD CONSTRAINT `shipping_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `supplier_pricing`
--
ALTER TABLE `supplier_pricing`
  ADD CONSTRAINT `supplier_pricing_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `supplier_pricing_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `traffic_analytics`
--
ALTER TABLE `traffic_analytics`
  ADD CONSTRAINT `traffic_analytics_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
