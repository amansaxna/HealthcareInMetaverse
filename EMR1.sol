// SPDX-License-Identifier: GPL-3.0
/*
    From Solidity v0.8.0 Breaking Changes https://docs.soliditylang.org/en/v0.8.0/080-breaking-changes.html
    ABI coder v2 is activated by default.
    So it is not experimental, but standard feature since solc v0.8.0
    Code Generator: 
        New ABI decoder which supports structs and arbitrarily nested arrays and checks input size
*/
// https://youtu.be/YJ-D1RMI0T0?t=3613 map of a map
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.16 <0.9.0;

contract EMR {

    enum RecordType { medicine, ENT, dental, orthopaedics, psychiatry }
    uint[] public uintArray = [1,2,3];
    address public admin;
    uint256 public recordIndex; //no OF RECORDS
    string public version = "0.0.1";
    
    // A map of records where key is record address(which is the "recordIndex" here) and value is record struct
    mapping(uint256 => Record)  private  records;
    
    struct Record
     {
        bool isActive;
        // add patient 
        recordType recordtype;

        address hospitalAddress;
        address doctorAddress; 
        address patientAddress; 
        
        bytes32 hashedRecord; // sha256 of full records from the provider
        
        //array of related records addresses
        //uint256[] medicalreport;
        Record[] medicalreport; 

        //address to whom the access is given to
        // convert this to structs having a mapping of requester => Visibility levels
        address[] openAcess;    // add healthcare

        string remark;  // temp to this version of the sc only, => futute => replace with ipfs  
        //string pointer; // A remote address to access patient's full records in provider's database

        // If an address is mapped to `true`, the report is active
            // the academic papers of the Researcher 
            // associated with the address
        //mapping(address => bool) can_review;
        //mapping(address => Doctors) instructors; https://jeancvllr.medium.com/solidity-tutorial-all-about-structs-b3e7ca398b1e#:~:text=by%20returning%20a%20tuple%20that%20contains%20the%20instructor%E2%80%99s%20age%2C%20first%20name%20and%20last%20name.
        
    }
    
    constructor() public {
        admin = msg.sender;
        recordIndex = 0;
    }

    //only patient can get their records
    // in future open this to be accessed by everyone depending upon visibilty set by the patient 
    function MedicalReportGet(uint256 _index) 
         public view returns(uint256){

        require(msg.sender == records[_index].patientAddress , "Only patient can see");
        return records[_index].medicalreport;
    }   

//work needed........................................................................
    function  MedicalReportAdd( //uint256 _index, 
                                //address hospitalAddress,
                                //address doctorAddress, 
                                //address patientAddress,
                                //bytes32 hashedRecord,
                                //Record[] medicalreport,
                                //address[] openAcess,
                                //string _remark ) 
        public {

        //require(msg.sender == records[_index].patientAddress , "Only patient can add");       not possible right now

        recordIndex++;
        records[recordIndex] = Record(  true, _remark );
        //patients[msg.sender].medicalreport.push(recordIndex);
    }
}