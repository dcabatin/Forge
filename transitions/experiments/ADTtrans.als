
/*
Single transition: warmup for using ADTs with traces.
Preds like ex:sApBC would be generated to test membership in ex:A+B*C.
Preds like ex:h would be generated from ex:f+g (approx).
This lets the transition predicate remain very simple.
*/

sig S {	stuff: set univ }
sig A {}
sig B {}
sig C {}

// one sig U {} // used for arity alignment

--------
--------

pred f[s, s': S, a: A] {
	s'.stuff = s.stuff+a
	a not in s.stuff
}
pred g[s, s': S, b: B, c: C] {
	s'.stuff = s.stuff+b+c
	b not in s.stuff
	c not in s.stuff
}

pred sApBC[a: A, b: B, c: C] {
	(lone a) (lone b) (lone c)
	(one a) implies (no b+c) else pBC[b, c]
}
pred pBC[b: B, c: C] {
	(one b) (one c)
}
run sApBC for 0 but exactly 2 A, exactly 2 B, exactly 2 C

pred h[s, s': S, a: A, b: B, c: C] {
	sApBC[a, b, c]
	(one a)   implies f[s, s', a]
	pBC[b, c] implies g[s, s', b, c]
}
run h for exactly 2 S, exactly 2 A, exactly 2 B, exactly 2 C

--------
--------

pred initialState[s: S] {
	no s.stuff
}
pred finalState[s: S] {
	#(s.stuff) = 3
}
pred myInv[s: S] {
	s.stuff in (A+B+C)
}

pred transition[s, s': S, a: lone A, b: lone B, c: lone C] {
	h[s, s', a, b, c]
	initialState[s]
	myInv[s]
	myInv[s']
}
run transition for 2 but exactly 1 A, exactly 1 B, exactly 1 C











