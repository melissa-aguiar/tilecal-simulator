%% Função faz a convolução de 2 sinais caso o desvio seja 0 e simula um desvio de fase e convolui caso o desvio seja 1;
%devemos passar para esta função:
%S_truth primeiro sinal a ser convoluido 
%desvio ou nao = 0 ou 1;
% posição1=posição dos pulsos
% coluna da matriz caso queira alterar basta substituir o numero 6 na linha
% 27 da função

function [sinal1,S_truth] = conv_longtail_tilecal_pulse(S_truth,desvio,posicao1)
%% sorteando os desvios de fase 

load pulsos_fases_calda_100n
matriz_sorteio = matrix;

%% sinal da distribuição "CONVOLUÇÃO"
[N_A,c] = size(matriz_sorteio);
fase_posicao = randi([1,c],1,length(posicao1));                            %Realizo o sorteio do desvio de fase de -11 a +11 ns
centro = 50;
matriz_sorteio(1:end, centro) = matriz_sorteio(1:end, centro);
% centro = .5 + c/2;
a = N_A/2;
sinal1 = zeros(1,length(S_truth) + N_A - 1);                         %criando o sinal1 com o comprimento de termos da convolução
S_truth1 = [(zeros(1,a)) S_truth (zeros(1,a))];                      % colocando zeros nas bordas do sinal truth para entrar na "convolução" 
jj = 1;
for i = 1+a:length(S_truth1)-a
    aux = zeros(1,N_A);
    if S_truth1(i)~=0
        if desvio == 1   
            for j = 1:N_A                                              
                aux(j) = S_truth1(i)*matriz_sorteio(j,fase_posicao(jj));   % algoritmo que convolui sorteando o desvio de fase 
            end                                                            % caso queira apenas a convolução basta mudar  o vetor matrix para o vetor a ser convoluido 
        else
            for j = 1:N_A  
                aux(j) = S_truth1(i)*matriz_sorteio(j,centro);                       %caso o desvio de fase nao seja simulado basta escolher aqui a coluna da matriz sorteio central para convolução neste caso 6 
            end
        end   
        jj=jj+1;  
    end
    sinal1(i-a:i+a-1) = aux + sinal1(i-a:i+a-1);                        %caso queira convoluir com apenas uma fase da matrix substituir fase posição pelo numero da coluna da fase
%     sinal1          = sinal1(a:end-a);
end
sinal1 = sinal1(4:end-2*a+4);

