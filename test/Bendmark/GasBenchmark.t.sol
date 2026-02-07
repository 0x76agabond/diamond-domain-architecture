// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {AppStorageFacetSample} from "../../src/benchmark/appStorage.sol";
import {DomainFacetSample} from "../../src/benchmark/Domain.sol";
import {IsolatedDomainFacetSample} from "../../src/benchmark/isolatedDomain.sol";

contract GasBenchmark is Test {
    AppStorageFacetSample public appStorageSample;
    DomainFacetSample public domainSample;
    IsolatedDomainFacetSample public isolatedDomainSample;
    address owner = address(0xABCD);

    function setUp() public {
        appStorageSample = new AppStorageFacetSample();
        domainSample = new DomainFacetSample();
        isolatedDomainSample = new IsolatedDomainFacetSample();
    }

    function test_App_ReadPackedValue() public view {
        (bool c, bool d, bool e) = appStorageSample.readPackedValue();
    }

    function test_App_readUnpackedValue() public view {
        (bool c, bool j, bool k) = appStorageSample.readUnpackedValue();
    }

    function test_App_readAllValue() public view {
        (uint256 a, uint256 b, bool c, bool d, bool e, uint256 i, bool j, bool k, bool l) =
            appStorageSample.readAllValue(0, 0);
    }

    function test_App_writePackedBools() public {
        appStorageSample.writePackedBools(true, false, true);
    }

    function test_App_writeUnpackedBools() public {
        appStorageSample.writeUnpackedBools(true, false, true);
    }

    function test_App_writeAllValue() public {
        appStorageSample.writeAllValue(
            123, // a
            1, // bKey
            999, // bValue
            true, // c
            false, // d
            true, // e
            2, // iKey
            888, // iValue
            true, // j
            false, // k
            true // l
        );
    }

    function test_App_readAndWriteUnpackedBools() public {
        appStorageSample.readAndWriteUnpackedValue(false, false, false);
    }

    function test_App_readAndWritePackedBools() public {
        appStorageSample.readAndWritePackedValue(false, false, false);
    }

    function test_Domain_ReadPackedValue() public view {
        (bool c, bool d, bool e) = domainSample.readPackedValue();
    }

    /**
     * @dev in domain, those variables are well packed in the same storage slot
     * keep the name for easier comparison with AppStorage.
     */
    function test_Domain_readUnpackedValue() public view {
        (bool c, bool j, bool k) = domainSample.readUnpackedValue();
    }

    function test_Domain_readAllValue() public view {
        (uint256 a, uint256 b, bool c, bool d, bool e, uint256 i, bool j, bool k, bool l) =
            domainSample.readAllValue(0, 0);
    }

    function test_Domain_writePackedBools() public {
        domainSample.writePackedBools(true, false, true);
    }

    /**
     * @dev in domain, those variables are well packed in the same storage slot
     * keep the name for easier comparison with AppStorage.
     */
    function test_Domain_writeUnpackedBools() public {
        domainSample.writeUnpackedBools(true, false, true);
    }

    function test_Domain_writeAllValue() public {
        domainSample.writeAllValue(
            123, // a
            1, // bKey
            999, // bValue
            true, // c
            false, // d
            true, // e
            2, // iKey
            888, // iValue
            true, // j
            false, // k
            true // l
        );
    }

    function test_Domain_readAndWriteUnpackedBools() public {
        domainSample.readAndWriteUnpackedValue(false, false, false);
    }

    function test_Domain_readAndWritePackedBools() public {
        domainSample.readAndWritePackedValue(false, false, false);
    }

    function test_IsolatedDomain_ReadPackedValue() public view {
        (bool c, bool d, bool e) = isolatedDomainSample.readPackedValue();
    }

    /**
     * @dev in domain, those variables are well packed in the same storage slot
     * keep the name for easier comparison with AppStorage.
     */
    function test_IsolatedDomain_readUnpackedValue() public view {
        (bool c, bool j, bool k) = isolatedDomainSample.readUnpackedValue();
    }

    function test_IsolatedDomain_readAllValue() public view {
        (uint256 a, uint256 b, bool c, bool d, bool e, uint256 i, bool j, bool k, bool l) =
            isolatedDomainSample.readAllValue(0, 0);
    }

    function test_IsolatedDomain_writePackedBools() public {
        isolatedDomainSample.writePackedBools(true, false, true);
    }

    /**
     * @dev in domain, those variables are well packed in the same storage slot
     * keep the name for easier comparison with AppStorage.
     */
    function test_IsolatedDomain_writeUnpackedBools() public {
        isolatedDomainSample.writeUnpackedBools(true, false, true);
    }

    function test_IsolatedDomain_writeAllValue() public {
        isolatedDomainSample.writeAllValue(
            123, // a
            1, // bKey
            999, // bValue
            true, // c
            false, // d
            true, // e
            2, // iKey
            888, // iValue
            true, // j
            false, // k
            true // l
        );
    }

    function test_IsolatedDomain_readAndWriteUnpackedBools() public {
        isolatedDomainSample.readAndWriteUnpackedValue(false, false, false);
    }

    function test_IsolatedDomain_readAndWritePackedBools() public {
        isolatedDomainSample.readAndWritePackedValue(false, false, false);
    }
}

