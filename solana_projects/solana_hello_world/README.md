# Solana commands

```solana config set --url https://api.devnet.solana.com```
```solana-keygen new --force```
```solana airdrop 1 <RECIPIENT_ACCOUNT_ADDRESS> --url https://api.devnet.solana.com```
# Resources

- https://stackoverflow.com/questions/63739813/error-linker-cc-not-found-when-cross-compiling-a-rust-project-from-windows

- https://stackoverflow.com/questions/31492799/cross-compile-a-rust-application-from-linux-to-windows

- https://dev.to/turupawn/tu-primer-programa-en-solana-b19

## Error with cargo in AL2

```cargo: error while loading shared libraries: libssl.so.1.1: cannot open shared object file: No such file or directory```

- https://stackoverflow.com/questions/42828083/error-while-loading-shared-libraries-usr-local-lib64-libssl-so-1-1

Solution

- sudo yum install -y  openssl11-libs