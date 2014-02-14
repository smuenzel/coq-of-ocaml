Require Import CoqOfOCaml.

Local Open Scope Z_scope.
Import ListNotations.
Set Implicit Arguments.

Inductive t1 : Type :=
| C1 : Z -> t1
| C2 : bool -> Z -> t1
| C3 : t1 .
Arguments C1 _.
Arguments C2 _ _.
Arguments C3 .

Definition n : t1 := C2 false 3.

Definition m : bool :=
  match n with
  | C2 b _ => b
  | _ => true
  end.

Inductive t2 (a : Type) : Type :=
| D1 : t2 a
| D2 : a -> (t2 a) -> t2 a.
Arguments D1 {a} .
Arguments D2 {a} _ _.

Fixpoint of_list_rec {A : Type} (counter : nat) (l : list A) :
  M [ NonTermination ] (t2 A) :=
  match counter with
  | 0 % nat => not_terminated tt
  | S counter =>
    match l with
    | [] => ret D1
    | cons x xs =>
      let! x_1 := (of_list_rec counter) xs in
      ret (D2 x x_1)
    end
  end.

Definition of_list {A : Type} (l : list A) :
  M [ Counter; NonTermination ] (t2 A) :=
  let! counter := lift [_;_] "10" (read_counter tt) in
  lift [_;_] "01" ((of_list_rec counter) l).

Fixpoint sum_rec (counter : nat) (l : t2 Z) : M [ NonTermination ] Z :=
  match counter with
  | 0 % nat => not_terminated tt
  | S counter =>
    match l with
    | D1 => ret 0
    | D2 x xs =>
      let! x_1 := (sum_rec counter) xs in
      ret ((Z.add x) x_1)
    end
  end.

Definition sum (l : t2 Z) : M [ Counter; NonTermination ] Z :=
  let! counter := lift [_;_] "10" (read_counter tt) in
  lift [_;_] "01" ((sum_rec counter) l).

Definition s : M [ Counter; NonTermination ] Z :=
  let! x := of_list (cons 5 (cons 7 (cons 3 []))) in
  sum x.