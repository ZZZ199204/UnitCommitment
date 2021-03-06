function model = modelMaker(dataset)
    [network, capacity, costs] = scenarios();
    
    
    %%Constru��o da fun��o objetivo
    objetivo = zeros(1,72)
    for i  = 1:3
        for j = 1:24
            index = (i-1)*24 + j;
            objetivo(index) = costs(i);
        end
    end
    model.obj = objetivo;
    clear objetivo;
    
    
    %% Restri��o para garantir que a gera��o atenda a demanda
    geracao = zeros(24,72);
    demanda = dataset.MW;
    restricaoDemanda ='';
    
    for i = 1:24
        for j = 1:3
            index = (i-1)*3;
            geracao(i,index+j) = capacity(j);
        end
        restricaoDemanda = strcat(restricaoDemanda, '>');
    end
    
    %% 5%
    geracao2 = zeros(24,72);
    demanda2 = dataset.MW*1.05;
    restricaoDemanda2 ='';
    
    for i = 1:24
        for j = 1:3
            index = (i-1)*3;
            geracao2(i,index+j) = capacity(j);
        end
        restricaoDemanda2 = strcat(restricaoDemanda2, '<');
    end
    
    %% Restri��o para limitar a quantidade de geradores de acordo com o tipo
    rede = eye(72);
    
    limiteRede = zeros(72,1);
    restricaoRede = '';
    for i = 1:24
        for j = 1:3
            index = (i-1)*3 + j;
            limiteRede(index) = network(j);
            restricaoRede = strcat(restricaoRede, '<');
        end
    end
    
    %% Constru��o das restri��es
    restricoes = [geracao; geracao2; rede]
    limites = [demanda; demanda2; limiteRede]
    tipoRestricao = strcat(restricaoDemanda,restricaoDemanda2, restricaoRede)
    model.A = sparse(restricoes)
    model.rhs = limites;
    model.sense = tipoRestricao;
    
    
    
    
    %% Liberando mem�ria
    clear geracao;
    clear rede;
    clear restricoes;
    clear limites;
    clear tipoRestricao;
    clear demanda;
    clear limiteRede;
    clear capacity;
    clear costs;
    clear i;
    clear j;
    clear network;
    clear restricaoRede;
    clear restricaoDemanda;
    
    
    %% Defini��o dos parametros
    model.modelsense ='min';
    model.vtype = 'I';
    model.lb = zeros(1,72);
    model.ub = zeros(1,72)+ 20;%%
   


end