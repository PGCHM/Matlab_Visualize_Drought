clear all
%For year 2013:
%f1='MOD13Q1.A2013193.h11v04.005.2013213113427.hdf';
%f2='MOD11A2.A2013193.h11v04.005.2013204214639.hdf';
%f3='MOD11A2.A2013201.h11v04.005.2013213180212.hdf';
%
%For year 2012:
%f1='MOD13Q1.A2012193.h11v04.005.2012212125952.hdf';
%f2='MOD11A2.A2012193.h11v04.005.2012202171831.hdf';
%f3='MOD11A2.A2012201.h11v04.005.2012212144917.hdf';
%
%For year 2011: 
%f1='MOD13Q1.A2011193.h11v04.005.2011210114625.hdf';
%f2='MOD11A2.A2011193.h11v04.005.2011203192224.hdf';
%f3='MOD11A2.A2011201.h11v04.005.2011210153236.hdf';
%
%For year 2010: 
%f1='MOD13Q1.A2010193.h11v04.005.2010211231512.hdf';
%f2='MOD11A2.A2010193.h11v04.005.2010202201106.hdf';
%f3='MOD11A2.A2010201.h11v04.005.2010211054830.hdf';
%
%For year 2009: 
%DOY=113
%f1='MOD13Q1.A2009113.h11v04.005.2009132093438.hdf';
%f2='MOD11A2.A2009113.h11v04.005.2009130013029.hdf';
%f3='MOD11A2.A2009121.h11v04.005.2009131114536.hdf';
%DOY=129
%f1='MOD13Q1.A2009129.h11v04.005.2009150000219.hdf';
%f2='MOD11A2.A2009129.h11v04.005.2009138202401.hdf';
%f3='MOD11A2.A2009137.h11v04.005.2009148231255.hdf';
%DOY=145
%f1='MOD13Q1.A2009145.h11v04.005.2009166073754.hdf';
%f2='MOD11A2.A2009145.h11v04.005.2009155003238.hdf';
%f3='MOD11A2.A2009153.h11v04.005.2009166042622.hdf';
%DOY=161
%f1='MOD13Q1.A2009161.h11v04.005.2009180222120.hdf';
%f2='MOD11A2.A2009161.h11v04.005.2009178062331.hdf';
%f3='MOD11A2.A2009169.h11v04.005.2009180110431.hdf';
%DOY=177
%f1='MOD13Q1.A2009177.h11v04.005.2009199112932.hdf';
%f2='MOD11A2.A2009177.h11v04.005.2009191062312.hdf';
%f3='MOD11A2.A2009185.h11v04.005.2009199035929.hdf';
%DOY=193
%f1='MOD13Q1.A2009193.h11v04.005.2009212081500.hdf';
%f2='MOD11A2.A2009193.h11v04.005.2009204003113.hdf';
%f3='MOD11A2.A2009201.h11v04.005.2009211234002.hdf';
%DOY=209
%f1='MOD13Q1.A2009209.h11v04.005.2009228052108.hdf';
%f2='MOD11A2.A2009209.h11v04.005.2009221144421.hdf';
%f3='MOD11A2.A2009217.h11v04.005.2009227222229.hdf';
%DOY=225
%f1='MOD13Q1.A2009225.h11v04.005.2009249200227.hdf';
%f2='MOD11A2.A2009225.h11v04.005.2009234215854.hdf';
%f3='MOD11A2.A2009233.h11v04.005.2009247192704.hdf';
%DOY=241
%f1='MOD13Q1.A2009241.h11v04.005.2009259013455.hdf';
%f2='MOD11A2.A2009241.h11v04.005.2009251034614.hdf';
%f3='MOD11A2.A2009249.h11v04.005.2009259013808.hdf';
%DOY=257
f1='MOD13Q1.A2009257.h11v04.005.2009275142244.hdf';
f2='MOD11A2.A2009257.h11v04.005.2009267044449.hdf';
f3='MOD11A2.A2009265.h11v04.005.2009275010011.hdf';
%
%Step 1
%NDWI
nir = hdfread(f1,'MODIS_Grid_16DAY_250m_500m_VI','Fields','250m 16 days NIR reflectance');
mir = hdfread(f1,'MODIS_Grid_16DAY_250m_500m_VI','Fields','250m 16 days MIR reflectance');

%he = double(nir+mir);
%cha = double(nir-mir);
%ndwi = cha./he;
ndwi=1-2*double(mir)./double(nir+mir);
clear nir mir
ndwi(ndwi<-1)=-1.0001;
ndwi(ndwi>1)=-1.0001;
ndwi=ndwi*10000;
ndwi=int16(ndwi);
%ndwi = double(ndwi)*0.0005;

%step 2
%NDVI
data3 = hdfread(f1,'MODIS_Grid_16DAY_250m_500m_VI','Fields','250m 16 days NDVI');%-3000,9996
%data3 = double(data3)/10000.000;

%ndata3=reshape(data3(range,range).',1,[]);
%nmed=reshape(med(range,range).',1,[]);
%scatter(ndata3,nmed)

%x=reshape(ndwi(range,range).',1,[]);
%y=reshape(data3(range,range).',1,[]);
%scatter(x,y)

%step 3
%rnddi=ndwi/(ndvi+ndwi)
%
rnddi = double(ndwi)./double(data3+ndwi);
rnddi(ndwi==-10001)=-1;
rnddi(data3<0)=-1;
clear ndwi data3
rnddi(rnddi<0)=-1;
rnddi(rnddi>1)=-1;
%step 4
%LST
data1 = hdfread(f2,'MODIS_Grid_8Day_1km_LST','Fields','LST_Day_1km');
data2 = hdfread(f3,'MODIS_Grid_8Day_1km_LST','Fields','LST_Day_1km');
data_med = (data1+data2)* 0.01;
d_med = int16(data_med);

mat1 = ones(4);
mat1 = int16(mat1);
med = kron(d_med,mat1);
clear data1 data2 data_med d_med mat1

%step 5
%range=2001:3000;
%x=reshape(med(range,range).',1,[]);
%y=reshape(rnddi(range,range).',1,[]);
%scatter(y,x)
