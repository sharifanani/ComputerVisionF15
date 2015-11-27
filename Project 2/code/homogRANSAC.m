function [Hres] = homogRANSAC(locs1,locs2, numIter)
A = zeros(8,9);
H = cell(1,numIter);
Hinv = H;
for j = 1:numIter
    i=1;
    k=1;
    c = floor(rand(1,4)*length(locs1))+1;
    while(i<=7)
        x1 = locs1(c(k),1);y1=locs1(c(k),2);X1=locs2(c(k),1);Y1=locs2(c(k),2);
        A(i,:) = [x1,y1,1,0,0,0,-x1*X1,-y1*X1,-X1];
        A(i+1,:) = [0,0,0,x1,y1,1,-x1*Y1,-y1*Y1,-Y1];
        k=k+1;
        i=i+2;
    end
    N = null(A);
    h = [N(1),N(2),N(3);
        N(4),N(5),N(6);
        N(7),N(8),N(9)];
    h=h/h(end,end);
    H{1,j} = h;
    hi = inv(h);
    hi = hi/hi(end,end);
    Hinv{1,j} = hi;
    
end
jMat = cell(2,size(Hinv,2));
for j = 1:size(jMat,2)
    jMat(1,j)=Hinv(j);
    X = locs2(:,1); Y = locs2(:,2);
    P = [X';Y';ones(1,length(locs2))];
    Pp = Hinv{j}*P;
    for i = 1:size(Pp,2)
        v=Pp(:,i);
        s=v(3);
        Pp(:,i)=v/s;
    end
    
    Xp = Pp(1,:)'; Yp = Pp(2,:)';
    locs2p = [Xp, Yp];
    diffxy = locs1-locs2p;
    diff = (diffxy(:,1).^2 + diffxy(:,2).^2);
    a=find(diff<1);
    a=numel(a);
    jMat{2,j} = a;
    
end
a = jMat(2,:);
a=cell2mat(a);
[val,ind]=max(a);
Hres = cell2mat(H(ind));
end
