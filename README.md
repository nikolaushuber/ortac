# `ortac` — OCaml RunTime Assertion Checking

:warning: This project is still under heavy development, with no
stable release yet. Expect rough edges!

`ortac` is a tool to convert an OCaml module interface with [Gospel]
specifications into code to check those specifications.

[Gospel]: https://ocaml-gospel.github.io/gospel/

There are various ways to check specifications:

- the _default_ mode generates a _wrapper_ module, _i.e._ a module
  exposing the original interface but instrumenting all function calls
  with assertions on arguments and on results, either normal or
  exceptional,
- the _monolith_ mode, provided as a plugin, generates a program using
  [Monolith] that will test the module by comparing it against an
  instrumented version of the module; see the [dedicated
  README][monolith README] for details,
- the _QCheck-STM_ mode, provided as a plugin, generates a program
  using [QCheck-STM] that will test the module by running random
  functions calls and checking they give consistent results with the
  model provided in the Gospel specification; see the [dedicated
  README][QCheck-STM README] for details.

[Monolith]: https://gitlab.inria.fr/fpottier/monolith
[monolith README]: plugins/monolith/README.md
[QCheck-STM]: https://ocaml-multicore.github.io/multicoretests/
[QCheck-STM README]: plugins/qcheck-stm/README.md

At its core, Ortac provides a way to convert the executable fragment
of Gospel into OCaml code. This core functionality is used by all
modes.


## Installation

The easiest way to try `ortac` out is to `opam pin` it:

```
opam pin add -y https://github.com/ocaml-gospel/ortac.git
```

It requires a yet-unreleased version of Gospel because Gospel evolved
quite a lot since its 0.1.0 release.

This repository contains the following OPAM packages:

- `ortac.opam` which provides the `ortac` command-line tool and its
  default mode,
- `ortac-runtime.opam` which provides the support library for the code
  generated by Ortac default mode,
- `ortac-monolith.opam` which provides the Monolith plugin for the
  `ortac` command-line tool,
- `ortac-runtime-monolith.opam` which provides the support library for
  the code generated with the Monolith plugin,
- `ortac-qcheck-stm.opam` which provides the QCheck-STM plugin for the
  `ortac` command-line tool.

You can install only some of those packages by explicitly mentionning
which package you want to install, for instance:

```
$ opam pin add ortac https://github.com/ocaml-gospel/ortac.git
```

To check that it is correctly installed, simply run `ortac`. If you
installed all packages, you should get:

```
$ ortac
ortac: required COMMAND name is missing, must be one of 'default', 'monolith' or 'qcheck-stm'.
Usage: ortac COMMAND …
Try 'ortac --help' for more information.
```


## Quick start

or: How to use Ortac to test whether the specifications of a module
hold. Using one of the plugins is probably the easiest option to
start with.


### Monolith plugin

The Monolith plugin can generate a standalone executable that will try
to falsify the Gospel specifications of a module by stress-testing the
code. Look in the [dedicated README][monolith README] for the Monolith
plugin to see how it can be used.


### QCheck-STM plugin

The QCheck-STM plugin can generate a standalone executable that will
test the consistency between the behaviour of the functions of the
module and their model, as provided by the Gospel specifications. Look
at the [dedicated README][QCheck-STM README] for the QCheck-STM plugin
to see how it can be used.


### Default mode

The `default` mode can be used to generate a _wrapper_ module that
will expose the same interface as the original module but
instrumenting all function calls with assertions corresponding to the
Gospel specifications.

Let’s start with a module interface `lib.mli` containing some Gospel
specifications, borrowed from Gospel documentation:

```ocaml
val euclidean_division: int -> int -> int * int
(*@ q, r = euclidean_division x y
    requires y > 0
    ensures  x = q * y + r
    ensures  0 <= r < y *)
```

Given that interface, `ortac default lib.mli` will display a code
structured as such:

```ocaml
include Lib
module Ortac_runtime = Ortac_runtime
let euclidean_division x y =
  (* check that y > 0 *)
  (* raise an error if the previous check failed *)
  let q, r =
    try euclidean_division x y
    with e ->
      (* raise an error as the specification do not mention exceptions *)
      raise e
  in
  (* check that x = q * y + r *)
  (* check that 0 <= r < y *)
  (* raise an error if one of the previous checks failed *)
  (q, r)
```

In other words, it produces a module exposing the same interface as
`Lib`, so that each function call is instrumented to test the
specification of the function at runtime.

If you want to use those assertions at runtime in your program, you
can do so:

```
$ ortac default lib.mli > libAsserts.ml
$ cp lib.mli libAsserts.mli
```

add `LibAsserts` to your build and, in all the modules in which you
want to check the specification on every function call, insert at the
very beginning:

```ocaml
module Lib = LibAsserts
```


## Supported Gospel

The various modes currently have some limitations on what Gospel
specifications are supported. They all inherit limitations from the
core translation from Gospel into OCaml:

1. The first general rule is the fact that it can only translate the
   executable fragment of the language.

2. The [runtime] currently supports only part of the Gospel Stdlib
   (see its `Gospelstdlib` module) but it is easy to extend if needed.
   ([`context.ml`] must be updated accordingly as it lists all the
   values to emit warnings for unsupported functions).

[runtime]: src/runtime/ortac_runtime.ml
[`context.ml`]: src/core/context.ml

Additionally, the default mode and the Monolith plugin do not support
yet:

- `model`s,
- the `old` operator.

The QCheck-STM plugin also has its own set of constraints on what it
can handle, see its [dedicated README][QCheck-STM README] for details.
