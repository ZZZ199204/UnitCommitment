function [network, capacity, costs] = scenarios()

    %Capacidade de cada um dos tipos (MWh)
    capacity = [
            1350 % Nuclear 1350MWh
            600  % Carv�o 600MWh
            400  % Combined cycle with carbon capture 400MWh  
    ];
        
    %Custos por MWh de cada tipo
    costs = [
        90 % Nuclear 90$ / MWh
        140 % Carv�o 140$ / MWh
        100 % Combined cycle with carbon capture 100$ / MWh
    ];

    
    %Quantidade de Geradores Disponiveis de cada tipo
    network = [
        5  % Nuclear
        15 % Carv�o
        15 % Geotermicos
        ];
end 