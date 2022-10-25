% Discard models containing items we havent picked. pick(pipe a), model(pipe B) will be discarded

{pick(NAME, COST, QUANTITY, LOCATION) : part(NAME, COST, QUANTITY, LOCATION)}.

% Constraints to satisfy:
% Must have sufficient amount of each part required

% Cost of product must be less than given limit

% Can only contain allowed locations

% Minimise cost
