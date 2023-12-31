% Clean
clear;
close all;


% Demo
tic;
A = rand(12000, 4400);
B = rand(12000, 4400);
disp(toc);

C = A .* B;
disp(toc);


% Script
sample_size = 5;
% generate n by x times
n = zeros(0, sample_size);
time = zeros(0, sample_size);
for i = 1 : 1 : sample_size
    n(i) = 10 .^ i;
end
% begin to cal time
tic;

% cal the sum and record the running time

for i = 1 : 1 : sample_size
    FindSum(n(i));
    time(i) = toc; % save the cal time into the array
end

% plot and style
figure;
plot(n, time);
title('Fig1 ExecTime to Num');
xlabel('Number n');
ylabel('Execution Time');

% compute the factorial of 5, 10, 15, 20
for i = 5 : 5 : 20
    disp(CalFactorial(i));
end


% Part 2 Re-design Lab2 Code
%% 



ErrorMAD(0.5);
ErrorMAPE(0.5);



% Function Def

% Find the sum of (1, n) and return
function [sum] = FindSum( n )
    sum_l = 0 ;   % clean the sum local var
    for i = 1 : 1 : n
        sum_l = sum_l + n;
    end
    sum = sum_l;
end

% Find the factorial of the input positive int n
function [factorial] = CalFactorial(n)
    % avoid the input is not positive int
    if((rem(n,1) ~= 0) || (n < 0)) 
        disp('n must be positive integer')
        return;
    end
    if (n > 0)
        factorial = n * CalFactorial(n - 1);
    else
        factorial = 1;
    end
end


% Computation of error between two solutions - mean abs difference
function [mad_err] = ErrorMAD(h)
    % Init mad err
    mad_err_l = 0;
    % Analy solution
    [va, ~] = AnalyticSolution(h);
    % Nume solution
    [vn, ~] = NumericalSolution(h);
    % Find the mean abs diff
    n = length(va);
    for t = 1 : 1 : (n - 1)
        mad_err_l = mad_err_l + abs(va(t) - vn(t));     % sum of the abs error
    end
    % mean() to find value
    % Find average
        mad_err = mad_err_l ./ n;
    disp('when h is');
    disp(h);
    disp('MeanAbsDifference is');
    disp(mad_err);
end

function [mape_err] = ErrorMAPE(h)
    % Init mad err
    mape_err_l = 0;
    % Analy solution
    [va, ~] = AnalyticSolution(h);
    % Nume solution
    [vn, ~] = NumericalSolution(h);
    % Find the mean abs diff
    n = length(va);
    for t = 1 : 1 : (n - 1)
        % sum of the abs error
        error_rate = abs(va(t) - vn(t));
        error_rate = error_rate ./ va(t) ./ 100;
        mape_err_l = mape_err_l + error_rate ;    
    end
    % Find average
        mape_err = mape_err_l ./ n;
        
    disp('when h is');
    disp(h);
    disp('MAPE is');
    disp(mape_err);
end

% Computation of analytic solution
function [v, t] = AnalyticSolution(h)
        % const
        m = 70;
        g = 9.81;
        c = 12.5;
        % find v
        t = 0 : h : 20.0;
        v = (g * m / c ) * ( 1 - exp ( - c * t / m ));

        % plot function part
        % if(plot_flag)
        %     figure("Name", fn); 
        %     plot(t, v, 'g+-', LineWidth = 3.0);
        %     title(fn);
        %     xlabel("t", "FontSize", 24);
        %     ylabel("volocity", "FontSize", 24);
        %     grid on;
        %     hold on;
        % end
end
% Computation of numerical solution
function [v, t] = NumericalSolution(h)
        % const
        % m = 70;
        % g = 9.81;
        % c = 12.5;
        % % find v
        t = 0 : h : 20.0;
        n = length(t);
        v = zeros(1, n);
        
        for i = 1 : n - 1
            slope = differential1(v(i));  %cal
            v(i + 1) = v(i) + slope * h;
        end

        % plot func
        % if(plot_flag)
        % plot(x, ns, 'ro-', LineWidth = 3.0);           %plot my fig
        % hold on;
        % end
end
%function_name : differential1
%function_description : find dy/dt
%slope = g - cvn/m
function [out_slope] = differential1(input_y)
    %Const Def
    g = 9.81;
    c = 12.5;
    m = 70;
    out_slope = g - ((c * input_y) / m); 
end
