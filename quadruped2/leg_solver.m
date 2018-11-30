function leg_solver(r1,r2,r3,r4,OX1,OX2,OX3,OX4,OY1,OY2,OY3,OY4)
X(1:2,1:5)=zeros(2,5);
X2(1:2,1:5)=zeros(2,5);
x3(1:2,1:5) = zeros(2,5);
x4(1:2,1:5) = zeros(2,5);
k=0;
syms x y;
l1=8.0;
l2=6.0;
l3=8.0;
t1=0;
t2=0;
t3 = 3.14;
q=0;
f11 = fopen('reverse_angler11.txt','a');
f12 = fopen('reverse_anglel12.txt','a');
f21 = fopen('reverse_angler21.txt','a');
f22 = fopen('reverse_anglel22.txt','a');
f31 = fopen('reverse_angler31.txt','a');
f32 = fopen('reverse_anglel32.txt','a');
f41 = fopen('reverse_angler41.txt','a');
f42 = fopen('reverse_anglel42.txt','a');
r = [r1 r2 r3 r4];
OX = [OX1 OX2 OX3 OX4];
OY = [OY1 OY2 OY3 OY4];

for v=1:1:3000
    X(1,3) = (r(1)*cos(t3))+ OX(1);
    X(2,3) = -1*(r(1)*sin(t3))+ OY(1);
    X2(1,3) = (r(2)*cos(t3+pi))+ OX(2);
    X2(2,3) = -1*(r(2)*sin(t3+pi))+ OY(2);
    X3(1,3) = (r(3)*cos(t3))+ OX(3);
    X3(2,3) = -1*(r(3)*sin(t3))+ OY(3);
    X4(1,3) = (r(4)*cos(t3+pi))+ OX(4);
    X4(2,3) = -1*(r(4)*sin(t3+pi))+ OY(4);
    
    %X(1,3) = OX(1);
    %X(2,3) = (r(1)*sin(t3))+ OY(1);
    %X2(1,3) = OX(2);
    %X2(2,3) = (r(2)*sin(t3+3.142))+ OY(2);
    %X3(1,3) = OX(3);
    %X3(2,3) = (r(3)*sin(t3))+ OY(3);
    %X4(1,3) = OX(4);
    %X4(2,3) = (r(4)*sin(t3+3.142))+ OY(4);
        
    if(X(2,3)<=OY(1))
        X(2,3)=OY(1);
    end
    if(X2(2,3)<=OY(2))
        X2(2,3)=OY(2);
    end
    if(X3(2,3)<=OY(3))
        X3(2,3)=OY(3);
    end
    if(X4(2,3)<=OY(4))
        X4(2,3)=OY(4);
    end
    
    
    y = (r(1)^2-(x-OX(1))^2)^0.5 + OY(1);
    ezplot(y)
    hold on
    y1 = -(r(2)^2-(x-OX(2))^2)^0.5 + OY(2);
    ezplot(y1)
    y2 = OY;
    plot(y2);
    
    
    lh=sqrt(X(1,3)^2 + X(2,3)^2);
    lh2=sqrt(X2(1,3)^2 + X2(2,3)^2);
    lh3=sqrt(X3(1,3)^2 + X3(2,3)^2);
    lh4=sqrt(X4(1,3)^2 + X4(2,3)^2);
    
    X(:,1)=[4,0];
    X(:,5)=[-4,0];
    syms a b
    vars = [a b];
    eqn = [(a - X(1,3))^2 + (b - X(2,3))^2 == l3^2, (a - (l1/2))^2 + b^2 == l2^2];
    S = solve(eqn,vars);
    syms c d
    vars2 = [c d];
    eqn2 = [(c-X(1,3))^2 + (d-X(2,3))^2 == l3^2, (c + (l1/2))^2 + d^2 == l2^2];
    S2 = solve(eqn2,vars2);
    
    if(double(S.a(1))>0 && double(S2.c(1)>0))
        X(1,2) = double(S.a(1));
        X(2,2) = double(S.b(1));
        X(1,4) = double(S2.c(2));
        X(2,4) = double(S2.d(2));
    elseif(double(S.a(1))<0 && double(S2.c(1))>0)
        X(1,2) = double(S.a(2));
        X(2,2) = double(S.b(2));
        X(1,4) = double(S2.c(2));
        X(2,4) = double(S2.d(2));
    elseif(double(S.a(1))>0 && double(S2.c(1)<0))
        X(1,2) = double(S.a(1));
        X(2,2) = double(S.b(1));
        X(1,4) = double(S2.c(1));
        X(2,4) = double(S2.d(1));
    elseif(double(S.a(1))<0 && double(S2.c(1)<0))
        X(1,2) = double(S.a(2));
        X(2,2) = double(S.b(2));
        X(1,4) = double(S2.c(1));
        X(2,4) = double(S2.d(1));
    end
    ar = atan(X(2,2)/(X(1,2)-(l1/2)));
    al = atan(X(2,4)/(X(1,4)+(l1/2)));
    ar = abs(ar*180/3.142);
    al = abs(al*180/3.142);
    
    fprintf(f12,"%f\n",al);
    fprintf(f11,"%f\n",ar);
    
    
    X2(:,1)=[4,0];
    X2(:,5)=[-4,0];
    syms e f
    vars = [e f];
    eqn = [(e - X2(1,3))^2 + (f - X2(2,3))^2 == l3^2, (e - (l1/2))^2 + f^2 == l2^2];
    S = solve(eqn,vars);
    syms g h
    vars2 = [g h];
    eqn2 = [(g-X2(1,3))^2 + (h-X2(2,3))^2 == l3^2, (g + (l1/2))^2 + h^2 == l2^2];
    S2 = solve(eqn2,vars2);
    
    if(double(S.e(1))>0 && double(S2.g(1)>0))
        X2(1,2) = double(S.e(1));
        X2(2,2) = double(S.f(1));
        X2(1,4) = double(S2.g(2));
        X2(2,4) = double(S2.h(2));
    elseif(double(S.e(1))<0 && double(S2.g(1))>0)
        X2(1,2) = double(S.e(2));
        X2(2,2) = double(S.f(2));
        X2(1,4) = double(S2.g(2));
        X2(2,4) = double(S2.h(2));
    elseif(double(S.e(1))>0 && double(S2.g(1)<0))
        X2(1,2) = double(S.e(1));
        X2(2,2) = double(S.f(1));
        X2(1,4) = double(S2.g(1));
        X2(2,4) = double(S2.h(1));
    elseif(double(S.e(1))<0 && double(S2.g(1)<0))
        X2(1,2) = double(S.e(2));
        X2(2,2) = double(S.f(2));
        X2(1,4) = double(S2.g(1));
        X2(2,4) = double(S2.h(1));
    end
    ar = atan(X2(2,2)/(X2(1,2)-(l1/2)));
    al = atan(X2(2,4)/(X2(1,4)+(l1/2)));
    ar = abs(ar*180/3.142);
    al = abs(al*180/3.142);
    
    fprintf(f22,"%f\n",al);
    fprintf(f21,"%f\n",ar);
    
    X3(:,1)=[4,0];
    X3(:,5)=[-4,0];
    syms e f
    vars = [e f];
    eqn = [(e - X3(1,3))^2 + (f - X3(2,3))^2 == l3^2, (e - (l1/2))^2 + f^2 == l2^2];
    S = solve(eqn,vars);
    syms g h
    vars2 = [   g h];
    eqn2 = [(g-X3(1,3))^2 + (h-X3(2,3))^2 == l3^2, (g + (l1/2))^2 + h^2 == l2^2];
    S2 = solve(eqn2,vars2);
    
    if(double(S.e(1))>0 && double(S2.g(1)>0))
        X3(1,2) = double(S.e(1));
        X3(2,2) = double(S.f(1));
        X3(1,4) = double(S2.g(2));
        X3(2,4) = double(S2.h(2));
    elseif(double(S.e(1))<0 && double(S2.g(1))>0)
        X3(1,2) = double(S.e(2));
        X3(2,2) = double(S.f(2));
        X3(1,4) = double(S2.g(2));
        X3(2,4) = double(S2.h(2));
    elseif(double(S.e(1))>0 && double(S2.g(1)<0))
        X3(1,2) = double(S.e(1));
        X3(2,2) = double(S.f(1));
        X3(1,4) = double(S2.g(1));
        X3(2,4) = double(S2.h(1));
    elseif(double(S.e(1))<0 && double(S2.g(1)<0))
        X3(1,2) = double(S.e(2));
        X3(2,2) = double(S.f(2));
        X3(1,4) = double(S2.g(1));
        X3(2,4) = double(S2.h(1));
    end
    ar = atan(X3(2,2)/(X3(1,2)-(l1/2)));
    al = atan(X3(2,4)/(X3(1,4)+(l1/2)));
    ar = abs(ar*180/3.142);
    al = abs(al*180/3.142);
    
    fprintf(f32,"%f\n",al);
    fprintf(f31,"%f\n",ar);
    
    X4(:,1)=[4,0];
    X4(:,5)=[-4,0];
    syms e f
    vars = [e f];
    eqn = [(e - X4(1,3))^2 + (f - X4(2,3))^2 == l3^2, (e - (l1/2))^2 + f^2 == l2^2];
    S = solve(eqn,vars);
    syms g h
    vars2 = [g h];
    eqn2 = [(g-X2(1,3))^2 + (h-X2(2,3))^2 == l3^2, (g + (l1/2))^2 + h^2 == l2^2];
    S2 = solve(eqn2,vars2);
    
    if(double(S.e(1))>0 && double(S2.g(1)>0))
        X4(1,2) = double(S.e(1));
        X4(2,2) = double(S.f(1));
        X4(1,4) = double(S2.g(2));
        X4(2,4) = double(S2.h(2));
    elseif(double(S.e(1))<0 && double(S2.g(1))>0)
        X4(1,2) = double(S.e(2));
        X4(2,2) = double(S.f(2));
        X4(1,4) = double(S2.g(2));
        X4(2,4) = double(S2.h(2));
    elseif(double(S.e(1))>0 && double(S2.g(1)<0))
        X4(1,2) = double(S.e(1));
        X4(2,2) = double(S.f(1));
        X4(1,4) = double(S2.g(1));
        X4(2,4) = double(S2.h(1));
    elseif(double(S.e(1))<0 && double(S2.g(1)<0))
        X4(1,2) = double(S.e(2));
        X4(2,2) = double(S.f(2));
        X4(1,4) = double(S2.g(1));
        X4(2,4) = double(S2.h(1));
    end
    ar = atan(X4(2,2)/(X4(1,2)-(l1/2)));
    al = atan(X4(2,4)/(X4(1,4)+(l1/2)));
    ar = abs(ar*180/3.142);
    al = abs(al*180/3.142);
    fprintf(f42,"%f\n",al);
    fprintf(f41,"%f\n",ar);
    
    
    plot3(X(1,:),[-5,-5,-5,-5,-5],X(2,:),'-o','linewidth',3)
    plot3(X2(1,:),[5,5,5,5,5],X2(2,:),'-o','linewidth',3)
    plot3(X4(1,:)+20.0,[-5,-5,-5,-5,-5],X4(2,:),'-o','linewidth',3)
    plot3(X3(1,:)+20.0,[5,5,5,5,5],X3(2,:),'-o','linewidth',3)
    plot3([X(1,5),X2(1,1)+20,X3(1,1)+20,X4(1,5),X(1,5)],[-5,-5,5,5,-5],[X(2,5),X2(2,1),X3(2,1),X3(2,5),X(2,5)],'-o','linewidth',3);
    view(45,45)
    grid on
    axis([-15 30 -15 30])
    zlim([-15, 0]);
    legend('leg_config')
    t3=t3+0.1;
    hold 	
    pause(0.0001)
end
end
