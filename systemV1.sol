// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.16 <0.9.0;
import "@openzeppelin/contracts/utils/Strings.sol";
contract manager{

    address admin;
    uint256 public recordIndex; //no OF RECORDS
    mapping(uint256 => Record)  public  records;
    string public s1;
    Record[] r ;

    struct Record
    {
        uint256 index;
        string remark; 
        // Record[] medicalreport;
        uint256[] medicalreport;
    }
    
    // key -> code and value provider {struct}
    mapping(string => Provider) private providers;

    // A map of patients where key is (hashed) full name and value is patient struct
    mapping(string => Patient) private patients;

    constructor()  {
        admin = msg.sender;
        recordIndex = 1;
        s1 = "";
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

    function MedicalReportGet(uint256 _index) public view returns(uint256){
        return records[_index].index;
    }   

    function MedicalReportGet2(uint256 _index) public view returns(uint256 , string memory){
        return (records[_index].index, records[_index].remark );
    }   

    function MedicalReportGetString(uint256 i) public view returns(string memory){
        return string(abi.encodePacked(s1, 
                                string(abi.encodePacked( Strings.toString(records[i].index) 
                                ,  records[i].remark
                            ))
                        ));
    }   

    function  MedicalReportAdd( uint256 _index, string memory _remark ) public payable {
        records[recordIndex++] = Record(  _index , _remark , new uint256[](0) );
    }
    

    function  printAll() public  {
        // string  temp ;
        for( uint i = 0 ;  i < recordIndex ; i++){
            // temp = string(abi.encodePacked( Strings.toString(records[i].index) 
            //                 ,  records[i].remark
            //                 ));
            s1 = string(abi.encodePacked(s1, 
                                string(abi.encodePacked( Strings.toString(records[i].index) 
                                ,  records[i].remark
                            ))
                        ));
        }
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
        MedicalReportAdd(1 , "1st");
        // MedicalReportAdd( uint256 _index, string memory _remark )
        //emr.MedicalReportGetString(1);
        return true;
    }

}
