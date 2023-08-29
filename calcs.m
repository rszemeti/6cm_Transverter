% Given S-parameter values @5.32 GHz
S11 = 0.77647251 * exp(1j * deg2rad(-65.628983));
S21 = 4.297 * exp(1j * deg2rad(82.71));
S12 = 0.069 * exp(1j * deg2rad(21.97));
S22 = 0.503 * exp(1j * deg2rad(-77.55));

% Characteristic impedance
Z0 = 50;


function retval = gammaToImpedance(Z0,gamma)
  imp=Z0* (1+gamma)/(1-gamma);
  retval = imp;
  return;
endfunction


input = gammaToImpedance(Z0,S11);

% Display the result
disp('Input Impedance:');
disp(['Real part: ', num2str(real(input)), ' ohms']);
disp(['Imaginary part: ', num2str(imag(input)), ' ohms']);



