import { useState } from 'react';
import './assets/styles/CustomerCard.css';
import { useNavigate } from 'react-router-dom';


const CustomerCard = (props) => {

    const [customerId, setId] = useState(props.customerId);
    const [name, setName] = useState(props.name);
    const [stAd, setStAd] = useState(props.stAd);
    const [city, setCity] = useState(props.city);
    const [postOrZip, setPostOrZip] = useState(props.postOrZip);
    const [provOrState, setProvOrState] = useState(props.provOrState);
    const [country, setCountry] = useState(props.country);
    const [email, setEmail] = useState(props.email);
    const [regDate, setRegDate] = useState(props.regDate.split('T')[0]);
    const [ssn_sin, setSsnSin] = useState(props.ssn_sin);
    const [passwrd, setPassword] = useState(props.passwrd);
    const port = 5100;
    const navigate = useNavigate();

    const deleteCustomer = () => {
        if (window.confirm('Are you sure you want to delete')) {
            console.log('confirmed')
            const body = {customerId};
            console.log(body);
            fetch(`http://localhost:${port}/customers`, {
                method: 'DELETE',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            });
        }

        else {

        }
    }

    const handleClick = () => {
        
        console.log('handleClick');
        
        navigate('/modifycustomers', {
            state: {
                customerId: customerId,
                name: name,
                stAd: stAd,
                city: city,
                provOrState: provOrState,
                postOrZip: postOrZip,
                country: country,
                email: email,
                password: passwrd,
                ssnSin: ssn_sin,
                regDate: regDate
            }});
        
    };


    return (
    
        <div className="customerCard" >
            <p><b>Name:</b> {name}</p>
            <p><b>Email:</b> {email}</p>
            <p><b>Registration Date: </b> {regDate}</p>
            <div className='cardBlock'>
                <div onClick={deleteCustomer}><img src={require('./assets/img/trash.png')} alt='trash image' /></div>
                <div style={{display: 'block', textDecoration: 'underline'}} onClick={handleClick}>Modify Customer Info</div>
            </div>
        </div>
    );
};

export default CustomerCard;