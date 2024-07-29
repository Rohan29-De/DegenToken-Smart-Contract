// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    mapping(string => uint256) public itemPrices;

    constructor(address initialOwner) ERC20("DegenToken", "DGN") Ownable(initialOwner) {
        // Initialize some items with their prices
        itemPrices["Sword"] = 100;
        itemPrices["Shield"] = 50;
        itemPrices["Potion"] = 25;
    }

    // Minting new tokens (only owner)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Redeeming tokens for items
    function redeem(string memory itemName) public {
        require(itemPrices[itemName] > 0, "Item does not exist");
        require(balanceOf(msg.sender) >= itemPrices[itemName], "Insufficient balance");

        _burn(msg.sender, itemPrices[itemName]);
        // Here you would typically trigger some event or external process
        // to deliver the in-game item to the player
        emit ItemRedeemed(msg.sender, itemName, itemPrices[itemName]);
    }

    // Burning tokens
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Add new items (only owner)
    function addItem(string memory itemName, uint256 price) public onlyOwner {
        itemPrices[itemName] = price;
    }

    // Event emitted when an item is redeemed
    event ItemRedeemed(address indexed player, string itemName, uint256 price);
}
