% Given S-parameter values @5.32 GHz

% 0.77647251 -65.628983
% 5.8355913 101.51994
% 0.056924067 52.496284
% 0.52234888 -36.645409

S11 = 0.776 * exp(1j * deg2rad(-65.62));
S21 = 5.835 * exp(1j * deg2rad(101.51));
S12 = 0.0569 * exp(1j * deg2rad(52.49));
S22 = 0.522 * exp(1j * deg2rad(-36.65));

% Characteristic impedance
Z0 = 50;


function retval = gammaToImpedance(Z0,gamma)
  imp=Z0* (1+gamma)/(1-gamma);
  retval = imp;
  return;
endfunction


input = gammaToImpedance(Z0,S11);
output = gammaToImpedance(Z0,S22);

% Display the result
disp('Input Impedance:');
disp(['Real part: ', num2str(real(input)), ' ohms']);
disp(['Imaginary part: ', num2str(imag(input)), ' ohms']);

% Display the result
disp('Output Impedance:');
disp(['Real part: ', num2str(real(output)), ' ohms']);
disp(['Imaginary part: ', num2str(imag(output)), ' ohms']);



