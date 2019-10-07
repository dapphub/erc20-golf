# ERC20 Gas golf contest

To submit your bytecode, simply make a PR to this repo with the _runtime bytecode_[1] of your contract in the file `src/bin_runtime`. See other PRs for examples.

After your PR has been submitted, you can track its progress at https://dapp.ci/erc20-golf/

Your bytecode must match the specifications defined [here](src/spec.md). In particular, notice the following:

- The `transferFrom` function must ONLY decrease the allowance of the sender if the allowance is not set to `uint(-1)` (also known as `2^256 -1`, or `115792089237316195423570985008687907853269984665640564039457584007913129639935`). In the case `allowance == uint(-1)`, you must leave the allowance as is. This optimization saves 5000-20000 gas on most `transferFrom` invocations.

- The storage variables defining `balances`, `supply` and `allowance` must be at slots 0, 1, and 2, respectively and either follow the [solidity](https://solidity.readthedocs.io/en/v0.5.12/miscellaneous.html#layout-of-state-variables-in-storage) or [vyper](https://github.com/ethereum/vyper/issues/769#issuecomment-380957681) storage convention. If you use vyper, you must edit the `src/storage.md` file accordingly.

- For the purposes of this contest, we will not take LOGs into account. You can simply omit logging from your token.



[1] The runtime bytecode of a contract is its code _after deployement_. 
Here is how you can extract the runtime bytecode from various source languages:

## Solidity:

Using the [solidity compiler](https://solidity.readthedocs.io/en/v0.5.11/installing-solidity.html), run
```sh
solc token.sol --bin-runtime > src/bin_runtime
```

## Yul:

In yul one writes init code and runtime code as different `object` blocks. If you want to focus on the runtime code, simply omit writing a constructor `object`.

Then compile with the [solidity compiler](https://solidity.readthedocs.io/en/v0.5.11/installing-solidity.html), using:
```sh
solc --strict-assembly token.yul
```

and paste the contents of the `binary representation:` in the `src/bin_runtime` file of this repository.

## Huff:


## Vyper:

Vyper has a different storage convention than Solidity, and our specs assert that the storage layout of the token must follow a Solidity style layout. 

If you are writing a Vyper contract, you must also edit `src/storage.md` and replace all instances of `"Solidity"` with `"Vyper"`.

Using the [vyper compiler](https://vyper.readthedocs.io/en/latest/installing-vyper.html), run
```sh
vyper -f bytecode_runtime token.vy > src/bin_runtime
```
