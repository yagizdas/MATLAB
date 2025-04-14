N = 10000; % Number of bits
bits = randi([0,1], N,1);
a_k = 2*bits - 1; % Mapping 0-1's to -1,1

L = 4;
X_upsampled = upsample(a_k,L);
M = X_upsampled;

gT = [1 1 1 1]; 
Xc = conv(X_upsampled,gT,'Same'); % Generating the Xc

nw = randn(40000,1); % Generating White Noise

y = Xc + nw;

sampled_y = downsample(y,L);

detected_bits = sampled_y > 0; %  Created the Decision rule 
DecisionRule_n_of_errors = sum(detected_bits ~= bits);
BER = DecisionRule_n_of_errors/length(bits)

Matched_Filter = [1 1 1 1];
r = conv(y, Matched_Filter, 'Same');

mf_sampled_y = downsample(r,L);

mf_detected_bits = mf_sampled_y > 0; %  Created the MF Decision rule 
MF_n_of_errors = sum(mf_detected_bits ~= bits) % Number of errors if we use a MF
MF_BER = MF_n_of_errors/length(bits)

% BER found with a MF is reasonabily better than without the usage of a
% matched filter.

%V1 = 4 V0 =-4 Therefore d = 8
%N = 2
BER_I = qfunc(2)

%When we use MF on the Noise, N becomes 4 
BER_J = qfunc(1)







