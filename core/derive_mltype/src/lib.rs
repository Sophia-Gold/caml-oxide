extern crate proc_macro;

use proc_macro::TokenStream;

#[proc_macro_derive(MLType)]
pub fn derive_mltype(_item: TokenStream) -> TokenStream {
    // std::intrinsics::type_name(self).to_owned()
    "fn name() -> String {
         \"foobar\".to_owned()
      }".parse().unwrap()
}
