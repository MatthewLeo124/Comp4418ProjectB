

{pick(NAME, COST, QUANTITY, LOCATION) : part(NAME, COST, QUANTITY, LOCATION)}.

% Constraints to satisfy:
% Must have sufficient amount of each part required
:- pick(NAME, COST, QUANTITY, LOCATION), QUANTITY < threshold(X).

% Cost of product must be less than given limit
    %Can't pick a supplier if supplier costs more than our limit
:- pick(NAME, COST, QUANTITY, LOCATION), wanted(NAME, THRESHOLD, WQUANTITY), THRESHOLD < COST.
    %Can't pick a supplier if they don't have enough
    %Can figure out logic to choose both this and another supplier to add together to make the wanted quantity (WQUANTITY)
:- pick(NAME, COST, QUANTTIY, LOCATION), wanted(NAME, THRESHOLD, WQUANTITY), WQUANTITY > QUANTITY.


% Can only contain allowed locations

% Minimise cost


%Discard models containing items we havent picked. pick(pipe a), model(pipe B) will be discarded
:- pick(NAME, COST, QUANTITY, LOCATION), not wanted(NAME, THRESHOLD, QUANTITY).

%Minimise shipping cost, as well as total part cost
%Minimise shipping time
%Discard models that take too long to ship out (longer than 3 months? or user defined limit)