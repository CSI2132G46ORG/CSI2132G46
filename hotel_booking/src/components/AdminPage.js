import EmployeeButton from "./EmployeeButton";

const AdminPage = () => {
    return (
        <div className="adminPage">
            <h2>Administrator Page</h2>
                <EmployeeButton title = "All Hotel Chains " path ='/allhotelchains' />
                {/* <EmployeeButton title = "All Rooms" path = '/allrooms'/> */}
                <EmployeeButton title = "All Customers" path = "/allcustomers"/>
        </div>
    );
};

export default AdminPage;