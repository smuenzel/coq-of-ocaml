(** Generated by coq-of-ocaml *)
Require Import OCaml.OCaml.

Local Set Primitive Projections.
Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Open Scope type_scope.
Import ListNotations.

Module Source.
  Record signature {t : Set} : Set := {
    t := t;
    x : t;
  }.
End Source.

Module Target.
  Record signature {t : Set} : Set := {
    t := t;
    y : t;
  }.
End Target.

Module M.
  Definition t : Set := int.
  
  Definition x : int := 12.
  
  Definition module :=
    existT (A := Set) _ t
      {|
        Source.x := x
      |}.
End M.
Definition M := M.module.

Module F.
  Class Args := {
    X : {t : Set & Source.signature (t := t)};
  }.
  
  Definition t `{Args} : Set := (|X|).(Source.t).
  
  Definition y `{Args} : (|X|).(Source.t) := (|X|).(Source.x).
  
  Definition functor `(Args)
    : {_ : unit & Target.signature (t := (|X|).(Source.t))} :=
    existT (A := unit) (fun _ => _) tt
      {|
        Target.y := y
      |}.
End F.
Definition F X := F.functor {| F.X := X |}.

Module FSubst.
  Class Args := {
    X : {t : Set & Source.signature (t := t)};
  }.
  
  Definition y `{Args} : (|X|).(Source.t) := (|X|).(Source.x).
  
  Definition functor `(Args)
    : {_ : unit & Target.signature (t := (|X|).(Source.t))} :=
    existT (A := unit) (fun _ => _) tt
      {|
        Target.y := y
      |}.
End FSubst.
Definition FSubst X := FSubst.functor {| FSubst.X := X |}.

Module Sum.
  Class Args := {
    X : {_ : unit & Source.signature (t := int)};
    Y : {_ : unit & Source.signature (t := int)};
  }.
  
  Definition t `{Args} : Set := int.
  
  Definition y `{Args} : int := Z.add (|X|).(Source.x) (|Y|).(Source.x).
  
  Definition functor `(Args) : {t : Set & Target.signature (t := t)} :=
    existT (A := Set) _ t
      {|
        Target.y := y
      |}.
End Sum.
Definition Sum X Y := Sum.functor {| Sum.X := X; Sum.Y := Y |}.

Module WithM.
  Definition t := (|M|).(Source.t).
  
  Definition x := (|M|).(Source.x).
  
  Definition z : int := 0.
End WithM.

Module WithSum.
  Definition F_include := F (existT (A := Set) _ _ (|M|)).
  
  Definition t := (|F_include|).(Target.t).
  
  Definition y := (|F_include|).(Target.y).
  
  Definition z : int := 0.
End WithSum.

Module GenFun.
  Definition t : Set := int.
  
  Definition y : int := 23.
  
  Definition module :=
    existT (A := Set) _ t
      {|
        Target.y := y
      |}.
End GenFun.
Definition GenFun := GenFun.module.

Definition AppliedGenFun := GenFun.
