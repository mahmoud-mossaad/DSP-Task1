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

myImage = imread('intro.png');
set(handles.axes1,'Units','pixels');
resizePos = get(handles.axes1,'Position');
myImage= imresize(myImage, [resizePos(3) resizePos(3)]);
axes(handles.axes1);
imshow(myImage);
get(0,'Factory')
set(0,'defaultfigurecolor','k')
set(handles.axes1,'Units','normalized');
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
if len == 38400
    x = 1:len;
    Dx=1800; y1=-1000; y2=2500;
    plot(x,signal,'g'); axis([v v+Dx y1 y2]);drawnow
    set(gca,'Color','k')
    set(handles.axes1,{'ycolor'},{'g'})
    set(handles.axes1,{'xcolor'},{'g'})
else if len == 921600
        x = 1:len;
        Dx=1800; y1=-2200; y2=3800;
        plot(x,signal(1,:),'g'); axis([v v+Dx y1 y2]);drawnow
        set(gca,'Color','k')
        set(handles.axes1,{'ycolor'},{'g'})
        set(handles.axes1,{'xcolor'},{'g'})
    else if len == 100000
            x = 1:len;
            Dx=1000; y1=300; y2=800;
            plot(x,signal(),'g'); axis([v v+Dx y1 y2]); drawnow
            set(gca,'Color','k')
            set(handles.axes1,{'ycolor'},{'g'})
            set(handles.axes1,{'xcolor'},{'g'})
        else if len == 50860
                x = 1:len;
                Dx=1200; y1=-5000; y2=8000;
                plot(x,signal(),'g'); axis([v v+Dx y1 y2]); drawnow
                set(gca,'Color','k')
                set(handles.axes1,{'ycolor'},{'g'})
                set(handles.axes1,{'xcolor'},{'g'})
            end
        end
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
if length(handles.var) == 38400
    if handles.f == 36601 | handles.browsed == 0
        handles.f = 1;
        handles.browsed = 1
        
    end
    %%checks if the signal is done and reset the counter f for EEG%%
    else if length(handles.var) == 921600
            if handles.f == 919810 | handles.browsed == 0
            handles.f = 1;
            handles.browsed = 1;
           
            end
            %%checks if the signal is done and reset the counter f for EHG%%
        else if length(handles.var) == 100000
                if handles.f == 98976 | handles.browsed == 0
                    handles.f = 1;
                    handles.browsed = 1
                    
                end
                %%checks if the signal is done and reset the counter f for EMG%%
            else if length(handles.var) == 50860
                       if handles.f == 49666 | handles.browsed == 0
                            handles.f = 1;
                            handles.browsed = 1
                            
                       end
                end
            end
        end
end
%checks if the button is pressed and the signal is ECG%
if length(handles.var) == 38400 & get(handles.togglebutton, 'value') ==1
    ecg = handles.var;
    x = 1:38400;
    Dx=1800; y1=-1000; y2=2500;
    %%ploting the signal with the counter f%%
    for n=handles.f:25:36600
        plot(x,ecg,'g'); axis([x(n) x(n+Dx) y1 y2]);drawnow
        set(gca,'Color','k')
        set(handles.axes1,{'ycolor'},{'g'})
        set(handles.axes1,{'xcolor'},{'g'})
        handles.f = handles.f+25
        set(handles.slider, 'value', handles.f)
        %%checks the toggle button if it's paused during the plotting%%
        if get(handles.togglebutton, 'value') ~= 1
               break;
        end
    end
    %checks if the button is pressed and the signal is EEG%
else if length(handles.var) == 921600 & get(handles.togglebutton, 'value') == 1
        eeg = handles.var(1,:);
        x = 1:921600;
        Dx=1800; y1=-2200; y2=3800;
        %ploting the signal with the counter f%
        for n=handles.f:99:919711
            plot(x,eeg,'g'); axis([x(n) x(n+Dx) y1 y2]);drawnow
            set(gca,'Color','k')
            set(handles.axes1,{'ycolor'},{'g'})
            set(handles.axes1,{'xcolor'},{'g'})
            handles.f = handles.f+99
            set(handles.slider, 'value', handles.f)
            %checks the toggle button if it's paused during the plotting%
            if get(handles.togglebutton, 'value') ~= 1
               break;
            end
        end
        %checks if the button is pressed and the signal is EHG%
    else if length(handles.var) == 100000 & get(handles.togglebutton, 'value') == 1
        ehg = handles.var;
        x = 1:100000;
        Dx=1000; y1=300; y2=800;
        %ploting the signal with the counter f%
        for n=handles.f:25:98969
            plot(x,ehg,'g'); axis([x(n) x(n+Dx) y1 y2]);drawnow
            set(gca,'Color','k')
            set(handles.axes1,{'ycolor'},{'g'})
            set(handles.axes1,{'xcolor'},{'g'})
            zoom xon
            handles.f = handles.f+25
            set(handles.slider, 'value', handles.f)
            %checks the toggle button if it's paused during the plotting%
            if get(handles.togglebutton, 'value') ~= 1
               break;
            end
        end
        %checks if the button is pressed and the signal is EMG%
        else if length(handles.var) == 50860 & get(handles.togglebutton, 'value') == 1
                emg = handles.var;
                x = 1:50860;
                Dx=1200; y1=-5000; y2=8000;
                %ploting the signal with the counter f%
                for n=handles.f:15:49651
                    plot(x,emg,'g'); axis([x(n) x(n+Dx) y1 y2]);drawnow
                    set(gca,'Color','k')
                    set(handles.axes1,{'ycolor'},{'g'})
                    set(handles.axes1,{'xcolor'},{'g'})
                    handles.f = handles.f+15
                    set(handles.slider, 'value', handles.f)
                    %checks the toggle button if it's paused during the plotting%
                    if get(handles.togglebutton, 'value') ~= 1
                        break;
                    end
                end
            end
        end
    end
end
%% If conditions to reset the counter whether the plotting is done or the browse button%%
%%is pressed%%
if length(handles.var) == 38400
    if handles.f == 36601 | handles.browsed == 0
        handles.f = 1;
        handles.browsed = 1
        set(handles.togglebutton, 'value', 0)
    end
    else if length(handles.var) == 921600
            if handles.f == 919810 | handles.browsed == 0
            handles.f = 1;
            handles.browsed = 1;
            set(handles.togglebutton, 'value', 0)
            end
        else if length(handles.var) == 100000
                if handles.f == 98976 | handles.browsed == 0
                    handles.f = 1;
                    handles.browsed = 1
                    set(handles.togglebutton, 'value', 0)
                end
            else if length(handles.var) == 50860
                       if handles.f == 49666 | handles.browsed == 0
                            handles.f = 1;
                            handles.browsed = 1
                            set(handles.togglebutton, 'value', 0)
                       end
                end
            end
        end
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
    var = load(ExPath);
    handles.var = var.val;
    set(handles.slider, 'max', length(handles.var))
%%Sending the signal that's browsed to the toggle button and the slider%%
switch length(var.val);
    case 38400 % User selects ECG.
        set(handles.text2, 'string', 'ECG Signal') %%Set the static text to the value showen%%
        plot(handles.var,'g')
        set(gca,'Color','k')
        set(handles.axes1,{'ycolor'},{'g'})
        set(handles.axes1,{'xcolor'},{'g'})
        zoom xon
        zoom(20)
        handles.browsed = 0;
    case 921600 % User selects EEG.
        set(handles.text2, 'string', 'EEG Signal') %Set the static text to the value showen%%
        plot(handles.var(1,:),'g')
        set(gca,'Color','k')
        set(handles.axes1,{'ycolor'},{'g'})
        set(handles.axes1,{'xcolor'},{'g'})
        zoom xon
        zoom(90)
        handles.browsed = 0;
    case 100000 % User selects EHG
        set(handles.text2, 'string', 'EHG Signal') %%Set the static text to the value showen%%
        plot(handles.var,'g')
        set(gca,'Color','k')
        set(handles.axes1,{'ycolor'},{'g'})
        set(handles.axes1,{'xcolor'},{'g'})
        zoom xon
        zoom(50)
        handles.browsed = 0;
    case 50860 % User selects EMG
        set(handles.text2, 'string', 'EMG Signal') %%Set the static text to the value showen%%
        plot(handles.var,'g')
        set(gca,'Color','k')
        set(handles.axes1,{'ycolor'},{'g'})
        set(handles.axes1,{'xcolor'},{'g'})
        zoom xon
        zoom(30)
        handles.browsed = 0;
end
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
