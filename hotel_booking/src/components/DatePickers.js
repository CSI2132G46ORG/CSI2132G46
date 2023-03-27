import React, { useState } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import './assets/styles/DatePicker.css';

function DatePickers(props) {
  const [checkInDate, setCheckIn] = useState(props.defaultCheckIn);
  const [checkOutDate, setCheckOut] = useState(props.defaultCheckOut);

  const handleCheckInDateChange = date => {
    const d = new Date(date).toLocaleDateString('fr-FR');
    var newdate = d.split("/").reverse().join("/");
    console.log("Selected check in date: ", newdate);
    setCheckIn(new Date(newdate));
    props.setCheckInDate(new Date(newdate));
  };

  const handleCheckOutDateChange = date => {
    const d = new Date(date).toLocaleDateString('fr-FR');
    var newdate = d.split("/").reverse().join("/");
    console.log("Selected check in date: ", newdate);
    setCheckOut(new Date(newdate));
    props.setCheckOutDate(new Date(newdate));
  };

  return (
    <div className="date-pickers-container">
      <div className="date-picker">
        <label htmlFor="checkin">Check-in Date: </label>
        <DatePicker
          id="checkin"
          selected={checkInDate}
          placeholderText="Select Date"
          onChange={handleCheckInDateChange}
          dateFormat="yyyy/MM/dd"
        />
      </div>
      <div className="date-picker">
        <label htmlFor="checkout">Check-out Date: </label>
        <DatePicker
          id="checkout"
          selected={checkOutDate}
          placeholderText="Select Date"
          onChange={handleCheckOutDateChange}
          dateFormat="yyyy/MM/dd"
        />
      </div>
    </div>
  );
}

export default DatePickers;