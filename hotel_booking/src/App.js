import './App.css';
import  { BrowserRouter as Router, Route, Routes} from 'react-router-dom';
import Home from './components/Home.js';
import CheckInOut from './components/CheckInOut';
import Signin from './components/CustomerSignIn';
import CreateCustomer from './components/CreateCustomer';
import { useState } from 'react';
import Filter from './components/Filter';
import Payment from './components/Payment';
import CustomerBookings from './components/CustomerBookings';
import EmployeeLogin from './components/EmployeeLogin';
import Hotel from './components/Hotel';

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
          <Route exact path='/bookaroom' element={<Payment/>}/>
          <Route exact path='/mybooking' element={<CustomerBookings/>}/>
          <Route exact path='/employeeLogin' element={<EmployeeLogin/>}/>
          <Route exact path='/hotel' element={<Hotel/>}/>
        </Routes>
      </div>
    </Router>
  );
}

export default App;
