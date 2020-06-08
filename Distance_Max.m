function y = Distance_Max(Cell) %%Calculate the Distance of each two member in the Cell
Distance_Max = 0;
for i = 1 : length(Cell)
    for j = i : length(Cell)
        D1 = sqrt((Cell{i}-Cell{j})*(Cell{i}-Cell{j})');
        Distance_Max = max(Distance_Max,D1);
    end
end
y = Distance_Max;
end