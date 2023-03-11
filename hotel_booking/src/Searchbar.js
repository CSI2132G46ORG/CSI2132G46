import { ReactSearchAutocomplete } from "react-search-autocomplete";


const items = [
    {
      id: 0,
      name: 'Cobol'
    },
    {
      id: 1,
      name: 'JavaScript'
    },
    {
      id: 2,
      name: 'Basic'
    },
    {
      id: 3,
      name: 'PHP'
    },
    {
      id: 4,
      name: 'Java'
    }
  ];

const formatResult = (item) => {
    return (
      <>
        <span style={{ display: 'block', textAlign: 'left' }}>id: {item.id}</span>
        <span style={{ display: 'block', textAlign: 'left' }}>name: {item.name}</span>
      </>
    )
};

const SearchBar = () => {
    return (
        <div className="searchBar">
            <ReactSearchAutocomplete
            items={items}
            onSearch = {[]}
            onHover = {[]}
            autoFocus
            formatResult={formatResult}
            />
        </div>
    );
};

export default SearchBar;