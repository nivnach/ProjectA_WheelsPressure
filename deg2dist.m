function [d1km d2km]=deg2dist(lat1,lon1,lat2,lon2)
% format: [d1km d2km]=deg2dist(lat1,lon1,lat2,lon2)
% Distance:
% d1km: distance in km based on Haversine formula
% (Haversine: http://en.wikipedia.org/wiki/Haversine_formula)
% d2km: distance in km based on Pythagoras theorem
% (see: http://en.wikipedia.org/wiki/Pythagorean_theorem)
% After:
% http://www.movable-type.co.uk/scripts/latlong.html
%
% --Inputs:
%   lat1,lon1: lat&lon of origin point
%   lat2,lon2: lat&lon of destination point
%
% --Outputs:
%   d1km: distance calculated by Haversine formula
%   d2km: distance calculated based on Pythagoran theorem
%--------------------------------------------------------------------------

radius=6371; %earth radius
%convert coordinates from degrees to radians
lat1=lat1*pi/180;
lat2=lat2*pi/180;
lon1=lon1*pi/180;
lon2=lon2*pi/180;
deltaLat=lat2-lat1;
deltaLon=lon2-lon1;
a=sin((deltaLat)/2)^2 + cos(lat1)*cos(lat2) * sin(deltaLon/2)^2;
c=2*atan2(sqrt(a),sqrt(1-a));
d1km=radius*c;    %Haversine distance

x=deltaLon*cos((lat1+lat2)/2);
y=deltaLat;
d2km=radius*sqrt(x*x + y*y); %Pythagoran distance

end
