import React, { useState, useEffect } from 'react';
import './Form.css';
import config from '../../config';
import { set } from 'date-fns';

const Form = ({ closeModal, onSave, cus }) => {
  const [formErrors, setFormErrors] = useState({});
  const [error, setError] = useState(null);
  const [formData, setFormData] = useState({
    name: '',
    phone: '',
    nic: '',
    license: '',
    jobPosition: '',
    address: '',
    customerReview: '',
    customerDescription: '',
    guarantorName: '',
    guarantorNic: '',
  });

  useEffect(() => {
    if (cus) {
      setFormData({
        name: cus.cusName || '',
        phone: cus.cusPhone || '',
        nic: cus.nic || '',
        license: cus.license || '',
        jobPosition: cus.cusJob || '',
        address: cus.cusAddress || '',
        customerReview: cus.customerReview || '',
        customerDescription: cus.customerDescription || '',
      });
    }
  }, [cus]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });

    if (formErrors[name]) {
      setFormErrors({ ...formErrors, [name]: '' });
    }
  };

  const validate = () => {
    const errors = {};

    if (!formData.name.trim()) {
      errors.name = 'Name is required.';
    }

    if (!formData.phone.trim()) {
      errors.phone = 'Phone number is required.';
    }

    if (!formData.address.trim()) {
      errors.address = 'Address is required.';
    }

    return errors;
  };

  const handleSubmitCus = async (e) => {
    e.preventDefault();
    const errors = validate();
    if (Object.keys(errors).length > 0) {
      setFormErrors(errors);
      return;
    }

    const customerData = {
      cusName: formData.name,
      cusPhone: formData.phone,
      nic: formData.nic,
      license: formData.license,
      cusJob: formData.jobPosition,
      cusAddress: formData.address,
      customerReview: formData.customerReview,
      customerDescription: formData.customerDescription,
    };

    try {
      const url = cus
        ? `${config.BASE_URL}/customer/${cus.cusId}`
        : `${config.BASE_URL}/customer`;
      const method = cus ? 'PUT' : 'POST';

      const response = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(customerData),
      });

      const responseData = await response.json();

      if (response.ok) {
        setError(cus ? 'Successfully Updated!' : 'Successfully Created!');
        onSave(customerData);
        closeModal();
      } else {
        setError(responseData.error || 'An error occurred while saving the customer.');
      }
    } catch (error) {
      setError('An error occurred while saving the customer.');
    }
  };

  const [guarantorSuggestions, setGuarantorSuggestions] = useState([]);

  const fetchGuarantorSuggestions = async (guarantorName) => {
    setFormData((prevData) => ({
      ...prevData,
      guarantorName,
    }));

    if (!guarantorName.trim()) {
      setGuarantorSuggestions([]);
      return;
    }

    try {
      const response = await fetch(`${config.BASE_URL}/guarantors/suggestions/${guarantorName}`);
      const data = await response.json();

      if (response.ok) {
        setGuarantorSuggestions(data);
      } else {
        setGuarantorSuggestions([]);
      }
    } catch (error) {
      console.error('Error fetching guarantor suggestions', error);
      setGuarantorSuggestions([]);
    }
  };

  const selectGuarantor = (guarantor) => {
    setFormData((prevData) => ({
      ...prevData,
      guarantorName: guarantor.guarantorName,
      guarantorNic: guarantor.guarantorNic,
    }));
    setGuarantorSuggestions([]);
  };

  return (
    <div style={{ placeItems: 'center' }}>
      <h2>{cus ? 'Edit Customer' : 'New Customer'}</h2>
      {error && <div className="error-message">{error}</div>}
      <form onSubmit={handleSubmitCus} className="form-container" autoComplete='off'>
        <div className="form-group-1">
          <div className="form-group">
            <label htmlFor="name">Name <span>*</span></label>
            <input
              id="name"
              type="text"
              name="name"
              value={formData.name}
              onChange={handleChange}
              placeholder="Enter Full Name"
              required
              aria-describedby={formErrors.name ? 'name-error' : undefined}
            />
            {formErrors.name && <span id="name-error" className="error-text">{formErrors.name}</span>}
          </div>

          <div className="form-group">
            <label htmlFor="phone">Phone <span>*</span></label>
            <input
              id="phone"
              type="text"
              name="phone"
              value={formData.phone}
              onChange={handleChange}
              placeholder="Enter Phone"
              required
              aria-describedby={formErrors.phone ? 'phone-error' : undefined}
            />
            {formErrors.phone && <span id="phone-error" className="error-text">{formErrors.phone}</span>}
          </div>

          <div className="form-group">
            <label htmlFor="nic">NIC</label>
            <input
              id="nic"
              type="text"
              name="nic"
              value={formData.nic}
              onChange={handleChange}
              placeholder="Enter NIC"
            />
          </div>

          <div className="form-group">
            <label htmlFor="license">License</label>
            <input
              id="license"
              type="text"
              name="license"
              value={formData.license}
              onChange={handleChange}
              placeholder="Enter License"
            />
          </div>

          <div className="form-group">
            <label htmlFor="jobPosition">Job Position</label>
            <input
              id="jobPosition"
              type="text"
              name="jobPosition"
              value={formData.jobPosition}
              onChange={handleChange}
              placeholder="Enter Job Position"
            />
          </div>

          <div className="form-group">
            <label htmlFor="address">Address <span>*</span></label>
            <input
              id="address"
              type="text"
              name="address"
              value={formData.address}
              onChange={handleChange}
              placeholder="Enter Address"
              required
              aria-describedby={formErrors.address ? 'address-error' : undefined}
            />
            {formErrors.address && <span id="address-error" className="error-text">{formErrors.address}</span>}
          </div>

          <div className="form-group">
            <label htmlFor="customerReview">Customer Review</label>
            <select
              id="customerReview"
              name="customerReview"
              value={formData.customerReview}
              onChange={handleChange}
              className="form-control"
            >
              <option value="">Select Review</option>
              <option value="Good">Good</option>
              <option value="Normal">Normal</option>
              <option value="Bad">Bad</option>
            </select>
          </div>

          {formData.customerReview && (
            <div className="form-group">
              <label htmlFor="customerDescription">Customer Description</label>
              <input
                id="customerDescription"
                type="text"
                name="customerDescription"
                value={formData.customerDescription}
                onChange={handleChange}
                placeholder="Enter Customer Description"
              />
            </div>
          )}

          <div className="form-group">
            <label htmlFor="guarantor">Guarantor</label>
            <input
              id="guarantor"
              type="text"
              name="guarantorName"
              value={formData.guarantorName}
              onChange={(e) => fetchGuarantorSuggestions(e.target.value)}
              placeholder="Enter Guarantor Name"
            />
            {guarantorSuggestions.length > 0 && (
              <ul className="list-group mt-0">
                {guarantorSuggestions.map((guarantor, index) => (
                  <li
                    key={index}
                    className="list-group-item list-group-item-action"
                    onClick={() => selectGuarantor(guarantor)}
                  >
                    {guarantor.guarantorName}
                  </li>
                ))}
              </ul>
            )}
          </div>

          <div className="form-actions">
            <button type="button" onClick={closeModal}>Close</button>
            <button type="submit">{cus ? 'Update' : 'Save Changes'}</button>
          </div>
        </div>
      </form>
    </div>
  );
};

export default Form;