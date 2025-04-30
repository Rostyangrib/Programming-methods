#include <iostream>
#include <vector>
#include <algorithm>

void sort(std::vector<int>& array) {
    auto is_not_zero = [](int x) { return x != 0; };
    auto is_even = [](int x) { return x % 2 == 0; };

    std::vector<int> evens;
    std::vector<int> odds;

    // Разделим на четные и нечетные
    std::for_each(array.begin(), array.end(), [&](int x) {
        if (is_not_zero(x)) {
            if (is_even(x)) {
                evens.push_back(x);
            } else {
                odds.push_back(x);
            }
        }
    });

    auto sort_down = [](int a, int b) { return a > b; };
    auto sort_up = [](int a, int b) { return a < b; };

    std::sort(evens.begin(), evens.end(), sort_down);
    std::sort(odds.begin(), odds.end(), sort_up);

    // Анонимные функции для индексов
    auto get_next_even = [&evens, idx = 0]() mutable { return evens[idx++]; };
    auto get_next_odd = [&odds, idx = 0]() mutable { return odds[idx++]; };

    for (int& x : array) {
        if (is_not_zero(x)) {
            x = is_even(x) ? get_next_even() : get_next_odd();
        }
    }
}

int main() {
    std::vector<int> array = {1, 6, 9, 0, 7, 4, 7, 0, 10, 11};

    auto print = [](const std::vector<int>& vec) {
        std::ranges::for_each(vec, [](int num) {
            std::cout << num << " ";
        });
        std::cout << std::endl;
    };

    std::cout << "Before sorting: ";
    print(array);
    sort(array);
    std::cout << "After sorting: ";
    print(array);

    return 0;
}