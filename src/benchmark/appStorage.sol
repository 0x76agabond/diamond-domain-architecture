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
 * Benchmark contract for ERC-8110.
 * AppStorage pattern.
 */
contract AppStorageFacetSample {
    /* =========================================================
                            STORAGE
       ========================================================= */

    bytes32 constant APP_STORAGE_POSITION = keccak256("app.storage");

    struct AppStorage {
        uint256 a;
        mapping(uint8 => uint256) mappingB;
        bool c;
        bool d;
        bool e;

        // slot 3 (break)
        // this is to simulate the case layout break on upgrade scenario
        mapping(uint8 => uint256) mappingI;
        bool j;
        bool k;
        bool l;
    }

    function getStorage() internal pure returns (AppStorage storage s) {
        bytes32 pos = APP_STORAGE_POSITION;
        assembly {
            s.slot := pos
        }
    }

    /* =========================================================
                            READ
       ========================================================= */

    /// read only packed bools (same slot)
    function readPackedValue() external view returns (bool, bool, bool) {
        AppStorage storage s = getStorage();
        return (s.c, s.d, s.e);
    }

    /// read bools from different packed groups
    function readUnpackedValue() external view returns (bool, bool, bool) {
        AppStorage storage s = getStorage();
        return (s.c, s.j, s.k);
    }

    ///  read everything (force multiple SLOADs)
    function readAllValue(uint8 bKey, uint8 iKey)
        external
        view
        returns (uint256 a, uint256 b, bool c, bool d, bool e, uint256 i, bool j, bool k, bool l)
    {
        AppStorage storage s = getStorage();

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
        AppStorage storage s = getStorage();
        s.c = c;
        s.d = d;
        s.e = e;
    }

    /// write unpacked bools (different slots)
    function writeUnpackedBools(bool c, bool j, bool k) external {
        AppStorage storage s = getStorage();
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
        AppStorage storage s = getStorage();

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
        AppStorage storage s = getStorage();

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
        AppStorage storage s = getStorage();

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
