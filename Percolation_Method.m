clear;
clc;
path_Train = 'D:\MATLAB_Undergraduate Design\Improved\'; %Read Crack data
D_Train = dir([path_Train '*.jpg']);
D_Train = sortnat({D_Train.name});

M = 41; %Define Basic Parameters
w = 1;
Ts = 0.6;
AddSize = 10;
for i = 5 : length(D_Train) %D_Train: Crack1.jpg Crack2.jpg......
    tic;
    imag = imread(strcat('D:\MATLAB_Undergraduate Design\Improved\',D_Train{i}));
    if(length(size(imag)) == 3) %Transform raw picture to Gray picture
        imag = rgb2gray(imag);
    end
    imag = im2uint8(Image_EdgeEnlarge_Copy(imag,AddSize));
    [row,column] = size(imag);
    Picture = [];
    for m = 1 : row %%Loop every pixel in one picture
        for n = 1 : column
            Cell = {[m,n]}; %%Dp ??
            Cell_Edge2 = Cell; %% The area adjacent to Dp
            N = 21;
            Max_Pixel = imag(Cell{1}(1),Cell{1}(2));
            Cell_Edge3 = {[m,n]}; %%Percolated area
            Distancemax = 0;%%????
            Percolated_Label = zeros(row,column);
            Percolated_Label(1,1) = 1;
            while(Distancemax <= N)
                
                    Fc = 4*length(Cell)/(pi*Distancemax^2);
    
                if(length(Cell_Edge3) > 0)
                    for j = 1 : length(Cell_Edge3)
                        Max_Pixel = max(Max_Pixel,imag(Cell_Edge3{j}(1),Cell_Edge3{j}(2)));
                    end
                end
                T = Max_Pixel + Fc*w; %Update T
                Cell_Edge1 = Edge_Insert(Cell_Edge2); %Find area adjacent to Dp
                Cell_Edge2 = Cell_Repeat(Cell_Edge1,Percolated_Label,row,column); %Delete repeated area
                Cell_Edge3 = Cell_Percolation1(imag,Cell_Edge2,T); %Find percolated area%%??
               
                for nn = 1 : length(Cell_Edge3)
                    Percolated_Label(Cell_Edge3{nn}(1),Cell_Edge3{nn}(2)) = 1;
                end
                for j = 1 : length(Cell_Edge3)
                    Cell{length(Cell)+1} = Cell_Edge3{j};
                end
                Distancemax = Distance_Max(Cell_Edge2);%%??
            end
                while(N<=M)
                    N = N + 2;
                    Fc = 4*length(Cell)/(pi*Distancemax^2);
                    if(Fc >= Ts)
                        Fc = 1;
                        break;
                    end
                    if(length(Cell_Edge3)>0)
                        for j = 1 : length(Cell_Edge3)
                            Max_Pixel = max(Max_Pixel,imag(Cell_Edge3{j}(1),Cell_Edge3{j}(2)));
                        end
                    end
                    T = Max_Pixel + Fc*w;
                    Cell_Edge1 = Edge_Insert(Cell_Edge2);
                    Cell_Edge2 = Cell_Repeat(Cell_Edge1,Percolated_Label,row,column);
                    Cell_Edge3 = Cell_Percolation2(imag,Cell_Edge2,T);
                    for nn = 1 : length(Cell_Edge3)
                        Percolated_Label(Cell_Edge3{nn}(1),Cell_Edge3{nn}(2)) = 1;
                    end
                    if(length(Cell_Edge3) == 0)
                        break;
                    else
                        for j = 1 : length(Cell_Edge3)
                            Cell{length(Cell)+1} = Cell_Edge3{j};
                        end
                    end
                    Distancemax = Distance_Max(Cell_Edge2);%%??
                end
            
            if(Fc ~= 1)
                Fc = 4*length(Cell)/(pi*Distancemax^2);
            end
            if(Fc >= Ts)
                Final_Value = 255;
            else
                Final_Value = 0;
            end
            Picture(m,n) = Final_Value;
        end
    end
    tt = toc;
    Image_Batch{i} ={Picture,tt};
end





