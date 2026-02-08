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
