import random

def fibonacci_generator(start1, start2):
    prev1, prev2 = start1, start2

    def generate_next():
        nonlocal prev1, prev2
        current = prev1 + prev2
        prev1, prev2 = prev2, current
        return current

    return generate_next


print("Генератор числовой последовательности Фибоначчи):")

sequence1 = fibonacci_generator(1, 1)
print("Последовательность 1:")
print(sequence1())
print(sequence1())

sequence2 = fibonacci_generator(0, 2)
print("\nПоследовательность 2")
print(sequence2())
print(sequence2())
print(sequence2())


def unique_random_generator():
    available_numbers = list(range(10))
    random.shuffle(available_numbers)

    def get_random():
        if not available_numbers:
            return False
        return available_numbers.pop()

    return get_random


print("\nГенератор уникальных случайных чисел:")
rand_gen = unique_random_generator()

for i in range(15):
    num = rand_gen()
    print(f"Попытка {i + 1}: {'Нет чисел' if num is False else num}")

