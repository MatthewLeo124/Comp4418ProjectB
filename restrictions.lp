#include "sample_data.txt".
#include "wanted.txt".

1 {pick(NAME, SIZE, COST, QUANTITY, LOCATION) : part(NAME, SIZE, COST, QUANTITY, LOCATION)}.


:- pick(NAME, _, _, _, _), not wanted(NAME, _, _).

% Constraints to satisfy:
% Must have sufficient amount of each part required
    %Consider the case where we can pick multiple suppliers to add up to our wanted quantity if one doesnt have it.
:- wanted(NAME, _, QUANTITYWANTED), T = #sum{QUANTITY: pick(NAME, _, _, QUANTITY,_)}, T < QUANTITYWANTED.

% Cost of product must be less than given limit
    %Can't pick a supplier if supplier costs more than our limit
%:- wanted(NAME, THRESHOLD, _), T = #sum{QUANTITY * COST: pick(NAME, _, COST, QUANTITY,_)}, T > THRESHOLD.

%:- wanted(NAME, THRESHOLD, QUANTITY1), TP = #sum{COST/QUANTITY: pick(NAME, _, COST, QUANTITY, _)},
%     CP = #count{COST/QUANTITY: pick(NAME, _, COST, QUANTITY, _)}, TP > THRESHOLD/QUANTITY1*CP.

%:- wanted(NAME, THRESHOLD, QUANTITY1), #min{COST/QUANTITY: pick(NAME, _, COST, QUANTITY, _)} > THRESHOLD/QUANTITY1.

% Can only contain allowed locations

% Minimise cost
    %How to represent an unknown fraction of each pick to optimise for?
    %For basic examples this work, shouldn't be too hard to break though.
totalPrice(T) :- T = #sum {COST*QUANTITY : pick(NAME, _, COST, _, LOCATION), wanted(NAME, _, QUANTITY)}.
#minimise {T: totalPrice(T)}.

%Discard models containing items we havent picked. pick(pipe a), model(pipe B) will be discarded
% :- pick(NAME, SIZE, COST, QUANTITY, LOCATION), not wanted(NAME, THRESHOLD, QUANTITY1).

%Minimise shipping cost, as well as total part cost
%Minimise shipping time
%Discard models that take too long to ship out (longer than 3 months? or user defined limit)

%#show wanted/3.
#show pick/5.
