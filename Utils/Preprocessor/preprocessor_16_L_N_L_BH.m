function I = preprocessor_16_L_N_L_BH(imagem)
    centroid = [360, 520];
    d1 = 250;
    d2 = 280;

    E1 = (centroid(1) - d1):(centroid(1) + d1);
    E2 = (centroid(2) - d2):(centroid(2) + d2);

    ROI = imagem(E1,E2);
    
    ROI = medfilt2(ROI, [16,16],'symmetric');
    
    adaptHistEqual = adapthisteq(ROI);
    
    I = adaptHistEqual;
end
