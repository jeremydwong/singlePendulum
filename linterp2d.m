function out = linterp2d(x,y,xx)
size_cols_in = size(y,2);
if size_cols_in ==1
    out = linterp(x,y,xx)';
else
    out = [linterp(x,y(:,1),xx)',linterp2d(x,y(:,2:end),xx)];
end;