let bigstring = Alcotest.testable Bigstring.print Bigstring.equal

let to_string () =
  Alcotest.(check string)
    "string from tuple"
    "str: hello, int: 42"
    (Externals.tuple_to_string ("hello", 42))

let string_tail () =
  Alcotest.(check string)
    "tail of string"
    "ello"
    (match Externals.strtail "hello" with Some s -> s | None -> "?")

let bytes_tail () =
  Alcotest.(check string)
    "tail of bytes"
    "ello"
    (match Externals.bytestail (Bytes.of_string "hello") with
     | Some s -> (Bytes.unsafe_to_string s)
     | None -> "?")

let bigstring_tail () =
  Alcotest.(check bigstring)
    "tail of bigstring"
    (Bigstring.of_string "ELLO")
    (match Externals.bigstrtail (Bigstring.of_string "HELLO") with
     | Some bs -> bs
     | None -> (Bigstring.of_string "?"))

type foobar = { foo : int ; bar : int }

let record () =
  Alcotest.(check int)
    "pass record from Rust struct"
    1
    (Externals.recordfst { foo = 1 ; bar = 2 })

let inc () = Alcotest.(check int) "increment int" 43 (Externals.inc 42)
let inc64 () = Alcotest.(check int64) "increment int64" 43L (Externals.inc64 42L)
let atoi () = Alcotest.(check int) "convert char to int" 42 (Externals.atoi '*')
let itoa () = Alcotest.(check char) "convert int to char" '*' (Externals.itoa 42)

let tests = [
    "tuple to string",      `Quick, to_string ;
    "tail of string",       `Quick, string_tail ;
    "tail of bytes",        `Quick, bytes_tail ;
    "increment int",        `Quick, inc ;
    "increment int64",      `Quick, inc64 ;
    "convert char to int",  `Quick, atoi ;
    "convert int to char",  `Quick, itoa ;
    "tail of bigstring",    `Quick, bigstring_tail ;
    "pass record"           `Quick, record ;
  ]

let () =
  Alcotest.run "dmz" [
      "tests", tests;
    ]

