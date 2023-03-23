import React, { useState } from 'react';
import './assets/styles/PeoplePicker.css';

function PeoplePicker() {
  const [numPeople, setNumPeople] = useState(1);

  const handleNumPeopleChange = data => {
    console.log("Number of people selected: ", data.target.value);
    setNumPeople(data.target.value);
  };

  return (
    <div className="people-pickers-container">
        <div className="people-picker">
            <label htmlFor="num-people">Number of People:</label>
        </div>
        <div className="people-picker">
            <input 
                type="number" 
                id="num-people" 
                value={numPeople} 
                onChange={handleNumPeopleChange} 
            />
        </div>
    </div>

  );
}

export default PeoplePicker;