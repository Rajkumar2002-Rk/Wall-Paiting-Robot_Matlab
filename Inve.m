classdef Inve < matlab.apps.AppBase
    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        INDUSTRIALMANIPULATORINVERSEKINEMATICSGUIbyTeamLabel  matlab.ui.control.Label
        ENTERXEditFieldLabel            matlab.ui.control.Label
        ENTERXEditField                 matlab.ui.control.NumericEditField
        ENTERYEditFieldLabel            matlab.ui.control.Label
        ENTERYEditField                 matlab.ui.control.NumericEditField
        ENTERZEditFieldLabel            matlab.ui.control.Label
        ENTERZEditField                 matlab.ui.control.NumericEditField
        ENTERROLLVALUEINTHETALabel      matlab.ui.control.Label
        ENTERROLLVALUEINTHETAEditField  matlab.ui.control.NumericEditField
        ENTERPITCHVALUEINTHETALabel     matlab.ui.control.Label
        ENTERPITCHVALUEINTHETAEditField  matlab.ui.control.NumericEditField
        ENTERYAWVALUEINTHETAEditFieldLabel  matlab.ui.control.Label
        ENTERYAWVALUEINTHETAEditField   matlab.ui.control.NumericEditField
        CALCULATEJOINTANGLESButton      matlab.ui.control.Button
        PLOTButton                      matlab.ui.control.Button
        D1EditFieldLabel                matlab.ui.control.Label
        D3EditField                     matlab.ui.control.NumericEditField
        D1EditField                     matlab.ui.control.NumericEditField
        D3EditFieldLabel                matlab.ui.control.Label
        Theta4EditField                 matlab.ui.control.NumericEditField
        Theta4EditFieldLabel            matlab.ui.control.Label
        Theta6EditField                 matlab.ui.control.NumericEditField
        Theta6EditFieldLabel            matlab.ui.control.Label
        Theta5EditField                 matlab.ui.control.NumericEditField
        Theta5EditFieldLabel            matlab.ui.control.Label
        Theta2EditField                 matlab.ui.control.NumericEditField
        UITable                         matlab.ui.control.Table
        Theta2EditFieldLabel            matlab.ui.control.Label
        ANIMATEButton                   matlab.ui.control.Button
        XANIMATEEditFieldLabel          matlab.ui.control.Label
        XANIMATEEditField               matlab.ui.control.NumericEditField
        YANIMATEEditFieldLabel          matlab.ui.control.Label
        YANIMATEEditField               matlab.ui.control.NumericEditField
        ZANIMATEEditFieldLabel          matlab.ui.control.Label
        ZANIMATEEditField               matlab.ui.control.NumericEditField
        ROLLANIMATEEditFieldLabel       matlab.ui.control.Label
        ROLLANIMATEEditField            matlab.ui.control.NumericEditField
        PITCHANIMATEEditFieldLabel      matlab.ui.control.Label
        PITCHANIMATEEditField           matlab.ui.control.NumericEditField
        YAWANIMATEEditFieldLabel        matlab.ui.control.Label
        YAWANIMATEEditField             matlab.ui.control.NumericEditField
        UIAxes                          matlab.ui.control.UIAxes
    end
    methods (Access = public)
        function [T]=Test(app,X,Y,Z,Roll,Pitch,Yaw)
a1=1;
a2=1;
a3=1;
a4=1;
a5=1;
a6=1;
a7=1;
width=5;
Size=6;
T = transl(X,Y,Z)*rpy2tr(Roll,Pitch,Yaw,'deg','xyz');
app.UITable.Data =T;
theta2=atan2(Y,X);
R30inv=[-sin(theta2) cos(theta2) 0;0 0 1;cos(theta2) sin(theta2) 0];
R60=rpy2r(Roll,Pitch,Yaw,'deg','xyz');
R63=R30inv*R60;
Ctheta5=R63(3,3);
theta5=acos(Ctheta5);
Ctheta6=-R63(3,1)/sin(theta5);
theta6=acos(Ctheta6);
Ctheta4=R63(2,3)/sin(theta5);
theta4=acos(Ctheta4);
d1=Z-a2-a1;
d3=sqrt(X^2+Y^2)-a3-a4;
app.D1EditField.Value = d1;
app.D3EditField.Value = d3;
app.Theta2EditField.Value = theta2;
app.Theta4EditField.Value = theta4;
app.Theta5EditField.Value = theta5;
app.Theta6EditField.Value = theta6;
val1=[0,0,0];
I=eye(4);
T1 = I*transl(0,0,a1+d1);
T2=((T1*transl(0,0,a2)*trotx(90,'deg'))*troty(pi/2+theta2));
T3=T2*transl(0,0,a3+a4+d3);
val2=T1*[0;0;0;1];
val2=val2([1,2,3],:)';
valtemp1=T1*[0;0;a2;1];
valtemp1=valtemp1([1,2,3],:)';
val3=T2*[0;0;a3;1];
val3=val3([1,2,3],:)';
val4=T3*[0;0;0;1];
val4=val4([1,2,3],:)';
val5=T3*trotz(theta4)*[a5;0;0;1];
val5=val5([1,2,3],:)';
val6=T3*trotz(theta4)*transl(a5,0,0)*trotx(-theta5)*[0;0;a6;1];
val6=val6([1,2,3],:)';
val7=T3*trotz(theta4)*transl(a5,0,0)*trotx(-theta5)*transl(0,0,a6)*trotz(theta6)*[a7;0;0;1];
val7=val7([1,2,3],:)';
val8=T3*trotz(theta4)*transl(a5,0,0)*trotx(-theta5)*transl(0,0,a6)*trotz(theta6)*transl(a7,0,0)*[0;1;0;1];
val8=val8([1,2,3],:)';
val9=T3*trotz(theta4)*transl(a5,0,0)*trotx(-theta5)*transl(0,0,a6)*trotz(theta6)*transl(a7,0,0)*[0;-1;0;1];
val9=val9([1,2,3],:)';
val10=T3*trotz(theta4)*transl(a5,0,0)*trotx(-theta5)*transl(0,0,a6)*trotz(theta6)*transl(a7,1,0)*[1;0;0;1];
val10=val10([1,2,3],:)';
val11=T3*trotz(theta4)*transl(a5,0,0)*trotx(-theta5)*transl(0,0,a6)*trotz(theta6)*transl(a7,-1,0)*[1;0;0;1];
val11=val11([1,2,3],:)';
v1=[val2;val1];
v2=[val3;valtemp1];
v3=[val4;val3];
v4=[val5;val4];
v5=[val6;val5];
v6=[val7;val6];
v7=[val8;val7];
v8=[val9;val8];
v9=[val10;val8];
v10=[val11;val9];
vtemp=[valtemp1;val2];
plot3(app.UIAxes,v1(:,1),v1(:,2),v1(:,3),'s-k','LineWidth',width,'MarkerSize',Size)
hold(app.UIAxes,"on") 
plot3(app.UIAxes,v2(:,1),v2(:,2),v2(:,3),'Color',[0.6350 0.0780 0.1840],'LineWidth',width,'MarkerSize',Size)
hold(app.UIAxes,"on") 
plot3(app.UIAxes,v3(:,1),v3(:,2),v3(:,3),'Color',[0 0.4470 0.7410],'Marker','s','LineWidth',width,'MarkerSize',Size)
hold(app.UIAxes,"on") 
plot3(app.UIAxes,v4(:,1),v4(:,2),v4(:,3),'Color',[0.6350 0.0780 0.1840],'Marker','o','LineWidth',width,'MarkerSize',Size/2)
hold(app.UIAxes,"on") 
plot3(app.UIAxes,v5(:,1),v5(:,2),v5(:,3),'Color',[0.4660 0.6740 0.1880],'Marker','o','LineWidth',width,'MarkerSize',Size/2)
hold(app.UIAxes,"on") 
plot3(app.UIAxes,v6(:,1),v6(:,2),v6(:,3),'Color',[0.8500 0.3250 0.0980],'Marker','o','LineWidth',width,'MarkerSize',Size/2)
hold(app.UIAxes,"on") 
plot3(app.UIAxes,v7(:,1),v7(:,2),v7(:,3),'Color',[0.6350 0.0780 0.1840],'Marker','o','LineWidth',width,'MarkerSize',Size/2)
hold(app.UIAxes,"on") 
plot3(app.UIAxes,v8(:,1),v8(:,2),v8(:,3),'Color',[0.4660 0.6740 0.1880],'Marker','o','LineWidth',width,'MarkerSize',Size/2)
hold(app.UIAxes,"on")
plot3(app.UIAxes,v9(:,1),v9(:,2),v9(:,3),'ko-','LineWidth',width,'MarkerSize',Size/2)
hold(app.UIAxes,"on") 
plot3(app.UIAxes,v10(:,1),v10(:,2),v10(:,3),'ko-','LineWidth',width,'MarkerSize',Size/2)
hold(app.UIAxes,"on") 
plot3(app.UIAxes,vtemp(:,1),vtemp(:,2),vtemp(:,3),'Color',[0.6350 0.0780 0.1840],'Marker','.','LineWidth',width,'MarkerSize',1)
hold(app.UIAxes,"off") 
        end
    end
    % Callbacks that handle component events
    methods (Access = private)
        % Button pushed function: CALCULATEJOINTANGLESButton
        function CALCULATEJOINTANGLESButtonPushed(app, event)
X=app.ENTERXEditField.Value;
Y=app.ENTERYEditField.Value;
Z=app.ENTERZEditField.Value;
Roll=app.ENTERROLLVALUEINTHETAEditField.Value;
Pitch=app.ENTERPITCHVALUEINTHETAEditField.Value;
Yaw=app.ENTERYAWVALUEINTHETAEditField.Value;
a1=1;
a2=1;
a3=1;
a4=1;
T = transl(X,Y,Z)*rpy2tr(Roll,Pitch,Yaw,'deg','xyz');
app.UITable.Data =T;
theta2=atan2(Y,X);
R30inv=[-sin(theta2) cos(theta2) 0;0 0 1;cos(theta2) sin(theta2) 0];
R60=rpy2r(Roll,Pitch,Yaw,'deg','xyz');
R63=R30inv*R60;
Ctheta5=R63(3,3);
theta5=acos(Ctheta5);
Ctheta6=-R63(3,1)/sin(theta5);
theta6=acos(Ctheta6);
Ctheta4=R63(2,3)/sin(theta5);
theta4=acos(Ctheta4);
d1=Z-a2-a1;
d3=sqrt(X^2+Y^2)-a3-a4;
app.D1EditField.Value = d1;
app.D3EditField.Value = d3;
app.Theta2EditField.Value = theta2;
app.Theta4EditField.Value = theta4;
app.Theta5EditField.Value = theta5;
app.Theta6EditField.Value = theta6;
        end
        % Button pushed function: PLOTButton
        function PLOTButtonPushed(app, event)
X=app.ENTERXEditField.Value;
Y=app.ENTERYEditField.Value;
Z=app.ENTERZEditField.Value;
Roll=app.ENTERROLLVALUEINTHETAEditField.Value;
Pitch=app.ENTERPITCHVALUEINTHETAEditField.Value;
Yaw=app.ENTERYAWVALUEINTHETAEditField.Value;
app.Test(X,Y,Z,Roll,Pitch,Yaw)
        end
        % Button pushed function: ANIMATEButton
        function ANIMATEButtonPushed(app, event)
X1=app.ENTERXEditField.Value;
Y1=app.ENTERYEditField.Value;
Z1=app.ENTERZEditField.Value;
Roll1=app.ENTERROLLVALUEINTHETAEditField.Value;
Pitch1=app.ENTERPITCHVALUEINTHETAEditField.Value;
Yaw1=app.ENTERYAWVALUEINTHETAEditField.Value;
X2=app.XANIMATEEditField .Value;
Y2=app.YANIMATEEditField .Value;
Z2=app.ZANIMATEEditField .Value;
Roll2=app.ROLLANIMATEEditField.Value;
Pitch2=app.PITCHANIMATEEditField.Value;
Yaw2=app.YAWANIMATEEditField.Value;
frames=50;
n1=linspace(Z1,Z2,frames);
n2=linspace(X1,X2,frames);
n3=linspace(Y1,Y2,frames);
n4=linspace(Roll1,Roll2,frames);
n5=linspace(Pitch1,Pitch2,frames);
n6=linspace(Yaw1,Yaw2,frames);
for i=1:length(n1)
    app.ENTERXEditField.Value=n2(i);
    app.ENTERYEditField.Value=n3(i);
    app.ENTERZEditField.Value=n1(i);
    app.ENTERROLLVALUEINTHETAEditField.Value=n4(i);
    app.ENTERPITCHVALUEINTHETAEditField.Value=n5(i);
    app.ENTERYAWVALUEINTHETAEditField.Value=n6(i);
    app.Test(n2(i),n3(i),n1(i),n4(i),n5(i),n6(i))
    drawnow();
end
        end
    end
    % Component initialization
    methods (Access = private)
        % Create UIFigure and components
        function createComponents(app)
            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 953 540];
            app.UIFigure.Name = 'MATLAB App';
            % Create INDUSTRIALMANIPULATORINVERSEKINEMATICSGUIbyTeamLabel
            app.INDUSTRIALMANIPULATORINVERSEKINEMATICSGUIbyTeamLabel = uilabel(app.UIFigure);
            app.INDUSTRIALMANIPULATORINVERSEKINEMATICSGUIbyTeamLabel.FontSize = 16;
            app.INDUSTRIALMANIPULATORINVERSEKINEMATICSGUIbyTeamLabel.Position = [0 507 612 34];
            app.INDUSTRIALMANIPULATORINVERSEKINEMATICSGUIbyTeamLabel.Text = '              INDUSTRIAL MANIPULATOR INVERSE KINEMATICS GUI  (by Team )';
            % Create ENTERXEditFieldLabel
            app.ENTERXEditFieldLabel = uilabel(app.UIFigure);
            app.ENTERXEditFieldLabel.HorizontalAlignment = 'right';
            app.ENTERXEditFieldLabel.Position = [1 473 61 22];
            app.ENTERXEditFieldLabel.Text = 'ENTER X:';
            % Create ENTERXEditField
            app.ENTERXEditField = uieditfield(app.UIFigure, 'numeric');
            app.ENTERXEditField.Position = [77 473 100 22];
            % Create ENTERYEditFieldLabel
            app.ENTERYEditFieldLabel = uilabel(app.UIFigure);
            app.ENTERYEditFieldLabel.HorizontalAlignment = 'right';
            app.ENTERYEditFieldLabel.Position = [1 439 60 22];
            app.ENTERYEditFieldLabel.Text = 'ENTER Y:';
            % Create ENTERYEditField
            app.ENTERYEditField = uieditfield(app.UIFigure, 'numeric');
            app.ENTERYEditField.Position = [77 439 100 20];
            % Create ENTERZEditFieldLabel
            app.ENTERZEditFieldLabel = uilabel(app.UIFigure);
            app.ENTERZEditFieldLabel.HorizontalAlignment = 'right';
            app.ENTERZEditFieldLabel.Position = [1 402 60 22];
            app.ENTERZEditFieldLabel.Text = 'ENTER Z:';
            % Create ENTERZEditField
            app.ENTERZEditField = uieditfield(app.UIFigure, 'numeric');
            app.ENTERZEditField.Position = [77 402 100 20];
            % Create ENTERROLLVALUEINTHETALabel
            app.ENTERROLLVALUEINTHETALabel = uilabel(app.UIFigure);
            app.ENTERROLLVALUEINTHETALabel.HorizontalAlignment = 'right';
            app.ENTERROLLVALUEINTHETALabel.Position = [205 472 192 22];
            app.ENTERROLLVALUEINTHETALabel.Text = 'ENTER ROLL (VALUE IN THETA):';
            % Create ENTERROLLVALUEINTHETAEditField
            app.ENTERROLLVALUEINTHETAEditField = uieditfield(app.UIFigure, 'numeric');
            app.ENTERROLLVALUEINTHETAEditField.Position = [413 472 100 20];
            % Create ENTERPITCHVALUEINTHETALabel
            app.ENTERPITCHVALUEINTHETALabel = uilabel(app.UIFigure);
            app.ENTERPITCHVALUEINTHETALabel.HorizontalAlignment = 'right';
            app.ENTERPITCHVALUEINTHETALabel.Position = [207 438 196 22];
            app.ENTERPITCHVALUEINTHETALabel.Text = 'ENTER PITCH (VALUE IN THETA):';
            % Create ENTERPITCHVALUEINTHETAEditField
            app.ENTERPITCHVALUEINTHETAEditField = uieditfield(app.UIFigure, 'numeric');
            app.ENTERPITCHVALUEINTHETAEditField.Position = [413 439 100 20];
            % Create ENTERYAWVALUEINTHETAEditFieldLabel
            app.ENTERYAWVALUEINTHETAEditFieldLabel = uilabel(app.UIFigure);
            app.ENTERYAWVALUEINTHETAEditFieldLabel.HorizontalAlignment = 'right';
            app.ENTERYAWVALUEINTHETAEditFieldLabel.Position = [207 401 186 22];
            app.ENTERYAWVALUEINTHETAEditFieldLabel.Text = 'ENTER YAW (VALUE IN THETA):';
            % Create ENTERYAWVALUEINTHETAEditField
            app.ENTERYAWVALUEINTHETAEditField = uieditfield(app.UIFigure, 'numeric');
            app.ENTERYAWVALUEINTHETAEditField.Position = [413 402 100 20];
            % Create CALCULATEJOINTANGLESButton
            app.CALCULATEJOINTANGLESButton = uibutton(app.UIFigure, 'push');
            app.CALCULATEJOINTANGLESButton.ButtonPushedFcn = createCallbackFcn(app, @CALCULATEJOINTANGLESButtonPushed, true);
            app.CALCULATEJOINTANGLESButton.Position = [16 358 175 26];
            app.CALCULATEJOINTANGLESButton.Text = 'CALCULATE JOINT ANGLES';
            % Create PLOTButton
            app.PLOTButton = uibutton(app.UIFigure, 'push');
            app.PLOTButton.ButtonPushedFcn = createCallbackFcn(app, @PLOTButtonPushed, true);
            app.PLOTButton.Position = [310 341 100 22];
            app.PLOTButton.Text = 'PLOT';
            % Create D1EditFieldLabel
            app.D1EditFieldLabel = uilabel(app.UIFigure);
            app.D1EditFieldLabel.HorizontalAlignment = 'right';
            app.D1EditFieldLabel.Position = [0 320 25 22];
            app.D1EditFieldLabel.Text = 'D1';
            % Create D3EditField
            app.D3EditField = uieditfield(app.UIFigure, 'numeric');
            app.D3EditField.Position = [59 289 146 18];
            % Create D1EditField
            app.D1EditField = uieditfield(app.UIFigure, 'numeric');
            app.D1EditField.Position = [59 320 146 18];
            % Create D3EditFieldLabel
            app.D3EditFieldLabel = uilabel(app.UIFigure);
            app.D3EditFieldLabel.HorizontalAlignment = 'right';
            app.D3EditFieldLabel.Position = [1 289 25 22];
            app.D3EditFieldLabel.Text = 'D3';
            % Create Theta4EditField
            app.Theta4EditField = uieditfield(app.UIFigure, 'numeric');
            app.Theta4EditField.Position = [59 233 147 18];
            % Create Theta4EditFieldLabel
            app.Theta4EditFieldLabel = uilabel(app.UIFigure);
            app.Theta4EditFieldLabel.HorizontalAlignment = 'right';
            app.Theta4EditFieldLabel.Position = [1 233 43 22];
            app.Theta4EditFieldLabel.Text = 'Theta4';
            % Create Theta6EditField
            app.Theta6EditField = uieditfield(app.UIFigure, 'numeric');
            app.Theta6EditField.Position = [58 170 147 18];
            % Create Theta6EditFieldLabel
            app.Theta6EditFieldLabel = uilabel(app.UIFigure);
            app.Theta6EditFieldLabel.HorizontalAlignment = 'right';
            app.Theta6EditFieldLabel.Position = [0 170 43 22];
            app.Theta6EditFieldLabel.Text = 'Theta6';
            % Create Theta5EditField
            app.Theta5EditField = uieditfield(app.UIFigure, 'numeric');
            app.Theta5EditField.Position = [59 203 147 18];
            % Create Theta5EditFieldLabel
            app.Theta5EditFieldLabel = uilabel(app.UIFigure);
            app.Theta5EditFieldLabel.HorizontalAlignment = 'right';
            app.Theta5EditFieldLabel.Position = [1 203 43 22];
            app.Theta5EditFieldLabel.Text = 'Theta5';
            % Create Theta2EditField
            app.Theta2EditField = uieditfield(app.UIFigure, 'numeric');
            app.Theta2EditField.Position = [58 262 147 18];
            % Create UITable
            app.UITable = uitable(app.UIFigure);
            app.UITable.ColumnName = {'1'; '2'; '3'; '4'};
            app.UITable.RowName = {'1'; '2'; '3'; '4'};
            app.UITable.Position = [529 402 400 103];
            % Create Theta2EditFieldLabel
            app.Theta2EditFieldLabel = uilabel(app.UIFigure);
            app.Theta2EditFieldLabel.HorizontalAlignment = 'right';
            app.Theta2EditFieldLabel.Position = [0 262 43 22];
            app.Theta2EditFieldLabel.Text = 'Theta2';
            % Create ANIMATEButton
            app.ANIMATEButton = uibutton(app.UIFigure, 'push');
            app.ANIMATEButton.ButtonPushedFcn = createCallbackFcn(app, @ANIMATEButtonPushed, true);
            app.ANIMATEButton.Position = [700 320 100 22];
            app.ANIMATEButton.Text = 'ANIMATE';
            % Create XANIMATEEditFieldLabel
            app.XANIMATEEditFieldLabel = uilabel(app.UIFigure);
            app.XANIMATEEditFieldLabel.HorizontalAlignment = 'right';
            app.XANIMATEEditFieldLabel.Position = [722 268 66 22];
            app.XANIMATEEditFieldLabel.Text = 'XANIMATE';
            % Create XANIMATEEditField
            app.XANIMATEEditField = uieditfield(app.UIFigure, 'numeric');
            app.XANIMATEEditField.Position = [828 268 99 22];
            % Create YANIMATEEditFieldLabel
            app.YANIMATEEditFieldLabel = uilabel(app.UIFigure);
            app.YANIMATEEditFieldLabel.HorizontalAlignment = 'right';
            app.YANIMATEEditFieldLabel.Position = [722 233 65 22];
            app.YANIMATEEditFieldLabel.Text = 'YANIMATE';
            % Create YANIMATEEditField
            app.YANIMATEEditField = uieditfield(app.UIFigure, 'numeric');
            app.YANIMATEEditField.Position = [828 233 99 20];
            % Create ZANIMATEEditFieldLabel
            app.ZANIMATEEditFieldLabel = uilabel(app.UIFigure);
            app.ZANIMATEEditFieldLabel.HorizontalAlignment = 'right';
            app.ZANIMATEEditFieldLabel.Position = [725 201 65 22];
            app.ZANIMATEEditFieldLabel.Text = 'ZANIMATE';
            % Create ZANIMATEEditField
            app.ZANIMATEEditField = uieditfield(app.UIFigure, 'numeric');
            app.ZANIMATEEditField.Position = [828 201 99 20];
            % Create ROLLANIMATEEditFieldLabel
            app.ROLLANIMATEEditFieldLabel = uilabel(app.UIFigure);
            app.ROLLANIMATEEditFieldLabel.HorizontalAlignment = 'right';
            app.ROLLANIMATEEditFieldLabel.Position = [722 170 89 22];
            app.ROLLANIMATEEditFieldLabel.Text = 'ROLLANIMATE';
            % Create ROLLANIMATEEditField
            app.ROLLANIMATEEditField = uieditfield(app.UIFigure, 'numeric');
            app.ROLLANIMATEEditField.Position = [827 170 100 20];
            % Create PITCHANIMATEEditFieldLabel
            app.PITCHANIMATEEditFieldLabel = uilabel(app.UIFigure);
            app.PITCHANIMATEEditFieldLabel.HorizontalAlignment = 'right';
            app.PITCHANIMATEEditFieldLabel.Position = [724 141 94 22];
            app.PITCHANIMATEEditFieldLabel.Text = 'PITCHANIMATE';
            % Create PITCHANIMATEEditField
            app.PITCHANIMATEEditField = uieditfield(app.UIFigure, 'numeric');
            app.PITCHANIMATEEditField.Position = [828 142 100 20];
            % Create YAWANIMATEEditFieldLabel
            app.YAWANIMATEEditFieldLabel = uilabel(app.UIFigure);
            app.YAWANIMATEEditFieldLabel.HorizontalAlignment = 'right';
            app.YAWANIMATEEditFieldLabel.Position = [725 103 83 22];
            app.YAWANIMATEEditFieldLabel.Text = 'YAWANIMATE';
            % Create YAWANIMATEEditField
            app.YAWANIMATEEditField = uieditfield(app.UIFigure, 'numeric');
            app.YAWANIMATEEditField.Position = [828 104 100 20];
            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Industrial Manipulator')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.XLim = [0 13];
            app.UIAxes.YLim = [0 13];
            app.UIAxes.ZLim = [0 13];
            app.UIAxes.XGrid = 'on';
            app.UIAxes.XMinorGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.YMinorGrid = 'on';
            app.UIAxes.ZGrid = 'on';
            app.UIAxes.ZMinorGrid = 'on';
            app.UIAxes.Position = [220 93 406 239];
            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end
    % App creation and deletion
    methods (Access = public)
        % Construct app
        function app = Inve
            % Create UIFigure and components
            createComponents(app)
            % Register the app with App Designer
            registerApp(app, app.UIFigure)
            if nargout == 0
                clear app
            end
        end
        % Code that executes before app deletion
        function delete(app)
            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end