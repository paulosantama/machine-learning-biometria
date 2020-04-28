clear;
close all; clc;

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

cd('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Classificadores');
acuraria_knn = knn(TrainImages, TrainLabels, TestImages, TestLabels);
acuracia_tree = tree(TrainImages, TrainLabels, TestImages, TestLabels);

fprintf('\n\nExecução Finalizada.\n')