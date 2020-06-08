function Cell_Update2 = Cell_Repeat(Cell_Edge1,Percolated_Label,row,column) %%Delete Repeated Cell Member or Zero Member and Create a new one
k = 1;
Percolated_Label2 = zeros(row,column);
Cell_Update2 = {};
for i = 1 : length(Cell_Edge1)
    if(Cell_Edge1{i}(1) <1 || Cell_Edge1{i}(2) < 1 || Cell_Edge1{i}(1) > 270 || Cell_Edge1{i}(2) > 270)
        continue;
    elseif(Percolated_Label(Cell_Edge1{i}(1),Cell_Edge1{i}(2)) ~= 1 && Percolated_Label2(Cell_Edge1{i}(1),Cell_Edge1{i}(2)) ~= 1)
        Cell_Update2{k} = Cell_Edge1{i};
        k = k+1;
        Percolated_Label2(Cell_Edge1{i}(1),Cell_Edge1{i}(2)) = 1;
    end
end    
end