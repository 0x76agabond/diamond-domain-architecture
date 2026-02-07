# Domain Architecture 
Reference Implementation for [ERC-8110: Domain Architecture for Diamonds](https://eips.ethereum.org/EIPS/eip-8110)

--- 

**⚠️ *Important Notice: The smart contract code provided in this repo serves only as an illustrative example. This example code has not undergone any security audits or formal verification processes.***

**⚠️ *Under developmet.***

--- 

## Abstract

ERC-8110 introduces a domain-based architectural pattern for contracts implementing the Diamond execution model defined by [ERC-2535 (Diamond Standard)](https://eips.ethereum.org/EIPS/eip-2535) or [ERC-8109 (Diamond, Simplified)](https://eips.ethereum.org/EIPS/eip-8109), together with the storage identifier mechanism defined by [ERC-8042 (Diamond Storage Identifier)](https://eips.ethereum.org/EIPS/eip-8042).

It defines a domain-centric storage management architecture, providing consistent storage identifiers and a structured directory model that decouples storage ownership from facet logic.

This pattern helps reduce storage collisions and human error while enabling better tooling for multi-facet systems.

## Key Elements

### Example Source Organization

Examples are implemented under `src/example`.

These examples demonstrate Domain and Isolated Domain patterns built on top of ERC-8109, focusing on domain-centric storage management and the separation of storage ownership from facet logic.

This repository uses Solidity free functions inside module (`mod`) files to manage storage, instead of libraries.

This design choice is made for ecosystem compatibility and to keep the examples minimal and explicit.  
It mirrors the structural pattern used in [Compose](https://github.com/Perfect-Abstractions/Compose), where `mod` files define storage boundaries and identifiers.

### Benchmark 

This repository provides a reference implementation and gas benchmarks comparing the original AppStorage pattern with Domain and Isolated Domain architectures.

- **AppStorage (src/benchmark/appStorage.sol)**  
Original Storage pattern for Diamond.

- **Domain (src/benchmark/domain.sol)**  
ERC-8110 convention, separating storage identifiers by domain and sub-domain to improve clarity and provide a consistent upgrade path for storage.

- **Isolated Domain - src/benchmark/isolatedDomain.sol**  
ERC-8110 convention, moving the data access layer from facets into the domain by introducing explicit getters and setters.  
This fully isolates storage management code from business logic.

### Run test

```bash
    forge test GasBenchmark.t.sol --gas-report -vv
```

### Result Benchmark 

| Function / Metric           | AppStorage | Domain  | Isolated Domain |
|----------------------------|------------|---------|-----------------|
| Deployment Gas            | 586,670    | **568,165** | 666,034      |
| Bytecode Size (bytes)     | 2,497      | **2,415**   | 2,868        |
| readPackedValue            | **2,386**  | **2,386**  | 2,446        |
| readUnpackedValue          | 4,523      | **2,431**  | 2,491        |
| readAllValue               | 11,479     | **9,375**  | 9,499        |
| writePackedBools           | 44,157     | 44,157  | **44,127**      |
| writeUnpackedBools         | 66,305     | 44,201  | **44,171**      |
| writeAllValue              | 134,501    | **112,411** | 112,500     |
| readAndWritePackedValue    | 24,676     | 24,652  | **24,509**      |
| readAndWriteUnpackedValue  | 26,818     | 24,695  | **24,563**      |





