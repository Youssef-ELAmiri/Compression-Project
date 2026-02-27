function [y,dict]=LZWEncoder(x,X,N)

y=[];
dict={};
if nargin<1
    disp('At least one argument is needed!');
    return;
end

x=x(:)';

if nargin<3
    N=0; 
    if nargin<2
        X=unique(x);
    end
end

X_n=numel(X);
if N>0
    if N<X_n
        disp('The dictionary size has to be larger than the alphabet size!');
        return;
    end
    dict=cell(1,N);
end
dict(1:X_n)=num2cell(X); 

y=zeros(1,numel(x));

y_i=0;
dict_i=X_n;
while 1
    n=numel(x);
    index=0;

    for i=1:n
        index1=IsInDict(x(1:i),dict);
        if index1==0 
            if (N<=0 || dict_i<N) 
                dict_i=dict_i+1;
                dict{dict_i}=x(1:i);
            end
            x(1:i-1)=[]; 
            break;
        else
            index=index1; 
        end
    end
    
    y_i=y_i+1;
    y(y_i)=index;
    if (index1>0 || isempty(x))
        break;
    end
end
y(y_i+1:end)=[];
if N>0
    dict(dict_i+1:end)=[]; 
end
