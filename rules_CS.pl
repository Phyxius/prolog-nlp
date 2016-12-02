%TODO: Adverb conjunctions, prepositioonal phrases
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


verbphrase(Verbphrase, End, Number) :- append([Adverbphrase, [Verb], Nounphrase, Adverbphrase2, End], Verbphrase), adverbphrase(Adverbphrase), verb(Verb, Number), ([] == Nounphrase; nounphrase(Nounphrase, [], _)), adverbphrase(Adverbphrase2).
verbphrase(Verbphrase, End, Number) :- append([[Copula], Copularobject, End], Verbphrase), copula(Copula, Number), copularobject(Copularobject, Number, End).
verbphrase(Conjoinedverbphrase, End, Number) :- append(First, [Conjunction | Rest], Conjoinedverbphrase), verbphrase(First, [], Number), conjunction(Conjunction), verbphrase(Rest, End, Number).

adverbphrase([]).
adverbphrase([Adverb, Conjunction, Adverb2 | Rest]) :- adverb(Adverb), conjunction(Conjunction), adverb(Adverb2), append([Adverb2], Rest, Rest2), adverbphrase(Rest2).
adverbphrase([Adverb | Rest]) :- adverb(Adverb), adverbphrase(Rest).

copularobject([], _, _).
copularobject([Noun], plural, _) :- noun(Noun, plural).
copularobject([Article | Rest], Number, End) :- article(Article, Number), adjectivephrase(Rest, End, Number).
copularobject([Adjective | Rest], _, Rest) :- adjective(Adjective).
copularobject(Object, _, _) :- allbuttail(Object, Head), all(Head, adverb), tail(Object, Tail), adjective(Tail).
copularobject(Object, Number, End) :- append(Start, [Conjunction | Rest], Object), conjunction(Conjunction), copularobject(Start, Number, []), copularobject(Rest, Number, End).