clear;
clc;
path_Train = 'D:\MATLAB_Undergraduate Design\Improved\'; %Read Crack data
D_Train = dir([path_Train '*.jpg']);
D_Train = sortnat({D_Train.name});

Imag_Size = [50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000];
M = 20;
w = 1;
Ts = 0.2;
AddSize = 10;
for ii = 1 :length(Imag_Size)
    Image_Resize('D:\MATLAB_Undergraduate Design\Origin\','D:\MATLAB_Undergraduate Design\Improved\','*.jpg',[Imag_Size(ii),Imag_Size(ii)]);
    for i = 43 : 43 %D_Train: Crack1.jpg Crack2.jpg......
        tic;
        imag = imread(strcat('D:\MATLAB_Undergraduate Design\Improved\',D_Train{i}));
        if(length(size(imag)) == 3) %Transform raw picture to Gray picture
            imag = rgb2gray(imag);
        end
        imag = im2uint8(Image_EdgeEnlarge(imag,AddSize));
        [row,column] = size(imag);
        Imag_Update = zeros(row,column);
        Imag_Update2 = zeros(row,column);
        for m = (1+AddSize):(row-AddSize)
            for n = (1+AddSize):(column-AddSize)
                N0 = 10;
                flag = 0;
                flag2 = 0;
                flag3 = 0;
                count = 1;
                T = imag(m,n);
                Dp = {[m,n]};
                Dc = {[m,n]};
                Dpcur = {[m,n]};
                Max_Pixel = 0;
                Perco_Label = zeros(row,column);
                Perco_Label(Dp{1}(1),Dp{1}(2)) = 1;
                Distancemax = 0;
                while(Distancemax <= N0)
                    for j = 1:length(Dp)
                        Max_Pixel = max(Max_Pixel,imag(Dp{j}(1),Dp{j}(2)));
                    end
                    if(Distancemax == 0)
                        Fc = 0;
                    end
                    T = double(Max_Pixel)+w*Fc;
                    Da = Edge_Insert(Dc);
                    Dc = Delete_Repeat(Da,Perco_Label,row,column);
                    Dp = Percolation1(imag,Dc,T);
                    if(count == 1)
                        for j = 1:length(Dp)
                            if(Imag_Update2(Dp{j}(1),Dp{j}(2)) == 255)
                                flag3 = 1;
                                Fc = 1;
                                break;
                            end
                        end
                        if(flag3 == 1)
                            break;
                        end
                    end
                    for j = 1:length(Dp)
                        Perco_Label(Dp{j}(1),Dp{j}(2)) = 1;
                        Dpcur{length(Dpcur)+1} = Dp{j};
                    end
                    Distancemax = Distance_Max(Dpcur);
                    Fc = 4*length(Dpcur)/(pi*Distancemax^2);
                    count = count + 1;
                end
                N0 = N0 + 2;
                if(flag3 == 0)
                    while(N0 <= M)
                        while(Distancemax <= N0)
                            for j = 1:length(Dp)
                                Max_Pixel = max(Max_Pixel,imag(Dp{j}(1),Dp{j}(2)));
                            end
                            T = double(Max_Pixel)+w*Fc;
                            Da = Edge_Insert(Dc);
                            Dc = Delete_Repeat(Da,Perco_Label,row,column);
                            [Dp,flag] = Percolation2(imag,Dc,T);
                            if(flag == 1)
                                break;
                            end
                            for j = 1:length(Dp)
                                Perco_Label(Dp{j}(1),Dp{j}(2)) = 1;
                                Dpcur{length(Dpcur)+1} = Dp{j};
                            end
                            Distancemax = Distance_Max(Dpcur);
                            Fc = 4*length(Dpcur)/(pi*Distancemax^2);
                            count = count +1;
                            if(Fc >= Ts)
                                flag2 = 1;
                                break;
                            end
                        end
                        if(flag == 1 || flag2 == 1)
                            break;
                        end
                        N0 = N0 + 2;
                    end
                end
                Imag_Update(m,n) = Fc;
                if(Fc >= Ts)
                    Imag_Update2(m,n) = 255;
                else
                    Imag_Update2(m,n) = 0;
                end
            end
        end
    end
    Imag_Update = Imag_Update(AddSize+1:row-AddSize,AddSize+1:column-AddSize);
    Imag_Update2 = Imag_Update2(AddSize+1:row-AddSize,AddSize+1:column-AddSize);
    t = toc;
    Picture_Batch_US_S12{ii}={Imag_Update,Imag_Update2,t};
end