clear;
close all;
x = linspace(0,10,100);
y = linspace(0,4,100);

a1x = trimf(x, [0 2 3]);
a2x = trimf(x, [2 4 8]);
b1y = trimf(y, [2 3 4]);
b2y = trimf(y, [0 2 3]);

aptrap = trapmf(x,[2 2.4 2.7 3]);
aptri = trimf(x, [0 2 3]);

implikacja1 = zeros(100);
implikacja2 = zeros(100);
implikacjamin = zeros(100);
implikacjasr = zeros(100);

temp = 0;
temp2 = 0;
% wiersze
for i=1:100
    % kolumny
    for k=1:100
        % liczenie pierwszej implikacji a1, b1
        temp = b1y(k)/a1x(i);
        if temp < 1
            implikacja1(i,k) = temp;
        else
            implikacja1(i,k) = 1;
            temp = 1;
        end
        % liczenie drugiej implikacji a2, b2
        temp2 = b2y(k)/a2x(i);
        if temp2 < 1
            implikacja2(i,k) = temp2;
        else
            implikacja2(i,k) = 1;
            temp2 = 1;
        end
        % agregacja - wyzanaczanie minimum i œredniej
        if temp < temp2
            implikacjamin(i,k) = temp;
        else
            implikacjamin(i,k) = temp2;
        end
        implikacjasr(i,k) = (temp + temp2) / 2;
    end
end

% wnioskowanie
wyniktrapmin = zeros(1,100);
max = 0;
% kolumny
for k = 1:100
    % znajdujemy maximum kolumny
    % wiersze
    for i = 1:100
        if implikacjamin(i,k) > max
            max = implikacjamin(i,k);
        else
        end
    end
    % i bierzemy czesc wspolna z trapezu i implikacji (minimum)
    if aptrap(k) < max
        wyniktrapmin(k) = aptrap(k);
    else
        wyniktrapmin(k) = max;
    end
end

wyniktrapsr = zeros(1,100);
max = 0;
for k = 1:100
    for i = 1:100
        if implikacjasr(i,k) > max
            max = implikacjasr(i,k);
        else
        end
    end
    if aptrap(k) < max
        wyniktrapsr(k) = aptrap(k);
    else
        wyniktrapsr(k) = max;
    end
end




wyniktrmin = zeros(1,100);
max = 0;
for k = 1:100
    for i = 1:100
        if implikacjamin(i,k) > max
            max = implikacjamin(i,k);
        else
        end
    end
    if aptri(k) < max
        wyniktrmin(k) = aptri(k);
    else
        wyniktrmin(k) = max;
    end
end

wyniktrsr = zeros(1,100);
max = 0;
for k = 1:100
    for i = 1:100
        if implikacjasr(i,k) > max
            max = implikacjasr(i,k);
        else
        end
    end
    if aptri(k) < max
        wyniktrsr(k) = aptri(k);
    else
        wyniktrsr(k) = max;
    end
end
figure(1)
plot(x,wyniktrapmin)
figure(2)
plot(x,wyniktrapsr)
figure(3)
plot(y,wyniktrmin)
figure(4)
plot(y,wyniktrmin)