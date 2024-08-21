// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Twitter {

    uint16 constant MAX_TWEET_LENGHT = 20;
    
    struct Tweet{
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }


    mapping(address => Tweet[]) internal tweets;

    function createTweet(string memory _tweet) public{
        require(bytes(_tweet).length <= MAX_TWEET_LENGHT, "Tweet is too long!!");

        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);
    }

    function getTweet(uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweet() public view returns (Tweet[] memory){
        return tweets[msg.sender];
    }
}