// SPDX-License-Identifier: GPL-3.0
// getter setter =-> update and delete
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.16 <0.9.0;
import "@openzeppelin/contracts/utils/Strings.sol";

contract EMR {

    address public admin;
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

    constructor() {
        admin = msg.sender;
        recordIndex = 1;
        s1 = "";
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
}