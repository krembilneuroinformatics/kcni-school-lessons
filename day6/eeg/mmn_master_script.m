% --- Analysis script for MMN Roving EEG dataset --- %

% Indicate the path to the directory */day4/eeg on your PC:
% For example: maindir = 'C:\kcni-school-lessons\day4\eeg';
maindir = '/Users/drea/Documents/Courses/KCNISummerSchool/eeg';

% set all analysis options and provide the path to the data
options = mmn_set_analysis_options(maindir);

% create the folder structure needed for the full analysis, and fill with necessary raw data
mmn_setup_analysis_folder(options);

% run the full first-level analysis
% includes: data preparation, EEG preprocessing, ERPs, conversion to images, 1st level statistics
loop_mmn_subject_analysis(options); 
