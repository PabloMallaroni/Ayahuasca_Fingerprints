%% Ayahuasca shared functional connectome identity. 
% Figure 2. Static Identifiability matrix.


%% Notes 

%The following script will do the following:
% take a time x regions x subjects variable and split it in half to generate test retest halves
% select according to an index which subject scans belong to placebo or high
% produce an identifiability matrix (square, symetrical) for all possible combinations
% extract relevant scores (Iself,Iothers,Idiff,SR,Iclinical) 
% plot all.
% 
% Note to repeat this dynamically, a separate approach is needed to work on a frame by frame basis. See dynamic equivalent of this code. 

%I've made the code purposely long-winded so you can see how different bits
%glue together. 

%% 
close all;
clear all, 

%% Params and configs

load('dynamicID_clean.mat'); %load time x regions x subject data
configs.numRegions = 200; % Schaefer parcellation number of brain regions
configs.mask_ut = triu(true(configs.numRegions,configs.numRegions),1); % upper triangular mask
configs.numVisits = 2; %two test days = two conditions 
configs.numFCs = size(dynamicID.matrix,3); %number of scans.
configs.numSubs = configs.numFCs/configs.numVisits; %number of subjects.
configs.make_figs = 1; 

ayaID =  dynamicID.dmtIndex ; %any  binary vector (1/0) to separate out subjects (1:total num scans)
%% Divide dataset and start allocating scans to conditions. 

flat_mat = f_restructure_mats(dynamicID.matrix,configs,0);

mat_baseline_test= flat_mat.test(~dynamicID.dmtIndex,:)';
mat_baseline_retest =  flat_mat.retest(~dynamicID.dmtIndex,:)';
mat_aya_test =  flat_mat.test((find(dynamicID.dmtIndex==1)),:)';
mat_aya_retest = flat_mat.retest((find(dynamicID.dmtIndex==1)),:)';

%% Now produce all possible identifiability matrices and extract scores.

%one for baseline and it's scores
[Iself(:,1),Iothers(:,1),Idiff(:,1),ID_mat(:,:,1)] = f_makeIDscores(mat_baseline_test,mat_baseline_retest);
%One for ayahuasca and it's scores
[Iself(:,2),Iothers(:,2),Idiff(:,2),ID_mat(:,:,2)] = f_makeIDscores(mat_aya_test,mat_aya_retest);

%One for each hybrid matrix (off-blocks),obtained cross correlating test of baseline with
%retest of ayahuasca and vice versa.
[Iself_hybtmp(:,1),Iothers_hybtmp(:,1),Idiff_hybtmp(:,1),ID_mat_hyb(:,:,1)] = f_makeIDscores(mat_baseline_test,mat_aya_retest);
[Iself_hybtmp(:,2),Iothers_hybtmp(:,2),Idiff_hybtmp(:,2),ID_mat_hyb(:,:,2)]  = f_makeIDscores(mat_aya_test,mat_baseline_retest);


%% Compute additional Hybrid scores and SR.

%Hybrid scores are the average of both off-blocks. 
Iself_hyb= nanmean(horzcat(Iself_hybtmp(:,1),Iself_hybtmp(:,2)),2);
Iothers_hyb = nanmean(horzcat(Iothers_hybtmp(:,1),Iothers_hybtmp(:,2)),2);
Idiff_hyb = nanmean(horzcat(Idiff_hybtmp(:,1),Idiff_hybtmp(:,2)),2);

%the Iclinical score is computed as the mean similarity of each
%clinical subject with each control subject, averaged between the two
%Iclinical matrices.
Iclinical1=nanmean(ID_mat_hyb(:,:,1),1);
Iclinical2=nanmean(ID_mat_hyb(:,:,2),2)';
Iclin_hyb =nanmean([Iclinical1;Iclinical2],1)';

%Calculate success rate. 
for i = 1:configs.numVisits
    sr_score(i) = f_makeSRscores(ID_mat(:,:,i),configs.numSubs);
end 


%% Plot constituents of figure 2A/B.
if configs.make_figs == 1 
%Figure 2A matrices. 
    figure;subplot(2,2,1);
    imagesc(ID_mat(:,:,1)); 
    axis square; xlabel('Subjects (Test)');ylabel('Subjects (Retest)'); 
    title('Baseline'); caxis([0.4 0.8]);
    set(gca,'XTick',[],'YTick',[]);
    hold on; 
    
    subplot(2,2,2);
    imagesc(ID_mat_hyb(:,:,1)); 
    axis square; xlabel('Subjects (Test)');ylabel('Subjects (Retest)'); 
    title('Hybrid 2'); caxis([0.4 0.8]);
    set(gca,'XTick',[],'YTick',[]);
    hold on; 

    subplot(2,2,3);
    imagesc(ID_mat_hyb(:,:,2)); 
    axis square; xlabel('Subjects (Test)');ylabel('Subjects (Retest)'); 
    title('Hybrid 2'); caxis([0.4 0.8]);
    set(gca,'XTick',[],'YTick',[]);
    hold on; 

    subplot(2,2,4)
    imagesc(ID_mat(:,:,2)); %colorbar('Ticks',[0.2,0.8])
    axis square; xlabel('Subjects (Test)');ylabel('Subjects (Retest)'); 
    title('Aya'); caxis([0.4 0.8]);
    set(gca,'XTick',[],'YTick',[]);
    hold off;
    
    %Figure 2B violin plots.
    figure; 
    subplot(1,3,1);
    x = {'Baseline','Ayahuasca','Hybrid'};
    y = []; y(:,1) = Iself(:,1); y(:,2) = Iself(:,2); y(:,3) =Iself_hyb;
    violinplot(y,x); title('Iself'); ylim([0,1]); axis square;
      hold on;
    subplot(1,3,2);
    y = []; y(:,1) = Iothers(:,1); y(:,2) = Iothers(:,2); y(:,3) = Iothers_hyb;
    violinplot(y,x); title('Iothers');ylim([0,1]); axis square;
    hold on;
    subplot(1,3,3);
    y = []; y(:,1) = Idiff(:,1); y(:,2) =Idiff(:,2);  y(:,3) = Idiff_hyb;
    violinplot(y,x); title('Idiff');ylim([0,100]); axis square;
    hold off;
end 


