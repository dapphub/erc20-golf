```act
behaviour balanceOf of Token
interface balanceOf(address who)

types

    Balance : uint256

storage

    #Token.balances[who] |-> Balance

iff

    VCallValue == 0

returns Balance
```

```act
behaviour totalSupply of Token
interface totalSupply()

types

    Supply : uint256

storage

    #Token.supply |-> Supply

iff

    VCallValue == 0

returns Supply
```

```act
behaviour transfer-diff of Token
interface transfer(address To, uint Value)

types

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

types

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

```act
behaviour transferFrom-diff of Token
interface transferFrom(address Src, address Dst, uint Value)

types

    SrcBal : uint256
    DstBal : uint256
    Allowance : uint256

storage

    #Token.balances[Src] |-> SrcBal => SrcBal - Value
    #Token.balances[Dst] |-> DstBal => DstBal + Value
    #Token.allowance[Src][CALLER_ID] |-> Allowance => Allowance - Value

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

types

    SrcBal : uint256
    Allowance : uint256

storage

    #Token.balances[Src] |-> SrcBal => SrcBal
    #Token.allowance[Src][CALLER_ID] |-> Allowance => Allowance - Value

iff in range uint256

    SrcBal - Value
    Allowance - Value

iff

    VCallValue == 0

if

    Src == Dst

returns 1
```


```act
behaviour approve of Token
interface approve(address Spender, uint Value)

types

    Allowance : uint256

storage

    #Token.allowance[CALLER_ID][Spender] |-> Allowance => Value

iff

    VCallValue == 0

returns 1
```
