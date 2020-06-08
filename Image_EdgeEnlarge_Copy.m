function Image2 = Image_EdgeEnlarge_Copy(Image,AddSize)
Image = im2double(Image);
[Row,Column] = size(Image);
Image2 = zeros(Row+2*AddSize,Column+2*AddSize);
for i = 1 : Row
    for j = 1 : AddSize
        Image2(i+AddSize,AddSize+1-j) = Image(i,j);
        Image2(i+AddSize,Column+AddSize+j) = Image(i,Column+1-j);
    end
end
for i =1 : AddSize
    for j = 1 : Column
        Image2(AddSize+1-i,j+AddSize) = Image(i,j);
        Image2(Row+AddSize+i,j+AddSize) = Image(Row+1-i,j);
    end
end
for i = 1 : Row
    for j = 1 : Column
        Image2(i+AddSize,j+AddSize) = Image(i,j);
    end
end
end