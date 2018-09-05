f1n='C:\Users\Janie\Documents\MATLAB\hdf\ndvi.2012.193.h11v04_19169_albers_clip.tif';
f1='C:\Users\Janie\Documents\MATLAB\hdf\ndvi.2011.193.h11v04_19169_albers_clip.tif';
of1='C:\Users\Janie\Documents\MATLAB\hdf\ndvi.2010.193.h11v04_19169_albers_clip.tif';
oof1='C:\Users\Janie\Documents\MATLAB\hdf\ndvi.2009.193.h11v04_19169_albers_clip.tif';
f2='C:\Users\Janie\Documents\MATLAB\hdf\LST.16days.2011.193.tif';
f3n='C:\Users\Janie\Documents\MATLAB\hdf\ndwi.2012.193.h11v04_19169_albers_clip.tif';
f3='C:\Users\Janie\Documents\MATLAB\hdf\ndwi.2011.193.h11v04_19169_albers_clip.tif';
of3='C:\Users\Janie\Documents\MATLAB\hdf\ndwi.2010.193.h11v04_19169_albers_clip.tif';
oof3='C:\Users\Janie\Documents\MATLAB\hdf\ndwi.2009.193.h11v04_19169_albers_clip.tif';
cf='C:\Users\Janie\Documents\MATLAB\hdf\CDL_2011_19169_albers.tif';

% %show NDVI 2012
data4 = imread(f1n);
data4=double(data4)/10000;
data4=data4*250;
data4(data4<0)=255;
data4=uint8(data4);
imshow(data4)
colormap('hot')
% 

% %show NDVI 2011
data3 = imread(f1);
data3=double(data3)/10000;
data3=data3*250;
data3(data3<0)=255;
data3=uint8(data3);
% %imshow(data3)
% %colormap('hot')
% 
% %show NDVI 2010
data2 = imread(of1);
data2=double(data2)/10000;
data2=data2*250;
data2(data2<0)=255;
data2=uint8(data2);
% %imshow(data2)
% %colormap('hot')
% 
% %show NDVI 2009
data1 = imread(oof1);
data1=double(data1)/10000;
data1=data1*250;
data1(data1<0)=255;
data1=uint8(data1);
%
avg = (double(data1) + double(data2) + double(data3))/3;
%
% %show diff
delta=double(data4) -avg;
max(max(delta))
min(min(delta))
%hist(int8(delta))
imshow(int8(delta))
colormap('jet')

delta_ndvi = delta;

[r,c]=size(delta_ndvi);
pos1=zeros(r,c);
for i=1:r,
    for j=1:c,
        if (delta_ndvi(i,j)<-25)
            pos1(i,j) = 1;
        else
            pos1(i,j) = 0;
        end
    end
end
imshow(pos1)

mean0 = mean(mean(data4,1),2)
mean1 = mean(mean(data3,1),2)
mean2 = mean(mean(data2,1),2)
mean3 = mean(mean(data1,1),2)

%--------------------------------------------------------------------------

    %show NDWI of 2012
    ndwi0 = imread(f3n);
    max(max(ndwi0))
    min(min(ndwi0))
    %ndwi0=-ndwi0;
    ndwi0=double(ndwi0)/40;
    ndwi0(ndwi0<0)=255;
    ndwi0=uint8(ndwi0);
    imshow(ndwi0)
    colormap('hot')

    %show NDWI of 2011
    ndwi = imread(f3);
    max(max(ndwi))
    min(min(ndwi))
    ndwi=-ndwi;
    ndwi=double(ndwi)/40;
    ndwi(ndwi<0)=255;
    ndwi=uint8(ndwi);
    %imshow(ndwi)
    %colormap('hot')

    %show NDWI of 2010
    ndwi2 = imread(of3);
    max(max(ndwi2))
    min(min(ndwi2))
    %ndwi2=-ndwi2;
    ndwi2=double(ndwi2)/40;
    ndwi2(ndwi2<0)=255;
    ndwi2=uint8(ndwi2);

    %show NDWI of 2009
    ndwi3 = imread(oof3);
    max(max(ndwi3))
    min(min(ndwi3))
    %ndwi2=-ndwi2;
    ndwi3=double(ndwi3)/40;
    ndwi3(ndwi3<0)=255;
    ndwi3=uint8(ndwi3);

    % %show diff between 2 ndwi
    % delta=int8(ndwi)-int8(ndwi2);
    % max(max(delta))
    % min(min(delta))
    % imshow(delta)
    % colormap('jet')

    %
    avg = (double(ndwi) + double(ndwi2) + double(ndwi3))/3;
    %
    % %show diff
    delta=double(ndwi0) -avg;
    max(max(delta))
    min(min(delta))
    %hist(int8(delta))
    imshow(int8(delta))
    colormap('jet')

    mean0 = mean(mean(ndwi0,1),2)
    %mean1 = mean(mean(ndwi,1),2)
    %mean2 = mean(mean(ndwi2,1),2)
    %mean3 = mean(mean(ndwi3,1),2)

    % %show LST
    % med = imread(f2);
    % med(med<7500) = 0;
    % med = med * 0.02;
    % med = (med -273.15)*1.8 +32;%to F
    % med=uint8(med);
    % imshow(med)
    % colormap('hot')
    % %show crop CDL
    % crop = imread(cf);
    % crop(crop~=1)=255;
    % imshow(crop)
    % colormap('hot')

[r,c]=size(delta);
pos2=zeros(r,c);
for i=1:r,
    for j=1:c,
        if (delta(i,j)<-40)
            pos2(i,j) = 1;
        else
            pos2(i,j) = 0;
        end
    end
end
imshow(pos2)

[r,c]=size(delta_ndvi);
pos=zeros(r,c);
for i=1:r,
    for j=1:c,
        if (delta_ndvi(i,j)<-50)
           if (delta(i,j)<-80)
               pos(i,j) = 60;
           else
               pos(i,j) = 50;
           end
        elseif (-50<delta_ndvi(i,j)<-25)
           if (-80<delta(i,j)<-40)
               pos(i,j) = 40;
           else
               pos(i,j) = 30;
           end
        elseif (-25<delta_ndvi(i,j)<0)
           if (-40<delta(i,j)<0)
               pos(i,j) = 20;
           else
               pos(i,j) = 10;
           end
        else
            pos(i,j) = 0;
        end
    end
end
imshow(pos)
colormap('jet')

imshow(int8((delta+delta_ndvi)/2))
colormap('jet')