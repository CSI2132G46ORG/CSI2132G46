import { useState } from 'react';

const HotelOverview = (props) => {
    const [number_of_rooms, setnumber_of_rooms] = useState(props.number_of_rooms);
    const [street_address, setstreet_address] = useState(props.street_address);
    const [city, setcity] = useState(props.city);
    const [province_or_state, setprovince_or_state] = useState(props.province_or_state);
    const [country, setcountry] = useState(props.country);
    const [postal_code_or_zip_code, setpostal_code_or_zip_code] = useState(props.postal_code_or_zip_code);
    const [contact_email, setcontact_email] = useState(props.contact_email);
    return (
    <div className="hotel-overview">
        <h1>Hotel Overview:</h1>
        <p>Number of rooms: {number_of_rooms}</p>
        <p>Address: {street_address}, {city}, {province_or_state}, {country}, {postal_code_or_zip_code}</p>
        <p>Contact email: {contact_email}</p>
    </div>
    );
};

export default HotelOverview;