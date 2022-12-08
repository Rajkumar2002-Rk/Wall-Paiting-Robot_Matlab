clc;clear all;close all;

Dimensions_of_the_Wall = input('Enter Dimensions of the Wall, in the form [x,y]:');
Length_of_the_Wall = Dimensions_of_the_Wall(1);
fprintf('\nLength of the Wall is : %d\n',Length_of_the_Wall);
Breadth_of_the_Wall = Dimensions_of_the_Wall(2);
fprintf('\nBreadth of the Wall is : %d\n',Breadth_of_the_Wall);
No_of_Coatings = input('\nEnter the Number Of Coatings on the Wall : ');
fprintf('\nNumber of Coatings on the Wall is : %d\n',No_of_Coatings);
Paint_brush_width = input('\nEnter the Paint brush width to be used : ');
fprintf('\nWidth of paint brush provided to be used on the Wall is : %d\n',Paint_brush_width);
p = input('\nEnter initial co-ordinate (Bottom-Left) in brackets, in the form [x,y,z] : ');

Strokes = floor(Dimensions_of_the_Wall/Paint_brush_width); [M,I] = min(Strokes);
fprintf('\nVertical Strokes : %d and Horizontal Strokes : %d  for the given wall dimensions\n',Strokes(1),Strokes(2));

p2=p;p4=[p(1)+Length_of_the_Wall,p(2),p(3)+Breadth_of_the_Wall];
p1=[p(1),p(2),p(3)+Breadth_of_the_Wall];p3=[p(1)+Length_of_the_Wall,p(2),p(3)];

plot3( [p2(1) p3(1) p4(1) p1(1) p2(1)], [p2(2) p3(2) p4(2) p1(2) p2(2)], [p2(3) p3(3) p4(3) p1(3) p2(3)] )
hold on;

for c=1:No_of_Coatings
    if(I==1)
        fprintf('\nVertical Strokes are recommended for the given wall dimensions\n');
        pi=p2;pd=p1;
        j = p2(1);k = 1;
        for i=1:Strokes(1)
            if(k==1)
                Painting_Robot_A(pi,pd,p(2));
            else
                Painting_Robot_A(pd,pi,p(2));
            end
            patch([j,j+Paint_brush_width,j+Paint_brush_width,j],[p2(2)+5,p2(2)+5,p2(2)+5,p2(2)+5],[p2(3),p2(3),p1(3),p1(3)],'red');
            pi(1)=pi(1)+Paint_brush_width;pd(1)=pd(1)+Paint_brush_width;
            j=j+Paint_brush_width;k = k*-1;
        end
        if(mod(Length_of_the_Wall,Paint_brush_width)~=0)
            pi=[p3(1)-Paint_brush_width,p3(2),p3(3)];pd=[p4(1)-Paint_brush_width,p4(2),p4(3)];
            if(k==1)
                Painting_Robot_A(pi,pd,p(2));
            else
                Painting_Robot_A(pd,pi,p(2));
            end
            patch([p3(1)-Paint_brush_width,p3(1),p3(1),p3(1)-Paint_brush_width],[p2(2)+5,p2(2)+5,p2(2)+5,p2(2)+5],[p2(3),p2(3),p1(3),p1(3)],'green');
        end
    else
        fprintf('\nHorizontal Strokes are recommended for the given wall dimensions\n');
        pi=p1;pd=p4;
        j = p1(3);k = 1;
        for i=1:Strokes(2)
            if(k==1)
                Painting_Robot_A(pi,pd,p(2));
            else
                Painting_Robot_A(pd,pi,p(2));
            end
            patch([p1(1),p4(1),p4(1),p1(1)],[p2(2)+5,p2(2)+5,p2(2)+5,p2(2)+5],[j,j,j-Paint_brush_width,j-Paint_brush_width],'red');
            pi(3)=pi(3)-Paint_brush_width;pd(3)=pd(3)-Paint_brush_width;
            j=j-Paint_brush_width;k = k*-1;
        end
        if(mod(Breadth_of_the_Wall,Paint_brush_width)~=0)
            pi=[p2(1),p2(2),p2(3)+Paint_brush_width];pd=[p3(1),p3(2),p3(3)+Paint_brush_width];
            if(k==1)
                Painting_Robot_A(pi,pd,p(2));
            else
                Painting_Robot_A(pd,pi,p(2));
            end
            patch([p1(1),p4(1),p4(1),p1(1)],[p2(2)+5,p2(2)+5,p2(2)+5,p2(2)+5],[p2(3)+Paint_brush_width,p2(3)+Paint_brush_width,p2(3),p2(3)],'green');
        end
    end
end