%PlotSNOPT PlotSNOPT class constructor.
%   obj = PlotSNOPT(file) creates a PlotSNOPT object using a json file
%   generated by a SNOPT run or load a saved .mat file
%
%   Example:
%
%       obj = PlotSNOPT;
%       OR
%       obj = PlotSNOPT('./some-mat-file.mat');
%
%  silvaw 04-30-15
classdef plotSNOPT
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
    properties
        simdata;
        legs = struct([]);
        array;
    end

    methods
        function obj = plotSNOPT(filepath) 
            % .mat or .json?
            [~,~,ext] = fileparts(filepath);
            if strcmp(ext,'.mat')
                load([load_path load_name]);
            else
                %load jsonlab toolbox
                addpath('./jsonlab');
                %load results
                jsondata = loadjson(filepath);
                if isfield(jsondata,'leg1') %check if json is multi-legged
                    legfields = fieldnames(jsondata);
                    for i = 1:numel(legfields)
                        temp{i} = struct(jsondata.(legfields{i}));
                    end
                    obj.legs = horzcat(temp{:});
                else
                    obj.legs = struct(jsondata);
                end
            end
      end

        
        %PlotSNOPT/save PlotSNOPT class save method.
        %save() saves the PlotSNOPT object to a .mat file
        %
        %   Example:
        %
        %       obj.save;
        function save(self)
            save_name = uiputfile('./Stored/*.mat');
            save(['./Stored/',save_name],'self','save_name');
        end
    end
    
    methods(Static = true)
        %PlotSNOPT/load PlotSNOPT class save method.
        %load() saves the PlotSNOPT object to a .mat file
        %
        %   Example:
        %
        %       obj.load;
        function obj = load(self)
            [load_name,load_path] = uigetfile();
            load([load_path, load_name],'self');
            obj = self;
        end
        
        
        
        %PlotSNOPT/plotnow static function
        %   plotnow(~) creates refreshing plot of SNOPT trajectories while SNOPT is
        %   running
        %
        %   Example:
        %
        %       plotSNOPT.plotnow;
        %
        %  silvaw 04-30-15
        function plotnow(rootpath)
            if nargin < 1
                rootpath = '..';
            end

        counter = 0;
        frames = 1;
        i = 1;

        unix(['rm ', rootpath, '/Xoutput.txt']);
        unix(['touch ', rootpath, '/Xoutput.txt']);
        filedata = dir([rootpath, '/Xoutput.txt']);
        old_datenum=filedata.datenum;
        %unix('export LD_LIBRARY_PATH=/usr/lib32;./Debug/flightplan &')

        %figure('units','normalized','outerposition',[0 0 1 1])
        figure()


        while 1
            filedata = dir([rootpath, '/Xoutput.txt']);
            if filedata.datenum ~= old_datenum
                pause(.001)
                old_datenum = filedata.datenum;
                %fid = fopen([rootpath, '/Xoutput.txt']);
                %cost = fgetl(fid);
                data(:,i) = csvread([rootpath, '/Xoutput.txt']);
                i = i + 1;
                if i > 5 %only store 5 latest trajectories
                    i = 1;
                end
                clf;
                %hAx1 = subplot(221); grid on
                for j = 1:size(data,2) %plot 5 latest
                    hh(j) = plot3(data(2:11:end,j),data(3:11:end,j),-data(4:11:end,j));
                    axis([-80 80 -80 80 -80 80]), axis equal
                    hold on
                end
                %h(j+1)=plot3(xcc,ycc,0.*ones(100,1),'g--','LineWidth',2);
                %hAx2 = subplot(222); axis equal; copyobj(h,hAx2); view(0,90), title('X-Y')
                %hAx3 = subplot(223); axis equal; copyobj(h,hAx3); view(0,0), title('X-Z')
                %hAx4 = subplot(224); axis equal; copyobj(h,hAx4); view(90,0), title('Y-Z')
                %suptitle(num2str(cost));
                grid on;
                drawnow;
                hold off
                M(frames) = getframe(gcf);

                counter = 0;
                frames = frames + 1;
            else
                pause(.001)
            end
            if counter >= 5000
                break;
            end
            counter = counter + 1;
        end

        % figure
        % axes('pos',[0 0 1 1],'visible','off'); 
        % movie(M,1,1)

        end
    end
    
end


