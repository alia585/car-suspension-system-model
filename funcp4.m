function dotx=funcp4(t, x, VH, B, K1, K2) % defines a function of t x VH B K1 and K2 and outputs a 2 column matrix to dotx
M=350; m=21;
L=VH*t; % equation to calculate L at specific time intervals
if L>=0 && L<2
    u=0;

elseif L>=2 && L<2.5
    u=(-0.06/0.5)*(L-2);
    
elseif L>=2.5 && L<3.5
    u=-0.06;
    
elseif L>=3.5 && L<4
    u=(0.06/0.5)*(L-4);
    
elseif L>=4 && L<240
    u=0;
    
elseif L>=240 && L<246
    u=0.1*sin((pi/6)*L-(40*pi));

elseif L>=246
    u=0;
end

y=x(1); z=x(2); vy=x(3); vz=x(4); % assign the elements of x to the suitable variable names
dotx=[vy; vz; (K2/M)*(z-y)+(B/M)*(vz-vy); (K1/m)*(u-z)-(K2/m)*(z-y)-(B/m)*(vz-vy)];

end

