use cairo_verifier::air::layouts::starknet::global_values::GlobalValues;

#[starknet::interface]
trait ILayoutCompositionContract<ContractState> {
    fn eval_composition_polynomial_inner(
        self: @ContractState,
        mask_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        trace_generator: felt252,
        global_values: GlobalValues
    ) -> felt252;
}

#[starknet::interface]
trait ILayoutOodsContract<ContractState> {
    fn eval_oods_polynomial_inner(
        self: @ContractState,
        column_values: Span<felt252>,
        oods_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        oods_point: felt252,
        trace_generator: felt252,
    ) -> felt252;
}

#[starknet::contract]
mod LayoutCompositionContract {
    use super::{ILayoutCompositionContract, ILayoutCompositionContractDispatcher};
    use cairo_verifier::air::layouts::starknet::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part_1,
    };
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        continuation_contracts: Span<ContractAddress>,
    }

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            let mut continuation_contracts = self.continuation_contracts.read();

            let mut total_sum = ILayoutCompositionContractDispatcher {
                contract_address: continuation_contracts.pop_front().unwrap()
            }
                .eval_composition_polynomial_inner(
                    mask_values,
                    constraint_coefficients.slice(0, 99),
                    point,
                    trace_generator,
                    global_values
                );

            total_sum +=
                ILayoutCompositionContractDispatcher {
                    contract_address: continuation_contracts.pop_front().unwrap()
                }
                .eval_composition_polynomial_inner(
                    mask_values,
                    constraint_coefficients.slice(99, 99),
                    point,
                    trace_generator,
                    global_values
                );

            total_sum
        }
    }
}

#[starknet::contract]
mod LayoutCompositionContract1 {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::starknet::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part_1,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part_1(
                mask_values, constraint_coefficients, point, trace_generator, global_values
            )
        }
    }
}

#[starknet::contract]
mod LayoutCompositionContract2 {
    use super::ILayoutCompositionContract;
    use cairo_verifier::air::layouts::starknet::{
        global_values::GlobalValues, autogenerated::eval_composition_polynomial_inner_part_2,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutCompositionContract of ILayoutCompositionContract<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner_part_2(
                mask_values, constraint_coefficients, point, trace_generator, global_values
            )
        }
    }
}

#[starknet::contract]
mod LayoutOodsContract {
    use super::ILayoutOodsContract;
    use cairo_verifier::air::layouts::starknet::{
        global_values::GlobalValues, autogenerated::eval_oods_polynomial_inner,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl LayoutOodsContract of ILayoutOodsContract<ContractState> {
        fn eval_oods_polynomial_inner(
            self: @ContractState,
            column_values: Span<felt252>,
            oods_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) -> felt252 {
            eval_oods_polynomial_inner(
                column_values,
                oods_values,
                constraint_coefficients,
                point,
                oods_point,
                trace_generator,
            )
        }
    }
}
