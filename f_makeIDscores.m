function [Iself,Iothers,Idiff,mat_tmp] = f_makeIDscores(ID_1,ID_2)

%Creates identifiability matrix and extracts subject level scores. 

mat_tmp = corr(ID_1,ID_2) ; %produce the identifiability matrix. 

%Iself
Iself = mat_tmp(logical(eye(size(mat_tmp)))); %extract diagonal of matrix/Iself

%Iothers
Iothers = [];  
Iothers_tmp = mat_tmp; 
Iothers_tmp(eye(size(Iothers_tmp))==1) = nan; %make diagonal nan 
for j  = 1:size(Iothers_tmp,1) %extract per row each off diagonal elements excluding matrix. 
       indiv_score = nanmean(Iothers_tmp(j,:));
       Iothers= [Iothers;indiv_score];
end                 

%Idiff
Idiff = (Iself - Iothers)*100;

end