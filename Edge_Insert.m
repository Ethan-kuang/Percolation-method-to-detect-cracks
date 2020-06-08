function y = Edge_Insert(Cell) %Detect Arrays belonging to Edges
Cell_Update = {};
for i = 1 : length(Cell)
    a = Cell{i}(1);
    b = Cell{i}(2);
    Edge_Pixel = {[a+1,b],[a-1,b],[a,b+1],[a,b-1]};
    for j = 1 : 4
        Cell_Update(length(Cell_Update)+1) = Edge_Pixel(j);
    end
end
y = Cell_Update;
end