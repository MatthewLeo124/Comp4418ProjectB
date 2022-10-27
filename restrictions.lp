#include "sample_data.txt".
#include "wanted.txt".

1 {pick(NAME, SIZE, COST, QUANTITY, LOCATION) : part(NAME, SIZE, COST, QUANTITY, LOCATION)}.

exceed(NAME, QUANT) :- wanted(NAME, _, QUANTWANTED), 
QUANTHAVE = #sum{QUANTITY: pick(NAME, _, _, QUANTITY, _)}, 
QUANTMAX = #max{QUANTITY: pick(NAME, _, _, QUANTITY, _)},
pick(NAME, _, _, QUANTMAX, _),
QUANT = QUANTHAVE - QUANTWANTED, 
QUANT>=0,
QUANT<=QUANTMAX.

:- wanted(NAME, _, _), not exceed(NAME, _).

refund(NAME, AMOUNT) :- exceed(NAME, QUANT), 
PRICE = #max{COST: pick(NAME, _, COST, QUANTITY, _), QUANT <= QUANTITY}, 
pick(NAME, _, PRICE, _, _), 
AMOUNT = PRICE*QUANT.

% :- pick(NAME, _, _, _, _), not wanted(NAME, _, _).

% Constraints to satisfy:
% Constraint 1: Must have sufficient amount of each part required
    %Consider the case where we can pick multiple suppliers to add up to our wanted quantity if one doesnt have it.
:- wanted(NAME, _, QUANTITYWANTED), T = #sum{QUANTITY: pick(NAME, _, _, QUANTITY,_)}, T < QUANTITYWANTED.

:- wanted(NAME, THRESHOLD, _), refund(NAME, AMOUNT), TP = #sum{COST*QUANTITY: pick(NAME, _, COST, QUANTITY, _)}, TP - AMOUNT > THRESHOLD.

% Constraint 3: Can only contain allowed locations

% Constraint 4: Minimise cost
    %How to represent an unknown fraction of each pick to optimise for?
    %For basic examples this work, shouldn't be too hard to break though.
totalPrice(T) :- T = #sum {COST*QUANTITY : pick(NAME, _, COST, QUANTITY, LOCATION)}.
totalSum(S) :- S = #sum{AMOUNT : refund(NAME, AMOUNT)}.
#minimise {T-S: totalPrice(T), totalSum(S)}.

#show exceed/2.
#show wanted/3.
#show pick/5.
#show refund/2.
% #show totalPrice/1.

