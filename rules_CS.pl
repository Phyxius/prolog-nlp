utterance(X) :- sentence(X, []).
utterance(X) :- sentence(X, [Conjunction | Rest]), conjunction(Conjunction), utterance(Rest).
sentence(Start, End) :- nounphrase(Start, Rest, Number), verbphrase(Rest, End, Number).

tail(List, Tail) :- append(_, [Tail], List). %from SWI-Prolog documentation
head([Head | _], Head).
nonempty([_ | _]).
allbuthead([_ | Rest], Rest).
allbuttail([_], []).
allbuttail([Head | Rest], Allbuttail) :- allbuttail(Rest, Allbuttail2), append([Head], Allbuttail2, Allbuttail).
all([], _).
all([Head | Rest], Predicate) :- call(Predicate, Head), all(Rest, Predicate).

noun(Noun, Number) :- noun(_, Noun, Number).
verb(Verb, Number) :- verb(_, Verb, Number).
adjective(Adjective) :- adjective(_, Adjective).
article(Article, Number) :- article(_, Article, Number).
adverb(Adverb) :- adverb(_, Adverb).
copula(Copula, Number) :- copula(_, Copula, Number).
conjunction(Conjunction) :- conjunction(_, Conjunction).

nounphrase(Adjectivephrase, End, Number) :- adjectivephrase(Adjectivephrase, End, Number).
nounphrase([Article | Rest], End, Number) :- article(Article, Number), adjectivephrase(Rest, End, Number).
nounphrase(Phrase, End, Number) :- append(Start, [Conjunction | Rest], Phrase), conjunction(Conjunction), nounphrase(Start, [], _), nounphrase(Rest, End, Number).

adjectivephrase([Adjective | Rest], End, Number) :- adjective(Adjective), adjectivephrase(Rest, End, Number).
adjectivephrase([Noun | End], End, Number) :- noun(Noun, Number).
adjectivephrase([Adjective, Conjunction, Adjective2 | Rest], End, Number) :- adjective(Adjective), conjunction(Conjunction), adjective(Adjective2), append([Adjective2], Rest, Subphrase), adjectivephrase(Subphrase, End, Number).

verbphrase([Verb | End], End, Number) :- verb(Verb, Number).
verbphrase([Verb | Rest], End, Number) :- verb(Verb, Number), nounphrase(Rest, End, _).
verbphrase([Adverb | Rest], End, Number) :- adverb(Adverb), length(Rest, Length), Length > 0, verbphrase(Rest, End, Number).
verbphrase([Copula | Object], End, Number) :- copula(Copula, Number), copularobject(Object, Number, End).
verbphrase(Verbphrase, End, Number) :- tail(Verbphrase, Tail), allbuttail(Verbphrase, Prefix), verbphrase(Prefix, End, Number), adverb(Tail).
verbphrase(Conjoinedverbphrase, End, Number) :- append(First, [Conjunction | Rest], Conjoinedverbphrase), verbphrase(First, [], Number), conjunction(Conjunction), verbphrase(Rest, End, Number).

copularobject([], _, _).
copularobject([Noun], plural, _) :- noun(Noun, plural).
copularobject([Article | Rest], Number, End) :- article(Article, Number), adjectivephrase(Rest, End, Number).
copularobject([Adjective | Rest], _, Rest) :- adjective(Adjective).
copularobject(Object, _, _) :- allbuttail(Object, Head), all(Head, adverb), tail(Object, Tail), adjective(Tail).
copularobject(Object, Number, End) :- append(Start, [Conjunction | Rest], Object), conjunction(Conjunction), copularobject(Start, Number, []), copularobject(Rest, Number, End).