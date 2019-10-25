let bigstring = Alcotest.testable Bigstring.print Bigstring.equal

let to_string () =
  Alcotest.(check string)
    "string from tuple"
    "str: hello, int: 42"
    (Rusty.tostring ("hello", 42))

let string_tail () =
  Alcotest.(check string)
    "tail of string"
    "ello"
    (match Rusty.strtail "hello" with Some s -> s | None -> "?")

let bytes_tail () =
  Alcotest.(check string)
    "tail of bytes"
    "ello"
    (match Rusty.bytestail (Bytes.of_string "hello") with
     | Some s -> (Bytes.unsafe_to_string s)
     | None -> "?")

let bigstring_tail () =
  Alcotest.(check bigstring)
    "tail of bigstring"
    (Bigstring.of_string "ELLO")
    (match Rusty.bigstrtail (Bigstring.of_string "HELLO") with
     | Some bs -> bs
     | None -> (Bigstring.of_string "?"))

let inc () = Alcotest.(check int) "increment int" 43 (Rusty.inc 42)
let inc64 () = Alcotest.(check int64) "increment int64" 43L (Rusty.inc64 42L)
let atoi () = Alcotest.(check int) "convert char to int" 42 (Rusty.atoi '*')
let itoa () = Alcotest.(check char) "convert int to char" '*' (Rusty.itoa 42)

let tests = [
    "tuple to string",      `Quick, to_string ;
    "tail of string",       `Quick, string_tail ;
    "tail of bytes",        `Quick, bytes_tail ;
    "increment int",        `Quick, inc ;
    "increment int64",      `Quick, inc64 ;
    "convert char to int",  `Quick, atoi ;
    "convert int to char",  `Quick, itoa ;
    "tail of bigstring",    `Quick, bigstring_tail ;
  ]

let () =
  Alcotest.run "dmz" [
      "tests", tests;
    ]

