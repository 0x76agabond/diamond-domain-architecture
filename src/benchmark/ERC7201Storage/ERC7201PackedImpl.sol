// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ERC7201PackedBase.sol";

contract ERC7201PackedImplSample is ERC7201PackedBase {
    /* =========================================================
                            READ
       ========================================================= */

    function readPackedValue() external view returns (bool, bool, bool) {
        AppStorage storage $ = getAppStorage();
        return ($.c, $.d, $.e);
    }

    function readUnpackedValue() external view returns (bool, bool, bool) {
        AppStorage storage $ = getAppStorage();
        return ($.c, $.j, $.k);
    }

    function readAllValue(uint8 bKey, uint8 iKey)
        external
        view
        returns (uint256 a, uint256 b, bool c, bool d, bool e, uint256 i, bool j, bool k, bool l)
    {
        AppStorage storage $ = getAppStorage();

        a = $.a;
        b = $.mappingB[bKey];
        i = $.mappingI[iKey];

        c = $.c;
        d = $.d;
        e = $.e;
        j = $.j;
        k = $.k;
        l = $.l;
    }

    /* =========================================================
                            WRITE
       ========================================================= */

    function writePackedBools(bool c, bool d, bool e) external {
        AppStorage storage $ = getAppStorage();
        $.c = c;
        $.d = d;
        $.e = e;
    }

    function writeUnpackedBools(bool c, bool j, bool k) external {
        AppStorage storage $ = getAppStorage();
        $.c = c;
        $.j = j;
        $.k = k;
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
        AppStorage storage $ = getAppStorage();

        $.a = a;
        $.mappingB[bKey] = bValue;
        $.mappingI[iKey] = iValue;

        $.c = c;
        $.d = d;
        $.e = e;
        $.j = j;
        $.k = k;
        $.l = l;
    }

    /* =========================================================
                        READ & WRITE
       ========================================================= */

    function readAndWritePackedValue(bool c, bool d, bool e)
        external
        returns (bool, bool, bool)
    {
        AppStorage storage $ = getAppStorage();

        if ($.c != c) 
            $.c = c;

        if ($.d != d) 
            $.d = d;

        if ($.e != e) 
            $.e = e;

        return ($.c, $.d, $.e);
    }

    function readAndWriteUnpackedValue(bool c, bool j, bool k)
        external
        returns (bool, bool, bool)
    {
        AppStorage storage $ = getAppStorage();

        if ($.c != c) 
            $.c = c;

        if ($.j != j) 
            $.j = j;

        if ($.k != k) 
            $.k = k;

        return ($.c, $.j, $.k);
    }
}
