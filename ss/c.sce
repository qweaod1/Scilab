clc;
clear;

// Deklaracja funkcji f(x)
function y = f(x)
    y = exp(x) - x^2;
endfunction

// Deklaracja funkcji pierwszej pochodnej f'(x)
function y = df(x)
    y = exp(x) - 2*x;
endfunction

// Deklaracja funkcji drugiej pochodnej f''(x)
function y = d2f(x)
    y = exp(x) - 2;
endfunction

// Obliczenie wartości funkcji pomocniczej g(x)
function y = g(x)
    y = (f(x + f(x)) - f(x)) / f(x);
endfunction

// Funkcja realizująca obliczenia dla nowego przybliżenia Subscript[x,n]
function xn = new_nol(x)
    xn = x - f(x) / g(x);
endfunction

// Wprowadzenie danych
N = 10;
a = -2;
b = 0;
alpha = 0; // Zakładamy, że równanie ma pierwiastek w okolicach 0

// Sprawdzenie założeń metody
if (f(a) - f(b) < 0) & (df(a) - df(b) > 0) & (d2f(a) * d2f(b) > 0)
    disp('Założenia metody są spełnione.');
    if f(a) * d2f(a) > 0
        x0 = a;
    else
        x0 = b;
    end
else
    disp('Założenia metody nie są spełnione.');
    return;
end

// Obliczenia przy użyciu metody Steffensena
disp('Numer przybliżenia | Przybliżenie');
disp('---------------------------------');
for n = 0:N-1
    x_n = new_nol(x0);
    disp([n, x_n]);
    x0 = x_n;
end
