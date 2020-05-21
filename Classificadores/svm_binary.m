function Md1 = svm_binary(TrainImages, TrainLabels)
    fprintf('\n\n-> Modelo: SVM...');
    fprintf('\n-> Realizando Treinamento...\n');
    tic
    Md1 = fitcsvm(TrainImages,TrainLabels, 'BoxConstraint', 0.0010032, 'KernelScale', 962.55);
    toc
    fprintf('<- Treinamento Concluído.')
end