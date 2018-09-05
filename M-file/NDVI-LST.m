data1 = hdfread('MOD11A2.A2011193.h11v04.005.2011203192224.hdf','MODIS_Grid_8Day_1km_LST','Fields','LST_Day_1km');
data2 = hdfread('MOD11A2.A2011201.h11v04.005.2011210153236.hdf','MODIS_Grid_8Day_1km_LST','Fields','LST_Day_1km');
data_med = (data1+data2)* 0.01;
d_med = int16(data_med);

mat1 = ones(4);
mat1 = int16(mat1);
med = kron(d_med,mat1);

data3 = hdfread('MOD13Q1.A2011193.h11v04.005.2011210114625.hdf','MODIS_Grid_16DAY_250m_500m_VI','Fields','250m 16 days NDVI');
data3 = data3/10000;

ndata3=reshape(data3.',1,[]);
nmed=reshape(med.',1,[]);

scatter(ndata3(1:100),nmed(1:100))