# Smart Contract Hacking


Most smart contract vulnerabilities arise due to:
- Logic flaws
- Poor Exception handling

## Tooling

As with all cryptocurrency related anything - beware.

https://remix.ethereum.org/ - offers a safe and controlled environment to test and deploy contracts as if they were on a public blockchain.

- Each contract must be compiled -> `Solidarity Compiler`
- To Deploy -> `Deploy & run transactions`
	- Deploy the contract `Contract -> <Select a contract> -> Deploy <Button>`

You can create interaction between different type of contract and test how they function.

## Re-entrancy Attack

Occurs when a malicious contract uses a fallback function to continue to deplete a contract's total balance due to flawed logic after an initial withdraw function occurs.

Contract A | Contract B
--- | ---
Withdraw Function: | Attack Function:
Require balance > 0 | Require value >= 1
Send the account balanace to contract that requested the withdrawal | Desposit 1 `crypto`
Set the account balance to 0  | Withdraw all `crypto` from account balance


