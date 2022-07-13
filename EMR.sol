// SPDX-License-Identifier: GPL-3.0
/*
    From Solidity v0.8.0 Breaking Changes https://docs.soliditylang.org/en/v0.8.0/080-breaking-changes.html
    ABI coder v2 is activated by default.
    So it is not experimental, but standard feature since solc v0.8.0
    Code Generator: 
        New ABI decoder which supports structs and arbitrarily nested arrays and checks input size
*/
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.16 <0.9.0;

contract EMR {

    enum RecordType { medicine, ENT, dental, orthopaedics, psychiatry }

    address public admin;
    uint256 public recordIndex; //no OF RECORDS
    string public version = "0.0.1";
    
    // A map of records where key is record address and value is record struct
    mapping(uint256 => Record) private records;
    
    struct Record {
        bool isActive;
        recordType recordType;

        address hospitalAddress;
        address doctorAddress; 
        address patientAddress; 
        
        bytes32 hashedRecord; // sha256 of full records from the provider
        
        //array of related records addresses
        uint256[] medicalreport;

        //address to whom the access is given to
        // convert this to structs having a mapping of requester => Visibility levels
        address[] openAcess;

        string remark;  // temp to this version of the sc only, => futute => replace with ipfs  
        //string pointer; // A remote address to access patient's full records in provider's database
    }
    
    constructor() public {
        owner = msg.sender;
        recordIndex = 0;
    }

    //only patient can get their records
    // in future open this to be accessed by everyone depending upon visibilty set by the patient 
    function MedicalReportGet(uint256 _index) public view returns(uint256[]){
        require(msg.sender == records[_index].patientAddress , "Only patient can see");
        return records[_index].medicalreport;
    }   

//work needed........................................................................
    function MedicalReportAdd(uint256 _index,
        string _remark) public {

        //require(msg.sender == records[_index].patientAddress , "Only patient can add");       not possible right now

        recordIndex++;
        records[recordIndex] = Record(
            true, MedicalReportIndex);

        patients[msg.sender].medicalreport.push(MedicalReportIndex);

    }


}