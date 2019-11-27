main: externs
	dune build example/caml/main.exe

externs:
	cd core && cargo build
	cd example && cargo build
	dune build util/printmod.exe

test: rusty
	dune runtest

clean:
	cd core && cargo clean
	cd example && cargo clean
	dune clean
