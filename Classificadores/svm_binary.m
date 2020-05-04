function acuracia_md1 = svm_binary(TrainImages, TrainLabels, TestImages, TestLabels)
    fprintf('\n\n-> Modelo: SVM...');
    fprintf('\n-> Realizando Treinamento...\n');
    tic
    Md1 = fitcsvm(TrainImages,TrainLabels, 'BoxConstraint', 0.0010032, 'KernelScale', 962.55);
    toc
    fprintf('<- Treinamento Concluído.')

    fprintf('\n\n-> Realizando Teste...\n');
    tic
    y_predicted_md1 = predict(Md1, double(TestImages));
    acuracia_md1 = sum(y_predicted_md1 == TestLabels)/length(TestLabels)*100;
    toc
    fprintf('<- Teste Concluído.')
end