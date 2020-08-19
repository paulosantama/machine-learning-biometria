function I = preprocessor_02_R_N_H_BH(imagem)
    for x = 1:size(imagem,2)
        if sum(imagem(192:576, x) > 90) > 10
            xMaoDedos = x;
            break
        end
    end
    imagemCropDedos = imagem(:, xMaoDedos:size(imagem,2));

    for y = 1:size(imagemCropDedos,1)
        if imagemCropDedos(y, fix(size(imagemCropDedos,2)/2)) > 70
            yMaoSuperior = y;
            break
        end
    end
    for y = size(imagemCropDedos,1):-1:1
        if imagemCropDedos(y, 100) > 70
            yMaoInferior = y;
            break
        end
    end
    imagemCrop = imagemCropDedos(yMaoSuperior:yMaoInferior, :);

    centroid = [fix(0.55*size(imagemCrop,1)), fix(0.59*size(imagemCrop,2))];
    d1 = 85;
    d2 = 100;

    E1 = (centroid(1) - d1):(centroid(1) + d1);
    E2 = (centroid(2) - d2):(centroid(2) + d2);

    ROI = imagemCrop(E1,E2);
    
    ROI = medfilt2(ROI, [16,16],'symmetric');
    
    adaptHistEqual = adapthisteq(ROI);
    
%     folder = dir(['E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Preprocessed\' '*.tif']);
%     index = size(folder,1) + 1;
%     path = strcat('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Preprocessed\',int2str(index));
%     imwrite(adaptHistEqual, strcat(path,'_mao.tif'));
    
    I = adaptHistEqual;
end
