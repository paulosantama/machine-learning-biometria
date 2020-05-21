clear;
close all; clc;

%% obtenção dos dados
tic
fprintf('Obtendo dados...\n')
rootFolder = 'E:\Pontificia Universidade Catolica de Goias\TCC\Projeto\saim\Dataset';
categories = {'23','25',...
    '27','29','31','32','34','35','36','37','38','39','40','41','42','43','44','45','46','48',...
    '49','50','51','52','55','56','57','58','59','60','62','63','64','65','66','67','70','72',...
    '73','75','76','77','79','81','84','85','86','87','88','89','90','93','94','95','96','98',...
    '99','102','103','104','105','106','107','108','109','110','112','114','115','116','117',...
    '118','119','120','121','122','123','124','125','127'};
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
imds.ReadFcn = @readFunctionTrain;

[trainingSet, testSet] = splitEachLabel(imds, 0.6);
toc
%% SVM
fprintf('\n\n-> Modelo: SVM...');
fprintf('\n-> Realizando Treinamento...\n');
tic

t = templateSVM();
Md1 = fitcecoc(trainingSet.readall, trainingSet.Labels,...
    'Learners',t,...
    'Options', statset('UseParallel',true));

toc
fprintf('<- Treinamento Concluído.')

%% Functions
function I = readFunctionTrain(filename)
I = imread(filename);
I = double(reshape(I, [size(I,1)*size(I,2), 1]));
end