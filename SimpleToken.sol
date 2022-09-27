// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface ISimpleToken {
    function mint(address to_, uint256 amount_) external;

    function burn(uint256 amount_) external;
}

contract SimpleToken is ISimpleToken, ERC20, Ownable {

    constructor(uint256 initialSupply) ERC20("SimpleToken", "ST") {}

    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    function burn(uint256 _amount) external {
        _burn(address(0), _amount);
    }
}