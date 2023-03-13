import React, { useState } from 'react';

function PeoplePicker() {
  const [numPeople, setNumPeople] = useState(1);

  const handleNumPeopleChange = data => {
    console.log("Number of people selected: ", data.target.value);
    setNumPeople(data.target.value);
  };

  return (
    <div>
    <div>
      <label htmlFor="num-people">Number of People:</label>
    </div>
    <div>
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