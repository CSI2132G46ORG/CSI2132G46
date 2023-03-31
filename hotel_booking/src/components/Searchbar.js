import { useEffect, useState } from "react";
import { ReactSearchAutocomplete } from "react-search-autocomplete";
import { useNavigate} from "react-router-dom";
// import './assets/styles/Searchbar.css';

const formatResult = (item) => {
    return (
      <>
        {/* <span style={{ display: 'block', textAlign: 'left' }}>id: {item.id}</span> */}
        <span style={{ display: 'block', textAlign: 'left' }}>{item.name}</span>
      </>
    )
};

const SearchBar = (props) => {

    const [items, setItems] = useState([]);


    const getItems = async () => {
        try {
            const response = await fetch("http://localhost:5100/city");
            const jsonData = await response.json();
            const tempArr = [];
            for (let i = 0; i < jsonData.length; i++){
                const val = jsonData[i]["city"].concat(",  ", jsonData[i]["country"]);
                const obj = {id: parseInt(jsonData[i]["id"]), name: val};
                tempArr.push(obj);
            }

            setItems(tempArr);
            console.log(items);

        } catch (error) {
            console.error(error);
        }
    };
    

    useEffect(() => {
        getItems();
    }, []);
    console.log(items);

    const navigate = useNavigate();

    const onSelect = (e) => {
        console.log('selected area ', e.name);

        if(window.location.pathname==="/reservio"){
            setTimeout(() => {
                navigate("/checkinout", {state: {
                    chosenLocation: e
                }});
            }, 500);
        }
        else {
            props.setArea(e.name);
        }
    };

    return (
        <div className="searchBar">
            <ReactSearchAutocomplete
            items={items}
            onSelect={onSelect}
            autoFocus
            inputSearchString={props.area}
            formatResult={formatResult}
            placeholder='Going to'
            />
        </div>
    );
};

export default SearchBar;