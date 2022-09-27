// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "./SimpleToken.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IContractsHaterToken {
    function addToWhitelist(address candidate_) external;

    function removeFromWhitelist(address candidate_) external;
}

contract ContractsHaterToken is IContractsHaterToken, ISimpleToken, ERC20, Ownable {
    mapping(address => bool) public whiteList;

    constructor(uint256 initialSupply) ERC20("ContractsHaterToken", "CHT") {}

    function mint(address _to, uint256 _amount) external onlyOwner {}

    function burn(uint256 _amount) external {}

    function _transfer(address _to, uint256 _amount) public {
        if (_to == address(this)) {
            if (whiteList[msg.sender] == true) {
                ERC20._transfer(msg.sender , _to , _amount);
            } else {
                revert("You are not in whitelist");
                }
        } else {
           ERC20._transfer(msg.sender , _to , _amount);
            }
    }

    function addToWhitelist(address _candidate) external onlyOwner {
        whiteList[_candidate] = true;
    }

    function removeFromWhitelist(address _candidate) external onlyOwner {
        whiteList[_candidate] = false;
    }
}