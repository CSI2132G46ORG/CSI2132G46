import { useState } from "react";

const Checkbox = (props) => {
    const [name, setName] = useState(props.name);
    const [value, setValue] = useState(props.value);

    
    return (
        <div>
            <input className={props.objClass} type="checkbox" id={name} name={name} value={`'${value}'`} onChange={props.onChange}/>
            <label htmlFor={name}>{value}</label><br/>
        </div>
    );
};

export default Checkbox;