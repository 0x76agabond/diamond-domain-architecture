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
 * The storage is well packed for comparison with domain pattern.
 */

library AppStorageSample {
    /* =========================================================
                            STORAGE
       ========================================================= */

    bytes32 constant APP_STORAGE_POSITION = keccak256("app.storage.packed");

    struct AppStorage {
        uint256 a;
        mapping(uint8 => uint256) mappingB;
        mapping(uint8 => uint256) mappingI;
        bool c;
        bool d;
        bool e;
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
}
