%% 
%CpMatrix.m - Compare any two matrices from one level of the quadtree
%**************************************************************************

if (exist('dialog-Compare.txt','file'))
  delete('dialog-Compare.txt');
end
set(0,'diaryFile','dialog-Compare.txt')
diary

tMatrix=csvread('C:\Users\math\Desktop\Lena Test1\zero-one-data.txt');
%function Compare2(lt,lb,rt,rb)
%   tMatrix = csvread(filename);  
  %% Import 4 submtrices
  
    if (exist('outputC.txt','file'))
        delete('outputC.txt');
    end
    
    global resultC;
    global flagC;
    
    %% Decomposition of whole matrix recursively (will excusion in Ftree.m)
     
   disp(tMatrix);
    rowN=size(tMatrix,1);  %Number of rows
    colN=size(tMatrix,2);   %Number of columns
    halfR=rowN/2;   %row's size of submatrix
    halfC=colN/2;   %col's size of submatrix
    
    %To decompose the whole matrix into 4 pieces evenly
    lt=tMatrix(1:halfR,1:halfC);
    rt=tMatrix(1:halfR,(halfC+1):colN);
    lb=tMatrix((halfR+1):rowN,1:halfC);
    rb=tMatrix((halfR+1):rowN,(halfC+1):colN);


    %% Comparision of matrices
    compM={lt,rt,lb,rb};              %Submatrices to be partitioned in one array
    %[indexR,indexC] = size(compM);
    indexM=size(compM,2);              %Since it is 1 vector, then use the col numbers.
    flagC=ones(1,indexM); %Flag of matrices
    
    
    %% Recursion
    for i=1:indexM-1;
    disp('------------Start to compare£º-----------------')
    disp('compM[]=');
    disp(compM);
    disp('indexM=');
    disp(indexM);
    disp('flagC');
    disp(flagC);
    disp('Flag(i)=');
    disp(flagC(i));
    
    resultC= zeros(1,indexM); %Save the result matrix
    
        %%Flag point1
        %Check if the flag offset of i is 0 or not
        n = sum(flagC);   %Check the flag status
        disp('now the number of rest submatrices in flagC is:');
        disp(n);
               
        if n<2;
                   disp('^^^^^^No more comparision^^^^^^');
                           disp('^^^^^^^^^^^Final Loop of Decision^^^^^^^^^')
                           if(n==0)
                              disp('==========Output the zero result(1)========')
                              twoColumnResultC = vec2mat(resultC,2);
                              disp(twoColumnResultC);
                              %save output twoColumnResultC '-append';
                              dlmwrite('outputC.txt',twoColumnResultC,'-append');
                           return;
                           else 
                               disp('==========Output the final result(2)========')
                               c=find(flagC==1);
                               disp('c');
                               disp(c);
                               resultC(c)=1;
                               disp('resultC=');
                               disp(resultC);
                               twoColumnResultC = vec2mat(resultC,2);
                               disp('twoColumnResultC');
                               disp(twoColumnResultC);
                               %save output twoColumnResultC '-append';
                               dlmwrite('outputC.txt',twoColumnResultC,'-append');
                               return;   
                           end
                  
        else
           disp('i=');
           disp(i);
            
            for j=(i+1):indexM;
                disp ('i=');
                disp(i);
                disp ('j=');
                disp(j);
                %%Flag point2
                %Check if the flag offset of j is 0 or not
                disp('Flag(j)=');
                disp(flagC(j));
               
                %% Check flag
                if flag(j)==0
                    disp('%%%%%%');
                    disp('j=');
                    disp(j);
                    continue
                
                else

                        itIsEqual=isequal(compM(i),compM(j));  %isEqual=> 1=True, 0=False.
                        resultC(i)=1;                           %Set the equally matrices positions as 1

                        %% ~~~~~If two matrices equal
                        if itIsEqual==1;
                           disp('=========The comparision result is £¨Same£©£º==============');
                           resultC(j)=1;
                           twoColumnResultC = vec2mat(resultC,2);   %Transfer resultC into 2x2 matrix for output
                           disp ('Same,itIsEqual=');
                           disp(itIsEqual);
                           disp ('Output result=');
                           disp(twoColumnResultC);
                           flagC(j)=0;          %Set the realted flag position as 0
                       
                       %% Delete the same submatrices

                           %if sum(sum(resultC))>=2
                           %   delC=find(resultC==1);
                           %   disp('delC is:')
                           %   disp(delC);
                           %  for m= 1:length(delC)
                           %     flagC(delC(m))=0;
                           %     disp('new flagC is:');
                           %     disp(flagC);
                           %  end                   
                           %end     
                          
                       %% Output
                           if (j==indexM)
                                disp('**************Write this result into file(1)******************');
                                disp(twoColumnResultC);
                                %save output twoColumnResultC '-append';
                                dlmwrite('outputC.txt',twoColumnResultC,'-append');
                           end
                           
                           
                       %% ~~~~~If two matrices not equal
                        else
                             disp('=========The comparision result is £¨Not Same£©£º==============');
                           %  resultC(i)=1;     %Set the main comparisor position as 1                
                             twoColumnResultC = vec2mat(resultC,2); %Transfer resultC from 1 vector into 2x2matrix for output
                             disp ('Not Same, itIsEqual=');
                             disp(itIsEqual);
                             disp ('Output result=');
                             disp(twoColumnResultC);

                           %% Delete the same submatrices
                          %   if sum(sum(resultC))>=2
                          %      delC=find(resultC==1);
                          %      disp('delC is:')
                          %      disp(delC);
                          %      for m= 1:length(delC)
                          %          flagC(delC(m))=0;
                          %          disp('new flagC is:');
                          %          disp(flagC);
                          %      end                   
                          %   end 
                              
                          %% Output
                             if (j==indexM)
                                disp('**************Write this result into file(2)******************');
                                disp(twoColumnResultC);
                                %save output twoColumnResultC '-append';
                                dlmwrite('outputC.txt',twoColumnResultC,'-append');
                             end
                        end
                end
            end   
        end
        flagC(i)=0;
        disp('@@@@@@@@@@@@@@@@The New flagC is:@@@@@@@@@@@@@@');
        disp(flagC);
        if  sum(flagC)==1;
            %flagC==[0,0,0,1];
            disp('**************Write this result into file(final)******************');
            twoColumnFlagC= vec2mat(flagC,2);
            disp(twoColumnFlagC);
            %save output twoColumnFlagC '-append' ;  
            dlmwrite('outputC.txt',twoColumnFlagC,'-append');
        else
            continue
        end
    disp('Finish Loop!Start Over!');
    end
    
    disp('The End!');
%end

diary

