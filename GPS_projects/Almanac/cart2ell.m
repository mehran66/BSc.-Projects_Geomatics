function ELL=cart2ell(CART,ellips)

% CART2ELL performs transformation from cartesian coordinates to ellipsoidal coordinates on that
%          ellipsoid
% 
% ELL=cart2ell(CART,ellips)
% 
% Also necessary:   Ellipsoids.mat   (see beneath)
% 
% Inputs:  CART right-handed cartesian coordinates as nx3-matrix (X,Y,Z) [m]
%               3xn-matrices are allowed. Be careful with 3x3-matrices!
%        ellips the underlying ellipsoid as string in lower case letters, default is 'besseldhdn'
%               The ellipsoids are stored in the mat-File "Ellipsoids.mat" also as
%               cell-arrays named by the ellipsoid, e.g. 'bessel1841' or 'wgs84'.
%               The ellipsoid cell array fields are
%                    a  semimajor axis
%                    b  semiminor axis
%                    f  flattening
%                   
% Outputs:  ELL 3xn-matrix with ellipsoidal coordinates (longitude, latitude, ell. height)
%               in [degree, m]
%               Southern hemisphere is signalled by negative latitude.
% 
% cart2ell is meant for geodetic transformations, when global coordinates have to
% be transformed to some projection.
%         
% Ellipsoids.mat are used because several of my files and GUIs need that parameters. 
% I considered it a better way to add those definition files rather to hardcode it
% several times. Feel free to enter your own ellipsoids.
%
% See also: ell2proj, proj2ell, ell2cart, d3trafo, Ellipsoids, Projections

% Author:
% Peter Wasmeier, Technical University of Munich
% p.wasmeier@bv.tum.de
% Jan 18, 2006

% Do some input checking
if     (size(CART,1)~=3)&&(size(CART,2)~=3), error('Coordinate list CART must be a nx3-matrix!')
elseif (size(CART,1)==3)&&(size(CART,2)~=3), CART=CART';
end
if nargin<2,ellips='besseldhdn';end

% Load ellipsoids
load Ellipsoids;
if ~exist(ellips,'var'), error(['Ellipsoid ',ellips,' is not defined in Ellipsoids.mat - check your definitions!.'])
end
eval(['ell=',ellips,';']);

% Do calculations
ELL=zeros(size(CART));
% Longitude
ELL(:,1)=atan2(CART(:,2),CART(:,1))*180/pi;
ELL(ELL(:,1)<0,:)=ELL(ELL(:,1)<0,:)+360;

% Latitude
B0=atan2(CART(:,3),sqrt(CART(:,1).^2+CART(:,2).^2));
B=100*ones(size(B0));
e2=(ell.a^2-ell.b^2)/ell.a^2;
while(any(abs(B-B0)>1e-10))
    N=ell.a./sqrt(1-e2*sin(B0).^2);
    h=sqrt(CART(:,1).^2+CART(:,2).^2)./cos(B0)-N;
    B=B0;
    B0=atan((CART(:,3)./sqrt(CART(:,1).^2+CART(:,2).^2)).*(1-e2*N./(N+h)).^(-1));
end
ELL(:,2)=B*180/pi;
ELL(:,3)=h;