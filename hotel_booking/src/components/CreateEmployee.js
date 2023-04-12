import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './assets/styles/CreateEmployee.css';
import useToken from './useToken';

const CreateEmployee = () => {

    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [name, setName] = useState('');
    const [address, setAddress] = useState('');
    const [city, setCity] = useState('');
    const [provOrState, setProvorState] = useState('');
    const [postOrZip, setPostOrZip] = useState('');
    const [country, setCountry] = useState('');
    const [ssn_sin, setSsnSin] = useState('');
    const [role, setRole] = useState('');
    const [hotelId, setHotelId] = useState('');
    const { token, setToken } = useToken();
    const navigate = useNavigate();
    const port = 5100;

    const onSubmitForm = (e) => {
        e.preventDefault();
        fetch(`http://localhost:${port}/employees/setEmail/${email}`, {method: 'GET' })
          .then(response => response.json())
          .then(json => {
            console.log("This is json.length: "+ json.length);
            if (json.length != 0) {
              console.log("user already exists");
            } else {
              //console.log("I am reaching here");
              const body = {name, address, city, provOrState, postOrZip, country, ssn_sin, email, password, role, hotelId};
              console.log('employee signup form', body);
              return fetch(`http://localhost:${port}/employees/SignUp`, {
                method: 'POST',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
              });
            }
          })
          .then(response => {
            console.log(response);
            return response;
          })
          .then((data) => {
            console.log('status', data.status);
            if (data.status == 200) {
              return fetch(`http://localhost:${port}/employees/setEmail/${email}`, {method: 'GET' })
                .then(d => {
                  return d.json();
                })
                .then((data) => {
                  const id = data[0].id;
                  const full_name = data[0].full_name;
                  console.log(id, full_name);
                  setToken({
                    token: {
                      id: id,
                      type: 'employee',
                      full_name: full_name
                    }
                  });
                  navigate('/reservio', { replace: true });
                });
            }
          })
          .catch(error => {
            console.log("This is error: "+error);
          });
      };
      

    return (
        <div className="employeesignUp">
            <h1>Create an account</h1>
            <form onSubmit={onSubmitForm}>
                <input type="email" placeholder="Email" value={email} onChange={e => setEmail(e.target.value)} required/>
                <input type="text" placeholder="Enter your name" value={name} onChange={e => setName(e.target.value)} required/>
                <input type="text" placeholder="Street address" value={address} onChange={e => setAddress(e.target.value)} required/>
                <input type="text" placeholder="City" value={city} onChange={e => setCity(e.target.value)} required/>
                <input type="text" placeholder="Province or State" value={provOrState} onChange={e => setProvorState(e.target.value)} required/>
                <input type="text" placeholder="Postal code or Zip code" value={postOrZip} onChange={e => setPostOrZip(e.target.value)} required/>
                <input type="text" placeholder="Country" value={country} onChange={e => setCountry(e.target.value)} required/>
                <input type="text" placeholder="SSN or SIN" value={ssn_sin} onChange={e => setSsnSin(e.target.value)} required/>
                <input type="password" placeholder='Create a New Password'  required/>
                <input type="password" placeholder='Confirm password' value={password} onChange={e => setPassword(e.target.value)} required/>
                <input type="text" placeholder="Role" value={role} onChange={e => setRole(e.target.value)} required/>
                <input type="text" placeholder="Hotel ID" value={hotelId} onChange={e => setHotelId(e.target.value)} required/>
                <input type='submit' value='Create a Employee Account'/>
            </form>
        </div>
    );
};

export default CreateEmployee;