// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address BOB = makeAddr("bob");
    address ALICE = makeAddr("alice");
    address CHARLIE = makeAddr("charlie");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(BOB, STARTING_BALANCE);
    }

    function testBobHasStartingBalance() public view {
        assertEq(ourToken.balanceOf(BOB), STARTING_BALANCE);
    }

    function testAllowanceWorks() public {
        uint256 initialAllowance = 1000;

        vm.prank(BOB);
        ourToken.approve(ALICE, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(ALICE);
        ourToken.transferFrom(BOB, ALICE, transferAmount);

        assertEq(ourToken.balanceOf(BOB), STARTING_BALANCE - transferAmount);
        assertEq(ourToken.balanceOf(ALICE), transferAmount);
        assertEq(ourToken.allowance(BOB, ALICE), initialAllowance - transferAmount);
    }

    function testTransfer() public {
        uint256 transferAmount = 10 ether;

        vm.prank(BOB);
        ourToken.transfer(ALICE, transferAmount);

        assertEq(ourToken.balanceOf(BOB), STARTING_BALANCE - transferAmount);
        assertEq(ourToken.balanceOf(ALICE), transferAmount);
    }

    function testTransferInsufficientBalanceReverts() public {
        uint256 transferAmount = STARTING_BALANCE + 1;

        vm.prank(BOB);
        vm.expectRevert();
        ourToken.transfer(ALICE, transferAmount);
    }

    function testApproveAndTransferFromInsufficientAllowanceReverts() public {
        uint256 initialAllowance = 100;

        vm.prank(BOB);
        ourToken.approve(ALICE, initialAllowance);

        vm.prank(ALICE);
        vm.expectRevert();
        ourToken.transferFrom(BOB, CHARLIE, initialAllowance + 1);
    }

    function testApproveAndTransferFromInsufficientBalanceReverts() public {
        uint256 initialAllowance = STARTING_BALANCE + 1;

        vm.prank(BOB);
        ourToken.approve(ALICE, initialAllowance);

        vm.prank(ALICE);
        vm.expectRevert();
        ourToken.transferFrom(BOB, CHARLIE, initialAllowance);
    }

    function testZeroAddressTransferReverts() public {
        vm.prank(BOB);
        vm.expectRevert();
        ourToken.transfer(address(0), 1);
    }

    function testZeroAddressApproveReverts() public {
        vm.prank(BOB);
        vm.expectRevert();
        ourToken.approve(address(0), 1);
    }
}
