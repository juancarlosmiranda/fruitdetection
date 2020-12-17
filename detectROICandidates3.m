clc; clear all; close all;


%% Lectura de la imagen con fondo removido
%imagenNombreFR='/home/usuario/development/fruitdetection/testingImages/BD12_sup_201711_171_08_RGBhr.jpg1C1.jpg';
%imagenNombreFR='/home/usuario/development/fruitdetection/testingImages/BD12_sup_201711_171_08_RGBhr.jpg1C2.jpg';
imagenNombreFR='/home/usuario/development/fruitdetection/testingImages/BD12_sup_201711_171_08_RGBhr.jpgC2.jpg';
IFR=imread(imagenNombreFR);

%% Binarización de la silueta fondo removido
umbral=graythresh(IFR);
IFRB1=im2bw(IFR,umbral); %Imagen tratada

%% ------ABRIR IMAGEN ------------------
fh = figure;
imshow(IFR, 'border', 'tight'); %//show your image
hold on;

%% Etiquetar elementos conectados

[ListadoObjetos, Ne]=bwlabel(IFRB1);

%% Calcular propiedades de los objetos de la imagen
propiedades= regionprops(ListadoObjetos);

%% Buscar áreas de pixeles correspondientes a objetos
seleccion=find([propiedades.Area]);


%% obtenr coordenadas de areas
contadorObjetos=0; %encontrados
% consulta si existen objetos, puede venir una imagen vacía
if (size(seleccion,2)==0)
    %si no existen objetos coloca en cero todos los valores de
    %caracteristicas.
    fprintf('cantidad de objetos %i \n', contadorObjetos);
else
    %% ------------------------
    for n=1:size(seleccion,2)
        contadorObjetos=contadorObjetos+1;
        coordenadasAPintar=round(propiedades(seleccion(n)).BoundingBox); %coordenadas de pintado
        %% recorta las imagenes
        %ISiluetaROI = imcrop(IFRB1,coordenadasAPintar);
        %IFondoR = imcrop(ImROI,coordenadasAPintar);
        
        
        %% Ejecucion de prediccion
        fprintf('Clasificando REGIONES CANDIDATAS --> \n');
        %% selector para marcar en un windows
        rectangle('Position',propiedades(n).BoundingBox,'EdgeColor','g','LineWidth',2)
        text(propiedades(n).Centroid(:,1), propiedades(n).Centroid(:,2),int2str(n),'Color','b');
        hold on %se van a gregando a la figura principal
        
    end % fin de ciclo
    
    fprintf('Total objects detected %i \n', contadorObjetos);
    
end% fin if
