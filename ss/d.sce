clc;
clear;

// Deklaracja funkcji f(x)
function y = f(x)
    y = x.^2 .* log(x - 7);
endfunction

// Funkcja obliczająca węzły trygonometryczne
function x_nodes = knots(N)
    x_nodes = (2 * %pi * (0:N-1)) / N;
endfunction

// Funkcja obliczająca wartość aproksymacyjnego wielomianu trygonometrycznego F w punkcie x
function F_x = F(x, a, b, s_max)
    F_x = a(1) / 2; // Pierwszy składnik

    for j = 1:s_max
        F_x = F_x + (a(j+1) * cos(j * x) + b(j) * sin(j * x));
    end
endfunction

// Funkcja obliczająca wartość funkcji R
function R_values = R(x, f_values, a_coeffs, b_coeffs, s_max)
    F_values = zeros(size(x));
    
    for i = 1:length(x)
        F_values(i) = F(x(i), a_coeffs, b_coeffs, s_max);
    end

    R_values = (f_values - F_values).^2;
endfunction

// Wprowadzenie danych
N = 11;
a = 0;
b = 2 * %pi;

// Obliczenie węzłów trygonometrycznych
x_nodes = knots(N);

// Obliczenie maksymalnego stopnia s_max
s_max = floor((N - 1) / 2);

// Obliczenie współczynników a_i i b_i
a_coeffs = zeros(s_max + 1, 1);
b_coeffs = zeros(s_max, 1);

for j = 0:s_max
    a_coeffs(j+1) = (2 / N) * sum(f(x_nodes) .* cos(j * x_nodes));
end

for j = 1:s_max
    b_coeffs(j) = (2 / N) * sum(f(x_nodes) .* sin(j * x_nodes));
end

// Generowanie wektora punktów dla funkcji plot
x_plot = linspace(a, b, 1000);

// Obliczenie wartości funkcji R w punktach x_plot
R_values = R(x_plot, f(x_plot), a_coeffs, b_coeffs, s_max);

// Wypisanie wyników do konsoli
disp(['Współczynniki a: ', string(a_coeffs')]);
disp(['Współczynniki b: ', string(b_coeffs')]);

// Wygenerowanie wykresu funkcji R
clf; // Wyczyszczenie aktualnego wykresu
plot(x_plot, R_values, '-b', 'LineWidth', 2);
title('Funkcja R=(f-F)^2');
xlabel('x');
ylabel('R(x)');
