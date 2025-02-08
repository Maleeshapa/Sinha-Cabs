import React, { useState, useEffect } from "react";
import './Hire.css';
import { User, CarFront } from "lucide-react";
import { Link } from "react-router-dom";
import CusNicSuggest from './CusNicSuggest';
import GNicSuggest from './GNicSuggest';
import config from "../../config";


const Hire = () => {
    const [customerData, setCustomerData] = useState({
        cusId: '',
        nic: '',
        license: '',
        cusName: '',
        cusAddress: '',
        cusPhone: ''
    });

    const [guarantorData, setGuarantorData] = useState({
        guarantorId: '',
        nic: '',
        guarantorName: '',
        guarantorPhone: '',
        guarantorAddress: ''
    });

    const [vehicles, setVehicles] = useState([]);
    const [selectedVehicle, setSelectedVehicle] = useState({
        productId: '',
        productName: '',
        productCode: '',
        productSellingPrice: ''
    });
    

    useEffect(() => {
        const fetchHireVehicles = async () => {
            try {
                const response = await fetch(`${config.BASE_URL}/products`);
                if (!response.ok) {
                    throw new Error(`Failed to fetch vehicles: ${response.status} ${response.statusText}`);
                }
                const data = await response.json();

                const hireVehicles = data.filter(vehicle => vehicle.rentOrHire === 'hire');
                setVehicles(hireVehicles);
            } catch (error) {
                console.error('Error fetching hire vehicles:', error);
            }
        };

        fetchHireVehicles();
    }, []);


    // Handle customer selection from suggestions
    const handleSelectCustomer = (customer) => {
        setCustomerData({
            cusId: customer.cusId,
            nic: customer.nic,
            license: customer.license || '',
            cusName: customer.cusName || '',
            cusAddress: customer.cusAddress || '',
            cusPhone: customer.cusPhone || ''
        });
    };

    const handleSelectGuarantor = (guarantor) => {
        setGuarantorData({
            guarantorId: guarantor.guarantorId,
            nic: guarantor.nic,
            guarantorName: guarantor.guarantorName || '',
            guarantorPhone: guarantor.guarantorPhone || '',
            guarantorAddress: guarantor.guarantorAddress || ''
        });
    };

    const handleVehicleSelect = (e) => {
        const selectedId = e.target.value;
        const selected = vehicles.find(vehicle => vehicle.productId === parseInt(selectedId));

        if (selected) {
            setSelectedVehicle({
                productId: selected.productId,
                productName: selected.productName,
                productCode: selected.productCode,
                productSellingPrice: selected.productSellingPrice
            });
        }
    };

    return (
        <div className="container-fluid p-5">
            <div className="row">
                <div className="col-md-4 border-end">
                    <div className="d-flex justify-content-between align-items-center mb-2">
                        <h5 className="d-flex align-items-center">
                            <User className="me-2" /> Customer Details
                        </h5>
                        <Link to="/customer/customer-list">
                            <button className="btn btn-success btn-sm">Create Customer</button>
                        </Link>
                    </div>

                    {/* NIC input with suggestions */}
                    <CusNicSuggest onSelectCustomer={handleSelectCustomer} />

                    <input
                        type="text"
                        className="form-control mb-2  bg-light"
                        placeholder="Customer Licence"
                        value={customerData.license}
                        readOnly
                    />
                    <input
                        type="text"
                        className="form-control mb-2  bg-light"
                        placeholder="Customer Name"
                        value={customerData.cusName}
                        readOnly
                    />
                    <input
                        type="text"
                        className="form-control mb-2  bg-light bg-light"
                        placeholder="Customer Address"
                        value={customerData.cusAddress}
                        readOnly
                    />
                    <input
                        type="text"
                        className="form-control mb-2  bg-light"
                        placeholder="Customer Phone"
                        value={customerData.cusPhone}
                        readOnly
                    />
                </div>

                {/* Guarantor Details */}
                <div className="col-md-4 border-end">
                    {/* <h5>Guarantor Details</h5> */}


                    <div className="d-flex justify-content-between align-items-center mb-2">
                        <h5 className="d-flex align-items-center">
                            <i className="bi bi-person-raised-hand me-2" style={{ fontSize: '20px' }}></i>  Guarantor Details
                        </h5>
                        <Link to="/gurantor">
                            <button className="btn btn-success btn-sm">Create Guarantor</button>
                        </Link>
                    </div>


                    <GNicSuggest onSelectGuarantor={handleSelectGuarantor} />

                    {/* Other guarantor fields */}
                    <input
                        type="text"
                        className="form-control mb-2 bg-light"
                        placeholder="Guarantor Name"
                        value={guarantorData.guarantorName}
                        readOnly
                    />
                    <input
                        type="text"
                        className="form-control mb-2 bg-light"
                        placeholder="Guarantor Phone"
                        value={guarantorData.guarantorPhone}
                        readOnly
                    />
                    <input
                        type="text"
                        className="form-control mb-2 bg-light"
                        placeholder="Guarantor Address"
                        value={guarantorData.guarantorAddress}
                        readOnly
                    />


                </div>

                {/* Vehicle Details */}
                <div className="col-md-4">
                    <div className="d-flex justify-content-between align-items-center mb-2">
                        <h5 className="d-flex align-items-center">
                            <CarFront className="me-2" />Hire Vehicle Details
                        </h5>
                        <Link to="/product/hire-vechicle-list">
                            <button className="btn btn-success btn-sm">Create Hire Vechicle</button>
                        </Link>
                    </div>
                    <select
                        className="form-control mb-2"
                        onChange={handleVehicleSelect}
                        value={selectedVehicle.productId}
                    >
                        <option value="">Select Vehicle</option>
                        {vehicles.map(vehicle => (
                            <option key={vehicle.productId} value={vehicle.productId}>
                                {vehicle.productName}
                            </option>
                        ))}
                    </select>

                    <input
                        type="text"
                        className="form-control mb-2 d-none"
                        placeholder="Vehicle Name"
                        value={selectedVehicle.productName}
                        readOnly
                    />

                    <input
                        type="text"
                        className="form-control mb-2"
                        placeholder="Number Plate"
                        value={selectedVehicle.productCode}
                        readOnly
                    />
                    <input
                        type="text"
                        className="form-control mb-2"
                        placeholder="Hire Price"
                        value={selectedVehicle.productSellingPrice}
                        readOnly
                    />
                </div>
            </div>



            <div className="d-flex justify-content-end">
                <button className="btn btn-primary mt-3">Add</button>
            </div>


            {/* Table */}
            <div className="table-responsive mt-3">
                <table className="table table-bordered">
                    <thead>
                        <tr>
                            <th>Customer Name</th>
                            <th>Customer NIC</th>
                            <th>Gurantor Name</th>
                            <th>Gurantor NIC</th>
                            <th>Vehicle Name</th>
                            <th>Number Plate</th>
                            <th>Hire Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>John Doe</td>
                            <td>123456789</td>
                            <td></td>
                            <td></td>
                            <td>Toyota Corolla</td>
                            <td>ABC-123</td>
                            <td>$100/day</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            {/* Payment Section */}
            <div className="row mt-3">
                <div className="col-md-6">
                    <label>Cashier</label>
                    <input type="text" className="form-control mb-2" placeholder="Cashier Name" />
                </div>

                <div className="col-md-6">
                    <label>Today's Date</label>
                    <input type="text" className="form-control mb-2" value={new Date().toLocaleString()} readOnly />
                </div>

            </div>

            <div className="col-md-6">
                    
                        <label >Driver select</label>
                        <select className="form-control mb-2" id="exampleFormControlSelect1">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                        </select>
                    
                </div>


            <div className="row mt-3">

                
                <div className="col-md-6">
                    <label>Payable Amount</label>
                    <input type="text" className="form-control mb-2" placeholder="Payable Amount" />
                    <button className="btn btn-success me-2">Cash</button>
                    <button className="btn btn-warning me-2">Pay Later</button>
                    <button className="btn btn-info me-2">Online Payment</button>
                </div>
                <div className="col-md-6">
                    <label>Total Amount</label>
                    <input type="text" className="form-control mb-2" placeholder="Total Amount" />
                    <label>Paid Amount</label>
                    <input type="text" className="form-control mb-2" placeholder="Paid Amount" />
                    <label>Due</label>
                    <input type="text" className="form-control mb-2" placeholder="Due" />
                    <label>Note</label>
                    <textarea className="form-control mb-2" placeholder="Note"></textarea>
                </div>
            </div>

            <div className="mt-3 justify-content-end d-flex">
                <button className="btn btn-danger me-2">Cancel</button>
                <button className="btn btn-primary">Create</button>
            </div>
        </div>
    );
};

export default Hire;
