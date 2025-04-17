// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";
import {DeployToken} from "../script/DeployToken.s.sol";

contract TokenTest is Test {
    Token public token;
    DeployToken public deployer;

    address ahmed = makeAddr("ahmed");
    address zoro = makeAddr("zoro");

    uint256 public constant STARTING_BALANCE = 1000 ether;

    function setUp() public {
        deployer = new DeployToken();
        token = deployer.run();

        vm.prank(msg.sender);
        token.transfer(ahmed, STARTING_BALANCE);
        // balanceof(msg.sender) = 10000 - STARTING_BALANCE 
    }

    function testahmedBalance() public view {
        assertEq(token.balanceOf(ahmed), STARTING_BALANCE);
    }

    function testAllowances() public {
        uint256 initialAllowance = 100;

        vm.prank(ahmed);
        token.approve(zoro, initialAllowance);

        uint256 transferAmount = 50;

        vm.prank(zoro);
        token.transferFrom(ahmed, zoro, transferAmount);

        assertEq(token.balanceOf(zoro), transferAmount);
        assertEq(token.balanceOf(ahmed), STARTING_BALANCE - transferAmount);
    }

    function testTotalSupply() public view {
        assertEq(token.totalSupply(), token.balanceOf(msg.sender) + token.balanceOf(ahmed));
    }

    function testTransferRevertsIfInsufficientBalance() public {
        vm.expectRevert();
        vm.prank(zoro);
        token.transfer(ahmed, 1 ether);
    }
}
