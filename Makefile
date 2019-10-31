main: rusty
	dune build example/main.exe

rusty:
	cargo build
	dune build caml/rusty.a

test: rusty
	dune runtest

clean:
	cargo clean
	dune clean
