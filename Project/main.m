clear
close all;
clc;

P = 'F:\MYSPACE\CHUROU\Project\sample_photo\';
D = dir([P 'rank*.jpg']);
for i = 1 : length(D)
a = imread([P D(i).name]);
 figure;
imshow(a);
sigma=10;
 if size(a,3) > 1
      a = rgb2gray(a);
 end
 %a = edge(a ,'sobel'); %sobel算子锐化
 
%a=double(a);
imb=a;
%   ima=a+sigma*randn(size(a));
%   tic;
%   imb=NLmeansfilter(ima,5,2,sigma);
%   toc;

imc=Divide_Tsallis_1D(imb);
imwrite(imc,['F:\MYSPACE\CHUROU\Project\divide_photo\','r' num2str(i) '.jpg']); %title(['Tsallis Entropy T=', num2str(bestT)]);%输出为ri.jpg


end

P = 'F:\MYSPACE\CHUROU\Project\divide_photo\';
D = dir([P 'r*.jpg']);
for i = 1 : length(D)
b = imread([P D(i).name]);
 figure;
imshow(b);


% imread('F:\MYSPACE\CHUROU\Project\divide_photo\r1.jpg')
m=Shape(b);
n=Texture(b);
matrix_row=[m n];
if i==1
    temp=matrix_row;
    matrix=temp;
end

if i>1
   matrix=[matrix;matrix_row];
end


end
label=[1:length(D)-1 3]';
save svm.mat label matrix

%% 清空环境变量
clc
close all
%% 导入数据
load svm.mat
% 随机产生训练集和测试集
%n = randperm(size(matrix,1));
n=1:length(D);
% 训练集——80个样本
train_matrix = matrix(n(1:length(D)-1),:);
train_label = label(n(1:length(D)-1),:);
% 测试集——26个样本
test_matrix = matrix(n(length(D):end),:);
test_label = label(n(length(D):end),:);

%% 数据归一化
[Train_matrix,PS] = mapminmax(train_matrix');
Train_matrix = Train_matrix';
Test_matrix = mapminmax('apply',test_matrix',PS);
Test_matrix = Test_matrix';

%% SVM创建/训练(RBF核函数)

% 寻找最佳c/g参数——交叉验证方法
[c,g] = meshgrid(-10:0.2:10,-10:0.2:10);
[m,n] = size(c);
cg = zeros(m,n);
eps = 10^(-4);
v = 5;
bestc = 1;
bestg = 0.1;
bestacc = 0;
for i = 1:m
    for j = 1:n
        cmd = ['-v ',num2str(v),' -t 2',' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j))];
        cg(i,j) = svmtrain(train_label,Train_matrix,cmd);     
        if cg(i,j) > bestacc
            bestacc = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end        
        if abs( cg(i,j)-bestacc )<=eps && bestc > 2^c(i,j) 
            bestacc = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end               
    end
end
cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg)];
% 创建/训练SVM模型
model = svmtrain(train_label,Train_matrix,cmd);

%% SVM仿真测试
[predict_label_1,accuracy_1] = svmpredict(train_label,Train_matrix,model);
[predict_label_2,accuracy_2] = svmpredict(test_label,Test_matrix,model);
result_1 = [train_label predict_label_1];
result_2 = [test_label predict_label_2];

%% 绘图
figure
plot(1:length(test_label),test_label,'r-*')
hold on
plot(1:length(test_label),predict_label_2,'b:o')
grid on
legend('真实类别','预测类别')
xlabel('测试集样本编号')
ylabel('测试集样本类别')
string = {'测试集SVM预测结果对比(RBF核函数)';
          ['accuracy = ' num2str(accuracy_2(1)) '%']};
title(string)
% switch predict_label_2[length(D)]
%     case 1  
%     case 2
%     case 3
%     case 4
%     case 5
% end



