clear; close all; clc;

cd('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Utils');

% porcentagemTreino = 0.7;
% 
% fprintf('Obtendo dados...\n')
% labels = getLabelSet();
% images = transpose(getDataSet(labels.Properties.RowNames));

load('..\Utils\workspace.mat');

imagesPreProcessed = preProcessorImg(transpose(images));
labels = labels(:,1);

TrainImages = double(imagesPreProcessed(1:fix(size(imagesPreProcessed,1)*porcentagemTreino), :));
TrainLabels = grp2idx(table2array(labels(1:fix(size(labels,1)*porcentagemTreino), :)));

TestImages = double(imagesPreProcessed(fix(size(imagesPreProcessed,1)*porcentagemTreino)+1: size(imagesPreProcessed,1), :));
TestLabels = grp2idx(table2array(labels(fix(size(labels,1)*porcentagemTreino)+1: size(labels,1), :)));

fprintf('\n\n-> Realizando Treinamento...\n');
tic
Md1 = fitcknn(TrainImages,TrainLabels,'NumNeighbors',6,'Distance','chebychev');
toc
fprintf('<- Treinamento Concluído.')

fprintf('\n\n-> Realizando Teste...\n');
tic
y_predicted_md1 = predict(Md1, double(TestImages));
acuracia_md1 = sum(y_predicted_md1 == TestLabels)/length(TestLabels)*100;
toc
fprintf('<- Teste Concluído.')

fprintf('\n\nExecução Finalizada.\n')
cd('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Classificadores');