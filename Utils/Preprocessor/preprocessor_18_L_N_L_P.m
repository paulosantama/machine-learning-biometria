function I = preprocessor_18_L_N_L_P(imagem)
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
    
    centroid = [fix(0.45*size(imagemCrop,1)), fix(0.62*size(imagemCrop,2))];
    d1 = 120;
    d2 = 250;

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
