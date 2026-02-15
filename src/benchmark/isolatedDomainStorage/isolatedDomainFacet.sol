pragma solidity >=0.8.30;
// SPDX-License-Identifier: MIT

/*
 * ===========================================================================
 * Author: Hoang (0x76agabond)
 * ===========================================================================
 * ERC-8110 Reference Implementation - Isolated Domain
 * ===========================================================================
 */

/**
 * Benchmark contract for ERC-8110.
 * Split storage into main domain + sub-domain and communicate with storage via helper functions.
 * In this version, all bools are well packed.
 * Some function are keep the name as unpacked for comparison with AppStorage pattern.
 */

import "./isolatedDomainStorage.sol";

contract IsolatedDomainFacetSample {
    /* =========================================================
                            READ
       ========================================================= */

    /// read only packed bools (same slot in sub-domain)
    function readPackedValue() external view returns (bool, bool, bool) {
        return getCDE();
    }

    /// read bools from different logical groups (still packed)
    function readUnpackedValue() external view returns (bool, bool, bool) {
        return getCJK();
    }

    /// read everything (domain + sub-domain)
    function readAllValue(uint8 bKey, uint8 iKey)
        external
        view
        returns (uint256 a, uint256 b, bool c, bool d, bool e, uint256 i, bool j, bool k, bool l)
    {
        return getAllValue(bKey, iKey);
    }

    /* =========================================================
                            WRITE
       ========================================================= */

    /// write packed bools (single slot SSTORE in sub-domain)
    function writePackedBools(bool c, bool d, bool e) external {
        setCDE(c, d, e);
    }

    /// write logical-unpacked bools (still same slot, different fields)
    function writeUnpackedBools(bool c, bool j, bool k) external {
        setCJK(c, j, k);
    }

    /// write everything (domain + sub-domain)
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
        setAllValue(a, bKey, bValue, c, d, e, iKey, iValue, j, k, l);
    }

    /* =========================================================
                        READ & WRITE
       ========================================================= */

    /// read => write => read
    function readAndWritePackedValue(bool c, bool d, bool e) external returns (bool, bool, bool) {
        (bool _c, bool _d, bool _e) = getCDE();

        if (_c != c) {
            setC(c);
        }

        if (_d != d) {
            setD(d);
        }

        if (_e != e) {
            setE(e);
        }

        return getCDE();
    }

    /// read => write => read
    function readAndWriteUnpackedValue(bool c, bool j, bool k) external returns (bool, bool, bool) {
        (bool _c, bool _j, bool _k) = getCJK();

        if (_c != c) {
            setC(c);
        }

        if (_j != j) {
            setJ(j);
        }

        if (_k != k) {
            setK(k);
        }

        return getCJK();
    }
}
