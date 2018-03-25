function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 22-Apr-2016 19:39:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)
 a=imread('F:\MYSPACE\CHUROU\Project\GUI\nuaa.jpg');
 axes(handles.axes4);
 imshow(a);
% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.*'},'Load Image File');

if (FileName==0) % cancel pressed
    return;
end


handles.fullPath = [PathName FileName];
[a, b, Ext] = fileparts(FileName);
availableExt = {'.bmp','.jpg','.jpeg','.tiff','.png','.gif'};
FOUND = 0;
for (i=1:length(availableExt))
    if (strcmpi(Ext, availableExt{i}))
        FOUND=1;
        break;
    end
end

if (FOUND==0)
    h = msgbox('File type not supported!','Error','error');
    return;
end
RGB = imread(handles.fullPath);

handles.RGB = RGB;
handles.RGB2 = RGB;
handles.RGB3 = RGB;


handles.fileLoaded = 1;
handles.fileLoaded2 = 0;
% set(handles.axes1,'Visible','off'); set(handles.axes2,'Visible','off');
% set(handles.axesHist1,'Visible','off'); set(handles.axesHist2,'Visible','off');
% set(handles.textHist1, 'Visible', 'off');
% axes(handles.axesHist2); cla;
% set(handles.textHist2, 'Visible', 'off');

axes(handles.axes1); cla; imshow(RGB);
axes(handles.axes2); cla;

%handles = updateHistograms(handles);
% a=1;
% if (a==1)
%   set(handles.text2,'string','等级gg');
% end
% set(handles.radiobutton6,'value',0);
% set(handles.radiobutton7,'value',0);
% set(handles.radiobutton8,'value',0);
% set(handles.radiobutton9,'value',0);
guidata(hObject, handles);
    


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'NumberTitle', 'off', 'Name', '正在执行去噪算法，请稍等……');
if (handles.fileLoaded==1)
    handles.RGB2 = handles.RGB;
    %axes(handles.axes2); imshow(handles.RGB2);
    
%     if size(handles.RGB,3) > 1
%     Gray = rgb2gray(handles.RGB);
%     handles.RGB2(:,:,1) = Gray;
%     handles.RGB2(:,:,2) = Gray;
%     handles.RGB2(:,:,3) = Gray;
%     end
    if size(handles.RGB2,3) > 1
    handles.RGB2 = rgb2gray(handles.RGB2);
    end
imwrite(handles.RGB2,'F:\MYSPACE\CHUROU\Project\sample_photo\rank6.jpg');
  %axes(handles.axes2); imshow(handles.RGB2);
    sigma=5;
    
    imd=handles.RGB2;
    %handles.RGB2=double(handles.RGB2);
    %handles.RGB2=NLmeansfilter(handles.RGB2,5,2,sigma);
    imd=double(imd);
   % h = figure('name','正在执行去噪算法','NumberTitle','off','position',[100 100 300 100]);
   
    tic
    imd=NLmeansfilter(imd,5,2,sigma);
    toc
    imd=uint8(imd);
    imwrite(imd,'denoise.jpg');
    %imwrite(imd,'F:\MYSPACE\CHUROU\Project\sample_photo\rank6.jpg');
    imz=imread('denoise.jpg');
    if(size(imz,3) > 1)%标准图像出来时RGB，一般灰度图像又不是RGB
       imz=rgb2gray(imz);
       end
    imo=imread('rank6.jpg');
    if(size(imo,3) > 1)%标准图像出来时RGB，一般灰度图像又不是RGB
       imo=rgb2gray(imo);
       end
    imn=imread('noised.jpg');
    if(size(imn,3) > 1)%标准图像出来时RGB，一般灰度图像又不是RGB
       imn=rgb2gray(imn);
       end
    size(imo);
    size(imn);
    size(imz);
    noised = Psnr( imo,imn )
    nonlocal = Psnr( imo,imz )
    axes(handles.axes2); imshow(imd);
    handles.fileLoaded2 = 1;
    %handles = updateHistograms(handles);
    
else
     h = msgbox('No primary file has been loaded!','Error','error');
    
end
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
       set(gcf,'NumberTitle', 'off', 'Name', '正在执行分割算法，请稍等……');
       handles.RGB2=imread('denoise.jpg');
       if(size(handles.RGB2,3) > 1)%标准图像出来时RGB，一般灰度图像又不是RGB
       handles.RGB2=rgb2gray(handles.RGB2);
       end
       handles.RGB3=Divide_Tsallis_1D(handles.RGB2);
%      handles.RGB3=uint8(handles.RGB3);
       
%      handles.RGB3=imread('divided.jpg');
     axes(handles.axes2);
     imshow(handles.RGB3);
     imwrite(handles.RGB3,'divided.jpg');
%      imagesc(handles.RGB3);
     handles.fileLoaded2 = 2;
     guidata(hObject, handles);
     
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'NumberTitle', 'off', 'Name', '正在特征提取与分类，请稍等……');
main;
% a=1;
 switch predict_label_2(1)
         case 1
         set(handles.text2,'String','等级一');  
         case 2
         set(handles.text2,'String','等级二');  
         case 3
         set(handles.text2,'String','等级三');  
         case 4
         set(handles.text2,'String','等级四');  
         case 5
         set(handles.text2,'String','等级五');  
 end
%   guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6
