function varargout = Task1(varargin)
% TASK1 MATLAB code for Task1.fig
%      TASK1, by itself, creates a new TASK1 or raises the existing
%      singleton*.
%
%      H = TASK1 returns the handle to a new TASK1 or the handle to
%      the existing singleton*.
%
%      TASK1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TASK1.M with the given input arguments.
%
%      TASK1('Property','Value',...) creates a new TASK1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Task1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Task1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Task1

% Last Modified by GUIDE v2.5 18-Feb-2019 03:23:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Task1_OpeningFcn, ...
                   'gui_OutputFcn',  @Task1_OutputFcn, ...
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


% --- Executes just before Task1 is made visible.
function Task1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Task1 (see VARARGIN)

% Choose default command line output for Task1
handles.output = hObject;
%our beloved counter%
f=1;
handles.f=f;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Task1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Task1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v = get(handles.slider, 'value') %V is the value of the slider at a certain poistion%
len = length(handles.var) %len is the length of the signal processed%
set(handles.slider, 'max', len) %Setting the maximum value of the slider to be like the length of the signal%
signal = handles.var; %Handing the signal to 'signal' for better coding%

%checks what type of signal is browsed to set the appropiate slider's
%minimum and maximum value%
x = 1:len;
Dx=1800; y1=min(handles.var(1,:)); y2=max(handles.var(1,:));
plot(x,signal(1,:)); axis([v v+Dx y1 y2]);drawnow
if get(handles.togglebutton, 'value')==0
    n=1:handles.step:handles.nmax;
    result = min(n(n>=get(handles.slider, 'value')))
    if result<handles.nmax | result>0
    handles.f=result
    else
        handles.f=handles.nmax
    end
end

        

 

      
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in togglebutton.
function togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%checks if the signal is done and reset the counter f for ECG%

if get(handles.slider, 'value')~= handles.f
    n=1:handles.step:handles.nmax;
    result = min(n(n>=get(handles.slider, 'value')))
    if result<handles.nmax | result>0
        handles.f=result
    else
        handles.f=handles.nmax
    end
 
end
if handles.f >= handles.nmax | handles.browsed == 0
        handles.f = 1;
        handles.browsed = 1
end
%checks if the button is pressed and the signal is ECG%
if get(handles.togglebutton, 'value') ==1
    sig = handles.var(1,:);
    x = 1:length(handles.var);
    Dx=1800; y1=min(handles.var(1,:)); y2=max(handles.var(1,:));
%%the signal with the counter f%%
    for n=handles.f:handles.step:handles.nmax
        plot(x,sig); axis([x(n) x(n+Dx) y1 y2]);drawnow
        handles.f = handles.f+handles.step
        set(handles.slider, 'value', handles.f)
        %%checks the toggle button if it's paused during the plotting%%
        if get(handles.togglebutton, 'value') ~= 1
               break;
        end
    end
end
    %checks if the button is pressed and the signal is EEG%

%% If conditions to reset the counter whether the plotting is done or the browse button%%
%%is pressed%%

if handles.f >= handles.nmax | handles.browsed == 0
        handles.f = 1;
        handles.browsed = 1
        set(handles.togglebutton, 'value', 0)
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of togglebutton




% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%check if the plotting is paused%%
if get(handles.togglebutton, 'value') == 0
    [FileName,FilePath]= uigetfile();
    ExPath = fullfile(FilePath, FileName);
    check = true;
    try
    var = load(ExPath);   %I can't load this file
    catch
    check = false;
    set(handles.text2, 'string', 'It is not a signal')
    end
    if check
    handles.var = var.val
    set(handles.slider, 'max', length(handles.var))
    if length(handles.var) > 500000
        handles.step = 99;
    else
        handles.step = 25;
    end
    handles.nmax = length(handles.var)-2000
    set(handles.text2, 'string', 'ECG Signal') %%Set the static text to the value showen%%
    plot(handles.var(1,:))
    axis([0 1800 min(handles.var(1,:)) max(handles.var(1,:))])
    handles.browsed = 0;
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
