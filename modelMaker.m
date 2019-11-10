function model = modelMaker(dataset)
    [network, capacity, costs] = scenarios();

    %%Construção da função objetivo
    objetivo = zeros(1,72)
    for i  = 1:3
        for j = 1:24
            index = (i-1)*24 + j;
            objetivo(index) = costs(i);
        end
    end
    model.obj = objetivo;
    clear objetivo;
    
    
    %% Restrição para garantir que a geração atenda a demanda
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
    
    
    
    %% Restrição para limitar a quantidade de geradores de acordo com o tipo
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
    
    %% Construção das restrições
    restricoes = [geracao; rede]
    limites = [demanda; limiteRede]
    tipoRestricao = strcat(restricaoDemanda, restricaoRede)
    model.A = sparse(restricoes)
    model.b = limites.';
    model.sense = tipoRestricao;
    
    
    
    
    %% Liberando memória
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
    
    
    %% Definição dos parametros
    model.modelsense ='min';
    model.vtype = 'I';
    model.lb = zeros(1,72);
    model.ub = zeros(1,72)+ 20;%%
   


end