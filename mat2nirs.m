% Licensed under the MIT License. See LICENSE file for details.

df_raw=load('14_2.mat'); % df_1=load('run2.nirs', '-mat');
df = cell2mat(struct2cell(df_raw)); % get the raw data from the mat file
nirs_1 = df([1:17], [5000:end])'; % get the raw data, need to check the raw data structure

nirs = nirs_1(:, [1 2 4 6 8 10 12 14 16 3 5 7 9 11 13 15 17]); % change the sequence of the different channels to...
% match the raw data

n = struct; % build a struct
n.t = nirs(:,1); % get the time
n.d = nirs(:,2:17); % get the fnirs data
n.s = uint8(255 * mat2gray(zeros(length(n.d), 1))); % set the marker's array
n.s([70251-5000, 121830-5000, 173374-5000, 224878-5000, 276413-5000])=1;
n.aux = zeros(length(n.d), 1); % set the auxiliary variables

n.SD.nSrcs = 8; %set the nirs sturcture based on the fNRIs probe information. I used the Artinis Octamon fNIRs device
n.SD.nDets = 2;
n.SD.Lambda = [760 850];
n.SD.SpatialUnit = ('mm');

n.SD.DetPos = [47.77, 65.28, 7.28; -46.45, 67.76, 8.81];
n.SD.SrcPos = [63.88, 34.84, 28.34; 64.96, 45.02, -10.31; 22.07, 74.86, 31.03; 17.84, 84.96, -10.84;...
-10.81, 77.96, 32.10; -15.96, 85.24, -7.41; -61.78, 40.78, 29.92; -65.28, 48.14, -10.73];

n.SD.MeasList = int32([...
   1, 1, 1, 1; 1, 1, 1, 2; 2, 1, 1, 1; 2, 1, 1, 2;...
   3, 1, 1, 1; 3, 1, 1, 2; 4, 1, 1, 1; 4, 1, 1, 2;...
   5, 2, 1, 1; 5, 2, 1, 2; 6, 2, 1, 1; 6, 2, 1, 2;...
   7, 2, 1, 1; 7, 2, 1, 2; 8, 2, 1, 1; 8, 2, 1, 2]);

save('14_2.nirs', '-struct', 'n');
