%   ECGDEMO    ECG PROCESSING DEMONSTRATION - R-PEAKS DETECTION
%              
%              This file is a part of a package that contains 5 files:
%
%                     1. ecgdemo.m - main script file;
%                     2. ecgdemowinmax.m - (this file) window filter script file;
%                     3. ecgdemodata1.mat - first ecg data sample;
%                     4. ecgdemodata2.mat - second ecg data sample;
%                     5. readme.txt - description.
%
%              The package downloaded from http://www.librow.com
%              To contact the author of the sample write to Sergey Chernenko:
%              S.Chernenko@librow.com
%
%              To run the demo put
%
%                     ecgdemo.m;
%                     ecgdemowinmax.m;
%                     ecgdemodata1.mat;
%                     ecgdemodata2.mat;
%
%              in MatLab's "work" directory, run MatLab and type in
%
%                     >> ecgdemo
%
%              The code is property of LIBROW
%              You can use it on your own
%              When utilizing credit LIBROW site

function Filtered=ecgdemowinmax(Original, WinSize)

    WinHalfSize = floor(WinSize/2);
    WinHalfSizePlus = WinHalfSize+1;
    WinSizeSpec = WinSize-1;
    FrontIterator = 1;
    WinPos = WinHalfSize;
    WinMaxPos = WinHalfSize;
    WinMax = Original(1);
    OutputIterator = 0;
    for LengthCounter = 0:1:WinHalfSize-1
        if Original(FrontIterator+1) > WinMax
            WinMax = Original(FrontIterator+1);
            WinMaxPos = WinHalfSizePlus + LengthCounter;
        end
        FrontIterator=FrontIterator+1;
    end
    if WinMaxPos == WinHalfSize
        Filtered(OutputIterator+1)=WinMax;
    else
        Filtered(OutputIterator+1)=0;
    end
    OutputIterator = OutputIterator+1;
    for LengthCounter = 0:1:WinHalfSize-1
        if Original(FrontIterator+1)>WinMax
            WinMax=Original(FrontIterator+1);
            WinMaxPos=WinSizeSpec;
        else
            WinMaxPos=WinMaxPos-1;
        end
        if WinMaxPos == WinHalfSize
            Filtered(OutputIterator+1)=WinMax;
        else
            Filtered(OutputIterator+1)=0;
        end
        FrontIterator = FrontIterator+1;
        OutputIterator = OutputIterator+1;
    end
    for FrontIterator=FrontIterator:1:length(Original)-1
        if Original(FrontIterator+1)>WinMax
            WinMax=Original(FrontIterator+1);
            WinMaxPos=WinSizeSpec;
        else
            WinMaxPos=WinMaxPos-1;
            if WinMaxPos < 0
                WinIterator = FrontIterator-WinSizeSpec;
                WinMax = Original(WinIterator+1);
                WinMaxPos = 0;
                WinPos=0;
                for WinIterator = WinIterator:1:FrontIterator
                    if Original(WinIterator+1)>WinMax
                        WinMax = Original(WinIterator+1);
                        WinMaxPos = WinPos;
                    end
                    WinPos=WinPos+1;
                end
            end
        end
        if WinMaxPos==WinHalfSize
            Filtered(OutputIterator+1)=WinMax;
        else
            Filtered(OutputIterator+1)=0;
        end
        OutputIterator=OutputIterator+1;
    end
    WinIterator = WinIterator-1;
    WinMaxPos = WinMaxPos-1;
    for LengthCounter=1:1:WinHalfSizePlus-1
        if WinMaxPos<0
            WinIterator=length(Original)-WinSize+LengthCounter;
            WinMax=Original(WinIterator+1);
            WinMaxPos=0;
            WinPos=1;
            for WinIterator=WinIterator+1:1:length(Original)-1
                if Original(WinIterator+1)>WinMax
                    WinMax=Original(WinIterator+1);
                    WinMaxPos=WinPos;
                end
                WinPos=WinPos+1;
            end
        end
        if WinMaxPos==WinHalfSize
            Filtered(OutputIterator+1)=WinMax;
        else
            Filtered(OutputIterator+1)=0;
        end
        FrontIterator=FrontIterator-1;
        WinMaxPos=WinMaxPos-1;
        OutputIterator=OutputIterator+1;
    end
