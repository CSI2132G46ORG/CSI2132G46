import { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import './assets/styles/CustomerForm.css';

const CustomerForm = () => {

    const port = 5100;
    const location = useLocation();

    const [customerId, setId] = useState(location.state && location.state.customerId? location.state.customerId:null);
    const [name, setName] = useState(location.state && location.state.name? location.state.name:null);
    const [ssnSin, setSsnSin] = useState(location.state && location.state.ssnSin? location.state.ssnSin:null);
    const [stAd, setStAd] = useState(location.state && location.state.stAd? location.state.stAd:null);
    const [city, setCity] = useState(location.state && location.state.city? location.state.city:null);
    const [postOrZip, setPostOrZip] = useState(location.state && location.state.postOrZip? location.state.postOrZip:null);
    const [country, setCountry] = useState(location.state && location.state.country? location.state.country:null);
    const [provOrState, setProvOrState] = useState(location.state && location.state.provOrState? location.state.provOrState:null);
    const [email, setEmail] = useState(location.state && location.state.email? location.state.email:null);
    const [password, setPassword] = useState(location.state && location.state.password? location.state.password:null);
    const [regDate, setRegDate] = useState(location.state && location.state.regDate? location.state.regDate:null);
    const navigate = useNavigate();



    const handleSubmit = (e) => {
        e.preventDefault();
        
        if (location.state){
            const body = {customerId, name, ssnSin, stAd, city, provOrState, postOrZip, country, email, password};
            console.log(body);
            fetch(`http://localhost:${port}/customers`, {
                method: 'PUT',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            })
            .then(
                navigate('/allcustomers', {replace: true})
            );
        }
        else {
            
        }
    };

    const updateName = (e) => {
        setName(e.target.value);
    };
    const updateSSNSIN = (e) => {
        setSsnSin(e.target.value);
    };
    const updateStAd = (e) => {
        setStAd(e.target.value);
    };
    const updatePostOrZip = (e) => {
        setPostOrZip(e.target.value);
    };
    const updateEmail = (e) => {
        setEmail(e.target.value);
    };
    const updateCity = (e) => {
        setCity(e.target.value);
    };
    const updateCountry = (e) => {
        setCountry(e.target.value);
    };

    const updateProvOrState = (e) => {
        setProvOrState(e.target.value);
    };
    const updatePassword = (e) => {
        setPassword(e.target.value);
    };



    return (
        <div className="customerForm">
            <h2>Customer Form</h2>

            <form onSubmit={handleSubmit}>
                <input type="text" placeholder="Enter your name" value={name} onChange={updateName}/>
                <input type="text" placeholder="Enter your SSN/SIN" value={ssnSin} onChange={updateSSNSIN}/>
                <input type="text" placeholder="Enter your street adress" value={stAd} onChange={updateStAd}/>
                <input type="text" placeholder="Enter your city" value={city} onChange={updateCity}/>
                <input type="text" placeholder="Enter your postal code or zip" value={postOrZip} onChange={updatePostOrZip}/>
                <input type="text" placeholder="Enter your country" value={country} onChange={updateCountry} />
                <input type="text" placeholder="Enter your province or state" value={provOrState} onChange={updateProvOrState}/>
                <input type="text" placeholder="Enter your email" value={email} onChange={updateEmail}/>
                <input type="text" placeholder="Enter your password" value={password} onChange={updatePassword}/>
                <input type="text" placeholder="Confirm your password"/>

                <input type="submit" value={"Submit"} />

            </form>
        </div>
    );
};

export default CustomerForm;