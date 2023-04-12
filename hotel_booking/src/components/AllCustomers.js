import { useLocation } from "react-router-dom";
import EmployeeButton from "./EmployeeButton";
import CustomerCard from "./CustomerCard";
import { useEffect } from "react";
import { useState } from "react";

const AllCustomers = () => {
    const location = useLocation();
    // const [category, setCategory] = useState();
    // const [stAd, setStAddress] = useState();
    // const [city, setCity] = useState();
    const [results, setResults] = useState([]);

    const port = 5100;

    const getAllCustomers = () => {
        fetch(`http://localhost:${port}/customers`, { method: 'GET' })
        .then(d => {
            return d.json();
        })
        .then((res) => {
            console.log(res);
            setResults(res);
        })
    };

    useEffect(() => {
        getAllCustomers();
    }, []);



    return (
        <div className="allCustomers">
            <h2>All Customers</h2>

                <EmployeeButton title = "Add New Customer"/>
                {
                    results.map((obj) => {
                        console.log('obj ', obj);
                        return (
                            <CustomerCard key = {obj.id} customerId = {obj.id} name = {obj.full_name} stAd = {obj.street_address} regDate = {obj.registration_date}
                            email = {obj.email} city = {obj.city} country={obj.country} 
                            postOrZip = {obj.postal_code_zip_code} ssn_sin = {obj.ssn_sin} passwrd = {obj.passwrd}
                            provOrState = {obj.province_or_state}/>
                        );
                    })
                }
        </div>
    );
};

export default AllCustomers;