%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ó�����Ҫ����ѵ������;���ȴ����ݿ��ж��������˵���ָ����ͼ��
%Ȼ��ӳ�䵽��ά�ռ���; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc
images=[];
ff=[];
img1=[];
uu1=[];		%����վ���
uu2=[];
m=[];
mm=[];
x=[];
xx=[];
sum1=0;
averg=[];
cc=68; 	%����� 
ni=25;   %��i���������,�������������ѵ�������������
l1=15;	%PCA�任��ͶӰ��ĸ���
l4=30;	%fisher�任��ͶӰ��ĸ���

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ȡ�ļ���Ϊ1�˵���ָ����ͼƬ
for j=1:cc
    sum1=0;
	for i=1:ni
		str=strcat('..\train\',(int2str(j)),'\',(int2str(j)),'-',(int2str(i)),'.bmp');%����ͼƬ��str
		img1(:,:,i)=(imread(str));%תΪ�Ҷ�ͼ		Img(:,:,n)�У���ʾÿ��ͼ�����
		sum1=sum1+double(img1(:,:,i));%ת��Ϊ˫���Ⱦ������
	end
	x(:,:,(j-1)*ni+1:j*ni)=img1(:,:,1:ni);%ÿһ��ͼ��ľ���
	m(:,:,j)=sum1/ni;%����j��ni��ƽ��ͼ��
	[row low]=size(sum1);
end

%�ܾ�ֵ
sum13=0;
for i=1:cc
   sum13=sum13+m(:,:,i); 
end
averge=sum13/cc;%��������������ƽ��ͼ��
averge233=mat2gray(averge(:,:,:));
imwrite(averge233, 'averge.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ȥ��� 
sum2=0;
for i=1:ni*cc
    temp1=(double(x(:,:,i)-averge)'*double(x(:,:,i)-averge));
    sum2=sum2+temp1 ;
end
COR1=1/(ni*cc)*sum2;	%Э�������
[v,r]=eig(COR1);	%��������
[t1,t2]=size(v);

V1=v(:,t2-l1+1:t2);							%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ӳ�����
sum(sum(r(:,t2-l1+1:t2)))/sum(sum(r));		%sum(sum())���������Ԫ�صĺ�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ԭ���ݱ任��2DPCA�� 
for i=1:cc*ni
	xx(:,:,i)=x(:,:,i)*V1;		%��ȫ��һ����ԭ����ӳ�䵽�����ռ����ٴ浽���������棬������LDA��׼��
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����������ռ�����ֵͶӰ��2DPCA��
xx(:,:,:)=double(xx(:,:,:)); 			%PCA�任��ȫ����Ϊdouble����
images=[];
for c=1:cc 
	mm(:,:,c)=m(:,:,c)*V1;		%ÿ���ƽ��ͼ��ӳ�䵽�����ռ����������������
end
aver=averge*V1;				%���е�ƽ��ͼ��ӳ�䵽�����ռ��������
pca=mat2gray(aver(:,:,:));
imwrite(pca, 'pca.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�Ծ���PCA�任���������з����Ͻ���fisher�任
for c=1:cc 
	sum2=0;
	for i=ni*(c-1)+1:ni*c
		temp1=(double((xx(:,:,i)-mm(:,:,c)))*double((xx(:,:,i)-mm(:,:,c)))');
		sum2=sum2+temp1 ;
	end
end
kw=sum2/(ni*cc);		%����Э�������

%�������ռ�������ֵͶӰ����ά�ռ���
images=[];
sum3=0;  
for i=1:cc
    temp2=double((mm(:,:,i)-aver))*double((mm(:,:,i)-aver))';
    sum3=sum3+temp2 ;  
end
kb=sum3/cc;				%���Э�������
rank(kw);				%��������

%�����������õ�ͶӰ����v
[v,r]=eig(kb,kw);		%��������
t2=size(v);
V2=v(t2-l4+1:t2,:);		%ӳ�����,��ת��		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����ӳ�����
size(V2);
sum(sum(r(t2-l4+1:t2,:)))/sum(sum(r));	%sum(sum())���������Ԫ�صĺ�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��������ֵ�к��з����Ϸֱ𾭹�pca��fisher�任����Ϊѵ��������������
for i=1:cc
	averg(:,:,i)=V2*double(m(:,:,i))*V1;      %ÿ��ƽ��ͼ���Ӧ��PCA-LDA����ӳ��
end
fld=mat2gray(averg(:,:,1));
imwrite(fld, 'fld.jpg');
save('..\data.mat','V1','V2','averg','ni');
%ѵ������
err%���㾲�����ݿ���ͼ���ʶ����