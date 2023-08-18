pragma solidity ^0.8.13;
pragma abicoder v2;

import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {FlashLoanSimpleReceiverBase} from "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@openzeppelin/contracts/token/ERC721/IERC20.sol";

contract Flashloan is FlashLoanSimpleReceiverBase {
    constructor(
        address _addressProvider,
        address _routerSudoSwap,
        address _routerSeaport,
        address _addrWeth
    )
        FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider))
        Arbitrage(_routerSudoSwap, _routerSeaport, _addrWeth)
    {}

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        uint256 amountOwed = amount + premium;
        IERC20(asset)(address(POOL), amountOwed);

        return true;
    }

    function requestFlashLoan(bytes calldata _params) external {
        address receiverAddress = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;

        POOL.flashLoanSimple(
            receiverAddress,
            asset,
            amount,
            params,
            referralCode
        );
    }
}
