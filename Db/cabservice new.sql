-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 08, 2025 at 08:31 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cabservice`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryId` int(11) NOT NULL,
  `categoryName` varchar(255) NOT NULL,
  `categoryType` varchar(100) DEFAULT NULL,
  `categoryStatus` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryId`, `categoryName`, `categoryType`, `categoryStatus`) VALUES
(1, 'Car', NULL, 'In stock'),
(2, 'Van', NULL, 'In stock');

-- --------------------------------------------------------

--
-- Table structure for table `chequedata`
--

CREATE TABLE `chequedata` (
  `chequeId` int(11) NOT NULL,
  `chequeNumber` varchar(255) NOT NULL,
  `chequeAmount` varchar(255) NOT NULL,
  `issuedDate` datetime DEFAULT NULL,
  `chequeDate` date NOT NULL,
  `chequeStatus` varchar(255) NOT NULL,
  `supplierId` int(11) NOT NULL,
  `stockPaymentId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `costing_details`
--

CREATE TABLE `costing_details` (
  `id` int(11) NOT NULL,
  `costing_header_id` int(11) NOT NULL,
  `description_customer` varchar(255) DEFAULT NULL,
  `product_code` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `warranty` varchar(100) DEFAULT NULL,
  `supplier` varchar(255) DEFAULT NULL,
  `unit_cost` decimal(15,2) DEFAULT NULL,
  `our_margin_percentage` decimal(5,2) DEFAULT NULL,
  `our_margin_value` decimal(15,2) DEFAULT NULL,
  `other_margin_percentage` decimal(5,2) DEFAULT NULL,
  `other_margin_value` decimal(15,2) DEFAULT NULL,
  `price_plus_margin` decimal(15,2) DEFAULT NULL,
  `selling_rate` decimal(15,2) DEFAULT NULL,
  `selling_rate_rounded` decimal(15,2) DEFAULT NULL,
  `uom` varchar(50) DEFAULT NULL,
  `qty` int(11) DEFAULT 1,
  `unit_price` decimal(15,2) DEFAULT NULL,
  `discount_percentage` decimal(5,2) DEFAULT NULL,
  `discount_value` decimal(15,2) DEFAULT NULL,
  `discounted_price` decimal(15,2) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `profit` decimal(15,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `needImage` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `costing_details`
--

INSERT INTO `costing_details` (`id`, `costing_header_id`, `description_customer`, `product_code`, `description`, `warranty`, `supplier`, `unit_cost`, `our_margin_percentage`, `our_margin_value`, `other_margin_percentage`, `other_margin_value`, `price_plus_margin`, `selling_rate`, `selling_rate_rounded`, `uom`, `qty`, `unit_price`, `discount_percentage`, `discount_value`, `discounted_price`, `amount`, `profit`, `created_at`, `needImage`) VALUES
(1, 1, 'A', '', '1', '1', '1', 10500.00, 42.00, 4410.00, 62.00, 6510.00, 10920.00, 12133.33, 12140.00, 'oo', 1, 12140.00, 10.00, 1214.00, 10926.00, 10926.00, 4472.00, '2024-12-29 06:40:38', NULL),
(2, 2, 'A', '', '1', '1', '1', 10500.00, 42.00, 4410.00, 62.00, 6510.00, 10920.00, 12133.33, 12140.00, 'oo', 1, 12140.00, 10.00, 1214.00, 10926.00, 10926.00, 4472.00, '2024-12-29 06:41:50', NULL),
(3, 2, 'b', '', 'hi', '1 Months', 'i', 1100.00, 35.00, 385.00, 12.00, 132.00, 517.00, 574.44, 580.00, 'io', 1, 580.00, 0.00, 0.00, 580.00, 580.00, 397.00, '2024-12-29 06:41:50', NULL),
(4, 3, '', 'cart', 'description', '12', 'kavindu', 100.00, 100.00, 100.00, 100.00, 100.00, 200.00, 222.22, 230.00, '', 1, 230.00, 0.00, 0.00, 230.00, 230.00, 200.00, '2025-01-22 17:34:55', 1);

-- --------------------------------------------------------

--
-- Table structure for table `costing_headers`
--

CREATE TABLE `costing_headers` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `total_amount` decimal(15,2) NOT NULL,
  `total_profit` decimal(15,2) NOT NULL,
  `status` varchar(50) DEFAULT 'draft',
  `cusId` int(11) DEFAULT NULL,
  `preparedBy` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `costing_headers`
--

INSERT INTO `costing_headers` (`id`, `created_at`, `updated_at`, `total_amount`, `total_profit`, `status`, `cusId`, `preparedBy`) VALUES
(1, '2024-12-29 06:40:38', '2024-12-29 06:40:38', 10926.00, 4472.00, 'draft', NULL, NULL),
(2, '2024-12-29 06:41:50', '2024-12-29 06:41:50', 11506.00, 4869.00, 'draft', NULL, NULL),
(3, '2025-01-22 17:34:55', '2025-01-22 17:34:55', 230.00, 200.00, 'draft', 6, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cusId` int(11) NOT NULL,
  `cusName` varchar(255) NOT NULL,
  `cusCode` varchar(255) NOT NULL,
  `cusAddress` varchar(255) NOT NULL,
  `cusPhone` varchar(255) NOT NULL,
  `cusJob` varchar(255) NOT NULL,
  `cusOffice` varchar(255) NOT NULL,
  `cusStore` varchar(255) NOT NULL,
  `cusEmail` varchar(255) DEFAULT NULL,
  `nic` varchar(255) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `customerReview` varchar(255) DEFAULT NULL,
  `customerDescription` varchar(255) DEFAULT NULL,
  `guarantorId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cusId`, `cusName`, `cusCode`, `cusAddress`, `cusPhone`, `cusJob`, `cusOffice`, `cusStore`, `cusEmail`, `nic`, `license`, `customerReview`, `customerDescription`, `guarantorId`) VALUES
(6, 'kavindu  Z', 'cus002', 'Hunnasgiriya Z', '1234567895 Z', 'kada Z', 'kavindu stores', 'terra', 'kavindu@gmail.com', 'nicZ', 'liceneZ', 'Bad', '', NULL),
(14, 'test', 'CUS003', 'kandy', '1', 'SE', '', '', NULL, '123456789v', '987654321', 'Good', NULL, NULL),
(17, 'test', 'CUS004', 'test', 'test', 'test', '', '', NULL, 'test', 'test', 'Good', NULL, NULL),
(18, 'test', 'CUS005', 'test', 'test', 'test', '', '', NULL, 'test', 'test', 'Good', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deliverynote`
--

CREATE TABLE `deliverynote` (
  `id` int(11) NOT NULL,
  `invoiceId` int(11) NOT NULL,
  `invoiceNo` varchar(255) NOT NULL,
  `productId` int(11) NOT NULL,
  `stockId` int(11) NOT NULL,
  `invoiceQty` int(11) NOT NULL,
  `sendQty` int(11) NOT NULL,
  `deliverdQty` int(11) NOT NULL,
  `totalAmount` int(11) NOT NULL,
  `deliveryStatus` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `duecustomer`
--

CREATE TABLE `duecustomer` (
  `duecustomerId` int(11) NOT NULL,
  `invoiceId` int(11) NOT NULL,
  `transactionId` int(11) NOT NULL,
  `cusId` int(11) NOT NULL,
  `dueDate` date NOT NULL,
  `dueamount` int(11) NOT NULL,
  `paidAmount` int(11) NOT NULL,
  `status` varchar(100) NOT NULL,
  `payType` varchar(50) DEFAULT NULL,
  `datedCheque` date DEFAULT NULL,
  `chequeDetail` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expensesId` int(11) NOT NULL,
  `expensesCatId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`expensesId`, `expensesCatId`, `productId`, `description`, `date`, `price`) VALUES
(1, 1, 14, 'test', '2025-02-04', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `expensescat`
--

CREATE TABLE `expensescat` (
  `expensesCatId` int(11) NOT NULL,
  `expensesCatName` varchar(255) DEFAULT NULL,
  `expensesCatType` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expensescat`
--

INSERT INTO `expensescat` (`expensesCatId`, `expensesCatName`, `expensesCatType`) VALUES
(1, 'Service', NULL),
(2, 'Other', NULL),
(3, 'Gas', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `guarantor`
--

CREATE TABLE `guarantor` (
  `guarantorId` int(11) NOT NULL,
  `guarantorName` varchar(255) NOT NULL,
  `guarantorNic` varchar(255) NOT NULL,
  `guarantorPhone` varchar(255) NOT NULL,
  `guarantorAddress` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guarantor`
--

INSERT INTO `guarantor` (`guarantorId`, `guarantorName`, `guarantorNic`, `guarantorPhone`, `guarantorAddress`) VALUES
(1, 'test', 'test', 'test', 'test'),
(2, 'z', 'z', 'z', 'z');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `invoiceId` int(11) NOT NULL,
  `invoiceNo` varchar(45) NOT NULL,
  `invoiceDate` datetime NOT NULL,
  `status` varchar(255) NOT NULL,
  `store` varchar(255) NOT NULL,
  `purchaseNo` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `cusId` int(11) NOT NULL,
  `invoiceTime` int(11) NOT NULL,
  `deliveryTime` int(11) NOT NULL,
  `performa` varchar(255) NOT NULL,
  `draft` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`invoiceId`, `invoiceNo`, `invoiceDate`, `status`, `store`, `purchaseNo`, `image`, `cusId`, `invoiceTime`, `deliveryTime`, `performa`, `draft`) VALUES
(30, '1502', '2025-01-31 17:11:40', 'delivery', 'terra', 'dw43423', NULL, 6, 3, 1, 'true', 'false'),
(31, '1503', '2025-01-31 17:00:34', 'delivery', 'terra', '', NULL, 6, 0, 2, 'false', 'false'),
(32, '1504', '2023-01-26 16:33:44', 'delivery', 'terra', '', NULL, 6, 0, 2, 'false', 'false'),
(34, '1505', '2025-01-26 16:38:30', 'delivery', 'terra', '', NULL, 6, 0, 1, 'false', 'false'),
(35, '1506', '2025-01-26 20:02:53', 'invoice', 'terra', 'one', NULL, 6, 0, 0, 'false', 'false'),
(37, '1507', '2025-01-29 17:23:51', 'invoice', 'terra', '', NULL, 6, 0, 0, 'false', 'false'),
(38, '1508', '2025-01-29 17:25:08', 'invoice', 'terra', '', NULL, 6, 1, 1, 'false', 'false'),
(39, '1509', '2025-01-29 14:17:43', 'delivery', 'terra', '', NULL, 6, 1, 3, 'false', 'false'),
(41, '1511', '2025-01-29 17:23:31', 'invoice', 'terra', 'one', NULL, 6, 1, 1, 'false', 'false'),
(42, '1512', '2025-01-31 17:13:17', 'invoice', 'terra', '', NULL, 6, 1, 1, 'false', 'false'),
(44, '1514', '2025-02-01 19:42:32', 'invoice', 'terra', '', NULL, 6, 1, 1, 'false', 'false'),
(45, '1515', '2025-02-01 19:55:19', 'invoice', 'terra', '', NULL, 6, 1, 1, 'false', 'false');

-- --------------------------------------------------------

--
-- Table structure for table `invoiceproduct`
--

CREATE TABLE `invoiceproduct` (
  `id` int(11) NOT NULL,
  `invoiceId` int(11) NOT NULL,
  `invoiceNo` varchar(255) NOT NULL,
  `productId` int(11) NOT NULL,
  `stockId` int(11) NOT NULL,
  `invoiceQty` int(255) NOT NULL,
  `sendQty` int(11) NOT NULL,
  `deliverdQty` int(11) NOT NULL,
  `discount` int(11) NOT NULL,
  `unitAmount` int(11) NOT NULL,
  `totalAmount` int(255) NOT NULL,
  `invoiceProductStatus` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productId` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productCode` varchar(45) NOT NULL,
  `productChassi` varchar(255) DEFAULT NULL,
  `productUnit` varchar(255) NOT NULL,
  `productDiscount` float DEFAULT NULL,
  `productBuyingPrice` int(11) NOT NULL,
  `productSellingPrice` int(11) NOT NULL,
  `productWarranty` varchar(100) DEFAULT NULL,
  `productProfit` float NOT NULL,
  `productEmi` varchar(255) DEFAULT NULL,
  `productDescription` varchar(255) DEFAULT NULL,
  `productImage` varchar(255) DEFAULT NULL,
  `productStatus` varchar(45) NOT NULL,
  `rentOrHire` varchar(255) DEFAULT NULL,
  `category_categoryId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productId`, `productName`, `productCode`, `productChassi`, `productUnit`, `productDiscount`, `productBuyingPrice`, `productSellingPrice`, `productWarranty`, `productProfit`, `productEmi`, `productDescription`, `productImage`, `productStatus`, `rentOrHire`, `category_categoryId`) VALUES
(14, 'Car  2', 'cn-1000', 'CN-5000', '', NULL, 0, 500, '', 0, NULL, 'hi', NULL, 'In stock', NULL, 1),
(15, 'van 1', 'p1', '', '', NULL, 0, 8000, '', 0, NULL, '', NULL, 'In stock', NULL, 1),
(16, 'Car  2ttt', '777', '777', '', NULL, 0, 777, '', 0, NULL, '777', NULL, 'In stock', NULL, 2),
(17, '7777', '777888', '777', '', NULL, 0, 7777, '', 0, NULL, '777', 'http://localhost:5000/uploads/products/7777_1738743832054.jpg', 'In stock', 'hire', 1),
(18, 'car test', 'car test 123', 'CN-car test', '', NULL, 0, 8000, '', 0, NULL, 'car test', NULL, 'In stock', 'hire', 1),
(19, 'van test', 'van test 123', '80000', '', NULL, 0, 300, '', 0, NULL, 'van test', NULL, 'In stock', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `returnitems`
--

CREATE TABLE `returnitems` (
  `returnItemId` int(11) NOT NULL,
  `returnItemDate` datetime NOT NULL,
  `store_storeId` int(11) NOT NULL,
  `user_userId` int(11) NOT NULL,
  `invoice_invoiceId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `returnproducts`
--

CREATE TABLE `returnproducts` (
  `returnProductId` int(11) NOT NULL,
  `returnQty` int(11) NOT NULL,
  `returnAmount` float NOT NULL,
  `returnItemType` varchar(100) DEFAULT NULL,
  `returnDate` datetime DEFAULT NULL,
  `returnNote` varchar(255) DEFAULT NULL,
  `stockId` int(11) NOT NULL,
  `invoiceProductId` int(11) NOT NULL,
  `returnItemId` int(11) NOT NULL,
  `productId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `stockId` int(11) NOT NULL,
  `stockName` varchar(255) NOT NULL,
  `unitPrice` int(11) DEFAULT NULL,
  `stockPrice` float NOT NULL,
  `stockQty` int(11) NOT NULL,
  `stockDate` datetime DEFAULT NULL,
  `mfd` date DEFAULT NULL,
  `exp` date DEFAULT NULL,
  `stockDescription` varchar(255) DEFAULT NULL,
  `stockStatus` varchar(45) NOT NULL,
  `products_productId` int(11) NOT NULL,
  `supplier_supplierId` int(11) NOT NULL,
  `category_categoryId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `stockhistory`
--

CREATE TABLE `stockhistory` (
  `stockHistoryId` int(11) NOT NULL,
  `stockHistoryQty` int(11) NOT NULL,
  `stock_stockId` int(11) NOT NULL,
  `products_productId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `stockpayments`
--

CREATE TABLE `stockpayments` (
  `stockPaymentId` int(11) NOT NULL,
  `cashAmount` float NOT NULL,
  `chequeAmount` float NOT NULL,
  `due` float NOT NULL,
  `total` float NOT NULL,
  `vat` float NOT NULL,
  `stockQty` int(11) NOT NULL,
  `supplierId` int(11) DEFAULT NULL,
  `stockPayDate` datetime NOT NULL,
  `stockId` int(11) NOT NULL,
  `stockPaymentStatus` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `storeId` int(11) NOT NULL,
  `storeName` varchar(45) NOT NULL,
  `storeAddress` varchar(255) NOT NULL,
  `storeStatus` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`storeId`, `storeName`, `storeAddress`, `storeStatus`) VALUES
(1, 'Sinha Rent a car and cab service ', 'Katugastota', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `supplierId` int(11) NOT NULL,
  `supplierName` varchar(45) NOT NULL,
  `supplierAddress` varchar(255) NOT NULL,
  `supplierNic` varchar(45) DEFAULT NULL,
  `supplierEmail` varchar(45) DEFAULT NULL,
  `supplierTP` varchar(45) NOT NULL,
  `supplierSecondTP` varchar(45) DEFAULT NULL,
  `supplierStatus` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplierId`, `supplierName`, `supplierAddress`, `supplierNic`, `supplierEmail`, `supplierTP`, `supplierSecondTP`, `supplierStatus`) VALUES
(1, 'kavindu', 'xxxxx', '123456789V', 'kunage07@gmail.com', '1234567890', '', 'Active'),
(2, 'Buddhika', 'gg', '121212121212', 'buddhika@gmail.com', '1234567890', '12334567890', 'Active'),
(3, 'Buddika', 'Kandy', NULL, NULL, '012456789', NULL, 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `supplierpayments`
--

CREATE TABLE `supplierpayments` (
  `payId` int(11) NOT NULL,
  `payDate` datetime NOT NULL,
  `payAmount` float NOT NULL,
  `stockPaymentId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `switch`
--

CREATE TABLE `switch` (
  `id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `switch`
--

INSERT INTO `switch` (`id`, `status`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transactionId` int(11) NOT NULL,
  `dateTime` datetime NOT NULL,
  `transactionType` varchar(255) DEFAULT NULL,
  `totalAmount` int(11) NOT NULL,
  `price` int(100) DEFAULT NULL,
  `discount` float DEFAULT NULL,
  `paid` float DEFAULT NULL,
  `due` float DEFAULT NULL,
  `OgDue` float NOT NULL,
  `chequeDate` date DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `invoice_invoiceId` int(11) NOT NULL,
  `user_userId` int(11) NOT NULL,
  `cusId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userId` int(11) NOT NULL,
  `userTitle` varchar(45) NOT NULL,
  `userFullName` varchar(100) NOT NULL,
  `userName` varchar(45) NOT NULL,
  `userPassword` varchar(255) NOT NULL,
  `userType` varchar(45) NOT NULL,
  `userEmail` varchar(45) NOT NULL,
  `userNIC` varchar(45) NOT NULL,
  `userSecondTP` varchar(45) DEFAULT NULL,
  `userTP` varchar(45) NOT NULL,
  `userAddress` varchar(255) NOT NULL,
  `userImage` varchar(255) DEFAULT NULL,
  `userStatus` varchar(45) NOT NULL,
  `store_storeId` int(11) NOT NULL,
  `is_hidden` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userId`, `userTitle`, `userFullName`, `userName`, `userPassword`, `userType`, `userEmail`, `userNIC`, `userSecondTP`, `userTP`, `userAddress`, `userImage`, `userStatus`, `store_storeId`, `is_hidden`) VALUES
(4, 'Mr.', 'master', 'master', '$2b$10$YOYbjZyy3L4nBG/QLXHT5OZGqyFj80naF.fLxwH7nXRPHld6CjdCC', 'Admin', 'master@gmail.com', '123456729V', '12334567890', '1234567890', 'xxx', NULL, 'Active', 1, 1),
(5, 'Mr.', 'maleesha', 'maleeshapa', '$2b$10$SQb/n5CQrtiyuE/ABCIVoO1noHx9zPc53rEVlC7WGZ9VkFBu4Qo4m', 'Admin', 'buddhika@gmail.com', '2002832992', '12334567890', '1234567890', 'kandy', 'http://localhost:5000/uploads/users/maleeshapa_1735067279096.jpg', 'Active', 1, 1),
(6, 'Mr.', 'test', 'test', '$2b$10$Q.FEvek9ohgMdXgJlQoOwOz09N9c0Hu1xyEXyL0Y2cUa4fxlErDDG', 'Admin', 'test@gmail.com', '553456789v', '777', '555', '416/A', 'http://localhost:5000/uploads/users/test_1738601571034.jpg', 'Active', 1, 0),
(8, 'Mr.', 'fname', 'uname', '$2b$10$wjq3NNTcBO/w2wYvWMHAk.PbrXVBqNkifuudrYlFFhOs5cuEjxbiW', 'Admin', 'email@gmail.com', 'ggggggggg', '1', '555', 'ggggggggg', NULL, 'Active', 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryId`) USING BTREE;

--
-- Indexes for table `chequedata`
--
ALTER TABLE `chequedata`
  ADD PRIMARY KEY (`chequeId`) USING BTREE,
  ADD KEY `supplierId` (`supplierId`) USING BTREE,
  ADD KEY `stockPaymentId` (`stockPaymentId`) USING BTREE;

--
-- Indexes for table `costing_details`
--
ALTER TABLE `costing_details`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_costing_header` (`costing_header_id`) USING BTREE;

--
-- Indexes for table `costing_headers`
--
ALTER TABLE `costing_headers`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_customer` (`cusId`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cusId`) USING BTREE,
  ADD KEY `fk_guarantor` (`guarantorId`);

--
-- Indexes for table `deliverynote`
--
ALTER TABLE `deliverynote`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `deliverynote_ibfk_1` (`invoiceId`) USING BTREE,
  ADD KEY `deliverynote_ibfk_3` (`stockId`) USING BTREE,
  ADD KEY `deliverynote_ibfk_2` (`productId`) USING BTREE;

--
-- Indexes for table `duecustomer`
--
ALTER TABLE `duecustomer`
  ADD PRIMARY KEY (`duecustomerId`),
  ADD KEY `cusId` (`cusId`),
  ADD KEY `invoiceId` (`invoiceId`),
  ADD KEY `transactionId` (`transactionId`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expensesId`),
  ADD KEY `expensesCatId` (`expensesCatId`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `expensescat`
--
ALTER TABLE `expensescat`
  ADD PRIMARY KEY (`expensesCatId`);

--
-- Indexes for table `guarantor`
--
ALTER TABLE `guarantor`
  ADD PRIMARY KEY (`guarantorId`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoiceId`) USING BTREE,
  ADD KEY `invoice_ibfk_1` (`cusId`) USING BTREE;

--
-- Indexes for table `invoiceproduct`
--
ALTER TABLE `invoiceproduct`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `invoiceId` (`invoiceId`) USING BTREE,
  ADD KEY `productId` (`productId`) USING BTREE,
  ADD KEY `stockId` (`stockId`) USING BTREE;

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productId`) USING BTREE,
  ADD UNIQUE KEY `productCode` (`productCode`) USING BTREE,
  ADD KEY `fk_products_category_idx` (`category_categoryId`) USING BTREE;

--
-- Indexes for table `returnitems`
--
ALTER TABLE `returnitems`
  ADD PRIMARY KEY (`returnItemId`) USING BTREE,
  ADD KEY `fk_return_store1_idx` (`store_storeId`) USING BTREE,
  ADD KEY `fk_return_user1_idx` (`user_userId`) USING BTREE,
  ADD KEY `fk_return_invoice1_idx` (`invoice_invoiceId`) USING BTREE;

--
-- Indexes for table `returnproducts`
--
ALTER TABLE `returnproducts`
  ADD PRIMARY KEY (`returnProductId`) USING BTREE,
  ADD KEY `returnproduct_ibfk_2` (`invoiceProductId`) USING BTREE,
  ADD KEY `returnproduct_ibfk_3` (`returnItemId`) USING BTREE,
  ADD KEY `returnproduct_ibfk_4` (`stockId`) USING BTREE,
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`stockId`) USING BTREE,
  ADD KEY `fk_stock_products1_idx` (`products_productId`) USING BTREE,
  ADD KEY `fk_stock_supplier1_idx` (`supplier_supplierId`) USING BTREE,
  ADD KEY `fk_stock_category1_idx` (`category_categoryId`) USING BTREE;

--
-- Indexes for table `stockhistory`
--
ALTER TABLE `stockhistory`
  ADD PRIMARY KEY (`stockHistoryId`) USING BTREE,
  ADD KEY `fk_stockHistory_stock1_idx` (`stock_stockId`) USING BTREE,
  ADD KEY `fk_stockHistory_products1_idx` (`products_productId`) USING BTREE;

--
-- Indexes for table `stockpayments`
--
ALTER TABLE `stockpayments`
  ADD PRIMARY KEY (`stockPaymentId`) USING BTREE,
  ADD KEY `supplierId` (`supplierId`) USING BTREE,
  ADD KEY `stockId` (`stockId`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`storeId`) USING BTREE;

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplierId`) USING BTREE;

--
-- Indexes for table `supplierpayments`
--
ALTER TABLE `supplierpayments`
  ADD PRIMARY KEY (`payId`) USING BTREE,
  ADD KEY `stockPaymentId` (`stockPaymentId`) USING BTREE;

--
-- Indexes for table `switch`
--
ALTER TABLE `switch`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transactionId`) USING BTREE,
  ADD KEY `fk_transaction_invoice1_idx` (`invoice_invoiceId`) USING BTREE,
  ADD KEY `fk_transaction_user1_idx` (`user_userId`) USING BTREE,
  ADD KEY `cusId` (`cusId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`) USING BTREE,
  ADD UNIQUE KEY `userName` (`userName`) USING BTREE,
  ADD KEY `fk_user_store1_idx` (`store_storeId`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `chequedata`
--
ALTER TABLE `chequedata`
  MODIFY `chequeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `costing_details`
--
ALTER TABLE `costing_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `costing_headers`
--
ALTER TABLE `costing_headers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `cusId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `deliverynote`
--
ALTER TABLE `deliverynote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `duecustomer`
--
ALTER TABLE `duecustomer`
  MODIFY `duecustomerId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expensesId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expensescat`
--
ALTER TABLE `expensescat`
  MODIFY `expensesCatId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `guarantor`
--
ALTER TABLE `guarantor`
  MODIFY `guarantorId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `invoiceId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `invoiceproduct`
--
ALTER TABLE `invoiceproduct`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `returnitems`
--
ALTER TABLE `returnitems`
  MODIFY `returnItemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `returnproducts`
--
ALTER TABLE `returnproducts`
  MODIFY `returnProductId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `stockId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `stockhistory`
--
ALTER TABLE `stockhistory`
  MODIFY `stockHistoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `stockpayments`
--
ALTER TABLE `stockpayments`
  MODIFY `stockPaymentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `store`
--
ALTER TABLE `store`
  MODIFY `storeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `supplierId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `supplierpayments`
--
ALTER TABLE `supplierpayments`
  MODIFY `payId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `switch`
--
ALTER TABLE `switch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transactionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chequedata`
--
ALTER TABLE `chequedata`
  ADD CONSTRAINT `chequedata_ibfk_1` FOREIGN KEY (`stockPaymentId`) REFERENCES `stockpayments` (`stockPaymentId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chequedata_ibfk_2` FOREIGN KEY (`supplierId`) REFERENCES `supplier` (`supplierId`);

--
-- Constraints for table `costing_details`
--
ALTER TABLE `costing_details`
  ADD CONSTRAINT `fk_costing_header` FOREIGN KEY (`costing_header_id`) REFERENCES `costing_headers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `costing_headers`
--
ALTER TABLE `costing_headers`
  ADD CONSTRAINT `fk_customer` FOREIGN KEY (`cusId`) REFERENCES `customer` (`cusId`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `fk_guarantor` FOREIGN KEY (`guarantorId`) REFERENCES `guarantor` (`guarantorId`);

--
-- Constraints for table `deliverynote`
--
ALTER TABLE `deliverynote`
  ADD CONSTRAINT `deliverynote_ibfk_1` FOREIGN KEY (`invoiceId`) REFERENCES `invoice` (`invoiceId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverynote_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deliverynote_ibfk_3` FOREIGN KEY (`stockId`) REFERENCES `stock` (`stockId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `duecustomer`
--
ALTER TABLE `duecustomer`
  ADD CONSTRAINT `duecustomer_ibfk_1` FOREIGN KEY (`cusId`) REFERENCES `customer` (`cusId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `duecustomer_ibfk_2` FOREIGN KEY (`invoiceId`) REFERENCES `invoice` (`invoiceId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `duecustomer_ibfk_3` FOREIGN KEY (`transactionId`) REFERENCES `transaction` (`transactionId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`expensesCatId`) REFERENCES `expensescat` (`expensesCatId`),
  ADD CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`);

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`cusId`) REFERENCES `customer` (`cusId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoiceproduct`
--
ALTER TABLE `invoiceproduct`
  ADD CONSTRAINT `invoiceproduct_ibfk_1` FOREIGN KEY (`invoiceId`) REFERENCES `invoice` (`invoiceId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoiceproduct_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoiceproduct_ibfk_3` FOREIGN KEY (`stockId`) REFERENCES `stock` (`stockId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_categoryId`) REFERENCES `category` (`categoryId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `returnitems`
--
ALTER TABLE `returnitems`
  ADD CONSTRAINT `returnitems_ibfk_1` FOREIGN KEY (`store_storeId`) REFERENCES `store` (`storeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `returnitems_ibfk_2` FOREIGN KEY (`user_userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `returnitems_ibfk_3` FOREIGN KEY (`invoice_invoiceId`) REFERENCES `invoice` (`invoiceId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `returnproducts`
--
ALTER TABLE `returnproducts`
  ADD CONSTRAINT `returnproducts_ibfk_1` FOREIGN KEY (`invoiceProductId`) REFERENCES `invoiceproduct` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `returnproducts_ibfk_2` FOREIGN KEY (`returnItemId`) REFERENCES `returnitems` (`returnItemId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `returnproducts_ibfk_3` FOREIGN KEY (`stockId`) REFERENCES `stock` (`stockId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `returnproducts_ibfk_4` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`category_categoryId`) REFERENCES `category` (`categoryId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`products_productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_ibfk_4` FOREIGN KEY (`supplier_supplierId`) REFERENCES `supplier` (`supplierId`);

--
-- Constraints for table `stockhistory`
--
ALTER TABLE `stockhistory`
  ADD CONSTRAINT `stockhistory_ibfk_1` FOREIGN KEY (`products_productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stockhistory_ibfk_2` FOREIGN KEY (`stock_stockId`) REFERENCES `stock` (`stockId`);

--
-- Constraints for table `stockpayments`
--
ALTER TABLE `stockpayments`
  ADD CONSTRAINT `stockpayments_ibfk_1` FOREIGN KEY (`supplierId`) REFERENCES `supplier` (`supplierId`),
  ADD CONSTRAINT `stockpayments_ibfk_2` FOREIGN KEY (`stockId`) REFERENCES `stock` (`stockId`);

--
-- Constraints for table `supplierpayments`
--
ALTER TABLE `supplierpayments`
  ADD CONSTRAINT `supplierpayments_ibfk_2` FOREIGN KEY (`stockPaymentId`) REFERENCES `stockpayments` (`stockPaymentId`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`invoice_invoiceId`) REFERENCES `invoice` (`invoiceId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`user_userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`cusId`) REFERENCES `customer` (`cusId`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`store_storeId`) REFERENCES `store` (`storeId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
