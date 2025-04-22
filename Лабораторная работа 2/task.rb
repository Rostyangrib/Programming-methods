def GenArray(size)
  # array = [9,8,7,6,5,4,3,2,1, 0]
  # array = [5, 3, 0, 4, 0, 1, 1, 1, 6, 7];
  array = Array.new(size) { rand(100) }
end

def GenManyArray(steps, size)
  for i in 0..10000
    array = Array.new(10) { rand(10) }
    copy_arr = array.dup
    ShellSort(array, steps)
    for j in 0..9 - 1
      if (array[j] > array[j + 1])
        return false
      end
    end
  end
  true
end

def GenerateKnuthSteps(n)
  steps = []
  i = 1
  max_steps = n
  while steps.size < max_steps
    step = (3 ** i - 1) / 2
    break if step >= n
    steps << step
    i += 1
  end
  steps.reverse
end

def GenSteps(size)
  steps = []
  steps_knut = GenerateKnuthSteps(size)
  steps_sedgewick = GenerateSedgewickSteps(size)
  if steps_knut.size == steps_sedgewick.size
    if steps_knut.sum > steps_sedgewick.sum
      steps = steps_knut
    else
      steps = steps_sedgewick
    end
  elsif steps_knut.size < steps_sedgewick.size
    steps = steps_knut
  else
    steps = steps_sedgewick
  end
  steps
end

def BubbleSort(array)
  cnt_cmp = 0
  for i in 0...(array.length - 1)
    for j in 0...(array.length - i - 1)
      cnt_cmp += 1
      if array[j] >= array[j + 1]
        array[j], array[j + 1] = array[j + 1], array[j]
      end
    end
  end
  cnt_cmp
end

def ShellSort(numbers, steps)
  cnt_cmp = 0
  steps.each do |st|
    (st...numbers.size).each do |i|
      temp = numbers[i]
      j = i
      while j >= st && numbers[j - st] > temp
        cnt_cmp += 1
        flag = true
        numbers[j] = numbers[j - st]
        j -= st
      end
      cnt_cmp += 1
      numbers[j] = temp
    end
  end
  cnt_cmp
end

def GenerateSedgewickSteps(n)
  steps = []
  i = 0
  loop do
    step1 = i % 2 == 0 ? 9 * (2 ** i) - 9 * (2 ** (i / 2)) + 1 : 8 * (2 ** i) - 6 * (2 ** ((i + 1) / 2)) + 1
    steps << step1 if step1 < n && step1 > -1
    break if step1 >= n
    i += 1
  end
  steps.sort.reverse
end

def main
  size = 1000
  steps = GenSteps(size)
  numbers = GenArray(size)
  numbers_bubble = numbers.dup
  flag = GenManyArray(steps, size)

  puts "Изначальный массив #{numbers.inspect}"
  puts "Массив шагов Кнута #{GenerateKnuthSteps(size).inspect}"
  puts "Массив шагов Седжвика #{GenerateSedgewickSteps(size).inspect}"
  puts "Сумма шагов Кнута #{GenerateKnuthSteps(size).sum}"
  puts "Сумма шагов Седжвика #{GenerateSedgewickSteps(size).sum}"
  puts "Выбранный массив шагов #{steps.inspect}"
  cnt_shell = ShellSort(numbers, steps)
  cnt_bubble = BubbleSort(numbers_bubble)
  puts "Отсортированный массив #{numbers.inspect}"
  puts "Сравнения Шелла #{cnt_shell}"
  puts "Сравнения пузырька #{cnt_bubble}"
  puts "Разница в сравнениях #{(cnt_shell - cnt_bubble).abs}"

  # puts "Проверяем гипотезу на массивах размером 100 #{flag}"
  # puts "Проверяем гипотезу на массивах размером 1000 #{flag}"
end

main


