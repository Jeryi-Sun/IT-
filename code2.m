clear;clc;
%总共信号数量 
num_signal = 1000;
y_label = [];
for i=1:num_signal
    if mod(i,2)==0
        y_label = [y_label, 1];
    else
        y_label = [y_label,-1];
    end
end

h = 1e-3;

%模拟构建数据集

x = y_label;
N = [];
for i = 2e4:((5e6-2e4)/500):5e6
    N = [N,i];
end
sum_y = zeros(1,num_signal);
acc  = [];
acc_each = 0;
for n = N  %对于N中的元素
        
        w = zeros(1,num_signal);
        for j = 1:n
            w = w+randn(1,num_signal);
        end
        for i = 1:num_signal %对于每个x
            sum_y(i) = n*h*x(i)+ w(i);   
            if sum_y(i) >0
                sum_y(i) = 1;
            else
                sum_y(i) = -1;
            end
        end
    count_e = 0;
    for zz =1:num_signal
        if sum_y(zz)==x(zz)
            count_e = count_e+1;
        end
    end
    acc_each = count_e/num_signal;
    acc = [acc,acc_each];
    sum_y = zeros(1,num_signal); %清零操作
end

for i = 1:1:(size(acc,2))
    acc(i)=1-acc(i);
end
figure;
plot(N,acc);
set(gca, 'Fontname', 'Times New Roman','FontSize',12);

xlabel('N for each signal','Fontname', 'Times New Roman','FontSize',12);

ylabel('BER','Fontname', 'Times New Roman','FontSize',12);

disp(acc);




    
