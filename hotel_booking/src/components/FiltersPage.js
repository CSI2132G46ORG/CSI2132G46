import React, { useState, useEffect } from 'react';

function FiltersPage({ city }) {
  const [hotels, setHotels] = useState([]);

  useEffect(() => {
    fetch(`/hotels/${city}`)
      .then(response => response.json())
      .then(data => setHotels(data))
      .catch(error => console.error(error));
  }, [city]);

  return (
    <div>
      <h2>Hotels in {city}</h2>
      <ul>
        {hotels.map(hotel => (
          <li key={hotel.id}>
            {hotel.name} - {hotel.address}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default FiltersPage;
