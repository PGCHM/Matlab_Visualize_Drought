%CROP TYPE
CROP_TYPE=1;
%For year 2012: 
f1='C:\Users\Janie\Documents\MATLAB\hdf\ndvi.2012.193.h11v04_19169_albers_clip.tif';
f2='C:\Users\Janie\Documents\MATLAB\hdf\LST.16days.2011.193.tif';
f3='C:\Users\Janie\Documents\MATLAB\hdf\ndwi.2012.193.h11v04_19169_albers_clip.tif';
cf='C:\Users\Janie\Documents\MATLAB\hdf\CDL_2012_19169.tif';
%For year 2011: 
% f1='C:\Users\Janie\Documents\MATLAB\hdf\ndvi.2011.193.h11v04_19169_albers_clip.tif';
% f2='C:\Users\Janie\Documents\MATLAB\hdf\LST.16days.2011.193.tif';
% f3='C:\Users\Janie\Documents\MATLAB\hdf\ndwi.2011.193.h11v04_19169_albers_clip.tif';
% cf='C:\Users\Janie\Documents\MATLAB\hdf\CDL_2011_19169_albers.tif';
%For year 2010: 
% f1='C:\Users\Janie\Documents\MATLAB\hdf\ndvi.2010.193.h11v04_19169_albers_clip.tif';
% f2='C:\Users\Janie\Documents\MATLAB\hdf\LST.16days.2010.193.tif';
% f3='C:\Users\Janie\Documents\MATLAB\hdf\ndwi.2010.193.h11v04_19169_albers_clip.tif';
% cf='C:\Users\Janie\Documents\MATLAB\hdf\CDL_2010_19169.tif';
% % %For year 2009: 
% f1='C:\Users\Janie\Documents\MATLAB\hdf\ndvi.2009.193.h11v04_19169_albers_clip.tif';
% f2='C:\Users\Janie\Documents\MATLAB\hdf\LST.16days.2009.193.tif';
% f3='C:\Users\Janie\Documents\MATLAB\hdf\ndwi.2009.193.h11v04_19169_albers_clip.tif';
% cf='C:\Users\Janie\Documents\MATLAB\hdf\CDL_2009_19169.tif';
% %
%LST
med = imread(f2);
med(med<7500) = 0;
med = med * 0.02;
%hist(double(med))
% 
%Convert Kelvin to Fahrenheit
%1. Subtract 273.15 from your Kelvin temperature
%2. Multiply this number by 1.8.
%3. Add 32 to this number.
med = (med -273.15)*1.8 +32;
hist(double(med))
% %
% %Convert Kelvin to Celcius
% %1. Subtract 273.15 from your Kelvin temperature
% med = med -273.15;
% hist(double(med))
%
%NDVI
data3 = imread(f1);
% x=reshape(med.',1,[]);
% y=reshape(data3.',1,[]);
% scatter(x,y)
% %NDWI
ndwi = imread(f3);
hist(double(ndwi))
% x=reshape(ndwi.',1,[]);
% y=reshape(data3.',1,[]);
% scatter(x,y)
% 
% 
% NDDI
% ndwi=-ndwi;
[r,c]=size(ndwi);
nddi=zeros(r,c);
for i=1:r,
    for j=1:c,
        if (ndwi(i,j)<0)
        	nddi(i,j) = -10000;
        elseif (data3(i,j)<0)
        	nddi(i,j) = -10000;
        else
            he = data3(i,j) + ndwi(i,j);
            if (he == 0)
                nddi(i,j) = -10001;
            else
                cha = data3(i,j) - ndwi(i,j);
                nddi(i,j) = double(cha)./double(he);
            end
        end
    end
end

nddi(nddi<=-10000) = NaN;
hist(double(nddi))
%max(max(nddi))
%min(min(nddi))
%drought means low rnddi
rnddi = 1 - nddi;
% max(max(rnddi))
% min(min(rnddi))
% %show rnddi vs. LST
% x=reshape(med.',1,[]);
% y=reshape(rnddi.',1,[]);
% scatter(y,x)

% rnddi=(rnddi-0.4)*200;
% max(max(rnddi))
% rnddi=uint8(rnddi);
% max(max(rnddi))

mean(mean(rnddi~=NaN)~=NaN)

%crop
crop=imread(cf);
[rows,columns]=size(crop);
%crop masked ndvi and ndwi
crop_ndvi=zeros(rows,columns);
crop_ndwi=zeros(rows,columns);
%crop_lst=zeros(rows,columns);
crop_rnddi=zeros(rows,columns);
count=0;
[verLines, horLines] = size(data3);
for i=1:rows,
    %do
    ver=int16(i*30/231.6564)+1;
    if (ver > verLines)
        ver = verLines;
    end
    for j=1:columns-1,
        %do 
        hor=int16(j*30/231.6564)+1;
        if (hor > horLines)
            hor = horLines;
        end
        if ( crop(i,j) == CROP_TYPE)
            count = count + 1;
            crop_ndvi(i,j) = data3(ver,hor);
            crop_ndwi(i,j) = ndwi(ver,hor);%ndwi values are negative for vegetation, and positive for water bodies;
            %crop_lst(i,j) = med(ver,hor);
            crop_rnddi(i,j) = rnddi(ver,hor);
            
        else
            crop_ndvi(i,j) = -3000;
            crop_ndwi(i,j) = -1000;
            %crop_lst(i,j) = NaN;
            crop_rnddi(i,j) = NaN;
            
        end
    end
end
%
% hist(double(crop_ndvi))
% hist(double(crop_ndwi))
%crop_ndvi=reshape(crop_ndvi.',1,[]);
%crop_ndwi=reshape(crop_ndwi.',1,[]);
%scatter(crop_ndwi, crop_ndvi)

crop_ndvi = double(crop_ndvi)/10000.000;
crop_ndvi(crop_ndvi<0) = 0;
crop_ndvi=uint8(crop_ndvi*250);

a=sum(sum(crop_ndvi))/count;
a

crop_ndwi = double(crop_ndwi)/10000.000;
crop_ndwi(crop_ndwi<0) = 0;
crop_ndwi=uint8(crop_ndwi*250);

b = sum(sum(crop_ndwi))/count;
b

c = sum(sum(crop_rnddi~=NaN)~=NaN)/count;
c

%%crop_lst=reshape(crop_lst.',1,[]);
%scatter(crop_ndvi, crop_lst)
%crop_lst=reshape(crop_lst.',1,[]);
%crop_rnddi=reshape(crop_rnddi.',1,[]);
%scatter(crop_rnddi, crop_lst)
%end