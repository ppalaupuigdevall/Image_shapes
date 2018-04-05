%Author: Ponç Palau Puigdevall
%Subject: ICV 
%Description: This script tests the ransacfitlines2d method. Parameters th,
%s and d can be changed as desired. 
clear all;
%Read the image
ima_gray = rgb2gray(imread('HT1_DEMO.png'));

th = 0;
%We find all the points that are not black (th=0)
indexes = find(ima_gray > th);
[M, N] = size(ima_gray);
%We convert the indexes to subindexes, which we save in the positions array
[I, J] = ind2sub([M, N], indexes);
positions = [J I]';

%This code was implemented to check whether the points that are represented
%by the vector positions are well or not
% for i=1:length(I)
%     ima_gray = insertMarker(ima_gray, positions(:, i)', 'color', 'green');
% end

%s is the minimum number of points to define a line
s = 2;
%We try to fit the line using RANSAC
d = 2;
[V, L, inliers] = ransacfitlines2d(positions, d,0,s);

figure;
title('s = 3, d = 2');
imshow(ima_gray);
%In order to draw the lines on top of the picture
hold on;
%Draw the line that fits the RANSAC method
line([L(1,1),L(1,2)],[L(2,1),L(2,2)]);
%The line that returned the least squares method
line([V(1,1),V(2,1)],[V(1,2),V(2,2)],'color','green');
