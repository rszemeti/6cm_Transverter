
% FROM https://ia801604.us.archive.org/21/items/RFCircuitDesign2ndEdition/RF%20Circuit%20Design%20-%202nd%20Edition.pdf
% Page 143
% Given S-parameter values @5.32 GHz
% 5300000000
%11 0.77647251 -65.628983
%21 5.8355913 101.51994
%12 0.056924067 52.496284
%22 0.52234888 -36.645409


%S11 = 0.77647251 * exp(1j * deg2rad(-65.628983));
%S21 = 5.8355913 * exp(1j * deg2rad(101.51994));
%S12 = 0.056924067 * exp(1j * deg2rad(52.496284));
%S22 = 0.52234888 * exp(1j * deg2rad(-36.645409));

%SAV541+ 60mA, 5.0 GHz
S11 = 0.68 * exp(1j * deg2rad(112.7));
S21 = 3.1 * exp(1j * deg2rad(11.2));
S12 = 0.105 * exp(1j * deg2rad(4.8));
S22 = 0.20 * exp(1j * deg2rad(125.6));

% test data from the book

%S11 = 0.4 * exp(1j * deg2rad(162));
%S21 = 5.2 * exp(1j * deg2rad(63));
%S12 = 0.04 * exp(1j * deg2rad(60));
%S22 = 0.35 * exp(1j * deg2rad(-39));



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

gamma_L = (B2 + s*sqrt(B2^2-4*abs(C2)^2))/(2*abs(C2));
mag_gamma_L = abs(gamma_L);
ang_gamma_L = angle(C2)*180/pi*(-1);
gamma_L = mag_gamma_L * exp(1j * deg2rad(ang_gamma_L));
imp_l = gammaToImpedance(Z0,gamma_L);

gamma_S=conj(S11+(S12*S21*gamma_L)/(1-(gamma_L*S22)));

mag_gamma_S =  abs(gamma_S);
ang_gamma_S = angle(gamma_S)*180/pi;

imp_s = gammaToImpedance(Z0,gamma_S);


disp(["Rollet Stability Factor K is : ",num2str(k)]);
if(k<1)
  disp("Warning, K is less than one!");
endif
disp(["Max available gain: ",num2str(MAG)," dB"]);
disp("Load Reflection Coefficent:");
disp(["Magnitude: ",num2str(mag_gamma_L)," Angle: ",num2str(ang_gamma_L)]);
disp(["Load impedance: ",num2str(real(imp_l)),", ",num2str(imag(imp_l)),"j"]);

disp("Source Reflection Coefficent:");
disp(["Magnitude: ",num2str(mag_gamma_S)," Angle: ",num2str(ang_gamma_S)]);
disp(["Source impedance: ",num2str(real(imp_s)),", ",num2str(imag(imp_s)),"j"]);

function retval = gammaToImpedance(Z0,gamma)
  imp=Z0* (1+gamma)/(1-gamma);
  retval = imp;
endfunction

