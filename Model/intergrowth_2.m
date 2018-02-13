function    intergrowth_2(Rate,Balance,Invest_N,Invest_V,a_1,a_2,b_2,b_1,a_3,b_3,NVratio_max,NVratio_best,NVratio_min,V_boundary,maxn,Invest_time,Max_car,figure_n)
N_s         = zeros(maxn,1);
V_s         = zeros(maxn,1);
for n = 1:maxn-1
    if N_s(n)/V_s(n) < NVratio_best % 15cars 1charger
        interinfluence = (V_s(n)*NVratio_best - N_s(n))/(N_s(n)+eps); %1.25 - 1 > 0
    elseif N_s(n)/V_s(n) > NVratio_max %5cars 1charger
        interinfluence = -(N_s(n) - V_s(n)*NVratio_max)/(N_s(n)+eps); %1-5/7 > 0
    else
        interinfluence = 0;
    end
    if interinfluence > 10
        interinfluence = 10;
    end
    praise          = a_3*(V_s(n)-V_boundary);
    if praise < 0
        praise = 0;
    end
    N_s(n+1)        = (a_1*Invest_N*(n<Invest_time) + a_2*N_s(n)*interinfluence) + N_s(n);
    V_s(n+1)        = (b_1*Invest_V*(n<Invest_time) - b_2*V_s(n)*interinfluence + praise - b_3*abs(Rate - Balance)) * (1-V_s(n)/Max_car) + V_s(n);
    if N_s(n+1) < 0
        N_s(n+1) = 0;
    end
    if V_s(n+1) < 0
        V_s(n+1) = 0;
    end
end
figure(figure_n);
figure_n = figure_n+1;
hold on;
plot(V_s,'-g')
plot(N_s,'-b')
axis([0,maxn,0,Max_car])
line([0 maxn],[0.1*Max_car 0.1*Max_car]);
line([0 maxn],[0.3*Max_car 0.3*Max_car]);
line([0 maxn],[0.5*Max_car 0.5*Max_car]);
line([0 maxn],[1.0*Max_car 1.0*Max_car]);
hold off;
figure(figure_n);
figure_n = figure_n+1;
plot(N_s./V_s,'-r')
hold on;
line([0 maxn],[NVratio_max NVratio_max]);
line([0 maxn],[NVratio_min NVratio_min]);
hold off;
figure(figure_n);
hold on;
plot(V_s./Max_car)
line([0 maxn],[0.1 0.1]);
line([0 maxn],[0.3 0.3]);
line([0 maxn],[0.5 0.5]);
line([0 maxn],[1.0 1.0]);
hold off;
end
%axis([0 maxn 0 3])