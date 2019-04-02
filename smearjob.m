%% load matrices

visibility_matrices_3 = load('visibility_matrices_chunk_1_to_1900.mat','visibility_matrices_3');
sum(visibility_matrices_3,'all')
visibility_matrices_4 = load('visibility_matrices_chunk_1_to_1900.mat','visibility_matrices_4');

%% smear
tic
smeared_matrices_3 = smear_time(smear_space(visibility_matrices_3,5),5);
smeared_matrices_4 = smear_time(smear_space(visibility_matrices_4,5),5);
toc
sum(smeared_matrices_3,'all') - sum(visibility_matrices_3,'all')
%% save

%save('smeared_matrices.mat','smeared_matrices_3','smeared_matrices_4');