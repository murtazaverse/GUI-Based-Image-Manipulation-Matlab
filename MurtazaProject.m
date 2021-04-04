function varargout = MurtazaLabExam(varargin)
% MURTAZALABEXAM MATLAB code for MurtazaLabExam.fig
%      MURTAZALABEXAM, by itself, creates a new MURTAZALABEXAM or raises the existing
%      singleton*.
%
%      H = MURTAZALABEXAM returns the handle to a new MURTAZALABEXAM or the handle to
%      the existing singleton*.
%
%      MURTAZALABEXAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MURTAZALABEXAM.M with the given input arguments.
%
%      MURTAZALABEXAM('Property','Value',...) creates a new MURTAZALABEXAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MurtazaLabExam_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MurtazaLabExam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MurtazaLabExam

% Last Modified by GUIDE v2.5 09-Feb-2021 02:30:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MurtazaLabExam_OpeningFcn, ...
                   'gui_OutputFcn',  @MurtazaLabExam_OutputFcn, ...
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




function MurtazaLabExam_OpeningFcn(hObject, eventdata, handles, varargin)

i1 = zeros(128,128,3);
handles.i1 = i1;
imshow(handles.i1);
axes(handles.axes4);
i2 = zeros(128,128,3);
handles.i2 = i2;
imshow(handles.i2);
axes(handles.axes5);

handles.output = hObject;

guidata(hObject, handles);




function varargout = MurtazaLabExam_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function Loadimg_pb_Callback(hObject, eventdata, handles)

global murtaza
[filename,pathname] = uigetfile('*.jpg;*.png;*.bmp;*.tif;*.jpeg','Pick any image');
i = imread([pathname,filename]);
murtaza = rgb2gray(i);
axes(handles.axes4);
imshow(murtaza);



function Histogram_pb_Callback(hObject, eventdata, handles)

global murtaza
axes(handles.axes5);
imhist(murtaza);
value = 'Histogram';
set(handles.Operation_pb,'String',value);


function Histeq_pb_Callback(hObject, eventdata, handles)

global murtaza
hist_eq = histeq(murtaza);
axes(handles.axes5);
imshow(hist_eq);
value = 'Histogram Equalization';
set(handles.Operation_pb,'String',value);


function Thresh_pb_Callback(hObject, eventdata, handles)

global murtaza
global threshold
Max_image = max(max(murtaza));
[row,col] = size(murtaza);
for i = 1:row
    for j=1:col
        f = murtaza(i,j);
        if f <= threshold
            A(i,j) = 0;
        else
            A(i,j) = 255;
        end
    end
end
axes(handles.axes5);
imshow(A);
value = 'Binary Thresholding';
set(handles.Operation_pb,'String',value);


function Erosion_pb_Callback(hObject, eventdata, handles)

global murtaza
struct_element1 = strel('disk',10);
erode_result1 = imerode(murtaza,struct_element1);
axes(handles.axes5);
imshow(erode_result1);
value = 'Erosion';
set(handles.Operation_pb,'String',value);



function Dilation_pb_Callback(hObject, eventdata, handles)

global murtaza
struct_element1 = strel('disk',10);
dilate_result = imdilate(murtaza,struct_element1);
axes(handles.axes5);
imshow(dilate_result);
value = 'Dilation';
set(handles.Operation_pb,'String',value);



function Smoothing_pb_Callback(hObject, eventdata, handles)

contents = cellstr(get(hObject,'String'));
a = contents{get(hObject,'Value')};
a
global murtaza
if (strcmp(a,'Averaging 3x3'))
    %i = imread('pout.tif');
    x1 = ones(3,3)/9;
    output = imfilter(murtaza,x1);
    value = 'Averaging 3x3';
    set(handles.Operation_pb,'String',value);
elseif (strcmp(a,'Averaging 5x5'))
    x1 = ones(5,5)/9;
    output = imfilter(murtaza,x1);
    value = 'Averaging 5x5';
    set(handles.Operation_pb,'String',value);
elseif (strcmp(a,'Median 3x3'))
    output = medfilt2(murtaza,[3 3]);
    value = 'Median 3x3';
    set(handles.Operation_pb,'String',value);    
elseif(strcmp(a,'Gaussian 3x3'))
    gaussian_filter = fspecial('gaussian',[3 3],0.5);
    output = imfilter(murtaza,gaussian_filter,'replicate');
    value = 'Gaussian 3x3';
    set(handles.Operation_pb,'String',value);
elseif (strcmp(a,'Median 5x5'))
    output = medfilt2(murtaza,[5 5]);
    value = 'Median 5x5';
    set(handles.Operation_pb,'String',value);    
elseif(strcmp(a,'Gaussian 5x5'))
    gaussian_filter = fspecial('gaussian',[5 5],0.5);
    output = imfilter(murtaza,gaussian_filter,'replicate');
    value = 'Gaussian 5x5';
    set(handles.Operation_pb,'String',value);
end

axes(handles.axes5);
imshow(output);


function Smoothing_pb_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Sharpening_pb_Callback(hObject, eventdata, handles)

contents = cellstr(get(hObject,'String'));
b = contents{get(hObject,'Value')};
b
global murtaza
if (strcmp(b,'Laplacian'))
    h1 = [0 1 0;1 4 1;0 1 0]; %kernel = 4
    output = imfilter(murtaza,h1);
    value = 'Laplacian';
    set(handles.Operation_pb,'String',value);
elseif (strcmp(b,'Unmask & Highboost'))
    k = 6;
    filt=imgaussfilt(murtaza,2);
    mask=murtaza-filt;
    output=murtaza-[k.*mask];
    value = 'Unmask & Highboost';
    set(handles.Operation_pb,'String',value);
elseif (strcmp(b,'Sobel'))
    mask1 = fspecial('sobel');
    result1 = imfilter(murtaza,mask1);
    result2 = imfilter(murtaza,mask1');
    output = abs(result1)+abs(result2);
    value = 'Sobel';
    set(handles.Operation_pb,'String',value);
elseif (strcmp(b,'Prewitt'))
    m1 = fspecial('prewitt');
    r1 = imfilter(murtaza,m1);
    r2 = imfilter(murtaza,m1');
    output = abs(r1)+abs(r2);
    value = 'Prewitt';
    set(handles.Operation_pb,'String',value);

end
axes(handles.axes5);
imshow(output);

function Sharpening_pb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Operation_pb_Callback(hObject, eventdata, handles)

function Operation_pb_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thresh_value_Callback(hObject, eventdata, handles)

global threshold
threshold = str2double(get(handles.thresh_value, 'String'))



function thresh_value_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
