function [ ] = myqqplot()
x = [2,6,7,9,11,12,14,15,16,20];
y = [3,4,5,7,9];
px = unidpdf( x, 10 ) % calculate the pdf
cx = unidcdf( x, 10 ) % calculate the cdf
[fx, xt] = ecdf(x)
[fy, yt] = ecdf(y)
%
figure( 1 ); clf; % create a new figure and clear the contents
subplot( 1,3,1 );
%plot( x , px );
%xlabel( 'x' ); ylabel( 'pdf' );
%title( 'Probability Density Function' );
plot(xt, fx);
title('Empirical Cumulative Probability Function');
%
subplot( 1,3,2 );
plot( x , cx );
xlabel( 'x' ); ylabel( 'cdf' );
title( 'Cumulative Density Function' );
%
subplot( 1,3,3 );
%hist( x , 10);
ecdfhist(fx, xt);
xlabel( 'x' ); ylabel( 'frequency' );
title( 'Histogram of x' );
%%
py = unidpdf( y, 5 ) % calculate the pdf
cy = unidcdf( y, 5 ) % calculate the cdf
%
figure( 2 ); clf; % create a new figure and clear the contents
subplot( 1,3,1 );
%plot( y , py );
%xlabel( 'y' ); ylabel( 'pdf' );
%title( 'Probability Density Function' );
plot(yt, fy);
title('Empirical Cumulative Probability Function');
%
subplot( 1,3,2 );
plot( y , cy );
xlabel( 'y' ); ylabel( 'cdf' );
title( 'Cumulative Density Function' );
%
subplot( 1,3,3 );
%hist( y , 5);
ecdfhist(fy, yt);
xlabel( 'y' ); ylabel( 'frequency' );
title( 'Histogram of y' );
%
end