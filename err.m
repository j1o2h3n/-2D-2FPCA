%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ó������ڲ���������ʶ�� 
load('..\data.mat','V1','V2','averg','ni')
d=[];
%���´��������������С����������Ĵ�����
%��֤
cc=68;%��������� 
n=31;%ÿ�����Ĵ�ʶ��������
e=0;
for j=1:cc
	for i=26:n
		str=strcat('..\test\',(int2str(j)),'\',(int2str(j)),'-',(int2str(i)),'.bmp');
		img=(imread(str));	%�ҶȻ�
		sum10=V2*double(img)*V1;	%����ʶ�����������ͶӰ��ʶ��ռ�
		dd=[];
		for l=1:cc
		   d(l)=norm(sum10-averg(:,:,l)); %�������
		   dd=[dd d(l)];
		end
		mind=min(dd(1:cc));	%�ҵ���С����
		if(d(j)~=mind) 		%��ǩ��Ԥ�ⲻ��ʱ
			e=e+1;
		end
	end
end;
fpca=mat2gray(sum10(:,:,:));
imwrite(fpca, 'fpca.jpg');
disp('������������Ϊ��');
disp(e);
disp('ʶ���ʣ�');
disp(1-e/(cc*(n-ni)));
