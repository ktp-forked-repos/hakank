%
% Who killed agatha? (The Dreadsbury Mansion Murder Mystery) in ASP.
%
% This is a standard benchmark for theorem proving.
%
% http://www.lsv.ens-cachan.fr/~goubault/H1.dist/H1.1/Doc/h1003.html
% 
% """ 
% Someone in Dreadsbury Mansion killed Aunt Agatha. 
% Agatha, the butler, and Charles live in Dreadsbury Mansion, and 
% are the only ones to live there. A killer always hates, and is no 
% richer than his victim. Charles hates noone that Agatha hates. Agatha 
% hates everybody except the butler. The butler hates everyone not richer 
% than Aunt Agatha. The butler hates everyone whom Agatha hates. 
% Noone hates everyone. Who killed Agatha? 
% """
%
% Originally from 
% F. J. Pelletier: Seventy-five problems for testing automatic theorem provers.
% Journal of Automated Reasoning, 2: 191–216, 1986.
%
% See "Solving the Steamroller, and Other Puzzles, with Extended Disjunctive
% Logic Programming", Gerd Wagner, page 14+15
%
% Another formulation of the problem:
% http://www.lsv.ens-cachan.fr/~goubault/H1.dist/H1.1/Doc/h1003.html
% %
% This was created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also http://www.hakank.org/answer_set_programming/
%


% "Someone who lives in Dreadsbury Mansion, killed aunt Agatha. Agatha, 
% the butler, and Charles live in Dreadsbury Mansion, and are the only 
% people who live therein."

% The people in this drama
person(agatha;butler;charles).

% Exactly one person killed agatha
1 {killed(agatha,agatha), killed(butler,agatha), killed(charles,agatha)} 1.

% A killer always hates her victim, and is never richer than her victim
hates(Killer,Victim) :- person(Killer), person(Victim), killed(Killer,Victim).
:- richer(Killer,Victim), person(Killer), person(Victim), killed(Killer,Victim). 

% a person cannot be richer than him/herself
richer(X,Y) :- person(X), person(Y), X != Y.

% Charles hates no one that aunt Agatha hates
0 { hates(charles,X) } 0 :- person(X), hates(agatha,X).

% Agatha hates everyone except the butler, ...
hates(agatha,X) :- person(X), X != butler.
% ... and no one the butler does not hate.
:- hates(agatha,X), person(X), hates(butler,X).

% the butler hates everyone not richer than aunt Agatha
:- hates(butler, X),  person(X), richer(X,agatha).

% No one [in Dreadsbury Mansion] hates everyone
{hates(X,Y):person(Y)} 2 :- person(X).

% Agatha is not the butler
% :- person(X), X=agatha, X=butler. 

% Who killed aunt Agatha?
{killed(X,agatha):person(X)}.

% #hide.
#show killed(X,Y).
