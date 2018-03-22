a1 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
a2 = fliplr(a1);

b1 = [6 6 6 6 10 10 10 10 6 6 6 6 6 10 10 10 10 10 10 10];
b2 = 6 * ones(1,20);

c1 = ones(1,20);
c2 = c1;

figure; plot3(a1,b1,c1)
hold on
plot3(a2,b2,c2)

i = 1;
new_axons(i).directionx = a1;
new_axons(i).directiony = b1;
new_axons(i).directionz = c1;

i = 2;
new_axons(i).directionx = a2;
new_axons(i).directiony = b2;
new_axons(i).directionz = c2;

[new_axons] = aligining_last_version(new_axons,1,2);

[new_neurites] = nanmergev3(new_axons,1,2);
%new_neurites = new_axons;
figure;
xlim([0 20])
ylim([6 10])
view(3)
hold on
for in = 1:size(new_neurites,2)
    plot3(new_neurites(1,in).directionx,new_neurites(1,in).directiony,new_neurites(1,in).directionz)
    pause(2)
end
hold off
