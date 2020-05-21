clear;
close all; clc;
cd('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Utils');

%% obtenção dos dados
porcentagemTreino = 0.7;
% rng(5)

fprintf('Obtendo dados...\n')
labels = getLabelSet();
% labels = labels(randperm(size(labels,1)),:);
labels_idx = grp2idx(table2array(labels(:,1)));
images = transpose(getDataSet(labels.Properties.RowNames));

% load('..\Utils\workspace_16_L_N_L_BH.mat');
%% pré-processamento dos dados
imagesPreProcessed = preProcessorImg(transpose(images));
labels = labels(:,1);

%% separação dos dados
rng(2)
TrainImages = double(imagesPreProcessed(1:fix(size(imagesPreProcessed,1)*porcentagemTreino), :));
TrainLabels = labels_idx(1:fix(size(labels,1)*porcentagemTreino), :);

TrainImages = TrainImages(randperm(size(TrainImages,1)),:);
TrainLabels = TrainLabels(randperm(size(TrainLabels,1)),:);

TestImages = double(imagesPreProcessed(fix(size(imagesPreProcessed,1)*porcentagemTreino)+1: size(imagesPreProcessed,1), :));
TestLabels = labels_idx(fix(size(labels,1)*porcentagemTreino)+1: size(labels,1), :);

%% SVM
cd('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Classificadores');
MdSVM = svm_binary(TrainImages, TrainLabels);

fprintf('\n\n-> Realizando Teste...\n');
tic
y_predicted_MdSVM = predict(MdSVM, double(TestImages));
MdSVM_acuracia = sum(y_predicted_MdSVM == TestLabels)/length(TestLabels)*100;
toc
fprintf('<- Teste Concluído.')

%% KNN
cd('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Classificadores');
MdKNN = svm_binary(TrainImages, TrainLabels);

fprintf('\n\n-> Realizando Teste...\n');
tic
y_predicted_MdKNN = predict(MdKNN, double(TestImages));
MdKNN_acuracia = sum(y_predicted_MdKNN == TestLabels)/length(TestLabels)*100;
toc
fprintf('<- Teste Concluído.')

%% Decision Tree
cd('E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Classificadores');
MdTREE = tree(TrainImages, TrainLabels);

fprintf('\n\n-> Realizando Teste...\n');
tic
y_predicted_MdTREE = predict(MdTREE, double(TestImages));
MdTREE_acuracia = sum(y_predicted_MdTREE == TestLabels)/length(TestLabels)*100;
toc
fprintf('<- Teste Concluído.')

%% finalização da execução
fprintf('\n\nExecução Finalizada.\n')