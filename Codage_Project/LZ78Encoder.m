function [y,dict]=LZ78Encoder(x,N)

y=[];
dict=[];

if nargin<1
    disp('At least one argument is needed!');
    return;
end

if nargin<2
    N=0; 
end

x=x(:)'; 
x_n=numel(unique(x));

if N>0
    if N<x_n
        disp('The dictionary size has to be larger than the number of distinct characters in x!');
        return;
    end
    dict=cell(1,N);
else
    dict={};
end

y_i=0;
dict_i=0;
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
    y{y_i,1}=index;
    if (index1>0 || isempty(x)) 
        y{y_i,2}=[];
        break;
    else
        y{y_i,2}=x(1);
        x=x(2:end);
        if isempty(x)
            break;
        end
    end
end
if N>0
    dict(dict_i+1:end)=[]; 
end
