% Octave File for Reed Muller Generator Matrix 
% https://searchcode.com/codesearch/view/9571043/

function G=reedmullergen(R,M)
    if ( nargin < 2 )
       print_usage();
    end

    G=ones(1,2^M);
    if ( R == 0 )
        return;
    end
    
    a=[0];
    b=[1];
    V=[];
    for idx=1:M;
        row=repmat([a,b],[1,2^(M-idx)]);
        V(idx,:)=row;
        a=[a,a];
        b=[b,b];
    end
    
    G=[G; V];

    if ( R == 1 )
        return
    else
        r=2;
        while r <= R
            p=nchoosek(1:M,r);
            prod=V(p(:,1),:).*V(p(:,2),:);
            for idx=3:r
                prod=prod.*V(p(:,idx),:);
            end
            G=[G; prod];
            r=r+1;
        end
    end
    return
end