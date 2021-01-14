function [ ] = defectDetectionExp( numeroROI, imagenNombreFR, imagenNombreROI, archivoVectorDef, nombreImagenOriginal, etiqueta)
% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
% deteccionDefectos  Crea un archivo con características de defectos a
% partir de una imagen a color y una imagen silueta.
% imagenNombreFR-> imagen silueta binaria
% imagenNombreROI-> imagen de región de interés
% archivoVectorDef->nombre de archivo con ruta para guardar características.
% nombreImagenOriginal-> nombre de la imagen original para relacionar las regiones.
% etiqueta-> nombre de la cadena que se colocará a la fila. Se asumen
% defectos marcados por el experto, por eso se conocen los resultados.
% ESPERA SILUETAS pre-binarizadas con OTZU.
%
%   function [ ] = deteccionDefectos( imagenNombreFR, imagenNombreROI, archivoVectorDef, nombreImagenOriginal, etiqueta)
%
%   OTRO COMENTARIO.


% SALIDAS= archivos conjuntos de calyx y defectos.

% Recibe una imagen en color y una imagen en blanco y negro.
% Se detectan objetos y se extraen las caracteristicas de color, textura,
% geometria.
% Este procedimiento sirve para extraer conjuntos de defectos y calyxs 

%clc; clear all; close all;


%imagenNombreFR='/home/usuario/ml/clasDefectos3/tmpToLearn/calyxBin/001.jpg_CALB1.jpg';
%imagenNombreROI='/home/usuario/ml/clasDefectos3/tmpToLearn/calyxColor/001.jpg_CALC1.jpg';


%pathPrincipal='/home/usuario/ml/clasDefectos3/'; 
%pathResultados=strcat(pathPrincipal,'output/');%se guardan los resultados
%archivoVectorDef=strcat(pathResultados,'aCalyx.csv'); %archivo de salida


%imagenNombreFR='/home/usuario/ml/clasDefectos3/tmpToLearn/defBin/003.jpg_DEFB1.jpg';
%imagenNombreROI='/home/usuario/ml/clasDefectos3/tmpToLearn/cDefectos/003.jpg_soC1.jpg';


%fprintf('archivoFR %s \n', imagenNombreFR);
%fprintf('archivoROI %s \n', imagenNombreROI);


%% Lectura de la imagen con fondo removido
IFR=imread(imagenNombreFR);
ImROI=imread(imagenNombreROI);


%% Binarización de la silueta fondo removido
umbral=graythresh(IFR);
IFRB1=im2bw(IFR,umbral); %Imagen tratada

%% Etiquetar elementos conectados

[ListadoObjetos Ne]=bwlabel(IFRB1);

%% Calcular propiedades de los objetos de la imagen
propiedades= regionprops(ListadoObjetos);

%% Buscar áreas de pixeles correspondientes a objetos
seleccion=find([propiedades.Area]);

%% obtenr coordenadas de areas
contadorObjetos=0; %encontrados
%numeroCuadro='';
%size(seleccion,2)
% consulta si existen objetos, puede venir una imagen vacía
if (size(seleccion,2)==0)
    %si no existen objetos coloca en cero todos los valores de
    %caracteristicas.
    fprintf('cantidad de objetos %i \n', contadorObjetos);
    promedioRGBR=0.0;
    promedioRGBG=0.0;
    promedioRGBB=0.0;
    desviacionRGBR=0.0;
    desviacionRGBG=0.0;
    desviacionRGBB=0.0;
    promedioLABL=0.0;
    promedioLABA=0.0;
    promedioLABB=0.0;
    desviacionLABL=0.0;
    desviacionLABA=0.0;
    desviacionLABB=0.0;
    promedioHSVH=0.0;
    promedioHSVS=0.0;
    promedioHSVV=0.0;
    desviacionHSVH=0.0;
    desviacionHSVS=0.0;
    desviacionHSVV=0.0;
    sumaArea=0;
    perimetro=0.0;
    excentricidad=0.0;
    ejeMayor=0.0;
    ejeMenor=0.0;
    entropia=0.0;
    inercia=0.0;
    energia=0.0;
    etiqueta='VACIO';
    x=0; 
    y=0;
    w=0;
    h=0;
    fila=sprintf('%s, %10i, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10i, %10i, %10i, %s \n', nombreImagenOriginal, numeroROI, contadorObjetos, promedioRGBR, promedioRGBG, promedioRGBB, desviacionRGBR, desviacionRGBG, desviacionRGBB, promedioLABL, promedioLABA, promedioLABB, desviacionLABL, desviacionLABA, desviacionLABB, promedioHSVH, promedioHSVS, promedioHSVV, desviacionHSVH, desviacionHSVS, desviacionHSVV, sumaArea, perimetro, excentricidad, ejeMayor, ejeMenor, entropia, inercia, energia, x, y, w, h,etiqueta);
    saveAVDefCalyx2( archivoVectorDef, fila);
    
%    fila=sprintf('%s, %10i, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %s \n', nombreImagenOriginal, numeroROI, contadorObjetos, promedioRGBR, promedioRGBG, promedioRGBB, desviacionRGBR, desviacionRGBG, desviacionRGBB, promedioLABL, promedioLABA, promedioLABB, desviacionLABL, desviacionLABA, desviacionLABB, promedioHSVH, promedioHSVS, promedioHSVV, desviacionHSVH, desviacionHSVS, desviacionHSVV, sumaArea, perimetro, excentricidad, ejeMayor, ejeMenor, entropia, inercia, energia, etiqueta);
%    guardarAVDefCalyx2( archivoVectorDef, fila)
    
    
else
%% ------------------------
for n=1:size(seleccion,2)
    contadorObjetos=contadorObjetos+1;
    coordenadasAPintar=round(propiedades(seleccion(n)).BoundingBox); %coordenadas de pintado
    %% recorta las imagenes

    ISiluetaROI = imcrop(IFRB1,coordenadasAPintar);
    IFondoR = imcrop(ImROI,coordenadasAPintar);
    
    %% INICIO extraer caracteristicas
    % las siluetas ya denen venir binarizadas con Otzu.
    [ promedioRGBR, promedioRGBG, promedioRGBB, desviacionRGBR, desviacionRGBG, desviacionRGBB ] = extractMeanCImgRGB( IFondoR, ISiluetaROI);
%    fprintf('%i, %f, %f, %f, %f, %f, %f \n',contadorObjetos, promedioR, promedioG, promedioB, desviacionR, desviacionG, desviacionB);

    [ promedioLABL, promedioLABA, promedioLABB, desviacionLABL, desviacionLABA, desviacionLABB ] = extractMeanCImgLAB( IFondoR, ISiluetaROI);
%    fprintf('%f, %f, %f, %f, %f, %f \n', promedioL, promedioA, promedioB, desviacionL, desviacionA, desviacionB);

    [ promedioHSVH, promedioHSVS, promedioHSVV, desviacionHSVH, desviacionHSVS, desviacionHSVV ] = extractMeanCImgHSV( IFondoR, ISiluetaROI);
%    fprintf('%f, %f, %f, %f, %f, %f \n', promedioH, promedioS, promedioV, desviacionH, desviacionS, desviacionV);

%    fprintf('contador objetos %i \n', contadorObjetos);    
    [ sumaArea, perimetro, excentricidad, ejeMayor, ejeMenor ] = extractDefCarGeoImg(ISiluetaROI);
%    fprintf('%10i, %10.4f, %10.4f, %10.4f, %10.4f, \n',  sumaArea, perimetro, excentricidad, ejeMayor, ejeMenor);    
    
    [ entropia, inercia, energia  ] = extractCTextures( IFondoR, ISiluetaROI);
    
    fprintf('%s, %10i, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %s \n', nombreImagenOriginal, numeroROI, contadorObjetos, promedioRGBR, promedioRGBG, promedioRGBB, desviacionRGBR, desviacionRGBG, desviacionRGBB, promedioLABL, promedioLABA, promedioLABB, desviacionLABL, desviacionLABA, desviacionLABB, promedioHSVH, promedioHSVS, promedioHSVV, desviacionHSVH, desviacionHSVS, desviacionHSVV, sumaArea, perimetro, excentricidad, ejeMayor, ejeMenor, entropia, inercia, energia, etiqueta); 
    %% FIN extraer caracteristicas  
%fprintf('En el archivo %s antes de correr el clasificador de DEFECTOS\n', archivoVectorDef);
    %% guardar el archivo
%    fila=sprintf('%s, %10i ,%10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %s \n', nombreImagenOriginal, numeroROI, contadorObjetos, promedioRGBR, promedioRGBG, promedioRGBB, desviacionRGBR, desviacionRGBG, desviacionRGBB, promedioLABL, promedioLABA, promedioLABB, desviacionLABL, desviacionLABA, desviacionLABB, promedioHSVH, promedioHSVS, promedioHSVV, desviacionHSVH, desviacionHSVS, desviacionHSVV, sumaArea, perimetro, excentricidad, ejeMayor, ejeMenor, entropia, inercia, energia, etiqueta); 
%    guardarAVDefCalyx2( archivoVectorDef, fila)
    
    fila=sprintf('%s, %10i, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10i, %10i, %10i, %10i, %s \n', nombreImagenOriginal, numeroROI, contadorObjetos, promedioRGBR, promedioRGBG, promedioRGBB, desviacionRGBR, desviacionRGBG, desviacionRGBB, promedioLABL, promedioLABA, promedioLABB, desviacionLABL, desviacionLABA, desviacionLABB, promedioHSVH, promedioHSVS, promedioHSVV, desviacionHSVH, desviacionHSVS, desviacionHSVV, sumaArea, perimetro, excentricidad, ejeMayor, ejeMenor, entropia, inercia, energia, coordenadasAPintar(1), coordenadasAPintar(2), coordenadasAPintar(3), coordenadasAPintar(4), etiqueta);
    saveAVDefCalyx2( archivoVectorDef, fila);
    
end % fin de ciclo

%% ------------------------
       
end% fin if



end %fin funcion

