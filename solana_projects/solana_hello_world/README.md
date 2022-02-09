```solana config set --url https://api.devnet.solana.com```
```solana-keygen new --force```
solana airdrop 1 <RECIPIENT_ACCOUNT_ADDRESS> --url https://api.devnet.solana.com

https://docs.solana.com/es/wallet-guide
https://docs.solana.com/es/cli/transfer-tokens

Compile the smart contract
cargo build --release --target x86_64-unknown-linux-gnu
cargo build --target=x86_64-unknown-linux-gnu
previously intall
rustup 
rustup target add x86_64-unknown-linux-musl

Resources
https://stackoverflow.com/questions/63739813/error-linker-cc-not-found-when-cross-compiling-a-rust-project-from-windows

https://stackoverflow.com/questions/31492799/cross-compile-a-rust-application-from-linux-to-windows

https://dev.to/turupawn/tu-primer-programa-en-solana-b19

Error
cargo: error while loading shared libraries: libssl.so.1.1: cannot open shared object file: No such file or directory
https://stackoverflow.com/questions/42828083/error-while-loading-shared-libraries-usr-local-lib64-libssl-so-1-1
Solution
sudo yum install -y  openssl11-libs