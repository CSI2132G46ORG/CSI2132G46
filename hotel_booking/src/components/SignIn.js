import { useState } from 'react';
import { Link } from 'react-router-dom';
import './assets/styles/SignIn.css'
import useToken from './useToken';

const Signin = () => {
    const [username, setEmail] = useState();
    const [password, setPassword] = useState();
    const { token, setToken } = useToken();
    const port = 5000;

    async function loginUser (email, password) {

        const res = await fetch(`http://localhost:${port}/customers/${email}/${password}`, { method: 'GET' });
        const data = await res.json();
        console.log(data);
        if (data.length == 0) {
            console.log('user not found');
            return null;
        }
        else {
            const body = {email, password};
            return await fetch(`http://localhost:${port}/login`, {
                    method: 'POST',
                    headers: {"content-type": "application/JSON"},
                    body: JSON.stringify(body)
            })
            .then(res => res.json())
            .then(data => {
                console.log('data', data[0]);
                return data;
            });
                
        }


    }

    const handleSubmit  = async e => {
        e.preventDefault();
        loginUser(username, password)
        .then((res) => {
            console.log('res', res);
            
            if(res!=null) setToken(res);
         }
        );
    };
    

    if(!token){
        return (
            <div className="login">
                <form onSubmit={handleSubmit}>
                    <h1>Sign in</h1>
                    <input type="email" placeholder='Email address' onChange={e => setEmail(e.target.value)} required/>
                    <input type="password" placeholder='password' onChange={e => setPassword(e.target.value)} required/>
                    <input type="submit" value="sign in"/>
                </form>
                <p>Don't have an account? <Link to='/signup'> Create one </Link></p>
            </div>
        );
    }
    else {
        return(
            <div>
                <h1>You're connected</h1>
            </div>
        );
    }
    
};

export default Signin;