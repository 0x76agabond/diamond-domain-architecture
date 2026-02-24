// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20;

import "forge-std/Test.sol";
import "forge-std/console2.sol";

contract StorageSlotCalcTest is Test {
    function test_calcPackedSlot() public {
        bytes32 result = keccak256(abi.encode(uint256(keccak256("app.storage.packed")) - 1)) & ~bytes32(uint256(0xff));
        console2.logBytes32(result);
    }
}
