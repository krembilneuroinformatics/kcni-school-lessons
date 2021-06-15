function [diffRT] = calcTtoR(idxRPeak, idxTPeak, myTime)

RPeakTime = myTime(idxRPeak);
TPeakTime = myTime(idxTPeak);
diffRT = TPeakTime - RPeakTime;
figure, 
subplot(3,2,1),hist(diffRT, 18)
title('Histogram R to T')
subplot(3,2,2),hist(diff(RPeakTime))
title('Histogram R to R')
subplot(3,2,3:4),plot(diffRT,'-o')
xlim([0 length(diffRT)])
title('Time Series R to T')
subplot(3,2,5:6), plot(diff(RPeakTime), '-o')
title('Time Series R to R')
xlim([0 length(diff(RPeakTime))])

disp(['Mean diff R to T is: ', num2str(mean(diffRT)), ' s'])
disp(['Mode diff R to T is: ', num2str(mode(diffRT)), ' s'])