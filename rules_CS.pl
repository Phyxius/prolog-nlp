utterance(X) :- sentence(X, []).
sentence(Start, End) :- nounphrase(Start, Rest, Number), verbphrase(Rest, End, Number).

tail(List, Tail) :- append(_, [Tail], List). %from SWI-Prolog documentation
allbuttail([_], Allbuttail) :- Allbuttail = [].
allbuttail(List, Allbuttail) :- length(List, Length), Length > 1, tail(List, Tail), append(List, Tail, All), prefix(Allbuttail, All).
all([], _).
all([Head | Rest], Predicate) :- call(Predicate, Head), all(Rest, Predicate).

noun(Noun, Number) :- noun(_, Noun, Number).
verb(Verb, Number) :- verb(_, Verb, Number).
adjective(Adjective) :- adjective(_, Adjective).
article(Article, Number) :- article(_, Article, Number).
adverb(Adverb) :- adverb(_, Adverb).
copula(Copula, Number) :- copula(_, Copula, Number).

nounphrase(Adjectivephrase, End, Number) :- adjectivephrase(Adjectivephrase, End, Number).
nounphrase([Article | Rest], End, Number) :- article(Article, Number), adjectivephrase(Rest, End, Number).

adjectivephrase([Adjective | Rest], End, Number) :- adjective(Adjective), adjectivephrase(Rest, End, Number).
adjectivephrase([Noun | End], End, Number) :- noun(Noun, Number).

verbphrase([Verb | End], End, Number) :- verb(Verb, Number).
verbphrase([Verb | Rest], End, Number) :- verb(Verb, Number), nounphrase(Rest, End, _).
verbphrase([Adverb | Rest], End, Number) :- adverb(Adverb), length(Rest, Length), Length > 0, verbphrase(Rest, End, Number).
verbphrase([Copula | Object], End, Number) :- copula(Copula, Number), copularobject(Object, Number, End).
verbphrase(Verbphrase, End, Number) :- tail(Verbphrase, Tail), allbuttail(Verbphrase, Prefix), length(Prefix, Length), Length > 0, verbphrase(Prefix, End, Number), adverb(Tail).

copularobject([Article | Rest], Number, End) :- article(Article, Number), adjectivephrase(Rest, End, Number).
copularobject(Object, _, _) :- allbuttail(Object, Head), all(Head, adverb), tail(Object, Tail), adjective(Tail).
