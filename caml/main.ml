open Bigstring

let () =
  for i = 1 to 1000 do
    let a = ref 10 and b = ref 20 in
    let a', b' = Rusty.mkpair a b in
    if a <> a || b <> b' then begin
      Printf.printf "%d=%d, %d=%d\n%!" !a !a' !b !b';
      assert false;
    end
  done;

  Printf.printf "%s\n" (Rusty.tostring ("hello", 42));
  Printf.printf "%s\n" (match Rusty.strtail "hello" with Some s -> s | None -> "?");

  let _pair =
    match Rusty.somestr 42 with
    | Some s -> Printf.printf "Some: %s\n" s
    | None -> Printf.printf "None" in

  let _ = Rusty.printint 42 in
  let _ = Rusty.printint64 (Int64.of_int 42) in
  let _ = Rusty.printchar (Char.chr 72) in

  let _ = Rusty.printbigstring (Bigstring.of_string "HELLO") in
  Printf.printf "%s\n" (match Rusty.bigstrtail (Bigstring.of_string "HELLO") with
                        | Some bs -> Bigstring.to_string bs
                        | None -> "?");
  ()
