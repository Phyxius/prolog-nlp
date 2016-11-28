utterance(X) :- sentence(X, []).
sentence(Start, End) :- nounphrase(Start, Rest, Number), verbphrase(Rest, End, Number).

noun(Noun, Number) :- noun(_, Noun, Number).
verb(Verb, Number) :- verb(_, Verb, Number).
adjective(Adjective) :- adjective(_, Adjective).
article(Article, Number) :- article(_, Article, Number).
adverb(Adverb) :- adverb(_, Adverb).

nounphrase(Adjectivephrase, End, Number) :- adjectivephrase(Adjectivephrase, End, Number).
%%nounphrase([Adjective, Rest | End], End, Number) :- nounphrase(Rest, End, Number), adjectivephrase(Adjective).
nounphrase([Article | Rest], End, Number) :- article(Article, Number), adjectivephrase(Rest, End, Number).

adjectivephrase([Adjective | Rest], End, Number) :- adjective(Adjective), adjectivephrase(Rest, End, Number).
adjectivephrase([Noun | End], End, Number) :- noun(Noun, Number).


verbphrase([Verb | End], End, Number) :- verb(Verb, Number).
%%verbphrase([Adverb, Verb | End], End, Number) :- verb(Verb, Number), adverb(Adverb).
verbphrase([Verb | Rest], End, Number) :- verb(Verb, Number), nounphrase(Rest, End, _).
%%verbphrase([Adverb, Verb | Rest], End, Number) :- verb(Verb, Number), adverb(Adverb), nounphrase(Rest, End, _).
verbphrase([Adverb | Rest], End, Number) :- adverb(Adverb), verbphrase(Rest, End, Number).




