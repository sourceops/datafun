module Contexts (Type : Set) where

open import Prelude


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

instance
  compose:Cx : Compose Cx _⊆_
  ident compose:Cx _ = id
  compo compose:Cx X⊆Y Y⊆Z o = X⊆Y o • Y⊆Z o

cat:Cx = cat compose:Cx

import Data.Sum

-- ∪ forms coproducts on Cx under renaming.
instance
  sums:Cx : Sums~ cat:Cx _∪_
  in₁ {{sums:Cx}} _ = inj₁
  in₂ {{sums:Cx}} _ = inj₂
  [_,_] {{sums:Cx}} f g _ = Data.Sum.[ f _ , g _ ]

∪/⊆ : ∀ {X L R} -> L ⊆ R -> X ∪ L ⊆ X ∪ R
∪/⊆ f = [ in₁ , f • in₂ ]

∷/⊆ : ∀ L {R a} -> L ⊆ R -> a ∷ L ⊆ a ∷ R
∷/⊆ _ = ∪/⊆
