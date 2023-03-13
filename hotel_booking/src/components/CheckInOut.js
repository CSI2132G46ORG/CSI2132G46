import React, {useState} from 'react';
import './styles/CheckInOut.css'
import DatePickers from './DatePicker';
import PeoplePicker from './PeoplePicker';
import SearchButton from './SearchButton';

function CheckInOut() {
  return (
    <div className="CheckInOut">
      <div className="container">
        <DatePickers />
        <PeoplePicker />
        <SearchButton />
      </div>
    </div>
  );
}

export default CheckInOut;