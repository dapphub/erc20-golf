// Copyright (C) 2019  Martin Lundfall

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// Minimal erc20 implementation

pragma solidity >0.5.0;
contract Token {
  mapping(address => uint) public balanceOf;
  uint public totalSupply;
  mapping (address => mapping (address => uint256)) public allowance;

  function add(uint256 x, uint256 y) internal pure returns (uint z) {
    z = x + y;
    require(z >= x);
  }
  function sub(uint256 x, uint256 y) internal pure returns (uint z) {
    z = x - y;
  }
  constructor(uint supply) public {
    totalSupply = supply;
    balanceOf[msg.sender] = supply;
  }
  function transfer(address receiver, uint256 value) public returns (bool) {
    require (balanceOf[msg.sender]>= value);
    balanceOf[msg.sender] = balanceOf[msg.sender] - value;
    balanceOf[receiver]   = add(balanceOf[receiver], value);
    return true;
  }
  function approve(address guy, uint wad) public returns (bool) {
    allowance[msg.sender][guy] = wad;    
    return true;
  }
  function transferFrom(address src, address dst, uint wad) public returns (bool) {
    if (!(allowance[src][msg.sender] == uint(-1))) {
      allowance[src][msg.sender] = sub(allowance[src][msg.sender], wad);
    }
    balanceOf[src] = sub(balanceOf[src], wad);
    balanceOf[dst] = add(balanceOf[dst], wad);
    return true;
  }
}
