import React, {useState} from 'react';
import { useLocation } from 'react-router-dom';
import './assets/styles/CheckInOut.css'
import DatePickers from './DatePickers';
import Navbar from './Navbar';
import PeoplePicker from './PeoplePicker';
import SearchButton from './SearchButton';

function CheckInOut() {

  const location = useLocation();
  var providedArea= (location.state!=null && location.state.chosenLocation !=null) ? location.state.chosenLocation.name:'Ottawa, Canada';
  const [checkInDate, setCheckInDate] = useState(new Date());
  const [checkOutDate, setCheckOutDate] = useState(new Date());
  const [numPeople, setNumPeople] = useState(1);
  const [area, setArea] = useState(providedArea);

  // function updateCheckInDate () {
  //     setCheckInDate();
  // };

  return (
    <div className="CheckInOut"  style={{paddingTop: "90px"}}>
      <Navbar/>
      <h3>The Best Hotels In {area}</h3>
      <div className="container">
        <DatePickers setCheckInDate={setCheckInDate} setCheckOutDate={setCheckOutDate}/>
        <PeoplePicker setNumPeople={setNumPeople}/>
        <SearchButton checkInDate={checkInDate} checkOutDate={checkOutDate} numPeople={numPeople} area={area}/>
      </div>
    </div>
  );
}

export default CheckInOut;