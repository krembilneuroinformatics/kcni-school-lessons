function plotRTECG(idxTPeak, ecg)

 figure, 
 plot(ecg)
 hold on,
 plot(idxTPeak, ecg(idxTPeak),'ro')

idxstop = round(length(ecg)/5);
idxstop2 = round(length(ecg)/5)*2;
idxstop3 = round(length(ecg)/5)*3;
idxstop4 = round(length(ecg)/5)*4;
idxstop5 = length(ecg);

figure, 
subplot(3,3,1),
plot(ecg(1:idxstop))
iT1 = idxTPeak(idxTPeak<idxstop);
hold on,
plot(iT1, ecg(iT1),'ro')

subplot(3,2,2),
plot(ecg(idxstop+1:idxstop2))
iT1 = idxTPeak(idxTPeak>=idxstop & idxTPeak<idxstop2);
hold on,
plot(iT1-idxstop, ecg(iT1),'ro')

subplot(3,2,3),
plot(ecg(idxstop2+1:idxstop3))
iT1 = idxTPeak(idxTPeak>=idxstop2 & idxTPeak<idxstop3);
hold on,
plot(iT1-idxstop2, ecg(iT1),'ro')

subplot(3,2,4),
plot(ecg(idxstop3+1:idxstop4))
iT1 = idxTPeak(idxTPeak>=idxstop3 & idxTPeak<idxstop4);
hold on,
plot(iT1-idxstop3, ecg(iT1),'ro')

subplot(3,2,5),
plot(ecg(idxstop4+1:idxstop5))
iT1 = idxTPeak(idxTPeak>=idxstop4 & idxTPeak<idxstop5);
hold on,
plot(iT1-idxstop4, ecg(iT1),'ro')