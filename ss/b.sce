clc;
clear;

// Węzły Czebyszewa
function x = knots(n)
    x = cos((2*(0:n)+1)./(2*(n+1))*%pi);
endfunction

// Współczynniki równań normalnych
function [a0, a1] = calculateCoefficients(x_nodes, f_values)
    g0 = sum(x_nodes.^0);
    g1 = sum(x_nodes.^1);
    g2 = sum(x_nodes.^2);
    rho0 = sum(f_values .* x_nodes.^0);
    rho1 = sum(f_values .* x_nodes.^1);

    a0 = (-g2 * rho0 + g1 * rho1) / (g1^2 - g0 * g2);
    a1 = (g1 * rho0 - g0 * rho1) / (g1^2 - g0 * g2);
endfunction

// Wielomian aproksymacyjny F
function F = calculateF(x, a)
    F = a(1) + a(2)*x;
endfunction

// Wprowadzenie danych
n = 10;
a = -1.1;
b = 1.1;

// Funkcja f
function y = myFunction(x)
    y = exp(x) - (x + 1)^2;
endfunction

// Obliczenie węzłów Czebyszewa
x_nodes = knots(n);

// Obliczenie wartości funkcji f w węzłach
f_values = myFunction(x_nodes);

// Obliczenie współczynników równań normalnych
[a0, a1] = calculateCoefficients(x_nodes, f_values);

// Obliczenie wartości wielomianu aproksymacyjnego F
x_range = linspace(a, b, 100);
F_values = calculateF(x_range, [a0, a1]);

// Wygenerowanie wykresu
plot(x_range, F_values, 'b-', x_nodes, f_values, 'ro');
title('Wielomian aproksymacyjny F i punkty węzłów');
xlabel('x');
ylabel('y');
legend('F(x)', 'Punkty węzłów', 'location', 'northwest');
