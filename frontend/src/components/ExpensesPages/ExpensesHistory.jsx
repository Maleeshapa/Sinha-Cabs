import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import config from '../../config';

const ExpensesHistory = () => {
    const [expenses, setExpenses] = useState([]);

    useEffect(() => {
        // Fetch expenses data
        axios.get(`${config.BASE_URL}/expenses`)
            .then(response => setExpenses(response.data))
            .catch(error => console.error('Error fetching expenses:', error));
    }, []);

    return (
        <div className="container mt-5">
            <h4>Expenses History</h4>
            <div className="table-responsive">
                <table className="table table-bordered table-striped">
                    <thead className='table-dark'>
                        <tr>
                            <th>#</th>
                            <th>Category</th>
                            <th>Vechicle</th>
                            <th>Price</th>
                            <th>Description</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
    {expenses.map(expense => (
        <tr key={expense.expensesId}>
            <td>{expense.expensesId}</td>
            <td>{expense.expensesCategory.expensesCatName    }</td>
            <td>{expense.product.productName }</td>
            <td>{expense.price}</td>
            <td>{expense.description}</td>
            <td>{new Date(expense.date).toLocaleDateString()}</td>
        </tr>
    ))}
</tbody>

                </table>
            </div>
        </div>
    );
};

export default ExpensesHistory;