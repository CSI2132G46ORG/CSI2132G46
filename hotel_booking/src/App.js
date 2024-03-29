import './App.css';
import  { BrowserRouter as Router, Route, Routes} from 'react-router-dom';
import Home from './components/Home.js';
import CheckInOut from './components/CheckInOut';
import Signin from './components/CustomerSignIn';
import CreateCustomer from './components/CreateCustomer';
import { useState } from 'react';
import Filter from './components/Filter';
import Payment from './components/Payment';
import EmployeeLogin from './components/EmployeeLogin';
import Hotel from './components/Hotel';
import EmployeePage from './components/EmployeePage';
import CreateRenting from './components/CreateRenting';
import AllBookings from './components/AllBookings';
import AllHotelChains from './components/AllHotelChains';
import HotelChainForm from './components/HotelChainForm';
import AllHotels from './components/AllHotels';
import HotelForm from './components/HotelForm';
import AllRooms from './components/AllRooms';
import RoomForm from './components/RoomForm';
import AdminPage from './components/AdminPage';
import AdminLogin from './components/AdminLogin';
import AllRentings from './components/AllRentings';
import AllCustomers from './components/AllCustomers';
import CreateEmployee from './components/CreateEmployee';
import MyBookings from './components/MyBookings';
import CustomerForm from './components/CustomerForm';

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
          <Route exact path='/employeeLogin' element={<EmployeeLogin/>}/>
          <Route exact path='/adminLogin' element={<AdminLogin/>}/>
          <Route exact path='/hotel' element={<Hotel/>}/>
          <Route exact path='/employeePage' element={<EmployeePage/>}/>
          <Route exact path='/adminPage' element={<AdminPage/>}/>
          <Route exact path='/createRenting' element={<CreateRenting/>}/>
          <Route exact path='/allbookings' element={<AllBookings/>}/>
          <Route exact path='/allrentings' element={<AllRentings/>}/>
          <Route exact path='/allhotelchains' element={<AllHotelChains/>}/>
          <Route exact path='/allhotels' element={<AllHotels/>}/>
          <Route exact path='/allrooms' element={<AllRooms/>}/>
          <Route exact path='/allcustomers' element={<AllCustomers/>}/>
          <Route exact path='/modifyhotelchains' element={<HotelChainForm/>}/>
          <Route exact path='/modifyhotels' element={<HotelForm/>}/>
          <Route exact path='/modifyrooms' element={<RoomForm/>}/>
          <Route exact path='/modifycustomers' element={<CustomerForm/>}/>
          <Route exact path='/employeeSignUp' element={<CreateEmployee/>}/>
          <Route exact path='/myBookings' element={<MyBookings/>}/>
          
          {/* <Route path='/allhotels' element={<AllHotelChains/>}/>
          <Route path='/allrooms' element={<AllHotelChains/>}/> */}
        </Routes>
      </div>
    </Router>
  );
}

export default App;
