function [flat_mat] = f_restructure_mats(input_mat,configs,mode)

%P.Mallaroni
%mode 0 = static, mode 1 = dynamic
%If 0: splits into test-retest halves and produces a matrix of subj x all edges x 
%If 1: splits main matrix into test-retest halves

%%For static this allows a "flat" subj x edges vector that can be compared using
%%pearson correlation. 

if (nargin < 3)
     mode = 0; 
end 
flat_mat = [];

if mode == 0 
    flat_mat = [];
    for i = 1:size(input_mat,3) %Per subject
    tmp = input_mat(1:size(input_mat,1)/2,:,i); %take volumes 1:midvol
    tmp_FC = corr(tmp(:,:)); %produce static Pearson connectome
    flat_mat.test(i,:) = tmp_FC(configs.mask_ut)'; % "flatten" aka take the upper triangular of full connectome.

    tmp = input_mat(((size(input_mat,1)/2)+1):end,:,i); %take volumes midvol+1:end
    tmp_FC = corr(tmp(:,:)); %produce static Pearson connectome
    flat_mat.retest(i,:) = tmp_FC(configs.mask_ut)'; % "flatten" aka take the upper triangular of full connectome.
    end

elseif mode == 1
    flat_mat = [];
    for i = 1:size(input_mat,3) %Per subject
    flat_mat.test(:,:,i) = input_mat(1:size(input_mat,1)/2,:,i); %take volumes 1:midvol
    flat_mat.retest(:,:,i) = input_mat(((size(input_mat,1)/2)+1):end,:,i); %take volumes midvol+1:end
    end 
end 


end