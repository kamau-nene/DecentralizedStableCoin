SPDX-Lisence-Identifier:MIT
pragma solidity ^0.8.7;

/**
 * @title DecentralizedStableCoin
 * @author KamauNene
 * @notice 
 * This contract is the implementation of a Decentralized Stable Coin (DSC) that is pegged to the US Dollar.
 * 
 */

import {ERC20Burnable, ERC20 } from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
contract DecentralizedStableCoin is ERC20Burnable, Ownable{

    error DecentralizedStableCoin__NeedsMoreThanZero();
    error DecentralizedStableCoin__BurnAmountExceedsBalance();
    error DecentralizedStableCoin__MintToZeroAddress();

    constructor() ERC20("Decentralized Stable Coin","DSC"){}

    function burn (uint256 _amount) public override onlyOwner{
        uint256 balance = balanceOf(msg.sender)
        if(_amount <=0 ){
            revert DecentralizedStableCoin__NeedsMoreThanZero
        }
        if(balance < _amount){ 
            revert DecentralizedStableCoin__BurnAmountExceedsBalance;
        }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner{
        if(_to == address(0)){
            revert DecentralizedStableCoin__MintToZeroAddress();
        }
        if(_ amount <=0) {
            revert DecentralizedStableCoin__NeedsMoreThanZero();
        }
        _mint(_to, _amount);
        return true;
    }
}