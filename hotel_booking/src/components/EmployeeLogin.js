import { Link } from "react-router-dom";
import SignInForm from "./SignInForm";

const EmployeeLogin = () => {
    return (
        <div className="employeeLogin">
            <SignInForm type={'employees'}/>
        </div>
    );
};

export default EmployeeLogin;