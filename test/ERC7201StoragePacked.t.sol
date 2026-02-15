// SPDX-License-Identifier: MIT
pragma solidity >=0.8.30;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {ERC7201PackedImplSample} from "../../src/benchmark/ERC7201Storage/ERC7201PackedImpl.sol";

contract ERC7201StoragePacked is Test {
    ERC7201PackedImplSample public app;

    function setUp() public {
        app = new ERC7201PackedImplSample();
    }

    function test_ReadPackedValue() public view {
        (bool c, bool d, bool e) = app.readPackedValue();
    }

    function test_ReadUnpackedValue() public view {
        (bool c, bool j, bool k) = app.readUnpackedValue();
    }

    function test_ReadAllValue() public view {
        (uint256 a, uint256 b, bool c, bool d, bool e, uint256 i, bool j, bool k, bool l) = app.readAllValue(0, 0);
    }

    function test_WritePackedValue() public {
        app.writePackedBools(true, false, true);
    }

    function test_WriteUnpackedValue() public {
        app.writeUnpackedBools(true, false, true);
    }

    function test_WriteAllValue() public {
        app.writeAllValue(
            123,    // a
            1,      // bKey
            999,    // bValue
            true,   // c
            false,  // d
            true,   // e
            2,      // iKey
            888,    // iValue
            true,   // j
            false,  // k
            true    // l
        );
    }

    function test_readAndWriteUnpacked() public {
        app.readAndWriteUnpackedValue(false, false, false);
    }

    function test_readAndWritePackedValue() public {
        app.readAndWritePackedValue(false, false, false);
    }
}
