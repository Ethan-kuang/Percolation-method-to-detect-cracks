%%-----------------------------------------------------------------
%%??????????? 
%%CSDN 
%%https://blog.csdn.net/w_q_q2017/article/details/78430587 
%%-----------------------------------------------------------------
function y = Image_Resize(Path_Read,Path_Save,Suffix,Size) %%Path_Read/ Path_Save: File_Name, Suffix: '.*jpg', Size: [256, 256]
file_path =  Path_Read;
img_path_list = dir([file_path,Suffix]);
img_num = length(img_path_list);
if img_num > 0 
        for j = 1:img_num 
            image_name = img_path_list(j).name;
            image =  imread(strcat(file_path,image_name));
            image = imresize(image,Size); 
            imwrite(image,strcat(Path_Save,image_name)); 
        end
end
end
