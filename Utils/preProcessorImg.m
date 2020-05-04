function Imgs = preProcessorImg(imagens)
fprintf('\n\n-> Iniciando pré-processamento das imagens...\n')
tic
widthImage =  1024;
heightImage = 768;
imagensPreProcessadas = [];

i = 1;
for image = imagens
    imagemReshaped = reshape(image, [heightImage,widthImage]);
    imagemPreProcessada =  aplicarFiltro(imagemReshaped);
    
%     path = strcat('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Preprocessed\',int2str(i));
%     imwrite(imagemPreProcessada, strcat(path,'_mao.tif'));
    
    imagemReshapedBack = reshape(imagemPreProcessada, [1, size(imagemPreProcessada,1)*size(imagemPreProcessada,2)]);
    imagensPreProcessadas = [imagensPreProcessadas; imagemReshapedBack];
    i = i+1;
end
Imgs = imagensPreProcessadas;

toc
fprintf('<- Finalizado o pré-processamento das imagens.')
end

function img = aplicarFiltro(imagem)
    centroid = [size(imagem, 2)/2+50, size(imagem, 1)/2+15];
    d1 = 250;
    d2 = 225;

    E1 = (centroid(2) - d2):(centroid(2) + d2);
    E2 = (centroid(1) - d1):(centroid(1) + d1);

    ROI = imagem(E1,E2);
    
    ROI = medfilt2(ROI, [5,5]);
    
    adaptHistEqual = adapthisteq(ROI);
    
    img = adaptHistEqual;
end