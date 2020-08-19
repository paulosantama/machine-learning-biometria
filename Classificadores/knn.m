function Md1 = knn(TrainImages, TrainLabels)
    fprintf('\n\n-> Modelo: KNN...');
    fprintf('\n-> Realizando Treinamento...\n');
    tic
    Md1 = fitcknn(TrainImages,TrainLabels,'NumNeighbors',6,'Distance','chebychev');
    toc
    fprintf('<- Treinamento Concluído.')
end