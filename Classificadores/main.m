clear;
close all; clc;

%% obten��o dos dados
tic
fprintf('Obtendo dados...\n')
% rootFolder = 'E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Dataset';
% categories = {'23','25',...
%     '27','29','31','32','34','35','36','37','38','39','40','41','42','43','44','45','46','48',...
%     '49','50','51','52','55','56','57','58','59','60','62','63','64','65','66','67','70','72',...
%     '73','75','76','77','79','81','84','85','86','87','88','89','90','93','94','95','96','98',...
%     '99','102','103','104','105','106','107','108','109','110','112','114','115','116','117',...
%     '118','119','120','121','122','123','124','125','127'};
% imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
% % imds.ReadFcn = @readFunctionTrain;
% 
% [trainingSet, testSet] = splitEachLabel(imds, 0.6);
% 
% bag = bagOfFeatures(trainingSet);
% trainFeatures = encode(bag, trainingSet);

load("Workspace\workspace_16_L_N_L_BH_bagOfFeatures.mat");

toc
%% SVM
fprintf('\nRealizando Treinamento...\n');
tic

rng default
t = templateSVM('BoxConstraint', 0.018576,...
    'KernelScale', 0.0023518);
Md1 = fitcecoc(trainFeatures, trainingSet.Labels,...
    'Learners',t,...
    'Coding', 'onevsall',...
    'Options', statset('UseParallel',true));


% Mdl = fitcecoc(trainFeatures, trainingSet.Labels,...
%     'OptimizeHyperparameters','auto',...
%     'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
%     'expected-improvement-plus',...
%     'UseParallel',true,...
%     'ShowPlots',false,...
%     'Verbose',1))

toc
%% Prepara��o dos dados de teste
tic

testFeatures = encode(bag, testSet);

toc
%% Testando modelo
tic

[pred score cost] = predict(Md1, testFeatures);
accuracy = sum(testSet.Labels == pred)/size(testSet.Labels,1);

toc