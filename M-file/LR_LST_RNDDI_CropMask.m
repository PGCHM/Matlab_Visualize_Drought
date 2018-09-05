%find the largest LST for each RNDDI
%rnddi=int16(crop_rnddi*1000);
%
[r1,c1]=size(crop_lst);
bins = max(max(rnddi));
maxLST = zeros(1,bins)-500;
minLST = zeros(1,bins)+500;
for i=1:r1,
    for j=1:c1,
        %do
        x=crop_rnddi(i,j);
        if((x>0)&&(x<bins))
            if(crop_lst(i,j)>maxLST(x))
                maxLST(x)= crop_lst(i,j);
            end
            if(crop_lst(i,j)<minLST(x))
                minLST(x)= crop_lst(i,j);
            end
        end
    end
end

X = [];
Y = [];
U = [];
T = [];

for j=1:bins,
    if(maxLST(j)>-500)
        X = [X j];
        Y = [Y maxLST(j)];
    end
    if((minLST(j)>-500)&&(minLST(j)<500))
        U = [U j];
        T = [T minLST(j)];
    end
end

p=polyfit(double(X),double(Y),1);
q=polyfit(double(U),double(T),1);

figure,
scatter(X,Y);hold on;
W=1:1:max(X);
plot(W, p(1)*double(W)+p(2),'c+:');hold on;
scatter(U,T);hold on;
plot(W, q(1)*double(W)+q(2),'c+:');
