extern crate dmz;

use dmz::*;
use std::io::{self, Write};

//#[derive(MLType)]
pub struct FooBar(Pair<OCamlInt, OCamlInt>);

impl MLType for FooBar {
    fn name() -> String {
        "foobar".to_owned()
    }

    fn module_name() -> String {
        "Test".to_owned()
    }
} 

camlmod!{
    fn tuple_to_string(gc, p: Pair<&str, OCamlInt>) -> &str {
        let pv = p.var(gc);
        let msg = format!("str: {}, int: {}",
                           p.fst().as_str(),
                          p.snd().as_int());        
        let ret = call!{ alloc_string(gc, &msg) };

        let _msg2 = format!("str: {}", pv.get(gc).fst().as_str());
        ret
    }

    fn mkpair(gc, x: AA, y: BB) -> Pair<AA, BB> {
        let pair = call!{ alloc_pair(gc, 0, x, y)};
        pair
    }

    fn strtail(gc, x: &str) -> Option<&str> {
        let b = x.as_str();
        if b.is_empty() {
            call!{ none(gc, ) }
        } else {
            call!{ alloc_some(gc, call!{alloc_string(gc, &b[1..])}) }
        }
    }

    fn bytestail(gc, x: String) -> Option<String> {
        let b = x.as_bytes();
        if b.is_empty() {
            call!{ none(gc, ) }
        } else {
            call!{ alloc_some(gc, call!{alloc_bytes(gc, String::from_utf8(b[1..].to_vec()).unwrap())}) }
        }
    }

    fn somestr(gc, x: OCamlInt) -> Option<&str> {
        let s = x.as_int().to_string();
        let pair = call!{ alloc_some(gc, call!{alloc_string(gc, &s)} ) };
        pair
    }

    fn triple(gc, x: AA) -> Pair<AA, Pair<AA, AA>> {
        let vx = x.var(gc);
        let snd = call!{alloc_pair(gc, 0, x, x)};
        call!{ alloc_pair(gc, 0, vx.get(gc), snd) }
    }
    
    // fn tuple3(gc, x: AA) -> Tuple3<AA, AA, AA>> {
    //     call!{ alloc_ntuple(gc, x, x, x) }
    // }

    fn recordfst(gc, x: FooBar) -> OCamlInt {
        let pair: Val<Pair<OCamlInt, OCamlInt>> = unsafe { x.field(0) };
        of_int(pair.fst().as_int())
    }

    fn bigstrtail(gc, x: &[u8]) -> Option<&[u8]> {
        let v = x.as_slice();
        if v.len() == 0 {
            call!{ none(gc, ) }
        } else {
            call!{ alloc_some(gc, call!{alloc_bigstring(gc, &v[1..])}) }
        }
    }
    
    fn printbigstring(gc, x: &[u8]) -> &str {
        let x = x.as_slice();
        for i in 0..x.len() {
            print!("{}", x[i] as char);
        }
        print!("\n");
        
        let msg = "";
        call!{ alloc_string(gc, msg) }
    }

    fn printchar(gc, x: char) -> &str {
        let x = x.as_char();
        println!("{} ", x);
        
        let msg = "";
        call!{ alloc_string(gc, &msg) }
    }

    fn printint(gc, x: OCamlInt) -> &str {
        let x = x.as_int();
        println!("{} ", x );
        
        let msg = "";
        call!{ alloc_string(gc, msg) }
    }

    fn printint64(gc, x: i64) -> &str {
        let x = x.as_i64();
        println!("{} ", x);
        
        let msg = "";
        call!{ alloc_string(gc, msg) }
    }

    fn inc(gc, x: OCamlInt) -> OCamlInt {
        of_int(x.as_int() + 1)
    }

    fn inc64(gc, x: i64) -> i64 {
        unsafe { Val::new(gc, caml_copy_int64(x.as_i64() + 1)) }
    }

    fn atoi(gc, x: char) -> OCamlInt {
        of_int(x.as_char() as i64)
    }
    
    fn itoa(gc, x: OCamlInt) -> char {
        of_char(x.as_int() as u8 as char)
    }
}
