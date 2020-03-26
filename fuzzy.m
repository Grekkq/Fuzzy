% równomierne próbkowanie przestrzeni wyjściowej
x = linspace(0,10,100);
y = linspace(0,4,100);

% tworzenie trójkątnych funkcji przynależności
a1x = trimf(x, [0 2 3]);
a2x = trimf(x, [2 4 8]);
b1y = trimf(y, [2 3 4]);
b2y = trimf(y, [0 2 3]);

% tworzenie wejściowych zbiorów rozmytych
aptrap = trapmf(x,[2 2.4 2.7 3]);
aptri = trimf(x, [0 2 3]);

% alokacja pamięci na macierze potrzebne do obliczeń
implikacja1 = zeros(100);
implikacja2 = zeros(100);
implikacjamin = zeros(100);
implikacjasr = zeros(100);

% zmienne pomocnicze
temp = 0;
temp2 = 0;

% wyznaczanie tablic z relacjami rozmytymi
for w=1:100
    for k=1:100
    % obliczanie implikacji Gogu dla a1, b1
    temp = b1y(k)/a1x(w);
    if temp < 1
        implikacja1(w,k) = temp;
    else
        implikacja1(w,k) = 1;
        temp = 1;
    end
    % obliczanie implikacji Gogu dla a2, b2
    temp2 = b2y(k)/a2x(w);
    if temp2 < 1
        implikacja2(w,k) = temp2;
    else
        implikacja2(w,k) = 1;
        temp2 = 1;
    end
    % agregacja danych z relacji
    % wyznaczanie minimum
    if temp < temp2
        implikacjamin(w,k) = temp;
    else
        implikacjamin(w,k) = temp2;
    end
    % wyznaczanie średniej
    implikacjasr(w,k) = (temp + temp2) / 2;
    end
end

implikacjamin = implikacjamin';             %transpozycja
implikacjasr = implikacjasr';               %transpozycja

% WNIOSKOWANIE FATI
% cylindryczne rozszerzenie zbiorów
extrap = repmat(aptrap, 100, 1);
extri = repmat(aptri, 100, 1);

% pomocnicza tablica F
ftemp = zeros(100);

% dla wejścia trapezowego i agregacji minimum
% obliczanie przekroju stosując t-normę (sup-M)
for w=1:100
    for k=1:100
        if extrap(w,k) < implikacjamin(w,k)
            ftemp(w,k) = extrap(w,k);
        else
            ftemp(w,k) = implikacjamin(w,k);
        end
    end
end
ftemp = ftemp';	%transpozycja

% projekcja
% tablica na wyniki
wynikimintrap = zeros(1,100);

for k=1:100
tempmax = 0;
    for w=1:100
        if ftemp(w,k) > tempmax
            tempmax = ftemp(w,k);
        else
        end
    end
    wynikimintrap(1,k) = tempmax;
end

% dla wejścia trapezowego i agregacji średnia
% obliczanie przekroju stosując t-normę (sup-M)
for w=1:100
    for k=1:100
        if extrap(w,k) < implikacjasr(w,k)
            ftemp(w,k) = extrap(w,k);
        else
            ftemp(w,k) = implikacjasr(w,k);
        end
    end
end
ftemp = ftemp';	%transpozycja

% projekcja
% tablica na wyniki
wynikisrtrap = zeros(1,100);

for k=1:100
    tempmax = 0;
        for w=1:100
            if ftemp(w,k) > tempmax
                tempmax = ftemp(w,k);
            else
            end
        end
    wynikisrtrap(1,k) = tempmax;
end

% dla wejścia trójkątnego i agregacji minimum
% obliczanie przekroju stosując t-normę (sup-M)
for w=1:100
    for k=1:100
        if extri(w,k) < implikacjamin(w,k)
            ftemp(w,k) = extri(w,k);
        else
            ftemp(w,k) = implikacjamin(w,k);
        end
    end
end
ftemp = ftemp';	%transpozycja

% projekcja
% tablica na wyniki
wynikimintri = zeros(1,100);
    for k=1:100
        tempmax = 0;
        for w=1:100
            if ftemp(w,k) > tempmax
                tempmax = ftemp(w,k);
            else
            end
        end
    wynikimintri(1,k) = tempmax;
end

% dla wejścia trójkątnego i agregacji średnia
% obliczanie przekroju stosując t-normę (sup-M)
for w=1:100
    for k=1:100
        if extri(w,k) < implikacjasr(w,k)
            ftemp(w,k) = extri(w,k);
        else
            ftemp(w,k) = implikacjasr(w,k);
        end
    end
end
ftemp = ftemp';	%transpozycja

% projekcja
% tablica na wyniki
wynikisrtri = zeros(1,100);
for k=1:100
    tempmax = 0;
    for w=1:100
        if ftemp(w,k) > tempmax
            tempmax = ftemp(w,k);
        else
        end
    end
    wynikisrtri(1,k) = tempmax;
end

% generowanie wykresów z wynikami
figure(1)
plot(y,wynikimintrap)
title({'Zbiór rozmyty B''_{trap,MIN}'});
xlabel('\bf x');
ylabel('\bf \mu     ');
set(get(gca,'ylabel'),'rotation',0)
axis([0 4 0 1.1]);
grid on;

figure(2)
plot(y,wynikisrtrap)
title({'Zbiór rozmyty B''_{trap,ŚR}'});
xlabel('\bf x');
ylabel('\bf \mu     ');
set(get(gca,'ylabel'),'rotation',0)
axis([-0.1 4.1 0 1.1]);
grid on;

figure(3)
plot(y,wynikimintri)
title({'Zbiór rozmyty B''_{tri,MIN}'});
xlabel('\bf x');
ylabel('\bf \mu     ');
set(get(gca,'ylabel'),'rotation',0)
axis([-0.1 4.1 0 1.1]);
grid on;

figure(4)
plot(y,wynikisrtri)
title({'Zbiór rozmyty B''_{tri,ŚR}'});
xlabel('\bf x');
ylabel('\bf \mu     ');
set(get(gca,'ylabel'),'rotation',0)
axis([-0.1 4.1 0.5 1.1]);
grid on;