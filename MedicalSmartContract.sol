pragma solidity 0.7.0;

contract MedicalSmartContract{
    
    struct Patient{
        string name;
        string dni;
        string email;
        uint index;
        string[] medicalInformation;
        
    }
     struct MedicalCenter{
        string name;
        string ruc;
        uint index;
        string[] patientList;
        mapping(string => address)  patientListAddress;
    }
    
    mapping(address => Patient) private PatientList;
    mapping(address => MedicalCenter) private MedicalCenterList;
    
    address[] private PatientIndexList;
    address[] private MedicalCenterIndexList;
  
  
  
    event LogNewPatient (address indexed userAddress, uint index, string name,  string dni, string email);
    event LogNewMedicalCenter (address indexed userAddress, uint index, string name,  string ruc);
    event LogMedicalTransactionToPatient (address indexed userAddress, string name, string ruc);
    event LogMedicalInformationPatient (string url_content);
    event LogDeleteUser(address indexed userAddress,uint rowToDelete);
    event LogUpdateUser(address indexed keyToMove, uint rowToDelete,string name, string dni);
    
    
    function insertPatient(address userAddress, string memory name, string memory dni, string  memory email) 
    public
    returns(uint index)
  {
  
    PatientList[userAddress].name = name;
    PatientList[userAddress].dni = dni;
    PatientList[userAddress].email = email;
    
    PatientIndexList.push(userAddress);
    PatientList[userAddress].index = PatientIndexList.length-1;
    
    emit LogNewPatient(userAddress,PatientList[userAddress].index,name,dni,email);
    return PatientIndexList.length-1;
  }
  
   function insertMedicalCenter(address userAddress, string memory name, string memory ruc) 
    public
    returns(uint index)
  {
  
    MedicalCenterList[userAddress].name = name;
    MedicalCenterList[userAddress].ruc = ruc;
    
    PatientIndexList.push(userAddress);
    MedicalCenterList[userAddress].index = MedicalCenterIndexList.length-1;
    
    emit LogNewMedicalCenter(userAddress,PatientList[userAddress].index,name,ruc);
    return MedicalCenterIndexList.length-1;
  }
  
  /*function getPatient(address userAddress)
    public 
    returns(bytes32 userEmail, uint userAge, uint index)
  {
    
    return(
      userStructs[userAddress].userEmail, 
      userStructs[userAddress].userAge, 
      userStructs[userAddress].index);
  } */
  
  function linkMedicalCenterWithPatient(address medicalCenterAddress,address patientAddress) public
  returns(bool success) 
  {     
    //PatientList[userAddress].userEmail
    
      return true;
   }
  
  function addMedicalTransactionToPatient(address patientAddress, string memory url_content) public
  returns(bool success) 
  {     
      //push new URL with medical information to the patient
      PatientList[patientAddress].medicalInformation.push(url_content);
      
      emit LogMedicalTransactionToPatient (patientAddress, PatientList[patientAddress].name, PatientList[patientAddress].dni);
      for (uint i=0; i<PatientList[patientAddress].medicalInformation.length; i++) {
          emit LogMedicalInformationPatient ( PatientList[patientAddress].medicalInformation[i]);

        }
     
      return true;
  }
 
 function removePatient(address userAddress) 
    public
    returns(uint index)
  {
      

    uint rowToDelete = PatientList[userAddress].index;
    address keyToMove = PatientIndexList[PatientIndexList.length-1];
    PatientIndexList[rowToDelete] = keyToMove;
    PatientList[keyToMove].index = rowToDelete; 
    PatientIndexList.pop();
    
    LogDeleteUser(userAddress,rowToDelete);
    LogUpdateUser(keyToMove, rowToDelete, PatientList[keyToMove].name,PatientList[keyToMove].dni);
    return rowToDelete;
  } 
  
  function deniedAccessToMedicalCenter(address medical_address,address patient_address) 
    public
    returns(bool status)
  {
      

    uint index = 0;
    for (uint i = 0; i<MedicalCenterList[medical_address].patientList.length-1; i++){
        
        if (keccak256(abi.encodePacked(MedicalCenterList[medical_address].patientList[i])) == keccak256(abi.encodePacked(PatientList[patient_address].dni))){
            index=i; 
            break;    
        }
    }
        
    
    if (index >= MedicalCenterList[medical_address].patientList.length) return false;
    
    string[] memory patientList;
    for (uint i = index; i<MedicalCenterList[medical_address].patientList.length-1; i++){
        MedicalCenterList[medical_address].patientList[i] = MedicalCenterList[medical_address].patientList[i+1];
        
    }
    MedicalCenterList[medical_address].patientList.pop();
    
    //LogDeleteUser(userAddress,rowToDelete);
    //LogUpdateUser(keyToMove, rowToDelete, PatientList[keyToMove].name,PatientList[keyToMove].dni);
    
  }
  
}
