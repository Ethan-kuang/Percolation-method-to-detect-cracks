function y = Cell_Percolation1(image, Cell_Update2, T) %%Update Cell based on T threshold
Cell_Update3 = {};
Min_Index = [];
Min_Pixal = 255;
for i = 1 : length(Cell_Update2)
    if(image(Cell_Update2{i}(1),Cell_Update2{i}(2)) <= T)
        Cell_Update3{length(Cell_Update3)+1} = Cell_Update2{i};
    end
    Min_Pixal = min(Min_Pixal,image(Cell_Update2{i}(1),Cell_Update2{i}(2)));
end
if(isempty(Cell_Update3))
    for i = 1 : length(Cell_Update2)
        if(image(Cell_Update2{i}(1),Cell_Update2{i}(2)) == Min_Pixal)
            Min_Index(length(Min_Index)+1) = i;
        end
    end
    for i = 1 : length(Min_Index)
        Cell_Update3{length(Cell_Update3)+1} = Cell_Update2{Min_Index(i)};
    end
end
y = Cell_Update3;
end
        