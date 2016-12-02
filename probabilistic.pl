utterance(Prob, X) :- sentence(Prob, X, []).
utterance(Prob, X) :- sentence(Prob, X, [Conjunction | Rest]), conjunction(P1, Conjunction), utterance(P2, Rest),pr(r1, P), Prob is P*P1*P2.

sentence(Prob, Start, End) :- nounphrase(P1, Start, Rest), verbphrase(P2, Rest, End), pr(r2, P), Prob is P*P1*P2.
sentence(Prob, Start, End) :- append(Prepositionalphrase, Rest, Start), nonempty(Prepositionalphrase), prepositionalphrase(P1, Prepositionalphrase), sentence(P2, Rest, End), pr(r3, P), Prob is P*P1*P2.

tail(List, Tail) :- append(_, [Tail], List). %from SWI-Prolog documentation
head([Head | _], Head).
nonempty([_ | _]).
allbuthead([_ | Rest], Rest).
allbuttail([_], []).
allbuttail([Head | Rest], Allbuttail) :- allbuttail(Rest, Allbuttail2), append([Head], Allbuttail2, Allbuttail).
all([], _).
all([Head | Rest], Predicate) :- call(Predicate, Head), all(Rest, Predicate).

noun(Prob, Noun) :- noun(Prob, Noun, _).
verb(Prob, Verb) :- verb(Prob, Verb, _).
adjective(Prob, Adjective) :- adjective(Prob, Adjective).
article(Prob, Article) :- article(Prob, Article, _).
adverb(Prob, Adverb) :- adverb(Prob, Adverb).
copula(Prob, Copula) :- copula(Prob, Copula).
conjunction(Prob, Conjunction) :- conjunction(Prob, Conjunction).
preposition(Prob, Preposition) :- preposition(Prob, Preposition).

nounphrase(Prob, Adjectivephrase, End) :- adjectivephrase(P1, Adjectivephrase, End), pr(r4, P), Prob is P*P1.
nounphrase(Prob, [Article | Rest], End) :- article(P1, Article), adjectivephrase(P2, Rest, End), pr(r5, P), Prob is P*P1*P2.
nounphrase(Prob, Phrase, End) :- append(Start, [Conjunction | Rest], Phrase), conjunction(P1, Conjunction), nounphrase(P2, Start, []), nounphrase(P3, Rest, End), pr(r6, P), Prob is P*P1*P2*P3.
nounphrase(Prob, Phrase, End) :- append([Nounphrase, Prepositionalphrase, End], Phrase), nonempty(Nounphrase), nonempty(Prepositionalphrase), nounphrase(P1, Nounphrase, []), prepositionalphrase(P2, Prepositionalphrase), pr(r7, P), Prob is P*P1*P2.

adjectivephrase(Prob, [Adjective | Rest], End) :- adjective(P1, Adjective), adjectivephrase(P2, Rest, End), pr(r8, P), Prob is P*P1*P2.
adjectivephrase(Prob, [Noun | End], End) :- noun(P1, Noun), pr(r9, P), Prob is P*P1.
adjectivephrase(Prob, [Adjective, Conjunction, Adjective2 | Rest], End) :- adjective(P1, Adjective), conjunction(P2, Conjunction), adjective(P3, Adjective2), append([Adjective2], Rest, Subphrase), adjectivephrase(P4, Subphrase, End), pr(r10, P), Prob is P*P1*P2*P3*P4.

verbphrase(Prob, Verbphrase, End) :- append([Adverbphrase, [Verb], Nounphrase, Adverbphrase2, Prepositionalphrase, End], Verbphrase), adverbphrase(P1, Adverbphrase), verb(P2, Verb), ([] == Nounphrase, pr(r1, P3); nounphrase(P3, Nounphrase, [])), adverbphrase(P4, Adverbphrase2), (prepositionalphrase(P5, Prepositionalphrase); pr(r1, P5), Prepositionalphrase == []), pr(r11, P), Prob is P*P1*P2*P3*P4*P5.
verbphrase(Prob, Verbphrase, End) :- append([[Copula], Copularobject, End], Verbphrase), copula(P1, Copula), copularobject(P2, Copularobject, End), pr(r12, P), Prob is P*P1*P2.
verbphrase(Prob, Conjoinedverbphrase, End) :- append(First, [Conjunction | Rest], Conjoinedverbphrase), verbphrase(P1, First, []), conjunction(P2, Conjunction), verbphrase(P3,Rest, End), pr(13, P), Prob is P*P1*P2*P3.

prepositionalphrase(Prob, [Preposition, Article | Nounphrase]) :- preposition(P1, Preposition), article(P2, Article), nounphrase(P3, Nounphrase, []), pr(r14, P), Prob is P*P1*P2*P3.
prepositionalphrase(Prob, [Preposition | Nounphrase]) :- preposition(P1, Preposition), nounphrase(P2, Nounphrase, []), pr(r15, P), Prob is P*P1*P2.
prepositionalphrase(Prob, Compoundphrase) :- append(First, Rest, Compoundphrase), nonempty(First), nonempty(Rest), prepositionalphrase(P1, First), prepositionalphrase(P2, Rest), pr(r16, P), Prob is P*P1*P2.
prepositionalphrase(Prob, Compoundphrase) :- append([First, [Conjunction], Rest], Compoundphrase), nonempty(First), nonempty(Rest), conjunction(P1, Conjunction), prepositionalphrase(P2, First), prepositionalphrase(P3, Rest), pr(r17, P), Prob is P*P1*P2*P3.

adverbphrase(Prob, []) :- pr(r18, P), Prob is P.
adverbphrase(Prob, [Adverb, Conjunction, Adverb2 | Rest]) :- adverb(P1, Adverb), conjunction(P2, Conjunction), adverb(P3, Adverb2), append([Adverb2], Rest, Rest2), adverbphrase(P4, Rest2), pr(r19, P), Prob is P*P1*P2*P3*P4.
adverbphrase(Prob, [Adverb | Rest]) :- adverb(P1, Adverb), adverbphrase(P2, Rest), pr(r20, P), Prob is P*P1*P2.

copularobject(Prob, [], _) :- pr(r21, P), Prob is P.
copularobject(Prob, [Noun], _) :- noun(P1, Noun), pr(r22, P), Prob is P*P1.
copularobject(Prob, [Article | Rest], End) :- article(P1, Article), adjectivephrase(P2, Rest, End), pr(r23, P), Prob is P*P1*P2.
copularobject(Prob, [Adjective | Rest], Rest) :- adjective(P1, Adjective), pr(r24, P), Prob is P*P1.
copularobject(Prob, Object, _) :- allbuttail(Object, Head), all(Head, adverb), tail(Object, Tail), adjective(P1, Tail), pr(25, P), Prob is P*P1.
copularobject(Prob, Object, End) :- append(Start, [Conjunction | Rest], Object), conjunction(P1, Conjunction), copularobject(P2, Start, []), copularobject(P3, Rest, End), pr(r26, P), Prob is P*P1*P2*P3.
copularobject(Prob, Prepositionalphrase, _) :- prepositionalphrase(P1, Prepositionalphrase), pr(r27, P), Prob is P*P1.

%%utterance
pr(r1, 1). 
%%sentence
pr(r2, 0.5). 
pr(r3, 0.5).
%%nounphrase
pr(r4, 0.25).
pr(r5, 0.25).
pr(r6, 0.25).
pr(r7, 0.25).
%%adjectivephrase
pr(r8, 0.34).
pr(r9, 0.33).
pr(r10, 0.33).
%%verbphrase
pr(r11, 0.34).
pr(r12, 0.33).
pr(r13, 0.33).
%%prepositionalphrase
pr(r14, 0.25).
pr(r15, 0.25).
pr(r16, 0.25).
pr(r17, 0.25).
%%adverbphrase
pr(r18, 0.34).
pr(r19, 0.33).
pr(r20, 0.33).
%%copularobject
pr(r21, 1).
pr(r22, 0.166).
pr(r23, 0.166).
pr(r24, 0.167).
pr(r25, 0.167).
pr(r26, 0.167).
pr(r27, 0.167).