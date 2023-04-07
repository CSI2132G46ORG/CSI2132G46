import React, { useState, useEffect } from "react";
import Navbar from "./Navbar";
import RoomCard from "./RoomCard";
import HotelOverview from "./HotelOverview";
import { useNavigate } from 'react-router-dom';
import { useLocation } from 'react-router-dom';

function Hotel() {
  const [rooms, setRooms] = useState([]); // state to hold the retrieved rooms
  const [totalRooms, setTotalRooms] = useState(0);
  const [hotelInfo, setHotelInfo] = useState([]);
  const [amenityInfo,setAmentiyInfo] = useState([]);
  const [error, setError] = useState(null); // state to hold any errors encountered during fetch
  const [payButtonClicked, setPayButtonClicked] = useState(false);
  const [payType, setPayType] = useState(false);
  const [roomObject, getRoomObject] = useState([]);
  const navigate = useNavigate();
  const location = useLocation();

  const port = 5100;
  var providedCheckIn= (location.state!=null && location.state.checkIn !=null) ? location.state.checkIn:new Date();
  var providedCheckout = (location.state!=null && location.state.checkOut !=null) ? location.state.checkOut:new Date();
  var providedArea = (location.state!=null && location.state.area !=null) ? location.state.area:'Ottawa, Canada';
  var providedHotelID = (location.state!=null && location.state.hotel_id !=null) ? location.state.hotel_id:null;
  var providedHotelName = (location.state!=null && location.state.hotelName !=null) ? location.state.hotelName:null;

  console.log("Provided Check in date : "+ providedCheckIn);
  console.log("Provided Check out date : "+ providedCheckout);
  console.log("Provided area : "+ providedArea);
  console.log("Provided Hotel ID : "+ providedHotelID);
  console.log("Provided Hotel Name : "+ providedHotelName);

const handlePayButtonClick = (payVal,roomObject,amenities) => {
  setPayButtonClicked(true);
  setPayType(payVal);
  getRoomObject(roomObject);

  console.log("room obj", roomObject);

  if(window.location.pathname==="/hotel"){
    setTimeout(() => {
      navigate("/bookaroom", {state: {
          number_of_rooms : hotelInfo.number_of_rooms,
          street_address : hotelInfo.street_address,
          city : hotelInfo.city,
          province_or_state: hotelInfo.province_or_state,
          contact_email : hotelInfo.contact_email,
          roomNumber : roomObject.roomNumber,
          price : roomObject.price,
          capacity : roomObject.capacity,
          view : roomObject.view,
          extended : roomObject.extended,
          problems : roomObject.problems,
          checkIn : providedCheckIn,
          checkOut : providedCheckout,
          area : providedArea,
          hotel_id : providedHotelID,
          hotelName : providedHotelName,
          amenities : amenities,
          payType: payVal
      }});
    }, 200);
  }
  
};
//console.log("This is the amenities: "+ roomObject.amenities.map((amenity) => amenity.amenity).join(', '));
// console.log("This is payButtonClicked: "+ payButtonClicked);
// console.log("This is paytype: "+ payType);
// console.log("This is roomNum: "+ roomObject.problems);
//const testVar = roomObject.map((room) => room.room_number);
//console.log("This is testvar : "+ testVar)

  useEffect(() => {
    async function fetchAmentityInfo() {
      try {
        const response = await fetch(`http://localhost:${port}/amenity/${providedHotelID}`); // fetch data from API with hotel id, checkin, and checkout parameters
        const data = await response.json(); // parse response data as JSON
        setAmentiyInfo(data); // update rooms state with fetched data

      } catch (error) {
        setError(error); // set error state if an error occurs during fetch
      }
    }
    async function fetchHotelInfo() {
        try {
          const response = await fetch(`http://localhost:${port}/hotels/info/${providedHotelID}`); // fetch data from API with hotel id, checkin, and checkout parameters
          const data = await response.json(); // parse response data as JSON
          console.log('data ', data); 
          setHotelInfo(data); // update rooms state with fetched data
  
        } catch (error) {
          setError(error); // set error state if an error occurs during fetch
        }
      }
    async function fetchRooms() {
      try {
        const response = await fetch(`http://localhost:${port}/hotels/${providedHotelID}/rooms?checkin_date=${providedCheckIn}&checkout_date=${providedCheckout}`); // fetch data from API with hotel id, checkin, and checkout parameters
        const data = await response.json(); // parse response data as JSON
        setTotalRooms(Object.keys(data).length);
        console.log('rooms: ', data)
        setRooms(data); // update rooms state with fetched data

      } catch (error) {
        setError(error); // set error state if an error occurs during fetch
      }
    }
    fetchAmentityInfo();
    fetchHotelInfo();
    fetchRooms(); // call fetchRooms function on component mount
  }, []);


  return (
    <div className="HotelPage"  style={{paddingTop: "90px"}}>
      <Navbar/>
      <div className="hotel-overview">
      {hotelInfo.map((hotelInfo) => {
            return (
                <HotelOverview key = {hotelInfo.id} number_of_rooms = {hotelInfo.number_of_rooms} street_address = {hotelInfo.street_address} city = {hotelInfo.city} province_or_state = {hotelInfo.province_or_state} country = {hotelInfo.country} postal_code_or_zip_code = {hotelInfo.postal_code_or_zip_code} contact_email = {hotelInfo.contact_email}/>
            );
        })
    }
      </div>
      <h1>The Number of Rooms available are : {totalRooms}</h1>
      <div>
        {/* map over the rooms array to render a RoomCard for each room */}
        {rooms.map((room) => {
          const amenities = amenityInfo.filter((amenity) => amenity.room_number === room.room_number);
            return (
                <RoomCard key ={`${room.room_number}_${room.hotel_id}`} roomNumber = {room.room_number} price = {room.price} capacity = {room.capacity} view = {room.view} extended = {room.extended} problems = {room.problems} amenities = {amenities} handlePayButtonClick={handlePayButtonClick}>
                  </RoomCard>
            );
        })
    }
      </div>
    </div>
  );
}

export default Hotel;
