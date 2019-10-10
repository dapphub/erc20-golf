<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Balance](#balance)
- [Total Supply](#total-supply)
- [Allowance](#allowance)
- [Transfer](#transfer)
- [TransferFrom](#transferfrom)
- [Approve](#approve)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Balance
```act
behaviour balanceOf of Token
interface balanceOf(address Who)

for all

    Balance : uint256

storage

    #Token.balances[Who] |-> Balance

iff

    VCallValue == 0

returns Balance
```
### Total Supply

```act
behaviour totalSupply of Token
interface totalSupply()

for all

    Supply : uint256

storage

    #Token.supply |-> Supply

iff

    VCallValue == 0

returns Supply
```

### Allowance

```act
behaviour allowance of Token
interface allowance(address src, address usr)

for all

  Allowance : uint256

storage

  allowance[src][usr] |-> Allowance

iff

  VCallValue == 0

returns Allowance
```

### Transfer
```act
behaviour transfer-diff of Token
interface transfer(address To, uint Value)

for all

    FromBal : uint256
    ToBal   : uint256

storage

    #Token.balances[CALLER_ID] |-> FromBal => FromBal - Value
    #Token.balances[To]        |-> ToBal => ToBal + Value

iff in range uint256

    FromBal - Value
    ToBal + Value

iff

    VCallValue == 0

if
    CALLER_ID =/= To

returns 1
```

```act
behaviour transfer-same of Token
interface transfer(address To, uint Value)

for all

    FromBal : uint256

storage

    #Token.balances[CALLER_ID] |-> FromBal => FromBal

iff in range uint256

    FromBal - Value

iff

    VCallValue == 0

if

    CALLER_ID == To

returns 1
```
### TransferFrom

```act
behaviour transferFrom-diff of Token
interface transferFrom(address Src, address Dst, uint Value)

for all

    SrcBal : uint256
    DstBal : uint256
    Allowance : uint256

storage

    #Token.balances[Src] |-> SrcBal => SrcBal - Value
    #Token.balances[Dst] |-> DstBal => DstBal + Value
    #Token.allowance[Src][CALLER_ID] |-> Allowance => #if Allowance == maxUInt256 #then Allowance #else Allowance - Value #fi

iff in range uint256

    SrcBal - Value
    DstBal + Value
    Allowance - Value

iff

    VCallValue == 0

if

    Src =/= Dst

returns 1
```

```act
behaviour transferFrom-same of Token
interface transferFrom(address Src, address Dst, uint Value)

for all

    SrcBal : uint256
    Allowance : uint256

storage

    #Token.balances[Src] |-> SrcBal => SrcBal
    #Token.allowance[Src][CALLER_ID] |-> Allowance => #if Allowance == maxUInt256 #then Allowance #else Allowance - Value #fi

iff in range uint256

    SrcBal - Value
    Allowance - Value

iff

    VCallValue == 0

if

    Src == Dst

returns 1
```

### Approve

```act
behaviour approve of Token
interface approve(address Spender, uint Value)

for all

    Allowance : uint256

storage

    #Token.allowance[CALLER_ID][Spender] |-> Allowance => Value

iff

    VCallValue == 0

returns 1
```
