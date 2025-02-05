import React, { useState, useEffect } from 'react';
import './Form.css';
import config from '../../config';

const Form = ({ closeModal, onSave, guarantor }) => {
  const [formErrors, setFormErrors] = useState({});
  const [error, setError] = useState(null);
  const [formData, setFormData] = useState({
    guarantorName: '',
    guarantorNic: '',
    guarantorPhone: '',
    guarantorAddress: '',
  });

  useEffect(() => {
    if (guarantor) {
      setFormData({
        guarantorName: guarantor.guarantorName || '',
        guarantorNic: guarantor.guarantorNic || '',
        guarantorPhone: guarantor.guarantorPhone || '',
        guarantorAddress: guarantor.guarantorAddress || '',
      });
    }
  }, [guarantor]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });

    if (formErrors[name]) {
      setFormErrors({ ...formErrors, [name]: '' });
    }
  };

  const validate = () => {
    const errors = {};

    if (!formData.guarantorName.trim()) {
      errors.guarantorName = 'Name is required.';
    }

    if (!formData.guarantorNic.trim()) {
      errors.guarantorNic = 'NIC is required.';
    }

    return errors;
  };

  const handleSubmitGuarantor = async (e) => {
    e.preventDefault();
    const errors = validate();
    if (Object.keys(errors).length > 0) {
      setFormErrors(errors);
      return;
    }

    const guarantorData = {
      guarantorName: formData.guarantorName,
      guarantorNic: formData.guarantorNic,
      guarantorPhone: formData.guarantorPhone,
      guarantorAddress: formData.guarantorAddress,
    };

    try {
      const url = guarantor
        ? `${config.BASE_URL}/guarantor/${guarantor.guarantorId}`
        : `${config.BASE_URL}/guarantor`;
      const method = guarantor ? 'PUT' : 'POST';

      const response = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(guarantorData),
      });

      const responseData = await response.json();

      if (response.ok) {
        setError(guarantor ? 'Successfully Updated!' : 'Successfully Created!');
        onSave(guarantorData);
        closeModal();
      } else {
        setError(responseData.error || 'An error occurred while saving the guarantor.');
      }
    } catch (error) {
      setError('An error occurred while saving the guarantor.');
    }
  };

  return (
    <div style={{ placeItems: 'center' }}>
      <h2>{guarantor ? 'Edit Guarantor' : 'New Guarantor'}</h2>
      {error && <div className="error-message">{error}</div>}
      <form onSubmit={handleSubmitGuarantor} className="form-container" autoComplete='off'>
        <div className="form-group-1">
          <div className="form-group">
            <label htmlFor="guarantorName">Name <span>*</span></label>
            <input
              id="guarantorName"
              type="text"
              name="guarantorName"
              value={formData.guarantorName}
              onChange={handleChange}
              placeholder="Enter Full Name"
              required
              aria-describedby={formErrors.guarantorName ? 'guarantorName-error' : undefined}
            />
            {formErrors.guarantorName && <span id="guarantorName-error" className="error-text">{formErrors.guarantorName}</span>}
          </div>

          <div className="form-group">
            <label htmlFor="guarantorNic">NIC <span>*</span></label>
            <input
              id="guarantorNic"
              type="text"
              name="guarantorNic"
              value={formData.guarantorNic}
              onChange={handleChange}
              placeholder="Enter NIC"
              required
              aria-describedby={formErrors.guarantorNic ? 'guarantorNic-error' : undefined}
            />
            {formErrors.guarantorNic && <span id="guarantorNic-error" className="error-text">{formErrors.guarantorNic}</span>}
          </div>

          <div className="form-group">
            <label htmlFor="guarantorPhone">Phone</label>
            <input
              id="guarantorPhone"
              type="text"
              name="guarantorPhone"
              value={formData.guarantorPhone}
              onChange={handleChange}
              placeholder="Enter Phone"
            />
          </div>

          <div className="form-group">
            <label htmlFor="guarantorAddress">Address</label>
            <input
              id="guarantorAddress"
              type="text"
              name="guarantorAddress"
              value={formData.guarantorAddress}
              onChange={handleChange}
              placeholder="Enter Address"
            />
          </div>

          <div className="form-actions">
            <button type="button" onClick={closeModal}>Close</button>
            <button type="submit">{guarantor ? 'Update' : 'Save Changes'}</button>
          </div>
        </div>
      </form>
    </div>
  );
};

export default Form;