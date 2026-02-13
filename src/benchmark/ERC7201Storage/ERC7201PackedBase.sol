// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title ERC7201PackedBase
/// @dev ERC-7201 namespaced storage pattern (OZ v5 style)
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
    bytes32 private constant AppStorageLocation = 0x3d5c47bbcbcf0f3cb4a71e1a2c2e9b52e5c8dc1f5e9d4e2a0c91b13e45f15a00;

    function getAppStorage() internal pure returns (AppStorage storage $) {
        bytes32 slot = AppStorageLocation;
        assembly {
            $.slot := slot
        }
    }
}
