
% FROM https://ia801604.us.archive.org/21/items/RFCircuitDesign2ndEdition/RF%20Circuit%20Design%20-%202nd%20Edition.pdf
% Page 143
% Given S-parameter values @5.32 GHz
S11 = 0.77647251 * exp(1j * deg2rad(-65.628983));
S21 = 4.297 * exp(1j * deg2rad(82.71));
S12 = 0.069 * exp(1j * deg2rad(21.97));
S22 = 0.503 * exp(1j * deg2rad(-77.55));

S11 = 0.4 * exp(1j * deg2rad(162));
S21 = 5.2 * exp(1j * deg2rad(63));
S12 = 0.04 * exp(1j * deg2rad(60));
S22 = 0.35 * exp(1j * deg2rad(-39));

% Characteristic impedance
Z0 = 50;

Ds = S11*S22-S12*S21;
k = (1+abs(Ds)^2-abs(S11)^2-abs(S22)^2)/(2*abs(S21)*abs(S12));

B1=1+abs(S11)^2-abs(S22)^2-abs(Ds)^2;

% work out whether to add or subtract the radical
s = 1;
if(B1>0)
s=-1;
endif

MAG = 10*log10(abs(S21)/abs(S12)) + s*10*log10(abs(k+sqrt(k^2-1)));

C2=S22-(Ds*conj(S11));
B2=1+abs(S22)^2-abs(S11)^2-abs(Ds)^2;


% work out whether to add or subtract the radical
s = 1;
if(B2>0)
s=-1;
endif

mag_gamma_L = (B2 + s*sqrt(B2^2-4*abs(C2)^2))/(2*abs(C2));
ang_gamma_L = angle(C2)*180/pi*(-1);
gamma_L = mag_gamma_L * exp(1j * deg2rad(ang_gamma_L))

gamma_S=conj(S11+(S12*S21*gamma_L)/(1-gamma_L*S22));
mag_gamma_S =  abs(gamma_S);
ang_gamma_S = angle(gamma_S)*180/pi;

disp(["Rollet Stability Factor K is : ",num2str(k)]);
if(k<1)
  disp("Warning, K is less than one!");
endif
disp(["Max available gain: ",num2str(MAG)," dB"]);
disp("Load Reflection Coefficent:");
disp(["Magnitude: ",num2str(mag_gamma_L)," Angle: ",num2str(ang_gamma_L)]);
disp("Surce Reflection Coefficent:");
disp(["Magnitude: ",num2str(mag_gamma_S)," Angle: ",num2str(ang_gamma_S)]);

function retval = gammaToImpedance(Z0,gamma)
  imp=Z0* (1+gamma)/(1-gamma);
  retval = imp;
  return;
endfunction

<<<<<<< Updated upstream

input = gammaToImpedance(Z0,S11);

% Display the result
disp('Input Impedance:');
disp(['Real part: ', num2str(real(input)), ' ohms']);
disp(['Imaginary part: ', num2str(imag(input)), ' ohms']);
=======
function out = polarPrint(A)
    absA = abs(A);
    phaseA = angle(A)*180/pi;
    out = arrayfun(@(x, y) sprintf('%f < %f', x, y), absA, phaseA, 'uni', 0);
endfunction


>>>>>>> Stashed changes



