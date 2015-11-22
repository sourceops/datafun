<!-- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum
dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
sunt in culpa qui officia deserunt mollit anim id est laborum. -->

# Syntax

$$\begin{array}{lrrl}
\text{types} & A,B
&::=& \N \pipe A \x B \pipe A \to B \pipe M \mono N \pipe \FS\;A \pipe A + B\\
\text{lattice types} & M,N
&::=& \N \pipe M \x N \pipe A \to M \pipe M \mono N \pipe \FS\;A\\
\text{expressions} & e
&::=& x \pipe \fn\bind{x} e \pipe \monofn\bind{x} e \pipe e_1\;e_2\\
&&|\,& (e_1, e_2) \pipe \pi_i\;e\\
&&|\,& \ms{in}_i\; e \pipe \case{e}{x}{e_1}{y}{e_2}\\
&&|\,& \emptyset \pipe e_1 \vee e_2\\
&&|\,& \{e\} \pipe \letin{x}{e_1}{e_2}\\
&&|\,& \fix{x}e\\
\text{contexts} & \GD &::=& \cdot \pipe \GD, x \of A \\
\text{monotone ctxts} & \GG &::=& \cdot \pipe \GG, x \of M\\
\text{typing judgment} & J &::=& \J{\GD}{\cdot}{e}{A}\\
&&|\,& \J{\GD}{\GG}{e}{M}
\end{array}$$

# Typing rules

## Structural rules

These rules are technically unnecessary, as they are (ought to be, no proof yet)
admissible.

$$
\infer[\ms{exchange}]{
  \J{\GD_1,\GD_2}{\GG_1,\GG_2}{e}{A}}{\J{\GD_2,\GD_1}{\GG_2,\GG_1}{e}{A}}
\quad
\infer[\ms{weaken}]{\J{\GD,\GD'}{\GG,\GG'}{e}{A}}{\J{\GD}{\GG}{e}{A}}
\quad
\infer[\ms{forget}]{\J{\GD,x\of M}{\GG}{e}{N}}{\J{\GD}{\GG,x\of M}{e}{N}}
$$

## Other rules

$$
\infer[\ms{hyp}]{\J{\GD}{\GG}{x}{A}}{x\of A \in \GD \cup \GG} \qquad
\infer[\fn]{\J{\GD}{\GG}{\fn\bind{x}{e}}{A \to B}}{
  \J{\GD,x\of A}{\GG}{e}{B}} \qquad
\infer[\ms{app}]{\J{\GD}{\GG}{e_1\;e_2}{B}}{
  \J{\GD}{\GG}{e_1}{A \to B} &
  \J{\GD}{\cdot}{e_2}{B}}
$$\ $$
\infer[\monofn]{\J{\GD}{\GG}{\monofn\bind{x}{e}}{M \mono N}}{
  \J{\GD}{\GG,x \of M}{e}{N}} \qquad
\infer[\widehat{\ms{app}}]{\J{\GD}{\GG}{e_1\;e_2}{N}}{
  \J{\GD}{\GG}{e_1}{M \mono N} &
  \J{\GD}{\GG}{e_2}{M}}
$$\ $$
\infer[(,\!)]{\J{\GD}{\GG}{(e_1, e_2)}{A_1 \x A_2}}{\J{\GD}{\GG}{e_i}{A_i}}
\qquad
\infer[\pi_i]{\J{\GD}{\GG}{\pi_i\; e}{A_i}}{\J{\GD}{\GG}{e}{A_1 \x A_2}}
$$\ $$
\infer[\ms{in}_i]{\J{\GD}{\cdot}{\ms{in}_i\;e}{A_1 + A_2}}{
  \J{\GD}{\cdot}{e}{A_i}} \qquad
\infer[\ms{case}]{\J{\GD}{\GG}{\case{e}{x}{e_1}{y}{e_2}}{C}}{
  \J{\GD}{\cdot}{e}{A + B} &
  \J{\GD,x\of A}{\GG}{e_1}{C} &
  \J{\GD,y\of B}{\GG}{e_2}{C}}
$$\ $$
\infer[\emptyset]{\J{\GD}{\GG}{\emptyset}{M}}{} \qquad
\infer[\vee]{\J{\GD}{\GG}{e_1 \vee e_2}{M}}{\J{\GD}{\GG}{e_i}{M}}
$$\ $$
\infer[\{\}]{\J{\GD}{\GG}{\{e\}}{\FS\;A}}{\J{\GD}{\cdot}{e}{A}} \qquad
\infer[\ms{let}_{\in}]{\J{\GD}{\GG}{\letin{x}{e_1}{e_2}}{M}}{
  \J{\GD}{\GG}{e_1}{\FS\;A} &
  \J{\GD,x\of A}{\GG}{e_2}{M}}
$$\ $$
\infer[\ms{fix}]{\J{\GD}{\GG}{\fix{x}e}{M}}{
  \J{\GD}{\GG,x\of M}{e}{M}}
$$

The \ms{fix} rule is overly permissive in allowing fix-points to be taken at any
lattice type; it needs to be be restricted to some computationally tractable
class of lattice types.