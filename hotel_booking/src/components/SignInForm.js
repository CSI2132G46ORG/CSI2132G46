import { useState } from "react";
import { useNavigate } from "react-router-dom";
import './assets/styles/SignInForm.css'
import useToken from "./useToken";

const SignInForm = (props) => {

    const [username, setEmail] = useState();
    const [password, setPassword] = useState();
    const [type, setType] = useState(props.type);
    const { token, setToken } = useToken();
    const navigate = useNavigate();
    const port = 5000;

    async function loginUser (email, password) {

        const res = await fetch(`http://localhost:${port}/${type}/${email}/${password}`, { method: 'GET' });
        const data = await res.json();
        console.log(data);
        if (data.length == 0) {
            console.log('user not found');
            return null;
        }
        else {
            const body = data[0];
            return await fetch(`http://localhost:${port}/login`, {
                    method: 'POST',
                    headers: {"content-type": "application/JSON"},
                    body: JSON.stringify(body)
            })
            .then(res => res.json())
            .then(data => {
                console.log('data', data[0]);
                return data;
            })
            ;
                
        }

    }

    const handleSubmit  = async e => {
        e.preventDefault();
        loginUser(username, password)
        .then((res) => {
            console.log('res', res.token);
            
            if(res!=null) setToken(res);
            if (type==="customers"){
                navigate('/reservio', { replace: true });
            }
            else {
                /*This should redirect to the employee's page */

            }
         }
        );
    };

    return (
    <form onSubmit={handleSubmit}>
                    <h1>Sign in</h1>
                    <input type="email" placeholder='Email address' onChange={e => setEmail(e.target.value)} required/>
                    <input type="password" placeholder='password' onChange={e => setPassword(e.target.value)} required/>
                    <input type="submit" value="sign in"/>
    </form>
    );
};
export default SignInForm;