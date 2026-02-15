// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
 * ===========================================================================
 * Author: Hoang (0x76agabond)
 * ===========================================================================
 * ERC-8110 Reference Implementation - Inheritance with ERC-7201 storage
 * ===========================================================================
 */

/**
 * @dev
 * Benchmark contract for ERC-8110.
 * ERC-7201 storage pattern.
 * The storage is well packed for comparison with domain pattern.
 */

abstract contract ERC7201PackedBase {
    /// @custom:storage-location erc7201:app.storage.packed
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

    /**
     * ERC-7201 slot derivation formula:
     *
     * keccak256(
     *     abi.encode(
     *         uint256(keccak256("app.storage.packed")) - 1
     *     )
     * ) & ~bytes32(uint256(0xff))
     *
     * Precomputed for efficiency.
     */
    bytes32 private constant AppStorageLocation = 0x665164b7f9fa75f791eb7e03ba72252e4be425b42d5f1a5ec5a49eca0a75d800;

    function getAppStorage() internal pure returns (AppStorage storage $) {
        bytes32 slot = AppStorageLocation;
        assembly {
            $.slot := slot
        }
    }
}
