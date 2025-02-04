const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const sequelize = require("./dbConfig");
const path = require('path');
const multer = require('multer');
const fs = require('fs');

//Controllers
const SupplierController = require("./controller/SupplerController");
const UserController = require("./controller/UserController");
const CategoryController = require("./controller/CategoryController");
const ProductController = require("./controller/ProductController");
const InvoiceController = require("./controller/InvoiceController");
const TransactionController = require("./controller/TransactionController");
const StoreController = require("./controller/StoreController");
const ReturnController = require("./controller/ReturnController");
const ReturnProductController = require("./controller/ReturnProductController");
const ExpenseController = require("./controller/ExpensesController");
const ExpensesCatController = require("./controller/ExpensesCatController");
const ReportController = require("./controller/Reports/ReportController");
const ProductNStockController = require("./controller/Reports/ProductStockController");
const InvoiceProductController = require('./controller/InvoiceProduct');
const CustomerController = require('./controller/CustomerController');
// const DeliveryNoteController = require('./controller/DeliveryNoteController');
const CostingController = require('./controller/CostingController');
const ChequeController = require('./controller/ChequeController');
const Transaction = require("./model/Transaction");
const DueCustomerController = require("./controller/DueCustomerController");
// const SupplierPaymentController = require("./controller/SupplierPaymentController");

const SwitchController = require('./controller/SwitchController');

const DueCustomer = require("./model/DueCustomer");
const DueController = require("./controller/DueController");
const GuarantorController = require("./controller/GuarantorController");

// const CostingController = require("./controller/CostingController");
// const CostingController = require("./controller/");

const app = express();
const PORT = process.env.PORT;




// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use('/uploads', express.static(path.join(__dirname, 'uploads', 'purchase-orders')));

app.use(express.static(path.join(__dirname, 'build')));
//user routes
app.post("/user", UserController.createUser);
app.get("/users", UserController.getAllUsers);
app.get("/user/:id", UserController.getUserById);
app.get('/user/name/:name', UserController.getUserByName);
app.put("/user/:id", UserController.updateUser);
app.delete("/user/:id", UserController.deleteUser);
app.post("/userLogin", UserController.userLogin);

//supplier routes
app.post("/supplier", SupplierController.createSupplier);
app.get("/suppliers", SupplierController.getAllSuppliers);
app.get("/supplier/:id", SupplierController.getSupplierById);
app.get("/supplier/supplierName/:name", SupplierController.getSupplierByName);
app.put("/supplier/:id", SupplierController.updateSupplier);
app.delete("/supplier/:id", SupplierController.deleteSupplier);
app.get('/suppliers/suggestions', SupplierController.getSupplierSuggestions);


//category routes
app.post("/category", CategoryController.createCategory);
app.get("/categories", CategoryController.getAllCategories);
app.get("/category/:id", CategoryController.getCategoryById);
app.put("/category/:id", CategoryController.updateCategory);
app.delete("/category/:id", CategoryController.deleteCustomer);
app.get("/category/name/:name", CategoryController.getNameCategories);

//customer routes
app.post('/customer', CustomerController.createCustomer);
app.get('/customers', CustomerController.getAllCustomers);
app.get('/customer/:id', CustomerController.getCustomerById);
app.put('/customer/:id', CustomerController.updateCustomer);
app.delete('/customer/:id', CustomerController.deleteCustomer);
app.get("/customer/cusCode/:code", CustomerController.getCustomerByCode);
app.get("/customer/cusName/:name", CustomerController.getCustomerByName);
app.get('/customers/suggestions', CustomerController.getCustomerSuggestions);
app.get('/customers/suggestion', CustomerController.getCustomerSuggestion);

//product routes
app.post("/product", ProductController.createProduct);
app.get("/products", ProductController.getAllProducts);
app.get("/product/:id", ProductController.getProductById);
app.put("/product/:id", ProductController.updateProduct);
app.delete("/product/:id", ProductController.deleteProduct);
app.get("/product/productName/:name", ProductController.getProductByName);
app.get('/product/codeOrName/:value', ProductController.getProductByCodeOrName);
app.get('/products/suggestions', ProductController.getProductSuggestions);
app.get('/product/image/:productCode', ProductController.getProductImageByCode);

//cheque routes
app.post("/cheque", ChequeController.addCheque);
app.get("/cheques", ChequeController.getAllCheques);
app.get("/cheque/:id", ChequeController.getChequeById);
app.put("/cheque/:id", ChequeController.updateCheque);
app.get("/countCheques", ChequeController.countPendingCheques);
app.get("/clearedChequeTotal", ChequeController.getClearedChequeTotal);
app.get('/pendingChequeTotal', ChequeController.getPendingChequeTotal);
app.get('/cheques/supplier/:supplierId', ChequeController.getChequesBySupplierId);
app.get('/cheques/pendingTotal/:supplierId', ChequeController.getPendingChequeTotalBySupplier)

//invoice routes
app.post("/invoice", InvoiceController.createInvoice);
app.get("/invoices", InvoiceController.getAllInvoice);
app.get("/invoice/:id", InvoiceController.getInvoiceById);
app.put("/invoice/:id", InvoiceController.updateInvoice);
app.put("/deliveryTime/:id", InvoiceController.updateDeliveryTime);
app.delete("/invoice/:id", InvoiceController.deleteInvoice);
app.get('/invoice/invoiceNo/:num', InvoiceController.getInvoiceByNo);
app.get('/invoice/last', InvoiceController.getLastInvoiceNumber);
app.post('/invoice/:id', InvoiceController.addImage);
app.get('/invoice/purchaseNo/:purchaseNo', InvoiceController.checkPurchaseNoExists)
app.put('/updatePerforma/:invoiceId', InvoiceController.updatePerforma)
app.put('/updateDraft/:invoiceId', InvoiceController.updateInvoiceDraft)

//invoiceProduct Route
app.post('/invoiceProduct', InvoiceProductController.createInvoiceProduct);
app.get('/invoiceProducts', InvoiceProductController.getAllInvoiceProducts);
app.delete('/invoiceProducts/:invoiceProductId', InvoiceProductController.deleteInvoiceProductById);

//guarantor routes
app.post("/guarantor", GuarantorController.createGuarantor);
app.get("/guarantors", GuarantorController.getAllGuarantors);
app.get("/guarantor/:id", GuarantorController.getGurantorById);
app.get("/guarantors/suggestions/:name", GuarantorController.getGurantorSuggestions);

//due Customer Route
app.post('/duecustomer', DueCustomerController.createDueCustomer);
app.get('/duecustomers', DueCustomerController.getAllDueCustomers);
app.get('/duecustomer/:id', DueCustomerController.getDueCustomerById);
app.put('/duecustomer/:id', DueCustomerController.updateDueCustomer);
app.delete('/duecustomer/:id', DueCustomerController.deleteDueCustomer);
app.post("/due/pay/:invoiceId", DueController.payDueAmount);

//transaction routes
app.post("/transaction", TransactionController.createTransaction);
app.put("/transactions/invoiceId/:invoiceId", TransactionController.updateTransaction);
app.get("/transactions", TransactionController.getAllTransactions);
app.get("/transactions/:id", TransactionController.getTransactionById);
app.get('/transaction/invoice/:invoiceId', TransactionController.getTransactionsByInvoiceId);
app.delete('/transactions/invoice/:invoice_invoiceId', TransactionController.deleteByInvoiceId);
app.put('/transaction/:id', TransactionController.editTransaction);

// Get transactions for a specific customer
app.get('/transactions/customer/:cusId', TransactionController.getTransactionsByCustomerId);

// Get invoice details for a specific customer
app.get('/duecustomer/invoice/:cusId', DueController.getDueCustomerByCusId);

//store routes
app.post("/store", StoreController.createStore);
app.get("/stores", StoreController.getAllStores);
app.get("/store/:id", StoreController.getStoreById);
app.put("/store/:id", StoreController.updateStore);
app.delete("/store/:id", StoreController.deleteStore);

//return routes
app.post("/return", ReturnController.createReturn);
app.get("/returns", ReturnController.getAllReturns);
app.get("/return/:id", ReturnController.getReturnById);

//returnProduct routes
app.post("/returnProduct", ReturnProductController.createReturnProduct);
app.get("/returnProducts", ReturnProductController.getAllReturnProducts);
app.get("/returnProduct/:id", ReturnProductController.getAllReturnProductsById);
app.get("/returnProduct/return/:returnItemId", ReturnProductController.getReturnProductsByInvoiceProductId);

//expenses routes
app.post("/expense", ExpenseController.createExpense);
app.get("/expenses", ExpenseController.getAllExpenses);
app.get("/expense/:id", ExpenseController.getExpenseById);
app.put("/expense/:id", ExpenseController.updateExpense);
app.delete("/expense/:id", ExpenseController.deleteExpense);

//expenses category routes
app.post("/expensesCat", ExpensesCatController.createExpensesCategory);
app.get("/expensesCats", ExpensesCatController.getAllExpensesCats);
app.get("/expensesCat/:id", ExpensesCatController.getExpensesCatById);
app.put("/expensesCat/:id", ExpensesCatController.updateExpensesCat);
app.delete("/expensesCat/:id", ExpensesCatController.deleteExpensesCat);

//get reports
app.get("/getReports", ReportController.getReports);
// app.get("/productStock", ProductNStockController.getStockReports);

// //Costing routes
app.post("/costing", CostingController.createCosting);
app.get("/costings", CostingController.getAllCostings);
app.get("/costing/:id", CostingController.getCostingById);
app.put("/costing/:id", CostingController.updateCosting);
app.delete("/costing/:id", CostingController.deleteCosting);
app.put("/costings/:id", CostingController.updateAllCosting);

// status endpoint
app.get('/api/switch', SwitchController.getStatus);
app.post('/api/switch', SwitchController.updateStatus);

sequelize
    .sync()
    .then(() => {
        console.log("Database synchronized");
    })
    .catch((err) => {
        console.error("Error synchronizing database:", err);
    });


    

app.get('/download/invoice/:filename', (req, res) => {
    const { filename } = req.params;
    const filePath = path.join(__dirname, 'uploads', 'invoice', filename);

    if (fs.existsSync(filePath)) {
        res.download(filePath, filename, (err) => {
            if (err) {
                res.status(500).json({ error: "Error downloading the file" });
            }
        });
    } else {
        res.status(404).json({ error: "File not found" });
    }
});

// Handle React routing, return all requests to React app
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'build', 'index.html'));
  });
  

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});