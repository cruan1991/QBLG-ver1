function [lt,rt,lb,rb ] = QTree( tMatrix,index,number )
%%
%Diary
%if (exist('dialog-Quadtree.txt','file'))
%  delete('dialog-Quadtree.txt');
%end
%set(0,'diaryFile','dialog-Quadtree.txt')
%diary

%%
%Error Handle
    if nargin ~=2
        disp('Error input');
    end

    [rowN, colN,dimN] = size(tMatrix);
    
    if dimN >2
        error('The input image should be gray-scale!\n');
    elseif rowN ~= colN
        error('The input image should be square!\n');
    end

%%
%Paraments setting
    i=(index-1)*4+number;
    depthN=log2(rowN)-1;
    fprintf('depth=%d \n', depthN);
    path=sprintf ('C:\\Users\\SCU\\Desktop\\Qtree-work\\Result\\Matrix\\%d\\',depthN-1);
    fprintf('C:\\Users\\SCU\\Desktop\\Qtree-work\\Result\\Matrix\\%d\\ \n',depthN-1);
	if ~exist(path) 
		mkdir(path)         
    end 
    
    dPath=sprintf ('C:\\Users\\SCU\\Desktop\\Qtree-work\\Result\\Decision\\%d\\',depthN-1);
    fprintf('C:\\Users\\SCU\\Desktop\\Qtree-work\\Result\\Decision\\%d\\ \n',depthN-1);
	if ~exist(dPath) 
		mkdir(dPath)         
	end 

%Splitting  
    lt = tMatrix(1:end/2    ,1:end/2    );
    rt = tMatrix(1:end/2    ,end/2+1:end);
    lb = tMatrix(end/2+1:end,1:end/2    );
    rb = tMatrix(end/2+1:end,end/2+1:end);
    
   
    
        disp('=======Start-nodes============');        
        fprintf('i=%d\n',i);
        s=2^(depthN-1);
        fprintf('%d x %d matrices. \n',s,s);
        savefile=sprintf ('level%dno%d',depthN-1,i);
        savefile=[path savefile];
        fprintf('Savc as:level%dno%d.mat\n',depthN-1,i);
        save(savefile,'tMatrix');
        
        %%
        %Call function to do comparision
        
        disp('=======Call the comparision function======'); 
        CpMatrixFuc( lt,rt,lb,rb );
        cmp=csvread('resultC.txt');
        disp('resultC= ');
        disp(cmp);
        
        mLt=vec2mat(cmp(1,:),2);
        mRt=vec2mat(cmp(2,:),2);
        mLb=vec2mat(cmp(3,:),2);
        mRb=vec2mat(cmp(4,:),2);
 
        %save division tree 
        saveDivision=sprintf ('level%dno%dDivision',depthN-1,i);
        saveDivision=[dPath saveDivision];
     %   fprintf('Savc as:level%dno%dDivision.mat\n',depthN-1,i);
    %    save(saveDivision,'mLt','mRt','mLb','mRb');
     %   fprintf('mLt=%d, mRt=%d, mLb=%d, mRb=%d \n',mLt,mRt,mLb,mRb);
        
        cLt=sum(sum(mLt));
        cRt=sum(sum(mRt));
        cLb=sum(sum(mLb));
        cRb=sum(sum(mRb));
        
        fprintf('cLt=%d, cRt=%d, cLb=%d, cRb=%d \n',cLt,cRt,cLb,cRb);
        disp('=======Decomposition Decision==========='); 
    
        %the leaf level
    if depthN ==0
        disp('******Final-level-of-leaves*******');
        fprintf('i=%d \n', i);
        fprintf('2x2 matrices.\n');
        savefile=sprintf ('finalLevel%dNo%d.mat',depthN, i);
        savefile=[path savefile];
        fprintf('Savc as:finalLevel%dNo%d.mat\n',depthN, i);
        save(savefile,'tMatrix');
        disp('***********************');

    else       
  
%other nodes
            if cLt~=0
               
                 lt= QTree(lt,i,1);
            end
            if cRt~=0
                
                  rt= QTree(rt,i,2);
            end
            if cLb~=0

                 
                 lb= QTree(lb,i,3);
            end
            if cRb~=0

                rb= QTree(rb,i,4);
            end
        disp('=====================================');      
        
    end
    
%diary
end