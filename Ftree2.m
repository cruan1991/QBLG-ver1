 function result=Ftree(a)
    result=[];
    s=size(tMatrix);
    middleX=s(1)/2;
    middleY=s(2)/2;
    a1=a(1:middleX,1:middleY);
    a2=a(middleX+1:middleX*2,1:middleY);
    a3=a(1:middleX,middleY+1:middleY*2);
    a4=a(middleX+1:middleX*2,middleY+1:middleY*2);
    
    if((middleX==1))
         result(1)=a1;
         result(2)=a2;
         result(3)=a3;
         result(4)=a4;
    else
        %result(1)=1;result(2)=0;result(3)=0;result(4)=0;
        %if isequal(a1,a2)==0
        %    result(2)=1;
        %end
        %if isequal(a1,a3)==0
        %    result(3)=1;
        %end
        %if isequal(a1,a4)==0
        %    result(4)=1;
        %end
        
        
      %  if result(1)==1
            result=[result Ftree(a1)];
      %  end
       % if result(2)==1
            result=[result Ftree(a2)];
       % end
       % if result(3)==1
            result=[result Ftree(a3)];
       % end
       % if result(4)==1
            result=[result Ftree(a4)];
       % end
        
       disp(result);
    end
    
end