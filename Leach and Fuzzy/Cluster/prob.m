function P = prob(r, p)
% Probability function for elect the node as CH
%   Input:
%       r     round no
%       p     p?
%   Example:
%       P = prob(1, 0.1);
%
% Mohammad Hossein Homaei, homaee@gmail.com, Homaei@wsnlab.org
% Ver 2. 06/2014
%
    if ~exist('p','var')
        p = 0.1;
    end
    
    P = p / (1-p * mod(r, round(1 / p)));
end