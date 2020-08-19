function I = preprocessor_13_L_V_H_P(imagem)
    for x = 1:size(imagem,2)
        if sum(imagem(192:576, x, 1) > 70) > 10 || sum(imagem(192:576, x, 2) > 70) > 10 || sum(imagem(192:576, x, 3) > 70) > 10
            xMaoDedos = x;
            break
        end
    end
    imagemCropDedos = imagem(:, xMaoDedos:size(imagem,2), :);

    for y = 1:size(imagemCropDedos,1)
        if imagemCropDedos(y, size(imagemCropDedos,2)-150, 1) > 45 || imagemCropDedos(y, size(imagemCropDedos,2)-150, 2) > 45 || imagemCropDedos(y, size(imagemCropDedos,2)-150, 3) > 45
            yMaoSuperior = y;
            break
        end
    end
    for y = size(imagemCropDedos,1):-1:1
        if imagemCropDedos(y, size(imagemCropDedos,2)-10, 1) > 45 || imagemCropDedos(y, size(imagemCropDedos,2)-10, 2) > 45 || imagemCropDedos(y, size(imagemCropDedos,2)-10, 3) > 45
            yMaoInferior = y;
            break
        end
    end
    imagemCrop = imagemCropDedos(yMaoSuperior:yMaoInferior, :, :);

    centroid = [fix(0.45*size(imagemCrop,1)), fix(0.62*size(imagemCrop,2))];
    d1 = 75;
    d2 = 100;

    E1 = (centroid(1) - d1):(centroid(1) + d1);
    E2 = (centroid(2) - d2):(centroid(2) + d2);

    ROI = imagemCrop(E1,E2, :);
    
    ROI_filtered = medfilt3(ROI, [15,15,3],'symmetric');

    adaptHistEqualR = adapthisteq(ROI_filtered(:,:,1));
    adaptHistEqualG = adapthisteq(ROI_filtered(:,:,2));
    adaptHistEqualB = adapthisteq(ROI_filtered(:,:,3));

    adaptHistEqualRGB(:,:,1) = adaptHistEqualR;
    adaptHistEqualRGB(:,:,2) = adaptHistEqualG;
    adaptHistEqualRGB(:,:,3) = adaptHistEqualB;
    
%     folder = dir(['E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Preprocessed\' '*.tif']);
%     index = size(folder,1) + 1;
%     path = strcat('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Preprocessed\',int2str(index));
%     imwrite(adaptHistEqualRGB, strcat(path,'_mao.tif'));
    
    I = adaptHistEqualRGB;
end
