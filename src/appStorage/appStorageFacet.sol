pragma solidity >=0.8.30;

// SPDX-License-Identifier: MIT

/*
 * ===========================================================================
 * Author: Hoang (0x76agabond)
 * ===========================================================================
 * ERC-8110 Reference Implementation - Diamond as Gnosis Safe Guard
 * ===========================================================================
 */

/**
 * @dev
 * Benchmark contract for ERC-8110.
 * AppStorage pattern.
 */

import "./libStorage.sol";
contract AppStorageFacetSample {

    /* =========================================================
                            READ
       ========================================================= */

    /// read only packed bools (same slot)
    function readPackedValue() external view returns (bool, bool, bool) {
        AppStorageSample.AppStorage storage s = AppStorageSample.getStorage();
        return (s.c, s.d, s.e);
    }

    /// read bools from different packed groups
    function readUnpackedValue() external view returns (bool, bool, bool) {
        AppStorageSample.AppStorage storage s = AppStorageSample.getStorage();
        return (s.c, s.j, s.k);
    }

    ///  read everything (force multiple SLOADs)
    function readAllValue(uint8 bKey, uint8 iKey)
        external
        view
        returns (uint256 a, uint256 b, bool c, bool d, bool e, uint256 i, bool j, bool k, bool l)
    {
        AppStorageSample.AppStorage storage s = AppStorageSample.getStorage();

        a = s.a; // slot 0
        b = s.mappingB[bKey]; // slot 1 (mapping)
        c = s.c; // slot 2
        d = s.d;
        e = s.e;
        i = s.mappingI[iKey]; // slot 3 (mapping)
        j = s.j; // slot 4
        k = s.k;
        l = s.l;
    }

    /* =========================================================
                            WRITE
       ========================================================= */

    /// write packed bools (single slot SSTORE)
    function writePackedBools(bool c, bool d, bool e) external {
        AppStorageSample.AppStorage storage s = AppStorageSample.getStorage();
        s.c = c;
        s.d = d;
        s.e = e;
    }

    /// write unpacked bools (different slots)
    function writeUnpackedBools(bool c, bool j, bool k) external {
        AppStorageSample.AppStorage storage s = AppStorageSample.getStorage();
        s.c = c; // slot 2
        s.j = j; // slot 4
        s.k = k;
    }

    function writeAllValue(
        uint256 a,
        uint8 bKey,
        uint256 bValue,
        bool c,
        bool d,
        bool e,
        uint8 iKey,
        uint256 iValue,
        bool j,
        bool k,
        bool l
    ) external {
        AppStorageSample.AppStorage storage s = AppStorageSample.getStorage();

        // slot 0
        s.a = a;

        // mapping (hash-based slot)
        s.mappingB[bKey] = bValue;

        // slot 2 (packed bools)
        s.c = c;
        s.d = d;
        s.e = e;

        // another mapping (hash-based slot)
        s.mappingI[iKey] = iValue;

        // slot 4 (packed bools)
        s.j = j;
        s.k = k;
        s.l = l;
    }

    /* =========================================================
                        READ & WRITE
       ========================================================= */

    function readAndWritePackedValue(bool c, bool d, bool e) external returns (bool, bool, bool) {
        AppStorageSample.AppStorage storage s = AppStorageSample.getStorage();

        if (s.c != c) {
            s.c = c;
        }

        if (s.d != d) {
            s.d = d;
        }

        if (s.e != e) {
            s.e = e;
        }

        return (s.c, s.d, s.e);
    }

    function readAndWriteUnpackedValue(bool c, bool j, bool k) external returns (bool, bool, bool) {
        AppStorageSample.AppStorage storage s = AppStorageSample.getStorage();

        if (s.c != c) {
            s.c = c;
        }

        if (s.j != j) {
            s.j = j;
        }

        if (s.k != k) {
            s.k = k;
        }

        return (s.c, s.j, s.k);
    }
}
