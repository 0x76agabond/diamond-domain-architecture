pragma solidity >=0.8.30;

// SPDX-License-Identifier: MIT

/*
 * ===========================================================================
 * Author: Hoang (0x76agabond)
 * ===========================================================================
 * ERC-8110 Reference Implementation - Broken Layout
 * ===========================================================================
 */

/**
 * @dev
 * Benchmark contract for ERC-8110.
 * AppStorage pattern.
 * The storage layout is intentionally broken to simulate realworld upgrade scenario.
 */

library AppStorageSample {
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
}
