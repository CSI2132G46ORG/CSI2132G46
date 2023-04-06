import EmployeeButton from "./EmployeeButton";

const AdminPage = () => {
    return (
        <div className="adminPage">
            <div className="col-1-of-2">
                <EmployeeButton title = "All Hotel Chains " path ='/allhotelchains' />
                {/* <EmployeeButton title = "All Rooms" path = '/allrooms'/> */}
                <EmployeeButton title = "All Customers"/>
            </div>
            <div className="col-2-of-2">
                
            </div>
        </div>
    );
};

export default AdminPage;