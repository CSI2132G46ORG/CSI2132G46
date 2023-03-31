import { useEffect, useState } from 'react';
import './assets/styles/CreateCustomer.css';
import useToken from './useToken';

const CreateCustomer = () => {

    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [name, setName] = useState('');
    const [address, setAddress] = useState('');
    const [city, setCity] = useState('');
    const [provOrState, setProvorState] = useState('');
    const [postOrZip, setPostOrZip] = useState('');
    const [country, setCountry] = useState('');
    const [ssn_sin, setSsnSin] = useState('');
    const { token, setToken } = useToken();
    const port = 5000;


    const onSubmitForm = async (e) => {
        e.preventDefault();
        try {

            await fetch(`http://localhost:${port}/customers/${email}`, {method: 'GET' })
            .then(d => {
                return d.json();
            })
            .then(data => {
                if(data.length!=0){
                    console.log("user already exists");
                }
                else {
                const body = {name, address, city, provOrState, postOrZip, country, ssn_sin, email, password};
                console.log(body);
            
                const response = fetch(`http://localhost:${port}/signUp`, {
                    method: 'POST',
                    headers: {"content-type": "application/JSON"},
                    body: JSON.stringify(body)
                });
                
                
                // console.log(response);
                return response;    
            }
            })
            .then((data) => {
                if (data.status==200){
                    fetch(`http://localhost:${port}/customers/${email}`, {method: 'GET' })
                    .then(d => {
                        return d.json();
                    })
                    .then((data) => {
                        const id = data[0].id;
                        const full_name = data[0].full_name;
                        setToken(
                            {token: {
                                id: id,
                                full_name: full_name
                            }}
                        );
                    }
                    );
                    
                }
            }
                
            );

            // console.log(user);
           
            // if (user.length!=0){

            //     console.log("user already exists");
            // }
            // else {
                // const body = {name, address, city, provOrState, postOrZip, country, ssn_sin, email, password};
                // console.log(body);
            
                // const response = await fetch(`http://localhost:${port}/signUp`, {
                //     method: 'POST',
                //     headers: {"content-type": "application/JSON"},
                //     body: JSON.stringify(body)
                // });

                // console.log(response);
            // }

        } catch (error) {
            
        }
    };


    return (
        <div className="signUp">
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
                <input type='submit' value='continue'/>
            </form>
        </div>
    );
};

export default CreateCustomer;