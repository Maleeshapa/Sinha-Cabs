import React, { useEffect, useState } from 'react';
import Table from '../Table/Table';
// import Form from '../../Models/Form/GurantorForm';
import Form from '../../Models/Gurantor/GurantorForm';
import Modal from 'react-modal';
import ConfirmModal from '../../Models/ConfirmModal';
import config from '../../config';

const GuarantorList = () => {
  const [data, setData] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [selectedGuarantor, setSelectedGuarantor] = useState(null);
  const [showConfirmModal, setShowConfirmModal] = useState(false);
  const [deleteRowIndex, setDeleteRowIndex] = useState(null);

  const columns = ['#', 'Name', 'NIC', 'Phone', 'Address'];

  useEffect(() => {
    fetchGuarantors();
  }, []);

  const fetchGuarantors = async () => {
    try {
      const response = await fetch(`${config.BASE_URL}/guarantors`);
      if (!response.ok) {
        setError('Failed to fetch Guarantor list');
        return;
      }
      const guarantors = await response.json();

      const formattedData = guarantors.map((guarantor, index) => [
        index + 1,
        guarantor.guarantorName,
        guarantor.guarantorNic,
        guarantor.guarantorPhone,
        guarantor.guarantorAddress,
      ]);
      setData(formattedData);
      setIsLoading(false);
    } catch (err) {
      setError(err.message);
      setIsLoading(false);
    }
  };

  const handleDelete = async () => {
    try {
      const guarantorId = data[deleteRowIndex][0];
      const response = await fetch(`${config.BASE_URL}/guarantors/${guarantorId}`, {
        method: 'DELETE',
      });

      if (!response.ok) {
        throw new Error('Failed to delete guarantor');
      }

      setData(prevData => prevData.filter((_, index) => index !== deleteRowIndex));
      fetchGuarantors();
    } catch (err) {
      setError(err.message);
    } finally {
      setShowConfirmModal(false);
    }
  };

  const confirmDelete = (rowIndex) => {
    setDeleteRowIndex(rowIndex);
    setShowConfirmModal(true);
  };

  const handleEdit = (rowIndex) => {
    const selectedGuarantorData = data[rowIndex];
    setSelectedGuarantor({
      guarantorId: selectedGuarantorData[0],
      guarantorName: selectedGuarantorData[1],
      guarantorNic: selectedGuarantorData[2],
      guarantorPhone: selectedGuarantorData[3],
      guarantorAddress: selectedGuarantorData[4],
    });
    setModalIsOpen(true);
  };

  const openModal = () => {
    setSelectedGuarantor(null);
    setModalIsOpen(true);
  };

  const closeModal = () => {
    setModalIsOpen(false);
    fetchGuarantors();
  };

  const title = 'Guarantor List';
  const invoice = 'guarantor_list.pdf';

  return (
    <div>
      
      
      <div className="scrolling-container">    
        <h4>Guarantor List</h4>       
          <Table
            data={data}
            columns={columns}
            showButton={true}
            btnName={"Add New Guarantor"}
            onAdd={openModal}
            onDelete={confirmDelete}
            onEdit={handleEdit}
            showDate={false}
            title={title}
            invoice={invoice}
          />
        
        <Modal
          isOpen={modalIsOpen}
          onRequestClose={closeModal}
          contentLabel="Guarantor Form"
        >
          <Form
            closeModal={closeModal}
            onSave={fetchGuarantors}
            guarantor={selectedGuarantor}
            style={{
              content: {
                width: '30%',
                height: '90%',
                top: '50%',
                left: '50%',
                transform: 'translate(-50%, -50%)',
              },
            }}
          />
        </Modal>
        {showConfirmModal && (
          <ConfirmModal
            onConfirm={handleDelete}
            onClose={() => setShowConfirmModal(false)}
          />
        )}
      </div>
    </div>
  );
};

export default GuarantorList;