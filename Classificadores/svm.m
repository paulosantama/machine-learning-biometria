function Md1 = svm(TrainImages, TrainLabels)
    fprintf('\n\n-> Modelo: SVM...');
    fprintf('\n-> Realizando Treinamento...\n');
    tic

    t = templateSVM();
    Md1 = fitcecoc(TrainImages, TrainLabels,...
        'Learners',t,...
        'Options', statset('UseParallel',true));
    
    toc
    fprintf('<- Treinamento Concluído.')
end