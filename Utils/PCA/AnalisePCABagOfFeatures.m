%% Inicialização
clc; clear

%% Obtenção dos dados
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
imds.ReadFcn = @preprocessor;
cd("..\Preprocessor")
toc
%% Preparação dos dados
tic
bag = bagOfFeatures(imds);
allFeatures = encode(bag, imds);
beep
toc
%% Gerando PC's
tic
fprintf("Gerando PC's...\n")
allFeatures = transpose(allFeatures);
[coeff,score,latent,tsquared,explained] = pca(allFeatures);
% load workspace_bagOfFeatures_pca.mat
toc
%% Plotando PCA
idxColor = 1;
load colorsScheme.mat
for i = 1:5:size(imds.Files,1)    
    scatter3(coeff(i:i+4,1), coeff(i:i+4,2), coeff(i:i+4,3), 50, color(idxColor,:), 'filled');
    hold on;
    idxColor = idxColor+1;
end

%% functions
function I = preprocessor(file)
    I = imread(file);
    I = preprocessor_16_L_N_L_BH(I);
end