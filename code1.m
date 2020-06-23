clear;clc;
%总共信号数量 
num_signal = 10000;
y_label = [];
for i=1:num_signal
    if mod(i,2)==0
        y_label = [y_label, 1];
    else
        y_label = [y_label,-1];
    end
end
%disp(y_label)

h = 1e-6;
%disp(h)

%模拟构建数据集

x = y_label;
N = [];
for i = 0:((5e12-0)/3000):5e12
    N = [N,i];
end
sum_y = zeros(1,num_signal);
acc  = [];
acc_each = 0;
for n = N  %对于N中的元素
    for i = 1:num_signal %对于每个x
        w = normrnd(0,sqrt(n));  %均值为0 方差为1
        sum_y(i) = n*h*x(i)+ w;   
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

