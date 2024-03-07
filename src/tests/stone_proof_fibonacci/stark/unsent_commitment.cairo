use cairo_verifier::{stark::StarkUnsentCommitment, tests::stone_proof_fibonacci};

fn get() -> StarkUnsentCommitment {
    return StarkUnsentCommitment {
        traces: stone_proof_fibonacci::traces::unsent_commitment::get(),
        composition: 0x30b93bbd6b193eb57d9f818202b899b7e8e09b0c7d183537fe85f4e6b6f4373,
        oods_values: stone_proof_fibonacci::stark::oods_values::get().span(),
        fri: stone_proof_fibonacci::fri::unsent_commitment::get(),
        proof_of_work: stone_proof_fibonacci::proof_of_work::unsent_commitment::get(),
    };
}
