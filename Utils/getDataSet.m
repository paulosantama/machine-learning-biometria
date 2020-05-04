function data = getDataSet(labels)
    fprintf('\n\n-> Iniciando obtenção das imagens...\n')
    tic
    
    data = [];
    baseFolder = strcat('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Dataset\');
    
    for label = transpose(labels)
        folderName = strcat(baseFolder,char(label));
        
        nomeImagemPrimaria = '\08_R_N_L_P.tif';
        nomeImagemSecundaria = '\08_R_N_L_P_1.tif';
        nomeImagemTerciaria = '\08_R_N_L_P_01.tif';
        
        if isfile(strcat(folderName, nomeImagemPrimaria))
            img = imread(strcat(folderName, nomeImagemPrimaria));
        elseif isfile(strcat(folderName, nomeImagemSecundaria))
            img = imread(strcat(folderName, nomeImagemSecundaria));
        else
            img = imread(strcat(folderName, nomeImagemTerciaria));
        end
            
        y = reshape(img, [size(img,1)*size(img,2), 1]);
        data = [data, y];
    end
    toc
    fprintf('<- Finalizada a obtenção das imagens.')
end