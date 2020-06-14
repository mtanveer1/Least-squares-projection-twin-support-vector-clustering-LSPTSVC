function [acc,time]= lsptsvc(C,test_data,Y,c1,c3,mu) 
  [no_input,no_col]=size(C);
  Y_test=test_data(:,no_col);
  Y1=Y_test;
   [no_test]=size(Y_test,1);


X=C(:,1:no_col-1);
X_test=test_data(:,1:no_col-1);
tol=0.001;
eps=0.0000001;
 M=X;      
     K=zeros(no_input,no_input);
   tic
    for i=1:no_input
        for j=1:no_input
            nom = norm( X(i,:)  - M(j,:)  );
            K(i,j) = exp( -1/(2*mu*mu) * nom * nom );
        end
    end
    time_k=toc;
X=K;

num=max(Y);
totalu=zeros(size(X,2),num);
diff=1;
diff2=1;
prev=0;
prevY=0;
times=0;
time=0;
tot_ite=0;
while ((norm(diff)>0.1)&(norm(diff2)~=0))
    times=times+1;
    Center=[];
for i=1:num
    inputA=X(Y==i,:);
    inputB=X(Y~=i,:);
    
[m1,n1]=size(inputA);
m2=size(inputB,1);
% tic
e1=ones(m1,1);
e2=ones(m2,1);

center1=1/m1*sum(inputA,1);
Center=[ Center;center1];
    ite=0;
    som=1;

D=inputA-e1*center1;
S1=D'*D;

u0=FirstStep(S1);
     [m1,n]=size(inputA);


d=(inputB-1/m1*e2*e1'*inputA);

tic
A=c1/c3*(eye(n1)-D'*((c3*eye(m1)+D*D')\D));
time_setup=toc;
tic
    while som>tol && ite<30
        ite=ite+1;
        u=u0;

  G=diag(sign(d*u))*d; 

u0=(A-A*G'*((eye(m2)+G*A*G')\G)*A)*G'*e2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        som=norm(u-u0);  
    end
    time=time+toc/ite;
    tot_ite=tot_ite+ite;
    totalu(:,i)=u0;
end
mes=zeros(no_input,num);
for i=1:no_input
for j=1:num
mes(i,j)=X(i,:)*totalu(:,j)-Center(j,:)*totalu(:,j);
end
end
[d pY]=min(abs(mes),[],2);
Y=pY;
diff=sum(d)-prev;
prev=sum(d);
diff2=pY-prevY;
prevY=pY;
end

time=(time+time_setup)/times+time_k;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Testing
 K=zeros(no_test,no_input);
   
    for i=1:no_test
        for j=1:no_input
            nom = norm( X_test(i,:)  - M(j,:)  );
            K(i,j) = exp( -1/(2*mu*mu) * nom * nom );
        end
    end
    
X_test=K;

mes=zeros(no_test,num);
for i=1:no_test
for j=1:num
mes(i,j)=X_test(i,:)*totalu(:,j)-Center(j,:)*totalu(:,j);
end
end
[d pY]=min(abs(mes),[],2);
MT=zeros(no_test);
for i=1:no_test
    for j=1:no_test
      if(Y1(i)==Y1(j))  
      MT(i,j)=1;
      end
    end
end

MP=zeros(no_test);
for i=1:no_test
    for j=1:no_test
      if(pY(i)==pY(j))  
      MP(i,j)=1;
      end
    end
end

n00=0;n11=0;cc=0;
for i=1:no_test
    for j=1:no_test
      if(MT(i,j)==MP(i,j))
          if(MT(i,j)==0)
            n00=n00+1;
          else
            n11=n11+1;
          end
      end       
    end
end

m=no_test;
acc=(n00+n11-m)/(m^2-m)*100;



function u=FirstStep(A)
[V,D]=eig(A);
[tmp,n]=min(abs(diag(D)));
u=V(:,n);
end
