#include "data.txt".
#include "wanted.txt".

1 {pick(NAME, SIZE, COST, QUANTITY, LOCATION) : part(NAME, SIZE, COST, QUANTITY, LOCATION)} 2.

% Constraints to satisfy:
% Must have sufficient amount of each part required
    %Consider the case where we can pick multiple suppliers to add up to our wanted quantity if one doesnt have it.

% Cost of product must be less than given limit
    %Can't pick a supplier if supplier costs more than our limit
:- pick(NAME, SIZE, COST, QUANTITY, LOCATION), wanted(NAME, THRESHOLD, QUANTITY1), THRESHOLD > COST.

%Throw away models that don't pick what we want
:- not pick(NAME, SIZE, COST, QUANTITY, LOCATION), wanted(NAME, THRESHOLD, QUANTITY1).

% Can only contain allowed locations

% Minimise cost


%Discard models containing items we havent picked. pick(pipe a), model(pipe B) will be discarded
% :- pick(NAME, SIZE, COST, QUANTITY, LOCATION), not wanted(NAME, THRESHOLD, QUANTITY1).

%Minimise shipping cost, as well as total part cost
%Minimise shipping time
%Discard models that take too long to ship out (longer than 3 months? or user defined limit)

#show wanted/3.
#show pick/5.
