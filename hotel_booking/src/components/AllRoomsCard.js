import './assets/styles/AllRoomsCard.css';
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';


const AllRoomsCard = (props) => {

    const [roomNumber, setRoomNumber] = useState(props.roomNumber);
    const [hotelId, setHotelId] = useState(props.hotelId);
    const [price, setPrice] = useState(props.price);
    const [capacity, setCapacity] = useState(props.capacity);
    const [view, setView] = useState(props.view);
    const [extended, setExtended] = useState(props.extended);
    const [problems, setProblems] = useState(props.problems);
    const port = 5100;
    const navigate = useNavigate();


    const deleteRoom = () => {
        const body = {roomNumber, hotelId};
        console.log(body);

        
        if (window.confirm('Are you sure you want to delete')) { 
            fetch(`http://localhost:${port}/rooms`, {
                method: 'DELETE',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            });
        }
        else {

        }

        
    };

    const handleClick = () => {
        navigate('/modifyrooms', {
            state: {
                roomNumber: roomNumber,
                hotelId: hotelId,
                price: price,
                capacity: capacity,
                view: view,
                extended: extended,
                problems: problems
            }
        });

    };
    return (
        <div className='roomCard'>
            <p><b>Room number:</b> {roomNumber}</p>
            <p><b>Capacity:</b>  {capacity}</p>
            <p><b>View:</b>  {view}</p>
            <p><b>Extended:</b>  {extended}</p>
            <p><b>Problems:</b>  {problems}</p>
            <div className='cardBlock'>
                <div onClick={deleteRoom}><img src={require('./assets/img/trash.png')} alt='trash image' /></div>
                <div style={{display: 'block', textDecoration: 'underline'}} onClick={handleClick}>Modify Room</div>
            </div>
        </div>
    );
};

export default AllRoomsCard;