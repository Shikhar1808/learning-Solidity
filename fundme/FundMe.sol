//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//Get funds from user
//Withdraw funds
//Set a minimum funding value in USD

// interface AggregatorV3Interface {
//   function decimals() external view returns (uint8);

//   function description() external view returns (string memory);

//   function version() external view returns (uint256);

//   function getRoundData(
//     uint80 _roundId
//   ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

//   function latestRoundData()
//     external
//     view
//     returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
// }

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceCovertor} from './priceConvertor.sol';


error NotOwner();

contract FundMe{    

    using PriceCovertor for uint256;
    // uint256 public myValue = 1;
    uint256 public constant minimumUsd = 5e18;
    address[] public funders;
    mapping(address => uint256 amoundFunded) public addressToAmountFunded;

    address public immutable owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        //Allow users to send money
        //Have a minimum $ sent $5
        //1. How do we send ETH to this contract?
        // myValue = myValue + 2;
        // require(getConversionRate(msg.value) >= minimumUsd, "didnt send enough ETH");
        require(msg.value.getConversionRate() >= minimumUsd, "didnt send enough ETH" );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        //What is a revert?
        //Undo any actions that have been done, and send the remaining gas back
    }

    function withdraw() public onlyOwner {
        //In this function we will withdraw the money.
        //Basically unmapping all the things back to zero. For this we sill use for loop.

        // require(msg.sender == owner, "Must be owner");     

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder =  funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        //reset the array and also withdraw the funds
        funders = new address[](0); //resetting the funders array to a brand new funders array

        //1.Transfer
        //msg.sender == address and payable(msg.sender) == payable address
        // payable(msg.sender).transfer(address(this).balance);

        //2. send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");

        //3.call (lower level commands/fucntions and can be used to call virtually and function in all of etherium without even having to have the ABI)
         (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("") //this call function returns two variables
        require(callSuccess, "Call Failed");

    }

    modifier onlyOwner(){ //we dont give it visiblity like normal functions
        // require(msg.sender == owner, "Sender is not owner");
        if(msg.sender != owner){
            revert NotOwner();
        }
        _;
    }


    // function getPrice() public view returns (uint256) {
    //     //address = 0x694AA1769357215DE4FAC081bf1f309aDC325306
    //     //ABI

    //      AggregatorV3Interface priceFeed =  AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    //      (, int256 price,,,) = priceFeed.latestRoundData();
    //      //Price of ETH in terms of USD

    //      return uint256(price*1e10);
    // }

    // function getConversionRate(uint256 ethAmount) public view returns (uint256) {
    //     uint256 ethPrice = getPrice();
    //     uint256 ethAmountInUsd = (ethPrice * ethAmount)/ 1e18;
    //     return ethAmountInUsd;
    // }

    // function getVersion() public view returns (uint256){
    //     return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    // }



    //What happens if someone sends this contarct ETH without calling the fund function

    receive() external payable {
        fund();
    }
    fallback() external payable {
        fund();
    }
    //Now if somebody actually sends some money without calling the fund function and these will route them to fund() function

}