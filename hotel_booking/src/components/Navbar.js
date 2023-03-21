import { Link } from 'react-router-dom';
import { HashLink } from 'react-router-hash-link';
import './assets/styles/Navbar.css';

const Navbar = () => {
    return (
        <div className="navbar">
            <ul role="list">
                <li className='parts' role="link"><HashLink to="/login">Sign In</HashLink></li>
                <li style={{ fontWeight: "bold"}} className="logo" role="link"><Link to="/reservio">Reservio</Link></li>
            </ul>
        </div>
    );
};

export default Navbar;