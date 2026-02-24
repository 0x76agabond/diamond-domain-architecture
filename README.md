# Domain Architecture 
Reference Implementation for [ERC-8110: Domain Architecture for Diamonds](https://eips.ethereum.org/EIPS/eip-8110).  

Benchmark and demonstration of the following sections:

- Domain-Facet Overlap

- Subdomains and Layout-Sensitive State

- Isolated Domains

--- 

**⚠️ *Important Notice: The smart contract code provided in this repo serves only as an illustrative example.***

--- 

## Abstract

[ERC-8110 (Domain Architecture for Diamonds)](https://eips.ethereum.org/EIPS/eip-8110) introduces a storage management architecture for contracts implementing a Diamond-based system.

Building on the namespaced storage identifier mechanism defined in [ERC-8042 (Diamond Storage)](https://eips.ethereum.org/EIPS/eip-8042), this proposal organizes contract state into domains and sub-domains.
Each domain owns a dedicated storage layout and identifier, enabling consistent naming, deterministic storage positions, and a structured directory model that separates storage ownership from facet-level logic.

By formalizing domain boundaries and identifier conventions, this pattern reduces the risk of storage collisions and human error, while improving auditability and enabling better tooling for complex, multi-facet systems.

ERC-8110 defines only how storage is organized within Diamond-based architectures.
It does not mandate a specific execution, upgrade, or facet model.
Any system compatible with the Diamond architecture may adopt this Domain Architecture to manage and evolve its storage safely.

## Benchmark

### Ideas

This repository provides a reference implementation and gas benchmarks comparing the original AppStorage pattern with Domain and Isolated Domain architectures.

- **AppStorage (AS Broken)** - `src/appStorage/`  
The original storage pattern commonly used in Diamonds.  
In this benchmark, the storage packing is intentionally broken to simulate a realistic upgrade scenario where layout changes over time.

- **AppStoragePacked (AS Packed)** - `src/appStoragePacked/`  
The original AppStorage pattern with an optimized and tightly packed storage layout.  
This variant is included to provide a fair baseline comparison against ERC-8110–based approaches.

- **ERC7201Packed (ERC-7201)** - `src/ERC7201Storage/`  
Implements the ERC-7201 storage pattern using inheritance, a widely adopted approach for proxy-safe storage management.  
The layout is also tightly packed to provide a fair baseline when comparing against ERC-8110–based approaches.

- **Domain** - `src/domainStorage/`  
An ERC-8110 compliant approach that separates storage identifiers by domains and sub-domains, improving clarity and providing a consistent and safer upgrade path for storage.

- **Isolated Domain** - `src/isolatedDomainStorage/`  
An ERC-8110 compliant approach that moves the data access layer from facets into the domains by introducing explicit getters and setters.  
This fully isolates storage management code from business logic, while keeping runtime gas costs comparable.

### Run test

```bash
    forge test --gas-report -vv
```

### Benchmark Results

| Function / Metric         | AS Broken | AS Packed | ERC-7201 | Domain    | Isolated Domain |
|---------------------------|-----------------|-----------------|--------------|--------------|-----------------|
| **Deployment Gas**        | 586,452         | 592,233         | 592,185      | **581,778**  | 666,034         |
| **Bytecode Size**         | 2,496           | 2,526           | 2,526        | **2,478**    | 2,868           |
| readAllValue              | 11,476          | **9,375**       | **9,375**    | **9,375**    | 9,499           |
| readAndWritePackedValue   | 24,676          | 24,676          | 24,676       | 24,652       | **24,509**      |
| readAndWriteUnpackedValue | 26,818          | 24,719          | 24,719       | 24,695       | **24,563**      |
| readPackedValue           | **2,386**       | **2,386**       | **2,386**    | **2,386**    | 2,446           |
| readUnpackedValue         | 4,523           | **2,431**       | **2,431**    | **2,431**    | 2,491           |
| writeAllValue             | 134,501         | **112,418**     | **112,418**  | **112,418**  | 112,500         |
| writePackedBools          | 44,157          | 44,157          | 44,157       | 44,157       | **44,127**      |
| writeUnpackedBools        | 66,305          | 44,201          | 44,201       | 44,201       | **44,171**      |






