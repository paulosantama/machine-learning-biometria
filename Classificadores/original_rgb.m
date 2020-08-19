clear;
close all; clc;

%% Obtenção dos dados
tic
fprintf('Obtendo dados...\n')
rootFolder = 'E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Dataset';
categories = {'23','25',...
    '27','29','31','32','34','35','36','37','38','39','54','41','42','43','44','47','46','48',...
    '49','50','51','52','55','56','57','58','59','60','62','63','64','65','66','67','70','72',...
    '73','75','76','77','79','81','84','85','86','87','88','89','90','93','94','95','96','98',...
    '99','102','103','104','105','106','107','108','109','110','112','114','115','116','117',...
    '118','119','120','121','122','123','124','125','127'};
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
imds.ReadFcn = @readFunction;

[trainingSet, testSet] = splitEachLabel(imds, 3);
toc
%% Preparação dos dados
tic

sizeConcat = size(trainingSet.readimage(1),1)*size(trainingSet.readimage(1),2)*3;
concatImageMatrixTrain = zeros(size(trainingSet.Files,1), sizeConcat);
for i = 1:size(trainingSet.Files,1)
    img = trainingSet.readimage(i);
    concatImageMatrixTrain(i, :) = reshape(img, [1, size(img,1)*size(img,2)*3]);
end

toc
fprintf('\nRealizando Treinamento...\n');
%% SVM
% tic
% 
% t = templateSVM();
% Md1 = fitcecoc(concatImageMatrixTrain, transpose(trainingSet.Labels),...
%     'Learners',t);
% 
% beep
% toc
%% KNN
tic

Md1 = fitcknn(concatImageMatrixTrain,transpose(trainingSet.Labels));

toc
%% Preparação dos dados de teste
tic

concatImageMatrixTest = zeros(size(testSet.Files,1),sizeConcat);
for i = 1:size(testSet.Files,1)
    img = testSet.readimage(i);
    concatImageMatrixTest(i, :) = reshape(img, [1, size(img,1)*size(img,2)*3]);
end

toc
%% Testando modelo
tic

[pred score cost] = predict(Md1, concatImageMatrixTest);
accuracy = sum(testSet.Labels == pred)/size(testSet.Labels,1); 

beep
toc
%% functions
function I = readFunction(file)
    I = imread(file);
    I = imresize(I, 0.4, 'nearest');
end