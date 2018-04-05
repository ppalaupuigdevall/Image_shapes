%Author: Ponç Palau
%Subject: ICV
%Description: This script finds the most common rotated line in a rotated
%picture and displays the picture in its original angle.

ima_gray = imread('rotated_building.png');
%Detect edges with Canny
BW = edge(ima_gray, 'canny', [0.2 0.4], 0.7);
%Compute the Hough transform once Canny has been applied
[H,theta,rho] = hough(BW);
%Find the peaks that are above 0.3*max(H)
P = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));

%The strategy that I followed is finding the theta value that appears most
%times. This is better than just taking the maximum of H because many lines
%with different rho but same theta can appear and this is the pattern for a
%rotation on an image.

%Count the number of times that a certain angle appears in the houghpeaks
%(the maximums that are over 0.3*Max(H))
comptador=histc(P(:,2),unique(P));
%We get the elements in P, the indexes of the theta vector
elements = unique(P);
%We get the maximum, the value of theta that appear more times in P
[maxi, posi] = max(comptador);
index_angle = elements(posi);
angle = theta(index_angle);
%We rotate the image according to the angle found
figure;
imshow(imrotate(ima_gray,angle))
fprintf("The image is rotated : %s degrees\n",  angle);


