(** File generated by coq-of-ocaml *)
Require Import CoqOfOCaml.CoqOfOCaml.
Require Import CoqOfOCaml.Settings.

Inductive exp : vtag -> Set :=
| E_Int : int -> exp int_tag.

(** Records for the constructor parameters *)
Module ConstructorRecords_term.
  Module term.
    Module T_constr.
      Record record {b : Set} : Set := Build {
        b : b }.
      Arguments record : clear implicits.
      Definition with_b {t_b} b (r : record t_b) :=
        Build t_b b.
    End T_constr.
    Definition T_constr_skeleton := T_constr.record.
  End term.
End ConstructorRecords_term.
Import ConstructorRecords_term.

Reserved Notation "'term.T_constr".

Inductive term : vtag -> Set :=
| T_constr : forall {a : vtag}, 'term.T_constr a -> term a

where "'term.T_constr" := (fun (t_a : vtag) => term.T_constr_skeleton (exp t_a)).

Module term.
  Include ConstructorRecords_term.term.
  Definition T_constr := 'term.T_constr.
End term.

(** Records for the constructor parameters *)
Module ConstructorRecords_wrapper.
  Module wrapper.
    Module W_exp.
      Record record {x : Set} : Set := Build {
        x : x }.
      Arguments record : clear implicits.
      Definition with_x {t_x} x (r : record t_x) :=
        Build t_x x.
    End W_exp.
    Definition W_exp_skeleton := W_exp.record.
    
    Module W_term.
      Record record {x : Set} : Set := Build {
        x : x }.
      Arguments record : clear implicits.
      Definition with_x {t_x} x (r : record t_x) :=
        Build t_x x.
    End W_term.
    Definition W_term_skeleton := W_term.record.
  End wrapper.
End ConstructorRecords_wrapper.
Import ConstructorRecords_wrapper.

Reserved Notation "'wrapper.W_exp".
Reserved Notation "'wrapper.W_term".

Inductive wrapper : Set :=
| W_exp : forall {kind : vtag}, 'wrapper.W_exp kind -> wrapper
| W_term : forall {kind : vtag}, 'wrapper.W_term kind -> wrapper

where "'wrapper.W_exp" :=
  (fun (t_kind : vtag) => wrapper.W_exp_skeleton (exp t_kind))
and "'wrapper.W_term" :=
  (fun (t_kind : vtag) => wrapper.W_term_skeleton (term t_kind)).

Module wrapper.
  Include ConstructorRecords_wrapper.wrapper.
  Definition W_exp := 'wrapper.W_exp.
  Definition W_term := 'wrapper.W_term.
End wrapper.

Definition unwrap (w1 : wrapper) (w2 : wrapper) : int :=
  match (w1, w2) with
  | (W_exp e1, W_term e2) => 2
  | _ => 4
  end.

Inductive ty : Set :=
| Ty_bool : ty
| Ty_pair : ty -> ty -> ty.

Fixpoint match_with_used_unused_existentials {a : Set}
  (fuel : list int) (t_value : ty) (function_parameter : a -> a) : int :=
  let '_ := function_parameter in
  match fuel with
  | [] => 0
  | cons _ l_value =>
    match t_value with
    | Ty_bool => 12
    | Ty_pair t1 t2 =>
      let 'existT _ __0 [t2, t1] :=
        cast_exists (Es := Set) (fun __0 => [ty ** ty]) [t2, t1] in
      match_with_used_unused_existentials l_value t1
        (fun (x_value : __0) => x_value)
    end
  end.
