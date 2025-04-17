// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Script} from "forge-std/script.sol";
import {Token} from "../src/Token.sol";

contract DeployToken is Script {
    uint256 public constant INITIAL_SUPPLY = 10000 ether;

    function run() external returns (Token) {
        vm.startBroadcast();
        Token token = new Token(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return token;
    }
}
