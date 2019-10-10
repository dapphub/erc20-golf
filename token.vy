balanceOf: public(map(address,uint256))
totalSupply: public(uint256)
allowance: public(map(address,map(address, uint256)))

@public
def __init__(_totalSupply: uint256):
    self.totalSupply = _totalSupply
    self.balanceOf[msg.sender] = self.totalSupply

@public
def transfer(dst: address, value: uint256) -> bool:
    assert value <= self.balanceOf[msg.sender], "You do not have sufficient balance to transfer these many tokens."
    self.balanceOf[msg.sender] -= value
    self.balanceOf[dst] += value
    return True

@public
def transferFrom(src: address, dst: address, value: uint256) -> bool:
    assert value <= self.balanceOf[src], "The specified account does not have sufficient balance to transfer these many tokens."
    assert value <= self.allowance[src][msg.sender], "You don't have approval to transfer these many tokens."
    
    if (self.allowance[src][msg.sender] != 115792089237316195423570985008687907853269984665640564039457584007913129639935):
       self.allowance[src][msg.sender] -= value
    self.balanceOf[src] -= value
    self.balanceOf[dst] += value
    return True

@public
def approve(_spender: address, _amount: uint256) -> bool:
    self.allowance[msg.sender][_spender] = _amount
    return True
