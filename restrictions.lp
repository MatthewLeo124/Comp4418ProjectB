% #include "sample_data.txt".
% #include "wanted.txt".

% Generator
1 {pick(NAME, SIZE, COST, QUANTITY, LOCATION) : part(NAME, SIZE, COST, QUANTITY, LOCATION)}.

% Helper predicates
unit(X, T) :- wanted(X, _, _), T = #sum{QUANTITY, COST: pick(X, _, COST, QUANTITY, _)}.

:- pick(NAME, _, _, _, _), not wanted(NAME, _, _).

exceed(NAME, QUANT) :- wanted(NAME, _, QUANTWANTED),
unit(NAME, QUANTHAVE),
QUANTMAX = #max{QUANTITY, COST: pick(NAME, _, COST, QUANTITY, _)},
pick(NAME, _, _, QUANTMAX, _),
QUANT = QUANTHAVE - QUANTWANTED, 
QUANT>=0,
QUANT<=QUANTMAX.

:- wanted(NAME, _, _), not exceed(NAME, _).

refund(NAME, AMOUNT) :- exceed(NAME, QUANT), 
PRICE = #max{COST: pick(NAME, _, COST, QUANTITY, _), QUANT <= QUANTITY}, 
pick(NAME, _, PRICE, _, _), 
AMOUNT = PRICE*QUANT.

price(NAME, AMOUNT) :- wanted(NAME, _, _),
AMOUNT = #sum{COST*QUANTITY: pick(NAME, _, COST, QUANTITY, _)}.

% Constraints to satisfy:
% Constraint 1: Must have sufficient amount of each part required
:- wanted(NAME, _, QUANTITYWANTED), unit(NAME, T), T < QUANTITYWANTED.

% Constraint 2: Total price for each wanted part must be less or equal to threshold
:- wanted(NAME, THRESHOLD, _), refund(NAME, AMOUNT), price(NAME, TP), TP - AMOUNT > THRESHOLD.

% Constraint 3: Can only contain allowed locations

% Constraint 4: Minimise cost
totalPrice(T) :- T = #sum {COST*QUANTITY : pick(NAME, _, COST, QUANTITY, LOCATION)}.
totalRefund(R) :- R = #sum{AMOUNT : refund(NAME, AMOUNT)}.
finalPrice(P) :- totalPrice(T), totalRefund(R), P = T - R.
#minimise {P: finalPrice(P)}.

% #show exceed/2.
#show wanted/3.
#show pick/5.
% #show refund/2.
#show finalPrice/1.