clc;
close;
clear;
TWSA_path = "D:\code\point mass\results\all_TWSA.nc";
location_path = 'D:\code\point mass\data\Lon_Lat_vec.nc';
TWSA = ncread(TWSA_path,'lwe_thickness');
TWSA = TWSA';
lon = ncread(location_path,'lon');
lat = ncread(location_path,'lat');

figure;
scatter(lon,lat,[],TWSA,'filled');
colormap(gca,'jet');
colorbar;
caxis([-20,20]);