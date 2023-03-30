import { useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import './assets/styles/Filter.css';
import Checkbox from './Checkbox';
import DatePickers from './DatePickers.js';
import Footer from './Footer';
import HotelCard from './HotelCard';
import Navbar from './Navbar.js';
import PeoplePicker from './PeoplePicker.js';
import SearchBar from './Searchbar';
import SearchButton from './SearchButton.js';
import useToken from './useToken';

const Filter = () => {
    const port = 5000;
    const location = useLocation();
    var providedCheckIn= (location.state!=null && location.state.checkIn !=null) ? location.state.checkIn:new Date();
    var providedCheckout = (location.state!=null && location.state.checkOut !=null) ? location.state.checkOut:new Date();
    var providedArea = (location.state!=null && location.state.area !=null) ? location.state.area:'Ottawa, Canada';
    // var tempLocation = providedArea.split(',');
    // var tempCity = tempLocation[0].trim();
    // var tempCountry = tempLocation[1].trim();
    // console.log(providedCheckout);


    const [price, setPrice] = useState({ min: 0, max: 100000 });
    const [amenities, setamenities] = useState([]);
    const [view, setView] = useState("");
    const [extended, setExtended] = useState(false);
    const [hotelchains, setHotelChains] = useState([]);
    const [selectedChains, setselectedChains] = useState([]);
    const [numRooms, setNumRooms] = useState();
    // const [country, setCountry] = useState(tempCountry);
    // const [city, setCity] = useState(tempCity);
    const [area, setArea] = useState(providedArea);
    const [checkInDate, setCheckInDate] = useState(providedCheckIn);
    const [checkOutDate, setCheckOutDate] = useState(providedCheckout);
    const [category, setCategory] = useState("");
    const [results, setResults] = useState([]);
    const { token, setToken } = useToken();


    if (true) {
        var d = new Date(providedCheckIn).toLocaleDateString('fr-FR');
        providedCheckIn= d.split("/").reverse().join("/").replace(/\//g, "_");
        d = new Date(providedCheckout).toLocaleDateString('fr-FR');
        providedCheckout= d.split("/").reverse().join("/").replace(/\//g, "_");
        console.log("Selected check in date: ", providedCheckIn);
        console.log("Selected check out date: ", providedCheckout);
    }

    const [criteria, setCriteria] = useState({
        minPrice: price.min,
        maxPrice: price.max,
        amenities: "",
        view: "",
        extended: "",
        hotelchains: "",
        area: area,
        category: "",
        capacity: "",
        checkInDate: providedCheckIn,
        checkOutDate: providedCheckout,
        numRooms: ""
    });
     
    console.log('criteria ', criteria);

    const updateResult = () => {
        const keys = Object.keys(criteria);
        let combined = "";
        for (let i = 0; i < keys.length; i++) {
            const str = `${keys[i]}=${criteria[keys[i]]}`;

            if (i==0){
                combined = str;
            }
            else {
                combined = `${combined}&${str}`;
            }
        }
        console.log(combined);

        fetch(`http://localhost:${port}/hotels/${combined}`, {method: 'GET' })
        .then(res => res.json())
        .then(data => {
            console.log('results ', data);
            setResults(data);
        });
        // console.log(results);
        // console.log("results updated");
    };

    const findHotelChains = () => {
        fetch(`http://localhost:${port}/hotelchains`, {method: 'GET'})
        .then(res => res.json())
        .then(data => {
            // console.log(data);
            setHotelChains(data);
        });
        
    };

    const updateNumOfRooms = (e) => {
        e.preventDefault();
        const val = document.getElementById("numRooms").value;
        // console.log("val", val);
        setNumRooms(val);
        setCriteria({
            ...criteria,
            numRooms: val
        });
        
    };

    const updateCategory = () => {
        let categories = document.getElementsByClassName("category");
        let tempArr= [];
        for (let i=0; i<categories.length; i++) {
            if (categories[i].checked){
                
                tempArr.push(categories[i].value);
            }
        }
        const categoryStr = tempArr.join();
        setCategory(categoryStr);

        setCriteria({
            ...criteria,
            category: categoryStr
        });
    }

    const updateAmenities = () => {
        let amenities = document.getElementsByClassName("amenity");
        let tempArr= [];
        for (let i=0; i<amenities.length; i++) {
            if (amenities[i].checked){
                
                tempArr.push(amenities[i].value.toLowerCase());
            }
        }
        const ameStr = tempArr.join();
        setamenities(ameStr);

        setCriteria({
            ...criteria,
            amenities: ameStr
        });
    }

    const updateHotelChains = () => {
        let chains = document.getElementsByClassName("hotelChain");
        let tempArr= [];
        for (let i=0; i<chains.length; i++) {
            if (chains[i].checked){
                tempArr.push(chains[i].value.toLowerCase());
            }
        }
        const chainStr = tempArr.join();
        // console.log(chainStr);
        setselectedChains(chainStr);

        setCriteria({
            ...criteria,
            hotelchains: chainStr
        });
    };
    const updatePrice = (e) => {
        // setPrice(e);
        // const p1 = e.min;
        // const p2 = e.max;
        // setCriteria(
        //     {
        //         ...criteria,
        //         minPrice: p1,
        //         maxPrice: p2,
        //     }
        // );
        e.preventDefault();

        const min = document.getElementById("price1").value;
        const max = document.getElementById("price2").value;
        setPrice({min: min, max: max});
        setCriteria({
            ...criteria,
            minPrice: min,
            maxPrice: max
        });
        
    };
    const updateCapacity = () => {
        let capacities = document.getElementsByClassName("capacity");
        let tempArr= [];
        for (let i=0; i<capacities.length; i++) {
            if (capacities[i].checked){
                tempArr.push(capacities[i].value.toLowerCase());
            }
        }
        const capStr = tempArr.join();
        // console.log(capStr);
        setView(capStr);

        setCriteria({
            ...criteria,
            capacity: capStr
        });
    };
    const updateView = (e) => {
        let chains = document.getElementsByClassName("view");
        let tempArr= [];
        for (let i=0; i<chains.length; i++) {
            if (chains[i].checked){
                tempArr.push(chains[i].value.toLowerCase());
            }
        }
        const viewStr = tempArr.join();
        // console.log(viewStr);
        setView(viewStr);

        setCriteria({
            ...criteria,
            view: viewStr
        });
    };
    const updateExtended = (e) => {
        let extended = document.getElementsByClassName("extended");
        let tempArr= [];
        for (let i=0; i<extended.length; i++) {
            if (extended[i].checked){
                
                tempArr.push(extended[i].value.toLowerCase());
            }
        }
        const exStr = tempArr.join();
        setExtended(exStr);

        setCriteria({
            ...criteria,
            extended: exStr
        });
    };
    const updateDates = () => {
        var checkInStr = checkInDate.toLocaleDateString('fr-FR');
        var checkOutStr = checkOutDate.toLocaleDateString('fr-FR');
        checkInStr = checkInStr.split("/").reverse().join("/").replace(/\//g, "_");
        checkOutStr = checkOutStr.split("/").reverse().join("/").replace(/\//g, "_");
        // console.log(checkInStr);
        // console.log(checkOutStr);
        setCriteria({
            ...criteria,
            checkInDate: checkInStr,
            checkOutDate: checkOutStr
        });
    };

    const updateArea = (area) => {
        setArea(area);
        setCriteria({
            ...criteria,
            area: area
        });
    };
    
    useEffect(() => {
        findHotelChains();
    }, []);
    useEffect(() => {updateResult()},
         [criteria]);

    return (
        <div className='filterpage' style={{paddingTop: "90px"}}>
            <Navbar token={token}/>
            
            <div>
                <SearchBar setArea={updateArea} area={area}/>
                <DatePickers setCheckInDate={setCheckInDate} setCheckOutDate={setCheckOutDate} defaultCheckIn ={checkInDate} defaultCheckOut={checkOutDate}/>
                {/* <PeoplePicker /> */}
                <SearchButton updateDates={updateDates}/>
            </div>
            <div className='row'>
                <div className='col-1-of-2'>
                    <h3>Filter by</h3>
                    <div>
                    <h5>Price</h5>
                        <form className='priceForm' onSubmit={updatePrice}>
    
                            <input type="text" id="price1" name="price1" placeholder='Min'  style={{width: "40px"}}/> To
                            <input type="text" id="price2" name="price2" placeholder='Max' style={{width: "40px"}} />
                            <input type={"submit"} value="OK"/>
                        </form>
                    </div>
                    
                    <div>
                        <h5>Hotel Chain</h5>
                        {/* <form> */}
                            {/* <input type="checkbox" id="vehicle1" name="vehicle1" value="1" />
                            <label htmlFor="vehicle1">1</label><br/> */}
                            {/* <input type="submit" value="Submit"/> */}
                            {
                                hotelchains.map((obj) => {
                                    // console.log(obj);

                                    return(
                                        <Checkbox key = {obj.id} name = {obj.name} value= {obj.name} objClass={"hotelChain"} onChange={updateHotelChains}/>
                                    );
                                    
                                })
                            }
                        {/* </form> */}
                    </div>

                    <div>
                    <h5>Number of Rooms</h5>
                        <form className='numberOfRoomsForm' onSubmit={updateNumOfRooms}>
                            <input type="text" id='numRooms' placeholder='Number of Rooms' />
                            <input type={"submit"} value="OK"/> 
                        </form>
                    </div>
                    
                    <div>
                        <h5>Category</h5>
                        <form>
                            <input className='category'  type="checkbox" id="category1" name="category1" value="'1'" onChange={updateCategory}/>
                            <label htmlFor="category1">1</label><br/>
                            <input className='category' type="checkbox" id="category2" name="category2" value="'2'" onChange={updateCategory}/>
                            <label htmlFor="category2">2</label><br/>
                            <input className='category' type="checkbox" id="category3" name="category3" value="'3'" onChange={updateCategory}/>
                            <label htmlFor="category3">3</label><br/>
                            <input className='category' type="checkbox" id="category4" name="category4" value="'4'" onChange={updateCategory}/>
                            <label htmlFor="category4">4</label><br/>
                            <input className='category' type="checkbox" id="category5" name="category5" value="'5'" onChange={updateCategory}/>
                            <label htmlFor="category5">5</label><br/>
                            {/* <input type="submit" value="Submit"/> */}
                        </form>
                    </div>
                    <div>
                        <h5>Amenities</h5>
                        <form>
                            <input className='amenity' type="checkbox" id="amenity1" name="amenity1" value="Wifi" onChange={updateAmenities}/>
                            <label htmlFor="amenity1">Wifi</label><br/>
                            <input className='amenity' type="checkbox" id="amenity2" name="amenity2" value="Free BreakFast" onChange={updateAmenities}/>
                            <label htmlFor="amenity2">Free BreakFast</label><br/>
                            <input className='amenity' type="checkbox" id="amenity3" name="amenity3" value="Free Parking" onChange={updateAmenities}/>
                            <label htmlFor="amenity3">Free Parking</label><br/>
                            <input className='amenity' type="checkbox" id="amenity4" name="amenity4" value="Pool" onChange={updateAmenities}/>
                            <label htmlFor="amenity4">Pool</label><br/>
                            <input className='amenity' type="checkbox" id="amenity5" name="amenity5" value="AC" onChange={updateAmenities}/>
                            <label htmlFor="amenity5">AC</label><br/>
                            {/* <input type="submit" value="Submit"/> */}
                        </form>
                    </div>
                    <div>
                        <h5>Capacity</h5>
                        <form>
                            <input className='capacity' type="checkbox" id="capacity1" name="capacity1" value="Single" onChange={updateCapacity}/>
                            <label htmlFor="capacity1">Single</label><br/>
                            <input className='capacity' type="checkbox" id="capacity2" name="capacity2" value="Double" onChange={updateCapacity}/>
                            <label htmlFor="capacity2">Double</label><br/>
                            <input className='capacity' type="checkbox" id="capacity3" name="capacity3" value="Queen" onChange={updateCapacity}/>
                            <label htmlFor="capacity3">Queen</label><br/>
                            <input className='capacity' type="checkbox" id="capacity4" name="capacity4" value="King" onChange={updateCapacity}/>
                            <label htmlFor="capacity4">King</label><br/>
                        </form>
                    </div>
                    <div>
                        <h5>View</h5>
                        <form>
                            <input className='view' type="checkbox" name="view1" value="Sea" onChange={updateView}/>
                            <label htmlFor="view1">Sea</label><br/>
                            <input className='view' type="checkbox" name="view2" value="Mountain" onChange={updateView}/>
                            <label htmlFor="view2">Mountain</label><br/>
                            {/* <input type="submit" value="Submit"/> */}
                        </form>
                    </div>
                    <div>
                        <h5>Can be Extended</h5>
                        <form>
                            <input className='extended' type="checkbox" id="extended1" name="extended1" value="true" onChange={updateExtended}/>
                            <label htmlFor="extended1">True</label><br/>
                            <input className='extended' type="checkbox" id="extended2" name="extended2" value="false" onChange={updateExtended}/>
                            <label htmlFor="extended2">False</label><br/>
                            {/* <input type="submit" value="Submit"/> */}
                        </form>
                    </div>
                </div>
                <div className='col-1-of-2'>
                    {
                        results.map((hotelObj) => {
                            return (
                                
                                <HotelCard key = {hotelObj.hotel_id} title = {hotelObj.name} price = {hotelObj.min}/>
                            );
                        })
                    }
                </div>
            </div>
            <Footer/>
        </div>
    );
};

export default Filter;