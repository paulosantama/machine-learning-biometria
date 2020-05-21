function data = getLabelSet()
    fprintf('\n-> Iniciando leitura do CSV com as labels...\n');
    tic
    data = readtable('..\Dataset\LabelSet - 16_L_N_L_BH.csv','ReadRowNames',true);
    toc
    fprintf('<- Finalizada a leitura do CSV com as labels.')
end