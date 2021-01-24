%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%该程序用于测试样本的识别 
load('..\data.mat','V1','V2','averg','ni')
d=[];
%以下代码段用来估计最小距离分类器的错误率
%验证
cc=68;%样本类别数 
n=31;%每个类别的待识别样本数
e=0;
for j=1:cc
	for i=26:n
		str=strcat('..\test\',(int2str(j)),'\',(int2str(j)),'-',(int2str(i)),'.bmp');
		img=(imread(str));	%灰度化
		sum10=V2*double(img)*V1;	%将待识别的样本矩阵投影到识别空间
		dd=[];
		for l=1:cc
		   d(l)=norm(sum10-averg(:,:,l)); %计算距离
		   dd=[dd d(l)];
		end
		mind=min(dd(1:cc));	%找到最小距离
		if(d(j)~=mind) 		%标签与预测不等时
			e=e+1;
		end
	end
end;
fpca=mat2gray(sum10(:,:,:));
imwrite(fpca, 'fpca.jpg');
disp('错分类的样本数为：');
disp(e);
disp('识别率：');
disp(1-e/(cc*(n-ni)));
