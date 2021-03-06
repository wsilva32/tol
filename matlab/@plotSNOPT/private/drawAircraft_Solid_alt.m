%PlotSNOPT/drawAircraft_Solid PlotSNOPT class aircraft plotting function.
%   drawAircraft_Solid( ~ ) plots the aircraft 3D trajectory and state history
%
%
%   unknown 04-30-15


function handle = drawAircraft_Solid_alt(self,uu,h)
%*=+--+=#=+--      EA-DDDAS Trajectory Optimization Layer         --+=#=+--+=#*%
%          Copyright (C) 2015 Regents of the University of Colorado.           %
%                             All Rights Reserved.                             %
%                                                                              %
%    This program is free software: you can redistribute it and/or modify      %
%    it under the terms of the GNU General Public License version 2 as         %
%    published by the Free Software Foundation.                                %
%                                                                              %
%    This program is distributed in the hope that it will be useful,           %
%    but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%    GNU General Public License for more details.                              %
%                                                                              %
%    You should have received a copy of the GNU General Public License         %
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.     %
%                                                                              %
%           Will Silva                                                         %
%           william.silva@colorado.edu                                         %
%                                                                              %
%*=+--+=#=+--                 --+=#=+--+=#=+--                    --+=#=+--+=#*%

    % process inputs to function
    pn       = uu(1);       % inertial North position     
    pe       = uu(2);       % inertial East position
    pd       = uu(3);            
    phi      = uu(4);       % roll angle         
    theta    = uu(5);       % pitch angle     
    psi      = uu(6);       % yaw angle
    

    
    
    [V,F,patchcolors] = DefineAirframe;
    
    % first time function is called, initialize plot and persistent vars
    
    set(0, 'currentfigure', h);
    %figure(h,'visibility','off');
    %hold on
    handle = drawSpacecraftBody(V,F,patchcolors,...
        pn,pe,pd,phi,theta,psi,...
        [],'normal');

end

%=======================================================================
% Define Airframe
% Defines 3d point locations and patches for aircraft model
%=======================================================================
%

function [V,F,patchcolors] = DefineAirframe()
%==========================================================================
% Define geometric terms
%==========================================================================
scale = 0.4;
fuse_I1 = 6*scale;        % Length from origin to nose cone
fuse_I2 = 3*scale;        % Length from origin to start of nose cone
fuse_I3 = 10*scale;       % Length from origin to end of tail
fuse_h = 1*scale;         % Max height of fuselage
fuse_w = 1.3*scale;         % Max width of fuselage
tailwing_w = 4*scale;     % Span of horizontal tail
tail_h = 3*scale;         % Height of vertical tail
tailwing_I = 1*scale;     % Chord of horizontal tail
wing_w = 20*scale;        % Wing span
wing_I = -0.2*scale;         % Chord of wing
p1.z = .5*scale;          % Z position of nose cone tip

%==========================================================================
% Define nose cone and fuselage
%==========================================================================

%------------
% Define nose cone/fuselage points
p17.x = 0;
p17.y = 0;
p17.z = 0;
p1.x = fuse_I1;
p1.y = 0;
p2.x = fuse_I2;
p2.y = fuse_w/2;
p2.z = -fuse_h/2;
p3.x = p2.x;
p3.y = -p2.y;
p3.z = p2.z;
p4.x = p3.x;
p4.y = p3.y;
p4.z = -p3.z;
p5.x = p2.x;
p5.y = p2.y;
p5.z = -p2.z;
p6.x = -fuse_I3;
p6.y = 0;
p6.z = -fuse_h/2;

%==========================================================================
% Define tail
%==========================================================================

%------------
% Define tail points
p11.x = -(fuse_I3 - tailwing_I);
p11.y = tailwing_w/2;
p11.z = -fuse_h/2;
p12.x = -fuse_I3;
p12.y = tailwing_w/2;
p12.z = -fuse_h/2;
p13.x = p12.x;
p13.y = -p12.y;
p13.z = -fuse_h/2;
p14.x = p11.x;
p14.y = -p11.y;
p14.z = -fuse_h/2;
p15.x = p11.x;
p15.y = 0;
p15.z = -fuse_h/2;
p16.x = p6.x;
p16.y = 0;
p16.z = -tail_h;

%==========================================================================
% Define wing
%==========================================================================

%------------
% Define wing points
p7.x = 0;
p7.y = wing_w/2;
p7.z = 0;
p8.x = fuse_I2;
p8.y = p7.y;
p8.z = -fuse_h/2;
p9.x = fuse_I2;
p9.y = -p8.y;
p9.z = -fuse_h/2;
p10.x = 0;
p10.y = p9.y;
p10.z = 0;
p18.x = -wing_I;
p18.y = -fuse_w/2;
p18.z = -fuse_h/2;
p19.x = -wing_I;
p19.y = fuse_w/2;
p19.z = -fuse_h/2;
p20.x = -wing_I;
p20.y = wing_w/2;
p20.z = -fuse_h/2;
p21.x = -wing_I;
p21.y = -wing_w/2;
p21.z = -fuse_h/2;

%==========================================================================
% Plot points
%==========================================================================

pts = [...
       p6.x p6.y p6.z;...
       p2.x p2.y p2.z;...
       p1.x p1.y p1.z;...
       p3.x p3.y p3.z;...
       p6.x p6.y p6.z;... 
       p4.x p4.y p4.z;...
       p1.x p1.y p1.z;... 
       p5.x p5.y p5.z;... 
       p2.x p2.y p2.z;... 
       p3.x p3.y p3.z;... 
       p4.x p4.y p4.z;... 
       p5.x p5.y p5.z;... 
       p6.x p6.y p6.z;...
       p12.x p12.y p12.z;...
       p11.x p11.y p11.z;...
       p14.x p14.y p14.z;...
       p13.x p13.y p13.z;...
       p6.x p6.y p6.z;...
       p16.x p16.y p16.z;...
       p15.x p15.y p15.z;...
       p17.x p17.y p17.z;...
       p7.x p7.y p7.z;...
       p8.x p8.y p8.z;...
       p9.x p9.y p9.z;...
       p10.x p10.y p10.z;...
       p7.x p7.y p7.z;...
       ]';
   
V = [ ...
    p1.x p1.y p1.z;...
    p2.x p2.y p2.z;...
    p3.x p3.y p3.z;...
    p4.x p4.y p4.z;...
    p5.x p5.y p5.z;...
    p6.x p6.y p6.z;...
    p7.x p7.y p7.z;...
    p8.x p8.y p8.z;...
    p9.x p9.y p9.z;...
    p10.x p10.y p10.z;...
    p11.x p11.y p11.z;...
    p12.x p12.y p12.z;...
    p13.x p13.y p13.z;...
    p14.x p14.y p14.z;...
    p15.x p15.y p15.z;...
    p16.x p16.y p16.z;...
    p17.x p17.y p17.z;...
    p18.x p18.y p18.z;...
    p19.x p19.y p19.z;...
    p20.x p20.y p20.z;...
    p21.x p21.y p21.z;...
    ];
   
F = [...
    1 2 3;...
    1 3 4;...
    1 4 5;...
    1 2 5;...
    2 3 6;... 
    3 4 6;...
    4 5 6;...
    2 5 6;...
    6 15 16;...
    6 12 15;...
    12 11 15;...
    6 15 13;...
    13 14 15;...
    3 8 18 ;...
    2 9 19;...
    9 19 21;...
    8 18 20;...
    ];

% define colors for each face    
  myred = [1, 0, 0];
  mygreen = [0, 1, 0];
  myblue = [0.8, 0.8, 0.8];
  myyellow = [0.6, 0.6, 0.6];
  mycyan = [0, 1, 1];
  myblack = [0.2, 0.2, 0.2];
  mywhite = [1, 1, 1];
  mygray = [0.4, 0.4, 0.4];

  patchcolors = [...
    mygray;...    
    myyellow;...  
    myblue;...   
    myyellow;... 
    mygray;...   
    myyellow;...   
    myblue;...
    myyellow;...
    myblack;...
    myblack;...
    myblack;...
    myblack;...
    myblack;...
    myblack;...
    myblack;...
    myblack;...
    myblack;...
    ];
end

  
%=======================================================================
% drawSpacecraft
% return handle if 3rd argument is empty, otherwise use 3rd arg as handle
%=======================================================================
%
function handle = drawSpacecraftBody(V,F,patchcolors,...
                                     pn,pe,pd,phi,theta,psi,...
                                     handle,mode)
  V = rotate(V', phi, theta, psi)';  % rotate spacecraft
  V = translate(V', pn, pe, pd)';  % translate spacecraft
  V = NEDtoENU(V')';
  
  if isempty(handle),
  handle = patch('Vertices', V, 'Faces', F,...
                 'FaceVertexCData',patchcolors,...
                 'FaceColor','flat');
  else
    set(handle,'Vertices',V,'Faces',F);
    drawnow
  end
end

%%%%%%%%%%%%%%%%%%%%%%%
function XYZ=rotate(XYZ,phi,theta,psi)
  % define rotation matrix
  R_pitch = [...
          1, 0, 0;...
          0, cos(phi), -sin(phi);...
          0, sin(phi), cos(phi)];
  R_roll = [...
          cos(theta), 0, sin(theta);...
          0, 1, 0;...
          -sin(theta), 0, cos(theta)];
  R_yaw = [...
          cos(psi), -sin(psi), 0;...
          sin(psi), cos(psi), 0;...
          0, 0, 1];
  R = R_yaw*R_pitch*R_roll;
  
  
  % rotate vertices
  XYZ = R*XYZ;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% translate vertices by pn, pe, pd
function XYZ = translate(XYZ,pn,pe,pd)

  %Plot as ENU
  XYZ = XYZ + repmat([pn;pe;pd],1,size(XYZ,2));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rotate NED to ENU frame
function XYZ = NEDtoENU(XYZ)
  R_x = [...
          cos(pi), 0, sin(pi);...
          0, 1, 0;...
          -sin(pi), 0, cos(pi)];
      
 R_z = [...
      cos(-pi/2), -sin(-pi/2), 0;...
      sin(-pi/2), cos(-pi/2), 0;...
      0, 0, 1];   
      
      
  XYZ = R_z*R_x*XYZ;

end

  
