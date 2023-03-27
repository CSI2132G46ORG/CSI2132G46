import './App.css';
import  { BrowserRouter as Router, Route, Routes} from 'react-router-dom';
import Home from './components/Home.js';
import CheckInOut from './components/CheckInOut';
import Signin from './components/SignIn';
import CreateCustomer from './components/CreateCustomer';
import { useState } from 'react';
import Filter from './components/Filter';
import Payment from './components/Payment';

function App() {
  const [token, setToken] = useState();
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route exact path='/reservio' element = {<Home/>}/>
          <Route path='/checkinout' element={<CheckInOut/>}/>
          <Route path='/login' element={<Signin/>} setToken={setToken}/>
          <Route path='/signup' element={<CreateCustomer/>}/>
          <Route path='/filter' element={<Filter/>}/>
          <Route path='/bookaroom' element={<Payment/>}/>
        </Routes>
      </div>
    </Router>
  );
}

export default App;
