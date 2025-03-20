pragma solidity ^0.8.0;

contract DonationPool {
    address private owner;
    
    mapping(address => uint256) public donations;
    uint256 public totalDonations;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }
    
    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than zero");
        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
    }
    
    function withdraw(uint256 amount) public onlyOwner {
        require(amount <= address(this).balance, "Insufficient balance");
        payable(owner).transfer(amount);
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
