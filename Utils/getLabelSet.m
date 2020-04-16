function data = getLabelSet()
    fprintf('\n-> Iniciando leitura do CSV com as labels...\n');
    tic
    data = readtable('..\Dataset\LabelSet.csv','ReadRowNames',true);
    toc
    fprintf('<- Finalizada a leitura do CSV com as labels.')
end