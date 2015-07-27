# ![Logo](https://raw.githubusercontent.com/clarus/icons/master/abc-48.png) CoqOfOCaml
[![Join the chat at https://gitter.im/clarus/coq-of-ocaml](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/clarus/coq-of-ocaml?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Compiler of OCaml to Coq. Still experimental. For more information look at the [Wiki](https://github.com/clarus/coq-of-ocaml/wiki).

## Install
### With OPAM
Add the [Coq repository](http://coq.io/opam/):

    opam repo add coq-released https://coq.inria.fr/opam/released

and run:

    opam install -j4 coq:coq-of-ocaml

### With Docker
Run the `Dockerfile` with:

    docker build --tag=coq-of-ocaml .

It will install the dependencies (can take time) and compile CoqOfOCaml. You can run the [Docker](https://www.docker.io/) image:

    docker run -ti coq-of-ocaml

and make the tests:

    eval `opam config env` # initialize the OPAM environment
    make test

### Manually
This compiler needs a working installation of OCaml 4.02 and Coq 8.4, plus the following packages (can be installed using [OPAM](http://opam.ocaml.org/)):
* [SmartPrint](https://github.com/clarus/smart-print)
* [YoJson](http://mjambon.com/yojson.html)

You have two parts to compile in order:

#### The Coq library
Go to `CoqOfOCaml/` and run:

    ./configure.sh
    make
    make install

#### The compiler
Go to the root folder and run:

    make
    make test

## Usage
CoqOfOCaml compiles the `.cmt` files (generated by the OCaml compiler using the option `-bin-annot`) to Coq definitions and print it on the standard output:

    coqOfOCaml.native -mode v file.cmt

You can start to experiment with the test files in `tests/`.

## License
MIT © Guillaume Claret.
