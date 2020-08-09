pragma solidity ^0.6.7;

import "ds-test/test.sol";

import "./GebPollingEmitter.sol";

contract GebPollingEmitterTest is DSTest {
    GebPollingEmitter emitter;

    function setUp() public {
        emitter = new GebPollingEmitter();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
