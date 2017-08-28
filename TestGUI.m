function varargout = TestGUI(varargin)
% TESTGUI MATLAB code for TestGUI.fig
%      TESTGUI, by itself, creates a new TESTGUI or raises the existing
%      singleton*.
%
%      H = TESTGUI returns the handle to a new TESTGUI or the handle to
%      the existing singleton*.
%
%      TESTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTGUI.M with the given input arguments.
%
%      TESTGUI('Property','Value',...) creates a new TESTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TestGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TestGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TestGUI

% Last Modified by GUIDE v2.5 21-Aug-2017 13:20:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TestGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TestGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before TestGUI is made visible.
function TestGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TestGUI (see VARARGIN)

% Choose default command line output for TestGUI
handles.output = hObject;
handles.bool = 0;
handles.fired = 0;
set(0, 'DefaultFigureVisible', 'on')

% Update handles structure
guidata(hObject, handles);




% UIWAIT makes TestGUI wait for user response (see UIRESUME)
% uiwait(handles.UI);


% --- Outputs from this function are returned to the command line.
function varargout = TestGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in simulation.
function simulation_Callback(hObject, eventdata, handles)
% hObject    handle to simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.UI, 'HandleVisibility', 'off')
close all
set(handles.UI, 'HandleVisibility', 'on')
set(handles.logo_fig, 'Visible', 'off')
set(handles.hg_led, 'Visible', 'off')
set(handles.cross_led, 'Visible', 'on')
    
set(handles.cross_led, 'Visible', 'off')
set(handles.logo_fig, 'Visible', 'off')
set(handles.hg_led, 'Visible', 'on')
pause(eps)

set(0, 'DefaultFigureVisible', 'off')

run('config.m') 
settings.motor.exp_time = handles.engine.motor.exp_time;
settings.motor.exp_thrust = handles.engine.motor.exp_thrust;
settings.m0 = handles.engine.m0;
settings.ms = handles.engine.ms;
settings.mp = handles.engine.mp;
settings.tb = handles.engine.tb;
settings.mfr = handles.engine.mfr;

settings.z0 = handles.altitude;
settings.lrampa = handles.length;
settings.OMEGA = handles.elevation_L*pi/180;
settings.PHI = handles.azimuth_L*pi/180;
settings.wind.MagMin = handles.magnitude;
settings.wind.MagMax = handles.magnitude;
settings.wind.ElMin = handles.elevation_W*pi/180;
settings.wind.ElMax = handles.elevation_W*pi/180;
settings.wind.AzMin = (180 + handles.azimuth_W)*pi/180;
settings.wind.AzMax = (180 + handles.azimuth_W)*pi/180;
settings.ballistic = handles.bal;
bool = handles.bool;
run('start_simulation.m')

format longe

set(handles.text1, 'String', ['altitude = ', num2str(apogee_h), ' m'])
set(handles.text2, 'String', ['velocity = ', num2str(mod_V(i_apogee)), ' m/s'])
set(handles.text3, 'String', ['time = ', num2str(Ta(end)), ' sec'])

set(handles.text4, 'String', ['max speed = ', num2str(max_v), ' m/s'])
set(handles.text5, 'String', ['altitude = ', num2str(z(imax_v)), ' m'])
set(handles.text6, 'String', ['Mach = ', num2str(M(imax_v))])
set(handles.text7, 'String', ['time = ', num2str(T(imax_v)), ' sec'])

set(handles.text8, 'String', ['max Mach = ', num2str(max_M)])
set(handles.text9, 'String', ['altitude = ', num2str(z(imax_M)), ' m'])
set(handles.text10, 'String', ['velocity = ', num2str(mod_V(imax_M)), ' m/s'])
set(handles.text11, 'String', ['time = ', num2str(T(imax_M)), ' sec'])

set(handles.text12, 'String', ['max acceleration = ', num2str(max_a/9.80665), ' g'])
set(handles.text13, 'String', ['velocity = ', num2str(mod_V(imax_a)), ' m/s'])
set(handles.text14, 'String', ['time = ', num2str(T(imax_a)), ' sec'])

set(handles.text15, 'String', ['run on lunchpad = ', num2str( mod_X(iexit)), ' m'])
set(handles.text16, 'String', ['speed at lunchpad exit = ', num2str(mod_V(iexit)), ' m/s'])
set(handles.text17, 'String', ['time on lunchpad = ', num2str(T(iexit)), ' sec'])

set(handles.hg_led, 'Visible', 'off')
set(handles.logo_fig, 'Visible', 'on')

handles.f1 = figure(1);
set(handles.f1, 'Visible', 'off')
handles.f2 = figure(2);
set(handles.f2, 'Visible', 'off')
handles.f3 = figure(3);
set(handles.f3, 'Visible', 'off')
handles.f4 = figure(4);
set(handles.f4, 'Visible', 'off')
handles.f5 = figure(5);
set(handles.f5, 'Visible', 'off')
handles.f6 = figure(6);
set(handles.f6, 'Visible', 'off')
handles.f7 = figure(7);
set(handles.f7, 'Visible', 'off')
handles.f8 = figure(8);
set(handles.f8, 'Visible', 'off')
handles.f9 = figure(9);
set(handles.f9, 'Visible', 'off')
handles.f10 = figure(10);
set(handles.f10, 'Visible', 'off')
handles.f11 = figure(11);
set(handles.f11, 'Visible', 'off')
handles.f12 = figure(12);
set(handles.f12, 'Visible', 'off')
handles.f13 = figure(13);
set(handles.f13, 'Visible', 'off')
handles.f14 = figure(14);
set(handles.f14, 'Visible', 'off')

handles.fired = true;

guidata(hObject,handles);

clc

function altitude_Callback(hObject, eventdata, handles)
% hObject    handle to altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of altitude as text
%        str2double(get(hObject,'String')) returns contents of altitude as a double

handles.altitude = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function altitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function length_Callback(hObject, eventdata, handles)
% hObject    handle to length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of length as text
%        str2double(get(hObject,'String')) returns contents of length as a double
handles.length = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function elevation_L_Callback(hObject, eventdata, handles)
% hObject    handle to elevation_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elevation_L as text
%        str2double(get(hObject,'String')) returns contents of elevation_L as a double
handles.elevation_L = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function elevation_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elevation_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function azimuth_L_Callback(hObject, eventdata, handles)
% hObject    handle to azimuth_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of azimuth_L as text
%        str2double(get(hObject,'String')) returns contents of azimuth_L as a double
handles.azimuth_L = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function azimuth_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to azimuth_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function magnitude_Callback(hObject, eventdata, handles)
% hObject    handle to magnitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of magnitude as text
%        str2double(get(hObject,'String')) returns contents of magnitude as a double
handles.magnitude = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function magnitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to magnitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function elevation_W_Callback(hObject, eventdata, handles)
% hObject    handle to elevation_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elevation_W as text
%        str2double(get(hObject,'String')) returns contents of elevation_W as a double
handles.elevation_W = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function elevation_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elevation_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function azimuth_W_Callback(hObject, eventdata, handles)
% hObject    handle to azimuth_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of azimuth_W as text
%        str2double(get(hObject,'String')) returns contents of azimuth_W as a double
handles.azimuth_W = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function azimuth_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to azimuth_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in all_std.
function all_std_Callback(hObject, eventdata, handles)
% hObject    handle to all_std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of all_std
if get(hObject,'Value')
handles.altitude = 100;
handles.length = 6.5;
handles.elevation_L = 80;
handles.azimuth_L = 270;
handles.magnitude = 6;
handles.elevation_W = 0;
handles.azimuth_W = 135;
end
guidata(hObject,handles);
    


% --- Executes on button press in bal.
function bal_Callback(hObject, eventdata, handles)
% hObject    handle to bal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bal
if get(hObject,'Value')
handles.bal = 1;
end
guidata(hObject,handles);


% --- Executes on button press in std.
function std_Callback(hObject, eventdata, handles)
% hObject    handle to std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of std
if get(hObject,'Value')
handles.bal = 0;
end
guidata(hObject,handles);


% --- Executes on selection change in engine.
function engine_Callback(hObject, eventdata, handles)
% hObject    handle to engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns engine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from engine
str = get(hObject,'String');
val = get(hObject,'Value');

switch str{val}
    case 'White Thunder'
        % Cesaroni PRO 150 White Thunder
        % Sampling for thrust interpolation
        settings.motor.exp_time = [0 0.05 0.15 0.5 0.6 0.74 0.85 1.15 1.7 2.4 3 ...
            4 4.5 4.8 4.9 5 5.05 5.1 5.15 5.2]; %s
        settings.motor.exp_thrust = [8605.1 8900 7900 8400 8400 8250 8200 8300 ...
            8400 8400 8200 7800 7600 7450 7350 7300 4500 500 100 0]; %N

        settings.m0 = 67.761;                    %kg    Overall Mass (Burnout + Propellant)
        settings.ms = 43.961;                    %kg    Structural Mass (Burnout - Nosecone)
        settings.mp = 18.6;                      %kg    Propellant Mass
        settings.tb = 5.12;                      %sec   Burning Time
        settings.mfr = settings.mp/settings.tb;  %kg/s  Mass Flow Rate
    case 'Skid Mark'
        % Cesaroni PRO 150 SkidMark
        % Sampling for thrust interpolation
        settings.motor.exp_time = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.8 1.2 1.8 3.2 ...
            3.6 4.8 6 7 7.2 7.6 7.8 7.9 8 8.1 8.19]; %s
        settings.motor.exp_thrust = [0 3400 3100 3000 3300 3400 3500 3700 3700 ...
            3800 4000 4081.6 3900 3800 3700 3500 3350 3200 3000 2000 750 0]; %N

        settings.m0 = 64.9;                     %kg    Overall Mass 
        settings.ms = 46.8;                     %kg    Structural Mass (Burnout)
        settings.mp = settings.m0-settings.ms;  %kg    Propellant Mass
        settings.tb = 8.19;                     %sec   Burning Time
        settings.mfr = settings.mp/settings.tb; %kg/s  Mass Flow Rate
    case 'Blue Streak'
        % Cesaroni PRO 150 BlueStreak
        % Sampling for thrust interpolation
        settings.motor.exp_time =   [0 0.06 0.1 0.15 0.25 0.45 0.8  1     2    3 ...
            4     5   6   6.8  7.05 7.3 7.6 7.8]; %s
        settings.motor.exp_thrust = [0 800 4000 5500 5160 5130 5400 5300 5450 5347 ...
            5160 4950 4700 4400 4400 3800 300 0]; %N

        settings.m0 = 66.2;                      %kg   Overall Mass 
        settings.ms = 47.3;                      %kg   Structural Mass (Burnout)
        settings.mp = settings.m0-settings.ms;   %kg   Propellant Mass
        settings.tb = 7.60;                      %sec  Burning Time
        settings.mfr = settings.mp/settings.tb;  %kg/s Mass Flow Rate
    otherwise
end
handles.engine = settings;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function engine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in more_plots.
function more_plots_Callback(hObject, eventdata, handles)
% hObject    handle to more_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of more_plots
if get(hObject,'Value')
    handles.bool = 1;
end
guidata(hObject,handles);


% --- Executes when UI is resized.
function UI_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to UI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
screensize = get( groot, 'Screensize' );
set(gcf,'units','pixels','position',[screensize(3)/2 - 300,...
    screensize(4)/2 - 200, 600, 400])


% --- Executes on button press in close_plots.
function close_plots_Callback(hObject, eventdata, handles)
% hObject    handle to close_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.UI, 'HandleVisibility', 'off')
    close all
    set(handles.UI, 'HandleVisibility', 'on')
    set(handles.logo_fig, 'Visible', 'off')
    set(handles.hg_led, 'Visible', 'off')
    set(handles.cross_led, 'Visible', 'on')
    handles.fired = false;
end
guidata(hObject,handles);

% --- Executes on button press in data.
function data_Callback(hObject, eventdata, handles)
% hObject    handle to data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of data
if get(hObject,'Value')
    set(handles.data_panel, 'Visible', 'on')
    set(handles.data_panel,'units','pixels','position',[0, 0, 600, 400])
end


% --- Executes on button press in close_data.
function close_data_Callback(hObject, eventdata, handles)
% hObject    handle to close_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.data_panel, 'Visible', 'off')
end


% --- Executes during object creation, after setting all properties.
function logo_fig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logo_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate logo_fig
[im, ~, alpha] = imread('\gfx\logo.png');
f = imshow(im);
set(f, 'AlphaData', alpha);


% --- Executes during object creation, after setting all properties.
function cross_led_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cross_led (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate cross_led
[im, ~, alpha] = imread('\gfx\cross.png');
f = imshow(im);
set(f, 'AlphaData', alpha);
set(f, 'Visible', 'on')
handles.cross_led = f;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function hg_led_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hg_led (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate hg_led
[im, ~, alpha] = imread('\gfx\hg.png');
f = imshow(im);
set(f, 'AlphaData', alpha);
set(f, 'Visible', 'off')
handles.hg_led = f;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function check_led_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logo_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate logo_fig
[im, ~, alpha] = imread('\gfx\check.png');
f = imshow(im);
set(f, 'AlphaData', alpha);
set(f, 'Visible', 'off')
handles.logo_fig = f;
guidata(hObject,handles);


% --- Executes on selection change in select_plot.
function select_plot_Callback(hObject, eventdata, handles)
% hObject    handle to select_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select_plot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_plot

str = get(hObject,'String');
val = get(hObject,'Value');

if handles.fired
        
set(0, 'DefaultFigureVisible', 'on')

switch str{val}
    case 'Dynamics'
        set(handles.f1, 'Visible', 'on')
        set(handles.f2, 'Visible', 'on')
        set(handles.f3, 'Visible', 'on')
        set(handles.f4, 'Visible', 'on')
        set(handles.f5, 'Visible', 'off')
        set(handles.f6, 'Visible', 'off')
        set(handles.f7, 'Visible', 'off')
        set(handles.f8, 'Visible', 'off')
        set(handles.f9, 'Visible', 'off')
        set(handles.f10, 'Visible', 'off')
        set(handles.f11, 'Visible', 'off')
        set(handles.f12, 'Visible', 'off')
        set(handles.f13, 'Visible', 'on')
        set(handles.f14, 'Visible', 'off')
    case 'Trajectory'
        set(handles.f1, 'Visible', 'off')
        set(handles.f2, 'Visible', 'off')
        set(handles.f3, 'Visible', 'off')
        set(handles.f4, 'Visible', 'off')
        set(handles.f5, 'Visible', 'on')
        set(handles.f6, 'Visible', 'on')
        set(handles.f7, 'Visible', 'on')
        set(handles.f8, 'Visible', 'off')
        set(handles.f9, 'Visible', 'off')
        set(handles.f10, 'Visible', 'off')
        set(handles.f11, 'Visible', 'off')
        set(handles.f12, 'Visible', 'off')
        set(handles.f13, 'Visible', 'off')
        set(handles.f14, 'Visible', 'off')
    case 'Angular Rates'
        set(handles.f1, 'Visible', 'off')
        set(handles.f2, 'Visible', 'off')
        set(handles.f3, 'Visible', 'off')
        set(handles.f4, 'Visible', 'off')
        set(handles.f5, 'Visible', 'off')
        set(handles.f6, 'Visible', 'off')
        set(handles.f7, 'Visible', 'off')
        set(handles.f8, 'Visible', 'on')
        set(handles.f9, 'Visible', 'on')
        set(handles.f10, 'Visible', 'off')
        set(handles.f11, 'Visible', 'off')
        set(handles.f12, 'Visible', 'off')
        set(handles.f13, 'Visible', 'off')
        set(handles.f14, 'Visible', 'off')
    case 'Aerodynamic Angles'
        set(handles.f1, 'Visible', 'off')
        set(handles.f2, 'Visible', 'off')
        set(handles.f3, 'Visible', 'off')
        set(handles.f4, 'Visible', 'off')
        set(handles.f5, 'Visible', 'off')
        set(handles.f6, 'Visible', 'off')
        set(handles.f7, 'Visible', 'off')
        set(handles.f8, 'Visible', 'off')
        set(handles.f9, 'Visible', 'off')
        set(handles.f10, 'Visible', 'on')
        set(handles.f11, 'Visible', 'on')
        set(handles.f12, 'Visible', 'on')
        set(handles.f13, 'Visible', 'off')
        set(handles.f14, 'Visible', 'off')
    case 'Temperature Profile'
        set(handles.f1, 'Visible', 'off')
        set(handles.f2, 'Visible', 'off')
        set(handles.f3, 'Visible', 'off')
        set(handles.f4, 'Visible', 'off')
        set(handles.f5, 'Visible', 'off')
        set(handles.f6, 'Visible', 'off')
        set(handles.f7, 'Visible', 'off')
        set(handles.f8, 'Visible', 'off')
        set(handles.f9, 'Visible', 'off')
        set(handles.f10, 'Visible', 'off')
        set(handles.f11, 'Visible', 'off')
        set(handles.f12, 'Visible', 'off')
        set(handles.f13, 'Visible', 'off')
        set(handles.f14, 'Visible', 'on')
    case 'Hide ALL Graphs'
        set(handles.f1, 'Visible', 'off')
        set(handles.f2, 'Visible', 'off')
        set(handles.f3, 'Visible', 'off')
        set(handles.f4, 'Visible', 'off')
        set(handles.f5, 'Visible', 'off')
        set(handles.f6, 'Visible', 'off')
        set(handles.f7, 'Visible', 'off')
        set(handles.f8, 'Visible', 'off')
        set(handles.f9, 'Visible', 'off')
        set(handles.f10, 'Visible', 'off')
        set(handles.f11, 'Visible', 'off')
        set(handles.f12, 'Visible', 'off')
        set(handles.f13, 'Visible', 'off')
        set(handles.f14, 'Visible', 'off')
    otherwise
end
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function select_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
