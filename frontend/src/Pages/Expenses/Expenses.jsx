import React from 'react'
import { Route, Routes } from 'react-router-dom';
import Header from '../../components/SideBar/Header'
import expensesCategory from '../../components/expenses/expensesCategory'

const Return = () => {
  return (
    <div>
      <div className='show-Header'><Header /></div>
      <Routes>

       <Route path="/expenses/category" element={<expensesCategory />} />
        
      </Routes>
    </div>
  )
}

export default Return