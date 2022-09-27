// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "./SimpleToken.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IMrGreedyToken {
    function treasury() external view returns (address);

    function getResultingTransferAmount(uint256 amount_) external view returns (uint256);
}

contract MrGreedyToken is IMrGreedyToken, ISimpleToken, ERC20, Ownable {
    address public treasury;
    uint8 public fee = 10;

    constructor(uint256 initialSupply, address _treasury) ERC20("MrGreedyToken", "MRG") {
        treasury = _treasury;
    }

    function mint(address _to, uint256 _amount) external onlyOwner {}

    function burn(uint256 _amount) external {}

    function _transfer(address _to, uint256 _amount) public {
        require (_amount > 0, "Not enough funds");
        if (_amount <= fee) {
            ERC20._transfer(msg.sender , treasury , _amount);
        } else {
            ERC20._transfer(msg.sender , treasury , fee);
            ERC20._transfer(msg.sender , _to , _amount - fee);
        }
    }

    function getResultingTransferAmount(uint256 _amount) external view returns (uint256) {
        return _amount - fee;
    }
}