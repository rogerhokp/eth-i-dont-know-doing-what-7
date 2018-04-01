pragma solidity ^0.4.17;

import "./Ownable.sol";


contract SingleMessage is Ownable {
    string public message;
    uint256 public priceInWei;
    uint256 public maxLength;

    event MessageSet(string message, uint256 priceInWei, uint256 newPriceInWei, address payer);

    function SingleMessage(string initialMessage, uint256 initialPriceInWei, uint256 maxLengthArg) public {
        message = initialMessage;
        priceInWei = initialPriceInWei;
        maxLength = maxLengthArg;
    }

    function set(string newMessage) external payable {
        require(msg.value >= priceInWei);
        require(bytes(newMessage).length <= maxLength);

        uint256 newPrice = priceInWei * 2;
        MessageSet(newMessage, priceInWei, newPrice, msg.sender);
        priceInWei = newPrice;
        message = newMessage;
    }

    function withdraw(address destination, uint256 amountInWei) external onlyOwner {
        require(this.balance >= amountInWei);
        require(destination != address(0));

        destination.transfer(amountInWei);
    }

}