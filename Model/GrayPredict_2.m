clear
a=[89677,99215,109655,120333,135823,159878,182321,209407,246619,300670];
n=length(a);
temp=zeros(1,n);
b=zeros(1,n-1);
for i=1:n
    temp(i)=sum(a(1:i));
end
for i=1:n-1
    b(i)=0.5*(temp(i)+temp(i+1));
end
init=a(1);
a(1)=[];
e=[-b;ones(1,n-1)];
c=inv(e*e')*e*a';
lamda1=c(1);
lamda2=c(2);
for t=0:199
    ansd(t+1)=(init-lamda2/lamda1)*exp(-lamda1*t)+lamda2/lamda1;
end
for t=2:200
    answer(t)=ansd(t)-ansd(t-1);
end
answer(1)=init;
t1=size(a);
t2=size(answer);
h=plot(t1,A,'o',t2,G,'-');