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
 * Domain Architecture pattern.
 * Domain for full slot variables
 * Sub-domain for variables can be packed in the same slot.
 * Bools are used for packing demonstration.
 * In practice developers can use other types.
 * Base on business, developer can also split by other criteria.
 */

/**
 * @dev
 * An Isolated Domain is a domain that have no facet accessing its storage directly.
 * All access must go through specific helper functions.
 */

/**
 * @dev
 * This implementation use Solidity's free funtion instead of library
 * free function in this case, behave similar to internal function in library.
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

/**
 * @dev
 * Helper to get multiple domain / sub-domain storage structs
 *
 * @return domainStorage
 * @return subDomainStorage
 */

function getAllDomainStorage()
    pure
    returns (DomainStorage storage domainStorage, SubDomainStorage storage subDomainStorage)
{
    bytes32 posDomain = DOMAIN_STORAGE_POSITION;
    bytes32 posSub = SUB_DOMAIN_STORAGE_POSITION;
    assembly {
        domainStorage.slot := posDomain
        subDomainStorage.slot := posSub
    }
}

// Getter
function getCDE() view returns (bool c, bool d, bool e) {
    SubDomainStorage storage s = getSubDomainStorage();
    c = s.c;
    d = s.d;
    e = s.e;
}

function getC() view returns (bool) {
    return getSubDomainStorage().c;
}

function getD() view returns (bool) {
    return getSubDomainStorage().d;
}

function getE() view returns (bool) {
    return getSubDomainStorage().e;
}

function getJ() view returns (bool) {
    return getSubDomainStorage().j;
}

function getK() view returns (bool) {
    return getSubDomainStorage().k;
}

function getCJK() view returns (bool c, bool j, bool k) {
    SubDomainStorage storage s = getSubDomainStorage();
    c = s.c;
    j = s.j;
    k = s.k;
}

function getAllValue(uint8 bKey, uint8 iKey)
    view
    returns (uint256 a, uint256 b, bool c, bool d, bool e, uint256 i, bool j, bool k, bool l)
{
    (DomainStorage storage dmn, SubDomainStorage storage sub) = getAllDomainStorage();

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

// Setter
function setCDE(bool c, bool d, bool e) {
    SubDomainStorage storage s = getSubDomainStorage();
    s.c = c;
    s.d = d;
    s.e = e;
}

function setC(bool c) {
    SubDomainStorage storage s = getSubDomainStorage();
    s.c = c;
}

function setD(bool d) {
    SubDomainStorage storage s = getSubDomainStorage();
    s.d = d;
}

function setE(bool e) {
    SubDomainStorage storage s = getSubDomainStorage();
    s.e = e;
}

function setCJK(bool c, bool j, bool k) {
    SubDomainStorage storage s = getSubDomainStorage();
    s.c = c;
    s.j = j;
    s.k = k;
}

function setJ(bool j) {
    SubDomainStorage storage s = getSubDomainStorage();
    s.j = j;
}

function setK(bool k) {
    SubDomainStorage storage s = getSubDomainStorage();
    s.k = k;
}

function setAllValue(
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
) {
    (DomainStorage storage dmn, SubDomainStorage storage sub) = getAllDomainStorage();
    dmn.a = a;
    dmn.mappingB[bKey] = bValue;
    dmn.mappingI[iKey] = iValue;
    sub.c = c;
    sub.d = d;
    sub.e = e;
    sub.j = j;
    sub.k = k;
    sub.l = l;
}
