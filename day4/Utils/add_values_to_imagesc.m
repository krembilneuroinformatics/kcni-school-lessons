function add_values_to_imagesc(values)


textStrings = num2str(values(:), '%0.2f');       % Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));
[x, y] = meshgrid(1:size(values,1));  % Create x and y coordinates for the strings
hStrings = text(x(:), y(:), textStrings(:), ...  % Plot the strings
    'HorizontalAlignment', 'center');
midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range
% Choose white or black for the text color of the strings so
% they can be easily seen over the background color
textColors = repmat(values(:) > midValue, 1, 3);
set(hStrings, {'Color'}, num2cell(textColors, 2));  % Change the text colors