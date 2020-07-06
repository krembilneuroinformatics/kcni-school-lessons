function tnueeg_struct2txtfile( structToBePrinted, nameOfStruct, textfile )
%TNUEEG_STRUCT2TXTFILE Prints a Matlab struct into a textfile.
%   This function prints the contents of a struct variable into a textfile,
%   using a line per field of the struct. If the file already exists, the
%   contents of the struct will be appendend at the end of the file.
%   IN:     structToBePrinted   - a Matlab struct
%           nameOfStruct        - string variable with name to be printed
%           textfile            - file name including path
%   OUT:    -

strArray = gencode(structToBePrinted, nameOfStruct);

nLines = numel(strArray);
fid = fopen(textfile, 'a');

for iLine = 1:nLines
    fprintf(fid, '%s\n', strArray{iLine});
end
fclose(fid);

end

