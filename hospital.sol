// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.16 <0.9.0;
import './EMRv1.sol';
contract manager{

    address admin;
    
    // key -> code and value provider {struct}
    mapping(string => Provider) private providers;

    // A map of patients where key is (hashed) full name and value is patient struct
    mapping(string => Patient) private patients;

    EMR emr; 

    function PatientsProviders() public {
        admin = msg.sender;
        //emr = EMR();
    }


    struct Provider {
        bool isActive;
        address providerAddress;

    }

    struct Patient {
        bool isActive;
        string fullName; // Patient full name
        // An array of providers which hold records of this patient
        string[] providers; 
        // A map to flag if a providers has record of this patient of not. 
        // Key is provider code and value is the flag
        //mapping(string => bool) isHistoricalProvider; 
 
    }
    function  registerNewProvider(string memory providerCode, address   providerAddress) 
    public {
        require(msg.sender == admin);
        providers[providerCode] = Provider({ isActive: true, providerAddress: providerAddress });
    }

    function  registerNewPatient(string memory fullName) public {
        assert(!patients[fullName].isActive);
        //patients[fullName] = Patient({ isActive: true, fullName: fullName, historicalProviders: new string[](0) });
        patients[fullName] = Patient( true , fullName , new string[](0) );
    }  
    /*
        Check if given full name has been registered as a patient
    */
    function  isRegisteredPatient(string memory fullName) public view 
    returns(bool isRegistered) {
        return patients[fullName].isActive;
    }

    /*
        Check if given provider code has been registered as a provider
    */
    function  isRegisteredProvider(string memory providerCode) public view
    returns(bool isRegistered) {
        return providers[providerCode].isActive;
    }

    /*
        Associate given patient's record with given provider 
        if the patient is new to the provider
    */
    function  addPatientRecord() public returns(bool success) 
    {
        // assert(isRegisteredPatient(fullName));
        // assert(isRegisteredProvider(providerCode));
        emr.MedicalReportAdd(1 , "1st");
        //emr.MedicalReportGetString(1);
        return true;
    }

    function  addTest() public  payable
    {
        // assert(isRegisteredPatient(fullName));
        // assert(isRegisteredProvider(providerCode));
        
        emr.MedicalReportAdd(1 , "1st");
        //emr.MedicalReportGetString(1);
    }
}