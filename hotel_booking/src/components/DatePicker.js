import React, { useState } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import './assets/styles/DatePicker.css';

function DatePickers() {
  const [checkInDate, setCheckInDate] = useState(null);
  const [checkOutDate, setCheckOutDate] = useState(null);

  const handleCheckInDateChange = date => {
    console.log("Selected check in date: ", date);
    setCheckInDate(date);
  };

  const handleCheckOutDateChange = date => {
    console.log("Selected check out date: ", date);
    setCheckOutDate(date);
  };

  return (
    <div className="date-pickers-container">
      <div className="date-picker">
        <label htmlFor="checkin">Check-in Date: </label>
        <DatePicker
          id="checkin"
          selected={checkInDate}
          onChange={handleCheckInDateChange}
          dateFormat="yyyy/MM/dd"
        />
      </div>
      <div className="date-picker">
        <label htmlFor="checkout">Check-out Date: </label>
        <DatePicker
          id="checkout"
          selected={checkOutDate}
          onChange={handleCheckOutDateChange}
          dateFormat="dd/MM/yyyy"
        />
      </div>
    </div>
  );
}

export default DatePickers;