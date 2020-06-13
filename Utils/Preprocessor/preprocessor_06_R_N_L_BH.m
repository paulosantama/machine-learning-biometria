function I = preprocessor_06_R_N_L_BH(imagem)
    for y = 1:size(imagem,1)
        if imagem(y, size(imagem,2)) > 70
            yMaoSuperior = y;
            break
        end
    end
    for y = size(imagem,1):-1:1
        if imagem(y, size(imagem,2)) > 70
            yMaoInferior = y;
            break
        end
    end
    imagemCrop = imagem(yMaoSuperior:yMaoInferior, :);
    
    centroid = [fix(0.525*size(imagemCrop,1)), fix(0.5*size(imagemCrop,2))];
    d1 = 142;
    d2 = 200;

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
