clc;
clear;

// Deklaracja funkcji f(x)
function y = f(x)
    y = sin(x) + (x + 1)^2;
endfunction

// Deklaracja funkcji f'(x)
function y_prime = f_prime(x)
    y_prime = cos(x) + 2 * (x + 1);
endfunction

// Deklaracja funkcji f''(x)
function y_double_prime = f_double_prime(x)
    y_double_prime = -sin(x) + 2;
endfunction

// Funkcja obliczająca odległość między przybliżeniem a rzeczywistym pierwiastkiem
function distance = xn_dist(x, x_prev, f_x, f_x_prev)
    distance = abs(x - x_prev) / abs(f_x - f_x_prev) * abs(f_x);
endfunction

// Funkcja obliczająca nowe przybliżenie x_n
function x_n = new_sol(x_prev, x_prev_prev, f_x_prev, f_x_prev_prev)
    x_n = x_prev - (f_x_prev * (x_prev - x_prev_prev)) / (f_x_prev - f_x_prev_prev);
endfunction

// Wprowadzenie danych
r = 4;
a = -1;
b = 1;

// Zbadanie założeń metody
if f(a) * f(b) < 0 && f_prime(a) * f_prime(b) > 0 && f_double_prime(a) * f_double_prime(b) > 0
    disp('Założenia metody spełnione.');
else
    error('Założenia metody nie spełnione.');
end

// Wybór punktów początkowych
if f_prime(a) * f_double_prime(a) < 0
    x_prev_prev = b;
    x_prev = a;
else
    x_prev_prev = a;
    x_prev = b;
end

// Pętla obliczająca kolejne przybliżenia
for n = 1:100 // ograniczenie do maksymalnie 100 iteracji
    f_x_prev = f(x_prev);
    f_x_prev_prev = f(x_prev_prev);

    x_n = new_sol(x_prev, x_prev_prev, f_x_prev, f_x_prev_prev);
    
    distance = xn_dist(x_n, x_prev, f_x_prev, f_x_prev_prev);

    // Wypisanie wyników do konsoli
    disp(['Iteracja ', string(n), ': x_n = ', string(x_n), ', |x_n - alpha| = ', string(distance)]);

    // Sprawdzenie warunku zakończenia
    if distance < 10^(-r)
        disp('Osiągnięto wymaganą dokładność.');
        break;
    end

    // Przygotowanie do następnej iteracji
    x_prev_prev = x_prev;
    x_prev = x_n;
end
