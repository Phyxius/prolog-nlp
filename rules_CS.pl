utterance(X) :- sentence(X, []).
sentence(Start, End) :- nounphrase(Start, Rest, Number), verbphrase(Rest, End, Number).
noun(Noun, Number) :- noun(_, Noun, Number).
verb(Verb, Number) :- verb(_, Verb, Number).
adjective(Adjective) :- adjective(_, Adjective).
article(Article, Number) :- article(_, Article, Number).
adverb(Adverb) :- adverb(_, Adverb).

nounphrase([Noun | End], End, Number) :- noun(Noun, Number).
nounphrase([Adjective, Noun | End], End, Number) :- noun(Noun, Number), adjective(Adjective).
nounphrase([Article, Noun | End], End, Number) :- noun(Noun, Number), article(Article, Number).
nounphrase([Article, Adjective, Noun | End], End, Number) :- noun(Noun, Number), article(Article, Number), adjective(Adjective).

verbphrase([Verb | End], End, Number) :- verb(Verb, Number).
verbphrase([Verb, Adverb | End], End, Number) :- verb(Verb, Number), adverb(Adverb).
verbphrase([Verb | Rest], End, Number) :- verb(Verb, Number), nounphrase(Rest, End, _).
verbphrase([Verb, Adverb | Rest], End, Number) :- verb(Verb, Number), adverb(Adverb), nounphrase(Rest, End, _).



