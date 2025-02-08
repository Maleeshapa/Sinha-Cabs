import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import './Header.css';
import Back from './Back';

const Header = () => {
  const navigate = useNavigate();
  const [currentTime, setCurrentTime] = useState(new Date());

  // Calculate the last day of the current month
  const getLastDayOfMonth = (date) => {
    const year = date.getFullYear();
    const month = date.getMonth() + 1; // Months are zero-based, so add 1
    return new Date(year, month, 0); // Day 0 of the next month is the last day of the current month
  };

  // Calculate remaining days until the end of the month
  const lastDayOfMonth = getLastDayOfMonth(currentTime);
  const remainingDays = Math.max(0, Math.ceil((lastDayOfMonth - currentTime) / (1000 * 60 * 60 * 24)));

  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentTime(new Date());
    }, 1000);

    return () => clearInterval(timer);
  }, []);

  const handleNewSaleClick = () => {
    navigate('/sales/new');
  };

  const handleNewHireClick = () => {
    navigate('/sales/hire');
  };

  const formattedDate = currentTime.toLocaleDateString('en-SL', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });

  const formattedTime = currentTime.toLocaleTimeString();

  return (
    <header className="d-flex align-items-center justify-content-between p-3  text-light">
      <div className="d-flex align-items-center">
        <Back />
      </div>
      <div className="d-flex align-items-center">
        <span className="trial-message text-white me-3 d-none d-md-block">
          {remainingDays > 0
            ? `${remainingDays} day${remainingDays > 1 ? 's' : ''} left until month end`
            : 'Today is the last day of the month'}
        </span>
        <div className="text-light">
          <div className='date'>
            <span>{formattedDate}</span>
          </div>
          <div className='time'>
            <span>{formattedTime}</span>
          </div>
        </div>
      </div>
     

     <div className='justify-content-end'>
     <button className="btn btn-success header-button" onClick={handleNewHireClick}>
        New Hire
      </button>

  
      <button className="btn btn-danger header-button" onClick={handleNewSaleClick}>
        New Rent
      </button>
      {' '}
     </div>
     

    </header>
  );
};

export default Header;