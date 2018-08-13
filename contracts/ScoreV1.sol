pragma solidity ^0.4.21;

import "./ScoreInterface.sol";
import "./ScoreStore.sol";

contract ScoreV1 is ScoreInterface, Ownable {
    ScoreStore internal store;

    constructor(address _storeAddress) public {
        setStoreContract(_storeAddress);
    }
    function setStoreContract(address _storeAddress) public {
        require(_storeAddress != address(0));
        store = ScoreStore(_storeAddress);
    }

    function hit() public {
        store.put(msg.sender, store.get(msg.sender) + 10);
    }

    function score() public view returns (uint) {
        return store.get(msg.sender);
    }

    function recliamStoreOwnership() public onlyOwner {
        store.transferOwnership(owner);
    }
}