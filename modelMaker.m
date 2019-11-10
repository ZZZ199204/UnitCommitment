function model = modelMaker(dataset)
    [network, capacity, costs] = scenarios();
    
    names = {}
    for i = 1:72
        resto = mod(i,3)
        if resto == 0
            names = [names, strcat('N',num2str(i))]
        elseif resto == 1
            names = [names, strcat('C',num2str(i))]
        else
            names = [names, strcat('CC',num2str(i))] 
        end
    end
    model.varnames = names;
    clear resto;
    clear names;
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
    model.rhs = limites;
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