import React, {useState} from 'react';
import './App.css'
import DatePickers from './components/DatePicker';
import PeoplePicker from './components/PeoplePicker';

function App() {
  return (
    <div className="App">
      <div className="container">
        <DatePickers />
        <PeoplePicker />
      </div>
    </div>
  );
}

export default App;