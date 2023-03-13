import React, {useState} from 'react';
import DatePickers from './components/DatePicker';
import PeoplePicker from './components/PeoplePicker';

function App() {
  return (
    <div className="App">
      <DatePickers />
      <PeoplePicker/>
    </div>
  );
}

export default App;