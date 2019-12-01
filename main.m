%% Environment Cleaning
close all;
clear;
clc;

%% Data cleaning
fprintf('Data Cleaning in progress\n');
table = readtable('./datasets/AEP_hourly.csv');

filtro = (table.Datetime >= '2017-08-07 00:00:00' & table.Datetime < '2017-08-14 00:00:00');
table = table(filtro, :);
clear filtro;

segunda = (table.Datetime >= '2017-08-07 00:00:00' & table.Datetime < '2017-08-07 23:59:59');
segunda = table(segunda,:);
segunda.Properties.VariableNames = {'datahora', 'MW'}

domingo = (table.Datetime >= '2017-08-13 00:00:00' & table.Datetime < '2017-08-13 23:59:59');
domingo = table(domingo,:);
domingo.Properties.VariableNames = {'datahora', 'MW'}

clear table;

segunda = sortrows(segunda, 'datahora');
domingo = sortrows(domingo, 'datahora');


fprintf('Data Cleaning done :)\n');



%% Model creation
fprintf('Creating models\n');


modeloSegunda = modelMaker(segunda);
modeloDomingo = modelMaker(domingo);
fprintf('Models created:)\n');


%% Memory Cleaning
%clear segunda;
%clear domingo;

%% Start processing
params.outputflag = 1;
resultSegunda = gurobi(modeloSegunda, params);
resultDomingo = gurobi(modeloDomingo, params);

%producao = [13150	12150	11550	11550	10950	10950	10950	10950	11550	12150	12750	13550	14350	14750	15550	15950	16350	16750	17150	16750	16350	15950	15550	14750];
%producaoSegunda = [12750	12150	11550	11550	11550	11550	12150	13950	14550	14550	15150	15750	15750	15750	16150	16150	16550	16550	16550	16150	15750	15750	15750	14550]

%producaoSegunda = [12750	12150	11550	11550	11550	11550	12150	13350	13950	14550	14550	15150	15750	15750	16150	16150	16550	16550	16550	16150	15750	15750	15750	14550]
%plot(segunda.datahora, segunda.MW)
%hold on
%lot(segunda.datahora, producaoSegunda)
%hold off


%plot(domingo.datahora, domingo.MW)
%hold on
%plot(domingo.datahora, producao)
%hold off





