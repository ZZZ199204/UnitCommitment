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
clear segunda;
clear domingo;

%% Start processing

params.outputflag = 0;
resultSegunda = gurobi(modeloSegunda, params);
resultDomingo = gurobi(modeloDomingo, params);






