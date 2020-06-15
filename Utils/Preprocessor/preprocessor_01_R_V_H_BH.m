function I = preprocessor_01_R_V_H_BH(imagem)
    for x = 1:size(imagem,2)
        if sum(imagem(192:576, x, :) > 50) > 10
            xMaoDedos = x;
            break
        end
    end
    imagemCropDedos = imagem(:, xMaoDedos:size(imagem,2), :);

    for y = 1:size(imagemCropDedos,1)
        if imagemCropDedos(y, fix(size(imagemCropDedos,2)/2), :) > 45
            yMaoSuperior = y;
            break
        end
    end
    for y = size(imagemCropDedos,1):-1:1
        if imagemCropDedos(y, 100, :) > 45
            yMaoInferior = y;
            break
        end
    end
    imagemCrop = imagemCropDedos(yMaoSuperior:yMaoInferior, :, :);

    centroid = [fix(0.52*size(imagemCrop,1)), fix(0.595*size(imagemCrop,2))];
    d1 = 85;
    d2 = 100;

    E1 = (centroid(1) - d1):(centroid(1) + d1);
    E2 = (centroid(2) - d2):(centroid(2) + d2);

    ROI = imagemCrop(E1,E2,:);
    
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
