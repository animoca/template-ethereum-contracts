# Animoca Ethereum Contracts - template

[![NPM Package](https://img.shields.io/npm/v/@animoca/template-ethereum-contracts.svg)](https://www.npmjs.org/package/@animoca/template-ethereum-contracts)
[![Coverage Status](https://codecov.io/gh/animoca/template-ethereum-contracts/graph/badge.svg)](https://codecov.io/gh/animoca/template-ethereum-contracts)

Solidity contracts project template.

## Audits

| Date       | Scope        | Commit                                                                                                                                  | Package version                                                            | Auditor                             | Report                                                                                    |
| ---------- | ------------ | --------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | ----------------------------------- | ----------------------------------------------------------------------------------------- |
| xx/xx/xxxx | xxxx | [commit-hash](https://github.com/animoca/template-ethereum-contracts/tree/commit-hash) | [x.x.x](https://www.npmjs.com/package/@animoca/ethereum-contracts/v/0.2.0) | [xxxx](https://) | [link](/audit/xxxx) |

## Development

Install the dependencies:

```bash
yarn
```

Compile the contracts:

```bash
yarn compile
```

Run the tests:

```bash
yarn test
# or
yarn test-p # parallel mode
```

Run the coverage tests:

```bash
yarn coverage
```

Run the full pipeline (should be run before commiting code):

```bash
yarn run-all
```

See `package.json` for additional commands.

Note: this repository uses git lfs: the module should be installed before pushing changes.
