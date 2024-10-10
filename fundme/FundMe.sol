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

contract FundMe{    

    using PriceCovertor for uint256;
    // uint256 public myValue = 1;
    uint256 public minimumUsd = 5e18;
    address[] public funders;
    mapping(address => uint256 amoundFunded) public addressToAmountFunded;

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
    // function withdraw() public {}


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
}