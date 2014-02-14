Require Import CoqOfOCaml.

Local Open Scope Z_scope.
Import ListNotations.
Set Implicit Arguments.

Definition n : Z :=
  match ((cons 1 (cons 2 [])), false) with
  | (cons x (cons _ []), true) => x
  | (cons _ (cons y []), false) => y
  | _ => 0
  end.