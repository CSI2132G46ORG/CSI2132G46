import { useNavigate } from 'react-router-dom';
import { HashLink } from 'react-router-hash-link';
import './assets/styles/EmployeeButton.css';




const EmployeeButton = (props) => {

    const navigate = useNavigate();
    const handleClick = () => {
        if (props.path=='/allhotels'){
            navigate(`${props.path}`, {state: {
                hotelChainId: props.hotelChainId
            }});
        }
        else if (props.path=='/allrooms'){
            navigate(`${props.path}`, {state: {
                hotelId: props.hotelId
            }});
        }
        else {
            navigate(`${props.path}`);
        }

    };

    return (
        <button className="EmployeeButton" onClick={handleClick}>
            {props.title}
        </button>
    );
};

export default EmployeeButton;