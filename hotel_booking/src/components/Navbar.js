import { useState } from 'react';
import { Link } from 'react-router-dom';
import { HashLink } from 'react-router-hash-link';
import './assets/styles/Navbar.css';
import useToken from './useToken';

const Navbar = (props) => {
    const [name, setName] = useState();
    const { token, setToken } = useToken();
    
    const menu = (
        <div id='navBarMenu' className="dropdown-content" >
            
                <HashLink to="/myBookings">My Bookings</HashLink>
                <HashLink to="/">My Info</HashLink>
                <HashLink to="/">Sign Out</HashLink>
            
        </div>
    );

    if (token && token.type=== 'customers'){
        return (
            <div className="navbar">
                <ul role="list">
                    <li className='parts' role="link" id='username'>{token.full_name}</li>
                    <li id='logo' style={{ fontWeight: "bold"}} className="logo" role="link"><Link to="/reservio">Reservio</Link></li>
                </ul>
                {menu}

            </div>
        );
    }
    else {
        return (
            <div className="navbar">
                <ul role="list">
                    <li className='parts' role="link"><HashLink to="/login">Sign In</HashLink></li>
                    <li id='logo' style={{ fontWeight: "bold"}} className="logo" role="link"><Link to="/reservio">Reservio</Link></li>
                </ul>
            </div>
        );
    }

};

export default Navbar;