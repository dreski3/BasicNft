// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant MRM =
        "ipfs://bafybeiap3azru6zweyehvt5cdaubez2b6mxbcnz7ohfs2zgexgralefdkm/?filename=fungi.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = BasicNft(deployer.run());
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Fungi";
        string memory actualName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(MRM);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(MRM)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
