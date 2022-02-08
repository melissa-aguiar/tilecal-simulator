clear, close

amp    = 1023;  %Amplitude máxima
med    = 30;    %Média da distribuição exponencial
ocp    = 30;    %Ocupação do sinal
rdo    = 1;     %Desvio padrão do ruído em ADC counts
fas    = 0;     %Desvio de fase do sinal
Ntrn   = 3.5e3; %Quantidade de amostras de treino
Ntst   = 3.5e3; %    || ... teste

for ocp = 10:5:90
    
    [eng,pos] = simdistuni(Ntrn,ocp,amp);
    [snl,eng] = conv_desvio(eng,0,pos);
    snl       = snl + randn(rdo,length(snl));
    save(['uniformdist_train_' num2str(ocp)],...
        'eng','snl');
end

for ocp = 10:5:90
    
    [eng,pos] = simdistexp(Ntst,ocp,med);
    [snl,eng] = conv_desvio(eng,0,pos);
    snl       = snl + randn(rdo,length(snl));
    save(['exponencialdist_test_' num2str(ocp)],...
        'eng','snl');
end

