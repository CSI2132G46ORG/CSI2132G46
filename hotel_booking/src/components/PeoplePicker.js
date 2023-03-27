import React, { useState } from 'react';
import './assets/styles/PeoplePicker.css';

function PeoplePicker(props) {
  const [numPeople, setNumPeople] = useState(1);

  const handleNumPeopleChange = data => {
    const val = data.target.value;
    console.log("Number of people selected: ", val);
    setNumPeople(val);
    props.setNumPeople(val);
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