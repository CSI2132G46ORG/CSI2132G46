import { Link } from "react-router-dom";
import SignInForm from "./SignInForm";

const EmployeeLogin = () => {
    return (
        <div className="employeeLogin">
            <SignInForm type={'employees'}/>
            <p>Don't have an account? <Link to='/employeeSignUp'> Create one </Link></p>
        </div>
    );
};

export default EmployeeLogin;