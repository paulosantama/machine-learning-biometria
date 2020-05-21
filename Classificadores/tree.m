function Md1 = tree(TrainImages, TrainLabels)
    fprintf('\n\n-> Modelo: Decision Tree...');
    fprintf('\n-> Realizando Treinamento...\n');
    tic
    Md1 = fitctree(TrainImages,TrainLabels,'MinLeafSize',55);
    toc
    fprintf('<- Treinamento Concluído.')
end