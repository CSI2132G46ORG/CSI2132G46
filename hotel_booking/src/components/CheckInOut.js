import React, {useState} from 'react';
import './assets/styles/CheckInOut.css'
import DatePickers from './DatePickers';
import PeoplePicker from './PeoplePicker';
import SearchButton from './SearchButton';

function CheckInOut() {
  const [checkInDate, setCheckInDate] = useState(new Date());
  const [checkOutDate, setCheckOutDate] = useState(new Date());
  const [numPeople, setNumPeople] = useState(1);

  // function updateCheckInDate () {
  //     setCheckInDate();
  // };

  return (
    <div className="CheckInOut">
      <div className="container">
        <DatePickers setCheckInDate={setCheckInDate} setCheckOutDate={setCheckOutDate}/>
        <PeoplePicker setNumPeople={setNumPeople}/>
        <SearchButton checkInDate={checkInDate} checkOutDate={checkOutDate} numPeople={numPeople}/>
      </div>
    </div>
  );
}

export default CheckInOut;