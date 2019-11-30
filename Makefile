main: externals
	dune build example/caml/main.exe

externals:
	cd core && cargo build
	cd example && cargo build
	dune build util/printmod.exe

test: externals
	dune runtest

clean:
	cd core && cargo clean
	cd example && cargo clean
	dune clean
