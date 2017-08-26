%CONFIG SCRIPT - This script sets up all the parameters for the simulation (H1 line)
% All the parameters are stored in the "settings" structure.
%

% TODO: GUI to fill automatically this configuration script

% Author: Ruben Di Battista
% Skyward Experimental Rocketry | CRD Dept | crd@skywarder.eu
% email: ruben.dibattista@skywarder.eu
% Website: http://www.skywarder.eu
% License: 2-clause BSD

% Author: Francesco Colombi
% Skyward Experimental Rocketry | CRD Dept | crd@skywarder.eu
% email: francesco.colombi@skywarder.eu
% Release date: 16/04/2016

% clear all
% close all
% clc

% ROCKET NAME
settings.rocket_name = 'R2A';

% GEOMETRY DETAILS %
% This parameters should be the same parameters set up in MISSILE DATCOM
% simulation.

settings.C = 0.174;     %m      Caliber (Fuselage Diameter)
settings.S = 0.02378;   %m2     Cross-sectional Surface
L = 4.4;              %m        Rocket length

% MASS GEOMERTY DETAILS %
% x-axis: along the fuselage
% y-axis: right wing
% z-axis: downward

% % Note: inerzias are used in "apogee_reached.m"
% % HP: rocket inertias = full finite cilinder inertias
% settings.Ixxf=settings.m0*(settings.C/2)^2/2; %Inertia to x-axis (Full)
% settings.Ixxe=settings.ms*(settings.C/2)^2/2; %Inertia to x-axis (Empty)
% settings.Iyyf=settings.m0.*((settings.C/2)^2/4 + L^2/3); %Inertia to y-axis (Full)
% settings.Iyye=settings.ms.*((settings.C/2)^2/4 + L^2/3); %Inertia to y-axis (Empty)
% settings.Izzf=settings.Iyyf; %Inertia to z-axis (Full)
% settings.Izze=settings.Iyye; %Inertia to z-axis (Empty)


% inertias first approximation
settings.Ixxf = 0.27;  %kg*m2 Inertia to x-axis (Full)
settings.Ixxe = 0.21;  %kg*m2 Inertia to x-axis (Empty)
settings.Iyyf = 86.02; %kg*m2 Inertia to y-axis (Full)
settings.Iyye = 66.84; %kg*m2 Inertia to y-axis (Empty)
settings.Izzf = 86.02; %kg*m2 Inertia to z-axis (Full)
settings.Izze = 66.84; %kg*m2 Inertia to z-axis (Empty)

% AERODYNAMICS DETAILS %
% This coefficients are intended to be obtained through MISSILE DATCOM
% (than parsed with the tool datcom_parser.py)
% The files are stored in the ../data folder with a naming convention of
% rocket_name_full.mat | rocket_name_empty.mat
% e.g. R1X_full.mat etc..

%Relative Path of the data files (default: ../data/). Remember the trailing
% slash!!

DATA_PATH = '/data/';
filename = strcat(DATA_PATH, settings.rocket_name);

%Coefficients in full configuration (with all the propellant embarqued)
filename_full = strcat(filename,'_full.mat');
CoeffsF = load(filename_full,'Coeffs');
settings.CoeffsF = CoeffsF.Coeffs;
clear('CoeffsF');

%Coefficients in empty configuration (all the propellant consumed)
filename_empty = strcat(filename,'_empty.mat');
CoeffsE = load(filename_empty,'Coeffs');
settings.CoeffsE = CoeffsE.Coeffs;
clear('CoeffsE');

%Note: All the parameters (AoA,Betas,Altitudes,Machs) must be the same for
%empty and full configuration
s = load(filename_full,'State');
settings.Alphas = s.State.Alphas';
settings.Betas = s.State.Betas';
settings.Altitudes = s.State.Altitudes';
settings.Machs = s.State.Machs';
clear('s');


%PARACHUTES DETAILS %
%%% DROGUE 1 %%%
settings.para1.S = 5;               %m2   Surface
settings.para1.mass = 0.577;        %kg   Parachute Mass
settings.para1.CD = 0.8;            %Parachute Drag Coefficient
settings.para1.CL = 0;              %Parachute Lift Coefficient

%Altitude of Drogue 2 Opening
settings.zdrg2 = 5000;

%%% DROGUE 2 %%%
settings.para2.S = 17.5;            %m2   Surface
settings.para2.mass = 1.140;        %kg   Parachute Mass
settings.para2.CD = 0.59;           %Parachute Drag Coefficient
settings.para2.CL = 0;              %Parachute Lift Coefficient

%Altitude of Main Parachute Opening
settings.zmain = 2000;

%%% MAIN - ROGALLO %%%
%The drogue parachute effects are neglected

settings.para3.S = 15;              %m2   Surface
settings.para3.mass = 1.466;        %kg   Parachute Mass
settings.para3.CD = 0.4;            %Parachute Drag Coeff
settings.para3.CL = 0.8;            %Parachute Lift Coefficient

% INTEGRATION OPTIONS %
settings.ode.timeasc = 0:0.01:2000;  %sec   %Time span for ascend
settings.ode.timedrg1 = 0:0.01:2000; %sec   %Time span for drogue 1
settings.ode.timedrg2 = 0:0.01:2000; %sec   %Time span for drogue 2
settings.ode.timemain = 0:0.01:2000; %sec   %Time span for main (rogallo)
settings.ode.timedesc = 0:0.01:2000; %sec   %Time span for ballistic descent

settings.ode.optionsasc = odeset('AbsTol',1E-3,'RelTol',1E-3,...
    'Events',@apogee,'InitialStep',1); %ODE options for ascend

settings.ode.optionsdrg1 = odeset('AbsTol',1E-3,'RelTol',1E-3,...
    'Events',@drg2_opening); %ODE options for drogue

settings.ode.optionsdrg2 = odeset('AbsTol',1E-3,'RelTol',1E-3,...
    'Events',@main_opening); %ODE options for drogue

settings.ode.optionsmain = odeset('AbsTol',1E-3,'RelTol',1E-12,...
    'Events',@crash);        %ODE options for ascend

settings.ode.optionsdesc = odeset('AbsTol',1E-3,'RelTol',1E-12,...
    'Events',@crash);        %ODE options for ballistic descent

% STOCHASTIC DETAILS %
%If N>1 the stochastic routine is fired (different standard plots)
settings.stoch.N = 1;            % Number of iterations
settings.stoch.parallel = false; % Using parallel or not parallel

% PLOT DETAILS %
settings.plot = false;         % Set to True to Plot with default plots
settings.tSteps = 250;         % Set the number of time steps to visualize
settings.DefaultFontSize = 10; % Default font size for plot
settings.DefaultLineWidth = 1; % Default Line Width for plot
