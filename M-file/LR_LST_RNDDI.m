%find the largest LST for each RNDDI
med=reshape(med.',1,[]);
rnddi=500*(rnddi+1);
rnddi=int16(rnddi);
rnddi=reshape(rnddi.',1,[]);
%
[rows,columns]=size(med);
bins = max(max(rnddi)) - min(min(rnddi));
maxLST = zeros(1,bins);
minLST = zeros(1,bins)+1000;
for i=1:rows*columns,
    %do
    x=rnddi(i);
    if(x>0)
        if(med(i)>maxLST(x))
            maxLST(x)= med(i);
        end
        if((med(i)<minLST(x))&&(med(i)>250))
            minLST(x)= med(i);
        end
    end
end

X = [];
Y = [];
U = [];
T = [];

for j=1:bins,
    if(maxLST(j)>0)
        X = [X j];
        Y = [Y maxLST(j)];
    end
    if((minLST(j)>0)&&(minLST(j)<500))
        U = [U j];
        T = [T minLST(j)];
    end
end

p=polyfit(double(X),double(Y),3);
q=polyfit(double(U),double(T),3);

f1=polyval(p,double(X));
f2=polyval(q,double(U));

err1=max(Y-f1);
err2=max(f2-T);

plot(X,Y,'o',X,f1+err1,'-r');hold on;
plot(U,T,'+',U,f2-err2,'-g');

title('RNDDI-LST space (2009/257,h11v04)')
xlabel('Scaled RNDDI = (RNDDI+1)*500')
ylabel('Scaled LST')

%plot(rnddi,med,'o'); hold on;
%plot(X,f1,'+',U,f2,'-');

%END
