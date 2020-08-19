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
    
    path = strcat('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Preprocessed\',int2str(i));
    imwrite(imagemPreProcessada, strcat(path,'_mao.tif'));
    imagemReshapedBack = reshape(imagemPreProcessada, [1, size(imagemPreProcessada,1)*size(imagemPreProcessada,2)]);
    imagensPreProcessadas = [imagensPreProcessadas; imagemReshapedBack];
    i = i+1;
end
Imgs = imagensPreProcessadas;

toc
fprintf('<- Finalizado o pré-processamento das imagens.')
end

function img = aplicarFiltro(imagem)
    centroid = [360, 520];
    d1 = 195;
    d2 = 220;

    E1 = (centroid(1) - d1):(centroid(1) + d1);
    E2 = (centroid(2) - d2):(centroid(2) + d2);

    ROI = imagem(E1,E2);

    ROI = medfilt2(ROI, [16,16]);

    adaptHistEqual = adapthisteq(ROI);

    L = imsegkmeans(adaptHistEqual,2);
    B = labeloverlay(adaptHistEqual,L);

    img = imbinarize(B);
    imgBinarize1 = img(:,:,1);

    imgYcbcr = rgb2ycbcr(uint8(img*255));

    se2 = strel('disk',4);

    imgErode2 = imerode(~imbinarize(imgYcbcr(:,:,2)),se2);
    imgEroDil = imdilate(imgErode2, se2);

    img = imgBinarize1;
%     img = ROI;
end