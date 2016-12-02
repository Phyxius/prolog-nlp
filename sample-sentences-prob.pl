% Let's test sentences with noun phrases and verb phrases:
utterance(Prob, [a, man, exists,]).
utterance(Prob, [the, man, likes, the, dog]).
utterance(Prob, [the, dogs, hate, the, man]).

%% Let's test sentences with adjectives.
utterance(Prob, [the, small, cat, eats]).
utterance(Prob, [the, small, and, round, cat, eats]).
utterance(Prob, [the, small, round, black, cat, eats]).
utterance(Prob, [the, small, round, and, black, cat, eats]).
utterance(Prob, [the, small, round, and, black, cat, eats, fake, pizza]).
utterance(Prob, [the, small, round, and, black, cat, eats, the, fake, pizza]).
utterance(Prob, [the, small, round, and, black, cat, eats, the, fake, poisonous, pizza]).
utterance(Prob, [the, small, round, and, black, cat, eats, the, flat, fake, poisonous, pizza]).
utterance(Prob, [the, small, round, and, black, cat, eats, the, flat, fake, and, poisonous, pizza]).
utterance(Prob, [the, small, round, and, black, cat, eats, the, flat, and, hollow, and, poisonous, pizza]).

%% Let's test sentences with adverbs.
utterance(Prob, [the, cat, eats, eloquently]).
utterance(Prob, [the, cat, eloquently, eats]).
utterance(Prob, [the, cat, eats, terribly, eloquently]).
utterance(Prob, [the, cat, eats, terribly, eloquently, and, wisely]).
utterance(Prob, [the, cat, stupidly, eats, terribly, eloquently, and, wisely]).
utterance(Prob, [the, cat, stupidly, and, illegally, eats, terribly, eloquently, and, wisely]).

%%  Let's test sentences with prepositional phrases.
utterance(Prob, [in, the, hat, the, cat, eats, robots]).
utterance(Prob, [the, cat, in, the, hat, eats, robots]).
utterance(Prob, [the, cat, eats, robots, in, the, hat]).

utterance(Prob, [the, cat, in, the, hat, eats, robots, under, the, clouds]).
utterance(Prob, [the, cat, in, the, hat, under, the, clouds, eats, robots, on, the, wall]).
utterance(Prob, [on, the, wall, the, cat, in, the, hat, eats, robots, under, the, clouds]).

%% Let's test compound sentences.
utterance(Prob, [lizards, eat, insects, and, robots, eat, humans]).
utterance(Prob, [the, lizards, eat, insects, and, the, robots, eat, humans]).
utterance(Prob, [the, lizards, eat, the, insects, and, the, robots, eat, the, humans]).

%% Let's put it all together.
utterance(Prob, [in, america, the, small, round, black, cat, in, the, hat, on, the, great, great, wall, under, the, fake, clouds, eloquently, eats, graceful, robots, and, good, poisonous, pizza, in, china, and, mexico]).
