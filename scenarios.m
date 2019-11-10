function [network, capacity, costs] = scenarios()

    %Capacidade de cada um dos tipos (MWh)
    capacity = [
            1350 % Nuclear 1350MWh
            600  % Carvão 600MWh
            400  % Combined cycle with carbon capture 400MWh  
    ];
        
    %Custos por MWh de cada tipo
    costs = [
        90 % Nuclear 90$ / MWh
        140 % Carvão 140$ / MWh
        100 % Combined cycle with carbon capture 100$ / MWh
    ];

    
    %Quantidade de Geradores Disponiveis de cada tipo
    network = [
        5  % Nuclear
        15 % Carvão
        15 % Geotermicos
        ];
end 