module Contexts (Type : Set) where

open import Prelude
open import Cartesian-new


---------- Contexts ----------
Cx : Set1
Cx = Type -> Set

∅ : Cx
∅ _ = ⊥

infix 4 _∈_
_∈_ : Type -> Cx -> Set
a ∈ X = X a

hyp : Type -> Cx
hyp = _≡_

infixr 4 _∪_
_∪_ : Cx -> Cx -> Cx
(X ∪ Y) a = X a ⊎ Y a

infixr 4 _∷_
_∷_ : Type -> Cx -> Cx
a ∷ X = hyp a ∪ X

pattern here = inj₁ Eq.refl
pattern next x = inj₂ x


---------- Context renamings ----------
infix 1 _⊆_
_⊆_ : Cx -> Cx -> Set
X ⊆ Y = ∀ a -> a ∈ X -> a ∈ Y

cat:cx : Cat _ _
Obj cat:cx = Cx
Arr cat:cx = _⊆_
ident cat:cx _ = id
compo cat:cx X⊆Y Y⊆Z o = X⊆Y o • Y⊆Z o

instance
  compose:cx : Compose Cx _⊆_
  compose:cx = cat->compose cat:cx

import Data.Sum

-- ∪ forms coproducts on Cx under renaming.
instance
  sums:cx : Sums~ cat:cx _∪_
  -- _∨_ {{sums:cx}} = _∪_
  in₁ {{sums:cx}} _ = inj₁
  in₂ {{sums:cx}} _ = inj₂
  [_,_] {{sums:cx}} f g _ = Data.Sum.[ f _ , g _ ]

∪/⊆ : ∀ {X L R} -> L ⊆ R -> X ∪ L ⊆ X ∪ R
∪/⊆ f = [ in₁ , f • in₂ ]

∷/⊆ : ∀ L {R a} -> L ⊆ R -> a ∷ L ⊆ a ∷ R
∷/⊆ _ = ∪/⊆
