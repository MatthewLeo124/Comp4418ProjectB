#include "SampleData1.lp".

% Generator
1 {pick(NAME, COMPANY, COST, QUANTITY, LOCATION) : part(NAME, COMPANY, COST, QUANTITY, LOCATION)}.

% Helper predicates
%Total price of the supplier picked, e.g. Supplier a 100 bolts at $20, unit(a, )
unit(X, T) :- wanted(X, _, _), T = #sum{QUANTITY, COST, COMPANY: pick(X, COMPANY, COST, QUANTITY, _)}.

%Calculate the supply of something left over from what we want to buy and the total amount the supplier has.
%E.g. we want 500 bolts, supplier A has 200, supplier B has 1000
% This predicate will return 700
exceed(NAME, QUANT) :- wanted(NAME, _, QUANTWANTED),
unit(NAME, QUANTHAVE),
QUANTMAX = #max{QUANTITY, COST: pick(NAME, _, COST, QUANTITY, _)},
pick(NAME, _, _, QUANTMAX, _),
QUANT = QUANTHAVE - QUANTWANTED, 
QUANT>=0,
QUANT<=QUANTMAX.

%We must calculate the exceeded amount for every item that we want.
:- wanted(NAME, _, _), not exceed(NAME, _).

%Calculate the $ amount to remove from the final price.
refund(NAME, AMOUNT) :- exceed(NAME, QUANT), 
PRICE = #max{COST: pick(NAME, _, COST, QUANTITY, _), QUANT <= QUANTITY}, 
pick(NAME, _, PRICE, _, _), 
AMOUNT = PRICE*QUANT.

%Total price of all suppliers and their costs from what we pick.
price(NAME, AMOUNT) :- wanted(NAME, _, _),
AMOUNT = #sum{COST*QUANTITY, COST, QUANTITY, COMPANY: pick(NAME, COMPANY, COST, QUANTITY, _)}.

% Constraints to satisfy:
% Constraint 1: Must have sufficient amount of each part required
:- wanted(NAME, _, QUANTITYWANTED), unit(NAME, T), T < QUANTITYWANTED.

% Constraint 2: Total price for each wanted part must be less or equal to threshold
:- wanted(NAME, THRESHOLD, _), refund(NAME, AMOUNT), price(NAME, TP), TP - AMOUNT > THRESHOLD.

% Constraint 3: Can only contain allowed locations
:- pick(NAME, _, _, _, LOCATION), banned(LOCATION).

% Constraint 4: Minimise cost
% Max price is used to slightly speed up resulting calculations
maxPrice(P) :- P = #sum{COST*QUANTITY, NAME, COMPANY, COST, QUANTITY, LOCATION : part(NAME, COMPANY, COST, QUANTITY, LOCATION), wanted(NAME, _, _)}.

totalPrice(T) :- maxPrice(P), T = #sum{AMOUNT, NAME: price(NAME, AMOUNT)}, T <= P.
totalRefund(R) :- maxPrice(P), R = #sum{AMOUNT, NAME : refund(NAME, AMOUNT)}, R <= P.
finalPrice(P) :- totalPrice(T), totalRefund(R), T >= R, P = T - R.
#minimise {P@2: finalPrice(P)}.

% Constraint 5: Minimise number of picks if price is tied
shippingCount(C) :- C = #count{NAME, COMPANY, COST, QUANTITY, LOCATION : pick(NAME, COMPANY, COST, QUANTITY, LOCATION)}.
#minimise {C@1: shippingCount(C)}.

#show wanted/3.
#show pick/5.
#show finalPrice/1.
