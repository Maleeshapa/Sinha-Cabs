import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import ConfirmModal from '../../Models/ConfirmModal';
import config from '../../config';
import 'bootstrap/dist/css/bootstrap.min.css';

const ProductSummary = () => {
  const [products, setProducts] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState(null);

  const navigate = useNavigate();

  useEffect(() => {
    fetchProductList();
  }, []);

  const fetchProductList = async () => {
    try {
      const response = await fetch(`${config.BASE_URL}/products`);
      if (!response.ok) throw new Error(`Failed to fetch: ${response.statusText}`);
      
      const data = await response.json();
      setProducts(data);
      setIsLoading(false);
    } catch (err) {
      setError(err.message);
      setIsLoading(false);
    }
  };

  const handleDelete = (product) => {
    setSelectedProduct(product);
    setIsModalOpen(true);
  };

  const confirmDelete = async () => {
    try {
      await fetch(`${config.BASE_URL}/product/${selectedProduct.productId}`, {
        method: 'DELETE',
      });

      setProducts(prev => prev.filter(prod => prod.productId !== selectedProduct.productId));
    } catch (err) {
      alert('This product is used for creating invoices.');
    } finally {
      setIsModalOpen(false);
      setSelectedProduct(null);
    }
  };

  const handleEdit = (product) => {
    navigate('/product/create', { state: { selectedProd: product } });
  };

  const handleStatusChange = async (product, newStatus) => {
    try {
      await fetch(`${config.BASE_URL}/product/${product.productId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ productStatus: newStatus }),
      });

      setProducts(prev =>
        prev.map(prod =>
          prod.productId === product.productId ? { ...prod, productStatus: newStatus } : prod
        )
      );
    } catch (err) {
      console.error('Error updating status:', err);
    }
  };

  const handleAddProduct = () => {
    navigate('/product/create');
  };

  if (isLoading) return <p>Loading products...</p>;
  if (error) return <p className="text-danger">Error: {error}</p>;

  return (
    <div className="container mt-4">
      <div className="d-flex justify-content-between align-items-center mb-3">
        <h4>🚗 Vehicles List</h4>
        <button className="btn btn-success" onClick={handleAddProduct}>+ Add Vehicle</button>
      </div>

      <div className="row row-cols-1 row-cols-md-3 g-4">
        {products.map((product) => (
          <div key={product.productId} className="col">
            <div className="card h-100 shadow-sm border-0 d-flex flex-column">
              <img
                src={product.productImage || 'https://via.placeholder.com/300'}
                className="card-img-top"
                alt={product.productName}
                style={{ height: '200px', objectFit: 'cover' }}
              />
              <div className="card-body d-flex flex-column">
                <h5 className="card-title">{product.productName}</h5>
                <p className="card-text"><strong>Number Plate:</strong> {product.productCode}</p>
                <p className="card-text"><strong>Chassis:</strong> {product.productChassi}</p>
                <p className="card-text"><strong>Rent Price:</strong> Rs. {product.productSellingPrice}</p>
                <p className="card-text flex-grow-1"><small>{product.productDescription}</small></p>

                <select
                  className="form-control mb-2"
                  value={product.productStatus}
                  onChange={(e) => handleStatusChange(product, e.target.value)}
                >
                  <option value="In stock">In Stock</option>
                  <option value="Out of Stock">Out of Stock</option>
                </select>

                <div className="d-flex justify-content-between mt-auto">
                  <button className="btn btn-warning btn-sm" onClick={() => handleEdit(product)}>✏️ Edit</button>
                  <button className="btn btn-danger btn-sm" onClick={() => handleDelete(product)}>🗑 Delete</button>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>

      {isModalOpen && (
        <ConfirmModal onConfirm={confirmDelete} onClose={() => setIsModalOpen(false)} />
      )}
    </div>
  );
};

export default ProductSummary;
