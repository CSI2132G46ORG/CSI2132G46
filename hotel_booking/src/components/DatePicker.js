import React, { useState } from 'react';
import DatePicker from 'react-datepicker';
import '../App.js'
import 'react-datepicker/dist/react-datepicker.css';

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
    <div>
      <div>
        <label htmlFor="checkin">Check-in Date: </label>
        <DatePicker
          id="checkin"
          selected={checkInDate}
          onChange={handleCheckInDateChange}
        />
      </div>
      <div>
        <label htmlFor="checkout">Check-out Date: </label>
        <DatePicker
          id="checkout"
          selected={checkOutDate}
          onChange={handleCheckOutDateChange}
        />
      </div>
    </div>
  );
}

export default DatePickers;