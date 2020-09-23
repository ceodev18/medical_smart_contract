pragma solidity  >=0.4.22 <0.7.0;

contract MedicalSmartContract{
    
    struct Patient{
        string name;
        string dni;
        string email;
        address address_user;
        uint index;
    }
     struct MedicalCenter{
        string name;
        string ruc;
        string email;
        address address_user;
    }
    
    mapping(address => Patient) private PatientList;
    mapping(address => MedicalCenter) private MedicalCenterList;
    
    address[] private PatientIndexList;
    address[] private MedicalCenterIndexList;
  
  
  
    event LogNewPatient   (address indexed userAddress, uint index, string name,  string dni, string email);
  
  
    function inserPatient(address userAddress, string name, string dni, string email) 
    public
    returns(uint index)
  {
  
    PatientList[userAddress].name = name;
    PatientList[userAddress].dni = dni;
    PatientList[userAddress].email = email;
    PatientList[userAddress].index = PatientIndexList.push(userAddress)-1;
    emit LogNewPatient(userAddress,PatientList[userAddress].index,name,dni,email);
    return PatientIndexList.length-1;
  }
}
