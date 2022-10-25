{pick(NAME, COST, QUANTITY, LOCATION) : part(NAME, COST, QUANTITY, LOCATION)}.

% Constraints to satisfy:
% Must have sufficient amount of each part required

% Cost of product must be less than given limit

% Can only contain allowed locations

% Minimise cost


%Discard models containing items we havent picked. pick(pipe a), model(pipe B) will be discarded
%Minimise shipping cost, as well as total part cost
%Minimise shipping time
%Discard models that take too long to ship out (longer than 3 months? or user defined limit)