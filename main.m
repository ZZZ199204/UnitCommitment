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

domingo = (table.Datetime >= '2017-08-13 00:00:00' & table.Datetime < '2017-08-13 23:59:59');
domingo = table(domingo,:);

clear table;
fprintf('Data Cleaning done :)\n');



%% Model creation
fprintf('Creating models\n');
modeloSegunda = modelMaker(segunda);
modeloDomingo = modelMaker(domingo);

fprintf('Models created:)\n');


%% Start processing

params.outputflag = 0;
resultSegunda = gurobi(modelSegunda, params);
resultDomingo = gurobi(modelDomingo, params);






