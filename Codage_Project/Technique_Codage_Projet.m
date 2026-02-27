

function varargout = Technique_Codage_Projet(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Technique_Codage_Projet_OpeningFcn, ...
                   'gui_OutputFcn',  @Technique_Codage_Projet_OutputFcn, ...
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



% --- Executes just before Technique_Codage_Projet is made visible.
function Technique_Codage_Projet_OpeningFcn(hObject, eventdata, handles, varargin)

set(handles.figure1, 'Color', [0.9 0.9 1] );

set(handles.welcom_Panel,'Visible','on');
set(handles.text_in,'Visible','off');
set(handles.img_in,'Visible','off');
set(handles.text_info,'Visible','off');
set(handles.h_v_z,'Visible','off');

handles.file_empty = 1;
guidata(hObject, handles);

[img, map] = imread('ENSAF_USMBA_logo.png');
img = ind2rgb(img, map);

imshow(img, 'Parent', handles.axe_Image);
axis image;
axis off;
axes(handles.axe_Image);

hold on;

handles.output = hObject;

guidata(hObject, handles);

% UIWAIT makes Technique_Codage_Projet wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Technique_Codage_Projet_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in img_choice.
function img_choice_Callback(hObject, eventdata, handles)
set(handles.welcom_Panel,'Visible','off');
set(handles.img_in,'Visible','on');


% --- Executes on button press in text_choice.
function text_choice_Callback(hObject, eventdata, handles)
set(handles.welcom_Panel,'Visible','off');
set(handles.text_in,'Visible','on');


% % --------------------------------------------------------------------
% function Untitled_1_Callback(hObject, eventdata, handles)
% % hObject    handle to Untitled_1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)



function texte_to_code_Callback(hObject, eventdata, handles)
% hObject    handle to texte_to_code (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of texte_to_code as text
%        str2double(get(hObject,'String')) returns contents of texte_to_code as a double


% --- Executes during object creation, after setting all properties.
function texte_to_code_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texte_to_code (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in valid.
function valid_Callback(hObject, eventdata, handles)
    text = get(handles.texte_to_code,'String');
    texte = char(text);
    [encoded_sh, bits_origin_sh, bits_comp_sh, rapp_sh, eff_sh,err_sh] = Shannon_Fano_Compression(texte);
    [encoded_huff, taille_init_huff, taille_final_huff, rap_comp_huff, eff_huff,err_huff] = Huffman_Compression(texte);
    [encoded_lz, taille_init_lz, taille_final_lz, rap_comp_lz,err_lz] = LZ78_Compression(texte);
    [encoded_lzw, taille_init_lzw, taille_final_lzw, rap_comp_lzw,err_lzw] = LZW_Compression(texte);
    if err_sh==true || err_huff==true || err_lz==true || err_lzw==true
        errordlg("Le texte est très court ou ne peut pas être compresser.\nS'il vous plait reecrire le texte!",'erreur');
    else
        set(handles.text_in,'Visible','off');
        set(handles.text_info,'Visible','on');
%         texte_info_sh = "Shannon-Fano codage : \n",'texte codé : ',encoded_sh,'\n',"nombre de bits d'origine : ",bits_origin_sh,'\n',"nombre de bits après compression : ",bits_comp_sh,'\n',"Rapport de compression : ",rapp_sh,'\n',"Efficacité : ",eff_sh ;
        texte_info_sh = sprintf('Shannon-Fano :\nTexte codé : %s\nBits origine : %d bits\nBits compressés : %d bits\nRapport : %.2f\nEfficacité : %.2f %%',encoded_sh, bits_origin_sh, bits_comp_sh, rapp_sh, eff_sh);
        texte_info_huff = sprintf('Huffman\nTexte codé : %s\nBits origine : %d bits\nBits compressés : %d bits\nRapport : %.2f\nEfficacité : %.2f %%',encoded_huff, taille_init_huff, taille_final_huff, rap_comp_huff, eff_huff);
        texte_info_lz = sprintf('LZ78\nCode : %s\nBits origine : %d bits\nBits compressés : %d bits\nRapport : %.2f',mat2str(encoded_lz), taille_init_lz, taille_final_lz, rap_comp_lz);
        texte_info_lzw = sprintf('LZW\nCode : %s\nBits origine : %d bits\nBits compressés : %d bits\nRapport : %.2f',mat2str(encoded_lzw), taille_init_lzw, taille_final_lzw, rap_comp_lzw);

        set(handles.Shanon_info,'String',texte_info_sh);
        set(handles.Huffman_info,'String',texte_info_huff);
        set(handles.LZ_info,'String',texte_info_lz);
        set(handles.LZW_info,'String',texte_info_lzw);
    end

% --- Executes on button press in return1.
function return1_Callback(hObject, eventdata, handles)
set(handles.text_in,'Visible','off');
set(handles.welcom_Panel,'Visible','on');


% --- Executes on button press in return2.
function return2_Callback(hObject, eventdata, handles)
    set(handles.img_in,'Visible','off');
    set(handles.welcom_Panel,'Visible','on');

% file_empty = true;
% --- Executes on button press in browser_btn.
function browser_btn_Callback(hObject, eventdata, handles)
    [filename, pathname] = uigetfile('Sélectionner un fichier');
    if isequal(filename,0)
        handles.file_empty = 1;
        guidata(hObject, handles);
    else
        fullpath = fullfile(pathname, filename);
        handles.Mat = path_to_matrix(fullpath);
        guidata(hObject, handles);
        handles.file_empty = 0;
        guidata(hObject, handles);
        
%         lect_max_zero = Lecture_max_zero(Mat);
        lect_max_zero = Lecture_max_zero(handles.Mat);
        switch lect_max_zero
            case 'V'
                msgbox("La lecture qui donne la plus suite de zero c'est : La lecture Verticale",'information');
            case 'H'
                msgbox("La lecture qui donne la plus suite de zero c'est : La lecture Horizontale"','information');
            case 'Z'
                msgbox("La lecture qui donne la plus suite de zero c'est : La lecture en ZigZag",'information');
        end
    end
    



% --- Executes on button press in h_choice.
function h_choice_Callback(hObject, eventdata, handles)
    handles = guidata(hObject);
    if handles.file_empty == 0
        handles = guidata(hObject);
        M = handles.Mat;
        [M_out_aug,taille_aug] = rendre_carre_augmenter(M); 
        [M_out_dim,taille_dim] = rendre_carre_diminuer(M);
        H_aug = lect_hor(M_out_aug);
        H_dim = lect_hor(M_out_dim);
        h_zeros_aug = max_zeros(H_aug);
        h_zeros_dim = max_zeros(H_dim);
        img_info_aug = sprintf("Lecture après l'augmentation du matrice :\nTaille de matrice image : %d\nNombre de plus grand suite de zero : %d \n",taille_aug,h_zeros_aug);
        img_info_dim = sprintf("Lecture après la diminution du matrice :\nTaille de matrice image : %d\nNombre de plus grand suite de zero : %d \n",taille_dim,h_zeros_dim);
        set(handles.matrice_aug,'String',img_info_aug);
        set(handles.matrice_dim,'String',img_info_dim);
        set(handles.img_in,'Visible','off');
        set(handles.h_v_z,'Visible','on');
    else
        errordlg('Vous devez entrez une image !!','erreur');
    end


% --- Executes on button press in v_choice.
function v_choice_Callback(hObject, eventdata, handles)
    handles = guidata(hObject);
    if handles.file_empty == 0
        handles = guidata(hObject);
        M = handles.Mat;
        [M_out_aug,taille_aug] = rendre_carre_augmenter(M); 
        [M_out_dim,taille_dim] = rendre_carre_diminuer(M);
        V_aug = lect_vert(M_out_aug);
        V_dim = lect_vert(M_out_dim);
        v_zeros_aug = max_zeros(V_aug);
        v_zeros_dim = max_zeros(V_dim);
        img_info_aug = sprintf("Lecture après l'augmentation du matrice :\nTaille de matrice image : %d\nNombre de plus grand suite de zero : %d \n",taille_aug,v_zeros_aug);
        img_info_dim = sprintf("Lecture après la diminution du matrice :\nTaille de matrice image : %d\nNombre de plus grand suite de zero : %d \n",taille_dim,v_zeros_dim);
        set(handles.matrice_aug,'String',img_info_aug);
        set(handles.matrice_dim,'String',img_info_dim);
        set(handles.img_in,'Visible','off');
        set(handles.h_v_z,'Visible','on');
    else
        errordlg('Vous devez entrez une image !!','erreur');
    end


% --- Executes on button press in z_choice.
function z_choice_Callback(hObject, eventdata, handles)
    handles = guidata(hObject);
    if handles.file_empty == 0
        handles = guidata(hObject);
        M = handles.Mat;
        [M_out_aug,taille_aug] = rendre_carre_augmenter(M); 
        [M_out_dim,taille_dim] = rendre_carre_diminuer(M);
        Z_aug = lect_zigzag(M_out_aug);
        Z_dim = lect_zigzag(M_out_dim);
        z_zeros_aug = max_zeros(Z_aug);
        z_zeros_dim = max_zeros(Z_dim);
        img_info_aug = sprintf("Lecture après l'augmentation du matrice :\nTaille de matrice image : %d\nNombre de plus grand suite de zero : %d \n",taille_aug,z_zeros_aug);
        img_info_dim = sprintf("Lecture après la diminution du matrice :\nTaille de matrice image : %d\nNombre de plus grand suite de zero : %d \n",taille_dim,z_zeros_dim);
        set(handles.matrice_aug,'String',img_info_aug);
        set(handles.matrice_dim,'String',img_info_dim);
        set(handles.img_in,'Visible','off');
        set(handles.h_v_z,'Visible','on');
    else
        errordlg('Vous devez entrez une image !!','erreur');
    end


% --- Executes on button press in return3.
function return3_Callback(hObject, eventdata, handles)
set(handles.text_info,'Visible','off');
set(handles.text_in,'Visible','on');


% --- Executes on button press in return4.
function return4_Callback(hObject, eventdata, handles)
set(handles.h_v_z,'Visible','off');
set(handles.img_in,'Visible','on');
