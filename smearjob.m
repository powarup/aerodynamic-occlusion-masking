%% load matrices

visibility_matrices_3 = load('visibility_matrices.mat','visibility_matrices_3');
visibility_matrices_4 = load('visibility_matrices.mat','visibility_matrices_4');

%% smear

smeared_matrices_3 = smear_time(smear_space(visibility_matrices_3,5),5);
smeared_matrices_4 = smear_time(smear_space(visibility_matrices_4,5),5);

%% save

save('smeared_matrices.mat','smeared_matrices_3','smeared_matrices_4');