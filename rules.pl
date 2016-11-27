utterance(Prob, X) :- sentence(Prob, X, []).
sentence(Prob, Start, End):- nounphrase(P1, Start, Rest),verbphrase(P2, Rest, End), pr(r1, P), Prob is P*P1*P2.
nounphrase(Prob, [Noun | End], End) :- noun(P1, Noun, _), pr(r2, P), Prob is P*P1.
nounphrase(Prob, [Article, Noun | End], End) :- article(P1, Article, _), noun(P2, Noun, _), pr(r3, P), Prob is P*P1*P2.
verbphrase(Prob, [Verb | End], End) :- verb(P1, Verb, _), pr(r4, P), Prob is P*P1.
verbphrase(Prob, [Verb | Rest], End) :- verb(P1, Verb, _), nounphrase(P2, Rest, End), pr(r5, P), Prob is P*P1*P2.
verbphrase(Prob, [Adverb | Rest], End) :- adverb(P1, Adverb), verbphrase(P2, Rest, End), pr(r6, P), Prob is P*P1*P2.
pr(r1, 1.0).
pr(r2, 0.3).
pr(r3, 0.7).
pr(r4, 0.2).
pr(r5, 0.8).
pr(r6, 0.6).

%% article(0.25, a).
%% article(0.75, the).
%% noun(0.65, man).
%% noun(0.35, dog).
%% verb(0.9, likes).
%% verb(0.1, bites).