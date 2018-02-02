function  CpMatrixFuc( lt,rt,lb,rb )
    if (exist('dialog-Compare.txt','file'))
      delete('dialog-Compare.txt');
    end
    set(0,'diaryFile','dialog-Compare.txt')
    diary
    
  %% Import 4 submtrices
    if (exist('outputC.txt','file'))
        delete('outputC.txt');
    end
    if (exist('resultC.txt','file'))
        delete('resultC.txt');
    end
    
    global resultC;
    global flagC;
    
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
    disp('============AAAAAAAAAAAAAAAAAAAAAAAAA==========')
    disp('i=');
    disp(i);
    
    resultC= zeros(1,indexM); %Save the result matrix
    
        %%Flag point1
        %Check if the flag offset of i is 0 or not
        n = sum(flagC);   %Check the flag status
        disp('now the number of rest submatrices in flagC is:');
        disp(n);
               
        if n<2;
                   disp('^^^^^^No more comparision^^^^^^');
                   disp('^^^^^^^^^^^Final Loop of Decision^^^^^^^^^')
                   resultM=csvread('resultC.txt');
                   r=size(resultM,1);
                   disp('The lines in resultC:');
                   disp(r);
                   
                           if(n==0)
                               if(r<4)
                                  disp('==========Output the zero result(1)========')
                                  addResultC=zeros(4-r,4);
                                  twoColumnAddResultC = vec2mat(addResultC,2);
                                  disp(twoColumnAddResultC);
                                  %save output twoColumnResultC '-append';
                                  dlmwrite('outputC.txt',twoColumnAddResultC,'-append');
                                  dlmwrite ('resultC.txt',addResultC,'-append');
                                  return;
                               else
                                   disp('Finished(1)!');
                               end
                           else 
                               disp('==========Output the final result(2)========')
                               c=find(flagC==1);
                               disp('c');
                               disp(c);
                               
                               if i<=c
                                       resultC(c)=1;
                                       disp('resultC=');
                                       disp(resultC);
                                       twoColumnResultC = vec2mat(resultC,2);
                                       disp('twoColumnResultC');
                                       disp(twoColumnResultC);
                                       disp('flagC=');
                                       disp(flagC);
                                       %save output twoColumnResultC '-append';
                                       dlmwrite('outputC.txt',twoColumnResultC,'-append');
                                       dlmwrite ('resultC.txt',resultC,'-append');
                                       resultM=csvread('resultC.txt');
                                       r=size(resultM,1);
                                       disp('~~~~~~~~111112~~~~~~~~~~~~~~The lines in resultC:');
                                       disp(r);
                                       disp('==========Output the zero result(2)========')
                                       addResultC=zeros(4-r,4);
                                       twoColumnAddResultC = vec2mat(addResultC,2);
                                       disp(twoColumnAddResultC);
                                       %save output twoColumnResultC '-append';
                                       dlmwrite('outputC.txt',twoColumnAddResultC,'-append');
                                       dlmwrite ('resultC.txt',addResultC,'-append');
                                       return   
                               else
                                   resultM=csvread('resultC.txt');
                                   r=size(resultM,1);
                                   disp('~~~~~~~~~2222~~~~~~~~~~~~~The lines in resultC:');
                                   disp(r);
                                   disp('==========Output the zero result(3)========')
                                   addResultC=zeros(4-r,4);
                                   twoColumnAddResultC = vec2mat(addResultC,2);
                                   disp(twoColumnAddResultC);
                                   %save output twoColumnResultC '-append';
                                   dlmwrite('outputC.txt',twoColumnAddResultC,'-append');
                                   dlmwrite ('resultC.txt',addResultC,'-append');
                                   return;
                                   
                               end
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
                if flagC(j)==0
                    disp('%%%%%%Stop Compairision since the related flagC is 0%%%%');
                    disp('j=');
                    disp(j);
                    disp('resultC=');
                    disp(resultC);
                    disp('flagC=');
                    disp(flagC);
                     %% Output
                           if (j==indexM)
                                disp('**************Write this result into file(1)******************');
                                disp(twoColumnResultC);
                                %save output twoColumnResultC '-append';
                                dlmwrite('outputC.txt',twoColumnResultC,'-append');
                                dlmwrite ('resultC.txt',resultC,'-append');
                           end
                           
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
                          
                       %% Output
                           if (j==indexM)
                                disp('**************Write this result into file(1)******************');
                                disp(twoColumnResultC);
                                %save output twoColumnResultC '-append';
                                dlmwrite('outputC.txt',twoColumnResultC,'-append');
                                dlmwrite ('resultC.txt',resultC,'-append');
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

                          %% Output
                             if (j==indexM)
                                disp('**************Write this result into file(2)******************');
                                disp(twoColumnResultC);
                                %save output twoColumnResultC '-append';
                                dlmwrite('outputC.txt',twoColumnResultC,'-append');
                                dlmwrite ('resultC.txt',resultC,'-append');
                             end
                        end
                end
            end   
        end
        flagC(i)=0;
        disp('@@@@@@@@@@@@@@@@The New flagC is:@@@@@@@@@@@@@@');
        disp(flagC);
        if  flagC==[0,0,0,1];
            %sum(flagC)==1;
            disp('**************Write this result into file(final)******************');
            twoColumnFlagC= vec2mat(flagC,2);
            disp(twoColumnFlagC);
            %save output twoColumnFlagC '-append' ;  
            dlmwrite('outputC.txt',twoColumnFlagC,'-append');
            dlmwrite ('resultC.txt',flagC,'-append');
 %       elseif sum(flagC)==0;
 %               disp('**************Write this result into file(final2)******************');
 %               twoColumnFlagC= vec2mat(flagC,2);
 %               disp(twoColumnFlagC);
 %               %save output twoColumnFlagC '-append' ;  
 %               dlmwrite('outputC.txt',twoColumnFlagC,'-append');
 %               dlmwrite ('resultC.txt',flagC,'-append');
        
        else
            continue
        end
    
    disp('Finish Loop!Start Over!');
    end
    
    
    disp('The End!');
    
    diary

end

