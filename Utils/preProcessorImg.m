function Imgs = preProcessorImg(imagens)
    fprintf('\n\n-> Iniciando pré-processamento das imagens...\n')
    tic
    widthImage =  1024;
    heightImage = 768;
    imagensPreProcessadas = [];
    
    for image = imagens
        imagemReshaped = reshape(image, [heightImage,widthImage]);
%         imagemPreProcessada =  aplicarFiltro(imagemPreProcessada);
        imagemReshapedBack = reshape(imagemReshaped, [heightImage*widthImage,1]);
        imagensPreProcessadas = [imagensPreProcessadas, imagemReshapedBack];
    end
    Imgs = imagensPreProcessadas;
    
    toc
    fprintf('<- Finalizado o pré-processamento das imagens.')
end

function img = aplicarFiltro(imagem)
    img = imagem;
end