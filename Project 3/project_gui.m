function varargout = project_gui(varargin)
% PROJECT_GUI MATLAB code for project_gui.fig
%      PROJECT_GUI, by itself, creates a new PROJECT_GUI or raises the existing
%      singleton*.
%
%      H = PROJECT_GUI returns the handle to a new PROJECT_GUI or the handle to
%      the existing singleton*.
%
%      PROJECT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT_GUI.M with the given input arguments.
%
%      PROJECT_GUI('Property','Value',...) creates a new PROJECT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before project_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to project_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help project_gui

% Last Modified by GUIDE v2.5 15-Dec-2015 13:42:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @project_gui_OpeningFcn, ...
    'gui_OutputFcn',  @project_gui_OutputFcn, ...
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


% --- Executes just before project_gui is made visible.
function project_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to project_gui (see VARARGIN)

% Choose default command line output for project_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes project_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = project_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in testSetMenu.
function testSetMenu_Callback(hObject, eventdata, handles)
% hObject    handle to testSetMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns testSetMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from testSetMenu


% --- Executes during object creation, after setting all properties.
function testSetMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to testSetMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    l = dir('TestImages');
    l(1:2)=[];
    l2 = struct2cell(l);
    l3=l2(1,:);
    handles.testSets = 3;
    guidata(hObject,handles);
end


% --------------------------------------------------------------------
function testSet_Callback(hObject, eventdata, handles)
% hObject    handle to testSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in browseButton.
function browseButton_Callback(hObject, eventdata, handles)
% hObject    handle to browseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,FilePath,FilterIndex]=uigetfile('*.png');
if(ischar(FileName))
    fp = [FilePath,'/',FileName];
    TestImage = imread(fp);
    setName=matchGlobal_gui(fp);
    handles.TestImage = TestImage;
    handles.FileName = FileName;
    handles.setName = setName;
    [matchIndex,Isbs] = matchLocal_gui(setName,fp);
    axes(handles.axes1)
    imshow(Isbs,[]);
    angleEstimate = (360/128)*(matchIndex+0.5);
    set(handles.text4,'String',['Estimated angle = ',num2str(angleEstimate),' degrees']);
end
guidata(hObject,handles);
