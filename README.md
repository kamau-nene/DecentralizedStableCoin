# DeFi Stablecoin

A decentralized stablecoin system built with Solidity and Foundry, designed to maintain a 1:1 peg to the USD through over-collateralization with crypto assets.

## Overview

This project implements a minimal Decentralized Stable Coin (DSC) protocol similar to DAI, featuring:

- **Exogenously Collateralized**: Backed by WETH and WBTC
- **Dollar Pegged**: Maintains $1 = 1 DSC peg
- **Algorithmically Stable**: Uses liquidation mechanisms to maintain stability
- **Over-Collateralized**: Requires 200% collateralization ratio

## Architecture

### Core Contracts

#### DecentralizedStableCoin (`src/DecentralizedStableCoin.sol`)

- ERC20 token with burnable extension
- Owner-controlled minting and burning
- Symbol: `DSC`, Name: `Decentralized Stable Coin`

#### DSCEngine (`src/DSCEngine.sol`)

The core protocol engine handling:

- Collateral deposits and withdrawals
- DSC minting and burning
- Health factor calculations
- Liquidation mechanics
- Price feed integration via Chainlink

### Key Features

- **Collateral Management**: Deposit WETH/WBTC as collateral
- **DSC Minting**: Mint DSC tokens based on collateral value (200% over-collateralization required)
- **Redemption**: Burn DSC to redeem collateral
- **Liquidation**: Liquidate under-collateralized positions with 10% bonus
- **Health Factor**: Real-time risk assessment (must stay above 1.0)

### Supported Assets

- **WETH** (Wrapped Ethereum)
- **WBTC** (Wrapped Bitcoin)

## Installation & Setup

### Prerequisites

- [Foundry](https://github.com/foundry-rs/foundry)
- [Make](https://www.gnu.org/software/make/)

### Quick Start

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd defi-stablecoin
   ```

2. **Install dependencies**

   ```bash
   make install
   ```

3. **Build the project**

   ```bash
   make build
   ```

4. **Run tests**

   ```bash
   make test
   ```

## Usage

### Local Development (Anvil)

1. **Start local blockchain**

   ```bash
   make anvil
   ```

2. **Deploy contracts**

   ```bash
   make deploy
   ```

### Testnet Deployment (Sepolia)

1. **Set environment variables**
   Create a `.env` file with:

   ```
   SEPOLIA_RPC_URL=your_sepolia_rpc_url
   PRIVATE_KEY=your_private_key
   ETHERSCAN_API_KEY=your_etherscan_api_key
   ```

2. **Deploy to Sepolia**

   ```bash
   make deploy ARGS="--network sepolia"
   ```

## Testing

Run the full test suite:

```bash
make test
```

Run with coverage:

```bash
make coverage
```

## Scripts

- `DeployDSC.s.sol`: Main deployment script
- `HelperConfig.s.sol`: Network configuration management

## Project Structure

```
├── src/
│   ├── DecentralizedStableCoin.sol    # DSC token contract
│   └── DSCEngine.sol                   # Core protocol logic
├── script/
│   ├── DeployDSC.s.sol                 # Deployment script
│   └── HelperConfig.s.sol              # Network configs
├── test/
│   ├── unit/                           # Unit tests
│   └── mocks/                          # Mock contracts
├── lib/
│   ├── forge-std/                      # Foundry standard library
│   └── openzeppelin-contracts/         # OpenZeppelin contracts
├── foundry.toml                        # Foundry configuration
└── Makefile                            # Build automation
```

## Security Considerations

- **Over-collateralization**: 200% minimum ratio required
- **Liquidation Threshold**: 50% (positions below this can be liquidated)
- **Health Factor**: Must remain above 1.0
- **Reentrancy Protection**: Uses OpenZeppelin's ReentrancyGuard
- **Price Feed Staleness**: Includes checks for outdated price data

## Development

### Code Quality

- **Linting**: Use `make format` to format code
- **Testing**: Comprehensive unit test coverage
- **Gas Optimization**: Efficient Solidity patterns

### Contributing

1. Fork the repository
2. Create a feature branch
3. Write tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Acknowledgments

- Inspired by MakerDAO's DSS system
- Built with Foundry and OpenZeppelin
- Price feeds powered by Chainlink
