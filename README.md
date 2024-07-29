# DegenToken-Smart-Contract
## Overview
The DegenToken contract is an ERC20 token with additional features for a gaming ecosystem. It allows the minting and burning of tokens, redeeming tokens for in-game items, and managing item prices.
## Features
1. **Minting Tokens:** Only the owner can mint new tokens.
2. **Burning Tokens:** Any user can burn their tokens.
3. **Redeeming Tokens for Items:** Users can redeem tokens for predefined in-game items.
4. **Managing Items:** The owner can add new items or update the prices of existing items.
5. **Checking token balance:** Players should be able to check their token balance at any time.
# Contract Details
## Inheritance
* 'ERC20': Implements the standard ERC20 token functionality.
* 'Ownable': Provides basic access control, where some functions can only be accessed by the contract owner.
## State Variables
* 'mapping(string => uint256) public itemPrices': Stores the prices of items in tokens.
## Constructor
```
constructor(address initialOwner) ERC20("DegenToken", "DGN") Ownable(initialOwner) {
    // Initialize some items with their prices
    itemPrices["Sword"] = 100;
    itemPrices["Shield"] = 50;
    itemPrices["Potion"] = 25;
}
```
* Initializes the token with the name "DegenToken" and symbol "DGN".
* Sets the initial owner.
* Predefines some items with their prices.
## Functions
1. Minting Tokens
```
function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
}
```
* Mints amount tokens to the address to.
* Can only be called by the owner.
2. Redeeming Tokens for Items
```
function redeem(string memory itemName) public {
    require(itemPrices[itemName] > 0, "Item does not exist");
    require(balanceOf(msg.sender) >= itemPrices[itemName], "Insufficient balance");

    _burn(msg.sender, itemPrices[itemName]);
    emit ItemRedeemed(msg.sender, itemName, itemPrices[itemName]);
}
```
* Redeems tokens for the specified itemName.
* Requires the item to exist and the sender to have enough balance.
* Burns the tokens equivalent to the item's price and emits an ItemRedeemed event.
3. Burning Tokens
```
function burn(uint256 amount) public {
    _burn(msg.sender, amount);
}
```
* Burns amount tokens from the sender's balance.
4. Adding New Items
```
function addItem(string memory itemName, uint256 price) public onlyOwner {
    itemPrices[itemName] = price;
}
```
* Adds a new item or updates the price of an existing item.
* Can only be called by the owner.
## Events
```
event ItemRedeemed(address indexed player, string itemName, uint256 price);
```
* Emitted when an item is redeemed.
* Logs the player's address, the name of the item, and the price
## Usage
1. Minting Tokens
   * Only the owner can call the mint function to mint new tokens.
2. Redeeming Tokens for Items
   * Users can call the redeem function to redeem tokens for items, provided they have enough balance.
3. Burning Tokens
   * Users can call the burn function to burn their tokens.
4. Managing Items
   * The owner can call the addItem function to add new items or update existing items.
## License
This project is licensed under the MIT License. See the LICENSE file for details.








  
