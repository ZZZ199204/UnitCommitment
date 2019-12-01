    rede = zeros(72,3);
    limiteRede = zeros(72,1);
    for i = 1:3
        for j = 1:24
            index = (i-1)*24 + j;
            rede(index,i) = 1;
            limiteRede(index) = network(i);
        end
    end