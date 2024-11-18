function sc = cs2sc(cs)
% convert the format |c\s| into format /s|c\
if ndims(cs)==2 % cs is the one CS matrix
    [rows,cols] = size(cs);
    lmax = rows-1;
    if cols ~= rows, error('cs2sc: A square matrix is needed.'), end
    c  = tril(cs);
    s  = rot90(triu(cs,1),-1);
    sc = [s(:,2:lmax+1) c];
elseif ndims(cs)==3  % cs is the series of CS matrixes
    [ntime,rows,cols] = size(cs);
    if cols ~= rows, error('cs2sc: A square matrix is needed.'), end
    for ii=1:ntime
        cs_tmp(:,:)=cs(ii,:,:);
        c  = tril(cs_tmp);
        s  = rot90(triu(cs_tmp,1),-1);
        sc_tmp = [s(:,2:lmax+1) c];
        sc(ii,:,:)=sc_tmp;
    end
else
    error('Input format is wrong.');
end