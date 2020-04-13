function data = getLabelSet(percentInicial, percentFinal)
    fprintf('\n-> Iniciando leitura do CSV com as labels...\n');
    tic
    table = readtable('..\Dataset\LabelSet.csv','ReadRowNames',true);
    qtdRegistros = size(table,1);
    
    inicio = fix(percentInicial * qtdRegistros + 1);
    fim = fix(percentFinal * qtdRegistros);
    
    data = table(inicio:fim,:);
    toc
    fprintf('<- Finalizada a leitura do CSV com as labels.')
end