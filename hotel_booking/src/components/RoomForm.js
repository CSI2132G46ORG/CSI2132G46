import { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";

const RoomForm = () => {
    
    const port = 5100;
    const location = useLocation();

    const [roomNumber, setRoomNumber] = useState(location.state && location.state.roomNumber?  location.state.roomNumber:'');
    const [hotelId, setHotelId] = useState(location.state && location.state.hotelId? location.state.hotelId:'');
    const [price, setPrice] = useState(location.state && location.state.price?  location.state.price:'');
    const [capacity, setCapacity] = useState(location.state && location.state.capacity? location.state.capacity:'');
    const [view, setView] = useState(location.state && location.state.view? location.state.view:'');
    const [extended, setExtended] = useState(location.state && location.state.extended? location.state.extended:'');
    const [problems, setProblems] = useState(location.state && location.state.problems? location.state.problems:'');
    const navigate = useNavigate();



    const handleSubmit = (e) => {
        e.preventDefault();
        if (location.state){
            const body = {roomNumber, hotelId, price, capacity, view, extended, problems};
            console.log(body);
            fetch(`http://localhost:${port}/rooms`, {
                method: 'PUT',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            })
            .then((res) => {
                if (res.status == 200) {
                    navigate('/allrooms', {replace: true, state: {
                        hotelId: hotelId
                    }})
                }
            });
        }
        else {
            const body = {roomNumber, hotelId, price, capacity, view, extended, problems};
            console.log(body);
            fetch(`http://localhost:${port}/rooms`, {
                method: 'POST',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            })
            .then((res) => {
                // if (res.status == 200) {
                //     navigate('/allrooms', {replace: true, state: {
                //         hotelId: hotelId
                //     }})
                // }
            });
        }
    };

    const updatePrice = (e) => {
        setPrice(e.target.value);
    };
    const updateCapacity = (e) => {
        setCapacity(e.target.value);
    };
    const updateView = (e) => {
        setView(e.target.value);
    };
    const updateExtended = (e) => {
        setExtended(e.target.value);
    };
    const updateProblems = (e) => {
        setProblems(e.target.value);
    };

    const updateRoomNumber = (e) => {
        setRoomNumber(e.target.value);
    };

    const updateHotelId = (e) => {
        setHotelId(e.target.value);
    };


    const extraInput = () => {
        if (!location.state) {
            return (
                <div>
                    <input type={"text"} value={roomNumber} onChange={updateRoomNumber} placeholder="Enter room number"/>
                    <input type={"text"} value={hotelId} onChange={updateHotelId} placeholder="Enter hotel Id"/>
                </div>
            );
        }
    };


    return (
        <div className="roomForm">
            <form onSubmit={handleSubmit}>
                <h2>Modify Rooms</h2>
                <input type={"text"} value={price} onChange={updatePrice} placeholder="Enter price"/>
                <input type={"text"} value={capacity} onChange={updateCapacity} placeholder="Enter capacity"/>
                <input type={"text"} value={view} onChange={updateView}  placeholder="Enter view"/>
                <input type={"text"} value={extended} onChange={updateExtended} placeholder="Enter if it can be extended"/>
                <input type={"text"} value={problems} onChange={updateProblems} placeholder="Enter if it has problems"/>
                {extraInput()}
                <input type={"submit"} value="submit"/>
            </form>
        </div>
    );
}

export default RoomForm;