clear; close all; clc;

cd('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\Utils');

% porcentagemTreino = 0.7;
% porcentagemTeste = 0.3;
% 
% fprintf('Lendo dados para treinamento...\n')
% TrainLabels = getLabelSet(0,porcentagemTreino);
% TrainImages = getDataSet(TrainLabels.Properties.RowNames);
% 
% fprintf('\n\nLendo dados para teste...\n')
% TestLabels = getLabelSet(porcentagemTreino, porcentagemTreino + porcentagemTeste);
% TestImages = getDataSet(TestLabels.Properties.RowNames);

load('..\Utils\workspace.mat');

y_train = TrainLabels(:,1);
X_train = preProcessorImg(TrainImages);
X_train = transpose(X_train);

y_test = TestLabels(:,1);
X_test = preProcessorImg(TestImages);
X_test = transpose(X_test);

y_train_number = grp2idx(table2array(y_train));
y_test_number = grp2idx(table2array(y_test));

fprintf('\n\n-> Realizando Treinamento...\n');
tic
Md1 = fitcknn(double(X_train),y_train_number,'NumNeighbors',5,'Standardize',1);
toc
fprintf('<- Treinamento Concluído.')
y_predicted_md1 = predict(Md1, double(X_test));
acuracia_md1 = sum(y_predicted_md1 == y_test_number)/length(y_test_number)*100;

fprintf('\n\nExecução Finalizada.\n')
cd('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\Classificadores');