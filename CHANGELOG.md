# Changelog

## [0.2.0]

### New Types

- `bytes` for mutable Rust `String`, whereas `string` becomes `&str`
- `int64` for Rust `i64` vs. 63-bit OCaml `int`
- `Bigstring.t` with custom allocator
- `Triple` that calls `caml_alloc_ntuple` in allocpair.c

### Administrative Changes

- Changed name from caml-oxide to dmz to avoid confusion with formal semantics project and others
- Unit test using Alcotest
- Build OCaml files with Dune
- Restructed directories to separate examples and tests from core Rust library

## [0.3.0]

### New Types

- `Z.t` for Rust `num::BigInt`
- `('a, string) result` for Rust `Result<A>`

### Administrative Changes

- Optional `type_def` method to `MLType` to print defintions of abstract types and records
- `camlmod!` also prints an .mli file using optional `interface` method for `MLType`

## To Do

- `alloc_tuple` for arbitrary sized n-tuples
- Deriving macro to generate `MLType` and `ValExt` (since inherent Val impls cannot be defined in other crates) impls for structs as well as allocation functions that call `caml_alloc_ntuple`
