function [] = Painting_Robot_A(Pi,Pd,Y_plane)

offset1=10;offset2=10;
L1 = Link('prismatic','theta',pi/2, 'a',0,'alpha',pi/2,'qlim',[0 100],'offset',offset1);
L2 = Link('prismatic','theta',pi/2, 'a',0,'alpha',pi/2,'qlim',[0 100],'offset',offset2);
Painting_Robot = SerialLink([L1 L2],'name','Wall Painting Robot');
Painting_Robot.base=SE3(0,Y_plane,0);

qi=[Pi(3)-offset1 Pi(1)-offset2];
qd=[Pd(3)-offset1 Pd(1)-offset2];

Ti = Painting_Robot.fkine(qi)
Tf = Painting_Robot.fkine(qd)

Tt = jtraj(qi,qd,10);
Painting_Robot.plot(Tt);


%Tt = ctraj(Ti,Tf,10);
%T = Painting_Robot.ikine(Tt, 'mask', [1 1 0 0 0 0]);
%Painting_Robot.plot(T);