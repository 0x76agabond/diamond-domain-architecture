pragma solidity >=0.8.30;
// SPDX-License-Identifier: MIT

/*
 * ===========================================================================
 * Author: Hoang (0x76agabond)
 * ===========================================================================
 * ERC-8110 Reference Implementation - Domain / Sub-domain Split
 * ===========================================================================
 */

/**
 * Benchmark contract for ERC-8110.
 * Split storage into main domain + sub-domain.
 */

/* =========================================================
                    MAIN DOMAIN STORAGE
   ========================================================= */

/// @custom:storage-location erc8042:app.domain.v1
bytes32 constant DOMAIN_STORAGE_POSITION = keccak256("app.domain.v1");

struct DomainStorage {
    uint256 a; // slot 0
    mapping(uint8 => uint256) mappingB; // slot 1 (hash-based)
    mapping(uint8 => uint256) mappingI; // slot 2 (hash-based)
}

function getDomainStorage() pure returns (DomainStorage storage s) {
    bytes32 pos = DOMAIN_STORAGE_POSITION;
    assembly {
        s.slot := pos
    }
}
/* =========================================================
                    SUB-DOMAIN STORAGE
   ========================================================= */
/// @custom:storage-location erc8042:app.domain.v1.flags
bytes32 constant SUB_DOMAIN_STORAGE_POSITION = keccak256("app.domain.v1.flags");

struct SubDomainStorage {
    bool c;
    bool d;
    bool e;
    bool j;
    bool k;
    bool l;
}

function getSubDomainStorage() pure returns (SubDomainStorage storage s) {
    bytes32 pos = SUB_DOMAIN_STORAGE_POSITION;
    assembly {
        s.slot := pos
    }
}

contract DomainFacetSample {
    /* =========================================================
                            READ
       ========================================================= */

    /// read only packed bools (same slot in sub-domain)
    function readPackedValue() external view returns (bool, bool, bool) {
        SubDomainStorage storage s = getSubDomainStorage();
        return (s.c, s.d, s.e);
    }

    /// read bools from different logical groups (still packed)
    function readUnpackedValue() external view returns (bool, bool, bool) {
        SubDomainStorage storage s = getSubDomainStorage();
        return (s.c, s.j, s.k);
    }

    /// read everything (domain + sub-domain)
    function readAllValue(uint8 bKey, uint8 iKey)
        external
        view
        returns (uint256 a, uint256 b, bool c, bool d, bool e, uint256 i, bool j, bool k, bool l)
    {
        DomainStorage storage dmn = getDomainStorage();
        SubDomainStorage storage sub = getSubDomainStorage();

        a = dmn.a;
        b = dmn.mappingB[bKey];
        i = dmn.mappingI[iKey];

        c = sub.c;
        d = sub.d;
        e = sub.e;
        j = sub.j;
        k = sub.k;
        l = sub.l;
    }

    /* =========================================================
                            WRITE
       ========================================================= */

    /// write packed bools (single slot SSTORE in sub-domain)
    function writePackedBools(bool c, bool d, bool e) external {
        SubDomainStorage storage s = getSubDomainStorage();
        s.c = c;
        s.d = d;
        s.e = e;
    }

    /// write logical-unpacked bools (still same slot, different fields)
    function writeUnpackedBools(bool c, bool j, bool k) external {
        SubDomainStorage storage s = getSubDomainStorage();
        s.c = c;
        s.j = j;
        s.k = k;
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
        DomainStorage storage dmn = getDomainStorage();
        SubDomainStorage storage sub = getSubDomainStorage();

        // main domain
        dmn.a = a;
        dmn.mappingB[bKey] = bValue;
        dmn.mappingI[iKey] = iValue;

        // sub-domain (packed)
        sub.c = c;
        sub.d = d;
        sub.e = e;
        sub.j = j;
        sub.k = k;
        sub.l = l;
    }

    /* =========================================================
                       READ & WRITE
      ========================================================= */

    function readAndWritePackedValue(bool c, bool d, bool e) external returns (bool, bool, bool) {
        SubDomainStorage storage s = getSubDomainStorage();

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
        SubDomainStorage storage s = getSubDomainStorage();

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
