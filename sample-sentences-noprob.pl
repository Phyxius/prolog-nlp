% Let's test sentences with noun phrases and verb phrases:
utterance([a, man, exists,]).
utterance([the, man, likes, the, dog]).
utterance([the, dogs, hate, the, man]).

%%, Let's test sentences with adjectives.
utterance([the, small, cat, eats]).
utterance([the, small, and, round, cat, eats]).
utterance([the, small, round, black, cat, eats]).
utterance([the, small, round, and, black, cat, eats]).
utterance([the, small, round, and, black, cat, eats, fake, pizza]).
utterance([the, small, round, and, black, cat, eats, the, fake, pizza]).
utterance([the, small, round, and, black, cat, eats, the, fake, poisonous, pizza]).
utterance([the, small, round, and, black, cat, eats, the, flat, fake, poisonous, pizza]).
utterance([the, small, round, and, black, cat, eats, the, flat, fake, and, poisonous, pizza]).
utterance([the, small, round, and, black, cat, eats, the, flat, and, hollow, and, poisonous, pizza]).

%% Let's test sentences with adverbs.
utterance([the, cat, eats, eloquently]).
utterance([the, cat, eloquently, eats]).
utterance([the, cat, eats, terribly, eloquently]).
utterance([the, cat, eats, terribly, eloquently, and, wisely]).
utterance([the, cat, stupidly, eats, terribly, eloquently, and, wisely]).
utterance([the, cat, stupidly, and, illegally, eats, terribly, eloquently, and, wisely]).

%%  Let's test sentences with prepositional phrases.
utterance([in, the, hat, the, cat, eats, robots]).
utterance([the, cat, in, the, hat, eats, robots]).
utterance([the, cat, eats, robots, in, the, hat]).

utterance([the, cat, in, the, hat, eats, robots, under, the, clouds]).
utterance([the, cat, in, the, hat, under, the, clouds, eats, robots, on, the, wall]).
utterance([on, the, wall, the, cat, in, the, hat, eats, robots, under, the, clouds]).

%% Let's test compound sentences.
utterance([lizards, eat, insects, and, robots, eat, humans]).
utterance([the, lizards, eat, insects, and, the, robots, eat, humans]).
utterance([the, lizards, eat, the, insects, and, the, robots, eat, the, humans]).

%% Let's put it all together.
utterance([in, america, the, small, round, black, cat, in, the, hat, on, the, great, great, wall, under, the, fake, clouds, eloquently, eats, graceful, robots, and, good, poisonous, pizza, in, china, and, mexico]).
