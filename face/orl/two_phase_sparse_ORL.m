
% two_phase_sparse__representation_ORL

% Yong Xu: Shenzhen Graduate School, Harbin Institute of Technology

clear all;

miu=1.0e-3;

m=10
c=40

% train_num=7;
%  train_num=6;
   train_num=5;

test=m-train_num;
N=c*train_num;
N1=N;

cha_jieguo=zeros(N,N);
K=zeros(N);

start_number=10;
end_number=c*train_num;

folder='orl\orl';
linshi0=imread('orl\orl001.bmp');
[row col]=size(linshi0);

for i=1:c
    for k=1:m
        filename=[folder num2str((i-1)*m+k,'%03d')  '.bmp'];
        input0(i,k,:,:)=imread(filename);
    end
end
input0=double(input0);

% M1=count/label_count;  
% 循环C(m,train_num)次数，并统计出相应的平均错误率

ttt=combntns(1:m,train_num);
[daxiao1 daxiao2]=size(ttt);

%  for rrr=1:daxiao1
  for rrr=daxiao1:daxiao1

    % 取出相应训练集和测试集    
      test_0=1; train_0=1;
      for jj=1:c
        input00(:,:)=input0(jj,:,:);
        for k=1:m
            for n=1:daxiao2
                if k==ttt(rrr,n)
                   tempt0(1,:)=input0(jj,k,:);
                   ex_data(train_0,:)=input0(jj,k,:)/norm(tempt0);
                   train_0=train_0+1;         
                   my_record(n,:)=k;
                end
            end        
                       
        end       
        [ppp qqq]=size(my_record);        
        for k=1:m
            biaoji=0;
            for uuu=1:ppp
                if k==my_record(uuu,:);
                   biaoji=1;
                end             
            end
            
            if biaoji==0
               tempt0(1,:)=input0(jj,k,:);
               data(test_0,:)=input0(jj,k,:)/norm(tempt0);
               test_0=test_0+1; 
            end
        end        
      end
    
    % 通过测试样本表达为所有训练样本的线性组合，然后确定出每个测试样本的若干近邻
        result=inv(ex_data*ex_data'+0.01*eye(c*train_num))*ex_data;
    
        for j=1:test*c
            shiliang=data(j,:); 
                   
          solution=result*shiliang';    
        
          contribution0=zeros(row*col,c*train_num);
        
        for kk=1:c
            for hh=1:train_num
                contribution0(:,(kk-1)*train_num+hh)=solution((kk-1)*train_num+hh)*ex_data((kk-1)*train_num+hh,:)';
            end            
        end
        
        for kk=1:c*train_num   
            wucha0(kk)=norm(shiliang'-contribution0(:,kk));     
        end        
        [recorded_value record00]=sort(wucha0);        
        record0(j,:)=record00(1,:);   
        
        for qq=1:train_num*c
            record0_class(j,qq)=floor((record00(qq)-1)/train_num)+1;
        end
        
        end

   
    % 测试样本的近邻确定完成
   
 n_number=40;
 n_number=30;
 %n_number=20;
 
%% 只用训练集中测试样本的 n_number 近邻来描述测试样本，并分类。

% for n_number=15:5:c*train_num
for n_number=start_number:10:end_number
    
    for j=1:test*c
        shiliang=data(j,:); 
        
        for rr=1:n_number
            useful_train(rr,:)=ex_data(record0(j,rr),:);
        end
           
        solution=inv(useful_train*useful_train'+0.01*eye(n_number))*useful_train*shiliang';
    
        if j==1
           solution0=solution;
        end
        
        contribution=zeros(row*col,N);
        
        for kk=1:c
            for hh=1:n_number
                if record0_class(j,hh)==kk
                   contribution(:,kk)=contribution(:,kk)+solution(hh)*useful_train(hh,:)';
                end
            end            
        end
        
        for kk=1:c   
            wucha(kk)=norm(shiliang'-contribution(:,kk));     
        end
        
        [min_value xx]=min(wucha);
        fen_label(j)=xx;       
     
    end

errors=0;
for i=1:test*c
    
    inte=floor((i-1)/test+1);
    label2(i)=inte;
    if fen_label(i)~=label2(i)
        errors=errors+1;
    end
end    

errors_ratio(rrr,n_number)=errors/c/test;
 

end

errors_ratio(rrr,start_number:10:end_number)

clear useful_train;
clear data;
clear ex_data;

  end 
 

