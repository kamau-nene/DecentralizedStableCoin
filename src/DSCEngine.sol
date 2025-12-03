// Layout of Contract:
// version
// imports
// interfaces, libraries, contracts
// errors
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions

SPDX:License-Identifier: MIT
pragma solidity ^0.8.7;


/**
 * @title DSCEngine
 * @author KamauNene
 * @notice 
 * This contract is the core of the Decentralized Stable Coin system. It handles all the logic for minting and redeeming DSC, as well as
 * managing collateral assets.
 * 
 */

import {DecentralizedStableCoin} from "./DecentralizedStableCoin.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {nonReetrant} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract DSCEngine is ReentrancyGuard{

    error DSCEngine__MustBeMoreThanZero();
    error DSCEngine__TokenAddressAndPriceFeedAddressMustBeSameLength();
    error DSCEngine__TokenNotAllowed(address token);
    error DSCEngine__TransferFailed();


    mapping (address token => address priceFeeeds ) private s_priceFeeds;
    DecentralizedStableCoin private immutable i_dsc;
    mapping(address user => mapping(address token => uint256 amount)) private s_collateralDeposited;


    event CollateralDeposited(address indexed user, address indexed token, uint256 indexed amount);


    constructor(address [] memory  tokenAddresses, address [] memory priceFeedAddresses, address dscAddress){
        if(tokenAddresses.length != priceFeedAddresses.length){
            revert DSCEngine__TokenAddressAndPriceFeedAddressMustBeSameLength();
        }

        for(uint256 i=0; i <tokenAddresses.length; i++ ){
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddresses[i];
        }
        i_dsc = DecentralizedStableCoin(dscAddress);
 }


    modifier moreThanZero ( uint256 amount) {
        if( amount == 0){
            revert DSCEngine__mustBeMoreThanZero();
        } 
        _;
        
    }

    modifier IsAllowedToken(address token){
        if(s_priceFeeds[token]== address (0)){
            revert DSCEngine__TokenNotAllowed(token);
        }
        -;
    }
 

    function depositCollateral(address tokenDepositCollateral, uint256 amount ) external DSCEngine__ moreThanZero(amount) nonReetrant IsAllowedToken(tokenDepositCollateral) {
         s_collateralDeposited[msg.sender][tokenCollateralAddress] += amountCollateral;
        emit CollateralDeposited(msg.sender, tokenCollateralAddress, amountCollateral);
        bool success = IERC20(tokenCollateralAddress).transferFrom(msg.sender, address(this), amountCollateral);
        if (!success) {
            revert DSCEngine__TransferFailed();
    }


    function mintDsc(uint256 amountDscToMint) public mooreThanZero(amountDscToMint)  {

    }
}
}