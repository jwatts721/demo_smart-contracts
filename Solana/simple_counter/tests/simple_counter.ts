import * as anchor from "@coral-xyz/anchor";
import { Program } from "@coral-xyz/anchor";
import { SimpleCounter } from "../target/types/simple_counter";
import { expect } from "chai";

describe("simple_counter", () => {
  // Configure the client to use the local cluster.
  anchor.setProvider(anchor.AnchorProvider.env());

  const program = anchor.workspace.SimpleCounter as Program<SimpleCounter>;
  let counterAccount; // The account to store the counter.

  it("Is initialized!", async () => {
    // Generate a keypair for the counter account
    counterAccount = anchor.web3.Keypair.generate();

    // Get the provider's wallet
    const provider = anchor.AnchorProvider.local();

    await program.methods
      .initialize() // Call the initialize function
      .accounts({
        counter: counterAccount.publicKey,
        user: provider.wallet.publicKey,
        systemProgram: anchor.web3.SystemProgram.programId,
      })
      .signers([counterAccount])
      .rpc();
  });

  it("Is incremented!", async () => {
    // Call the increment function
    await program.methods
      .increment()
      .accounts({
        counter: counterAccount.publicKey,
        user: anchor.AnchorProvider.local().wallet.publicKey,
      })
      .rpc();

    // Fetch the account and check the incremented value
    const account = await program.account.counter.fetch(counterAccount.publicKey);
    expect(account.count.toNumber()).to.equal(1);

  });
});
