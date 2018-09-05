%
%f1='MOD13Q1.A2010193.h11v04.005.2010211231512.hdf';
%
f1='MOD13Q1.A2009193.h11v04.005.2009212081500.hdf';
data3 = hdfread(f1,'MODIS_Grid_16DAY_250m_500m_VI','Fields','250m 16 days NDVI');
data3 = double(data3)/10000.000;
data3(data3==-0.3) = 1.02;
data3(data3<0) = 254/250;
data3(data3==-0.3) = 1.02;
max(max(data3))
min(min(data3))
data3=uint8(data3*250);
hdf5write('ndvi_out_2009.193.hdf', '/MODIS_Grid_16Day_250m_NDVI/NDVI_250m', data3);