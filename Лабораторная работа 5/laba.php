<?php
function solve(array $range, float $precision, ...$coefficients)
{
    $roots = [];
    $step = 0.1; // Шаг

    // считаем  полином
    $calculate = function ($x) use ($coefficients) {
        $result = 0.0;
        $degree = count($coefficients) - 1;
        foreach ($coefficients as $i => $coef) {
            $result += $coef * pow($x, $degree - $i);
        }
        return $result;
    };

    // Бинпоиск
    $binarySearch = function ($a, $b) use ($calculate, $precision) {
        $fa = $calculate($a);
        $fb = $calculate($b);

        // Проверка на наличие корня на интервале
        /* если непрерывная функция [a,b] принимает значения разных знаков на концах интервала,
            то внутри существует хотя бы один корень
         */
        if ($fa * $fb > 0) {
            return null;
        }

        while (abs($b - $a) > $precision) {
            $mid = ($a + $b) / 2;
            $fmid = $calculate($mid);

            if ($fmid == 0) {
                return $mid;
            }

            if ($fa * $fmid < 0) {
                $b = $mid;
                $fb = $fmid;
            } else {
                $a = $mid;
                $fa = $fmid;
            }
        }

        return ($a + $b) / 2;
    };

    // Старт
    $start = $range[0];
    $end = $range[1];

    for ($x = $start; $x < $end; $x += $step) {
        $x1 = $x;
        $x2 = min($x + $step, $end);

        $root = $binarySearch($x1, $x2);
        if ($root !== null) {
            // Не нашли ли такой же
            $isNew = true;
            foreach ($roots as $existingRoot) {
                if (abs($root - $existingRoot) < $precision) {
                    $isNew = false;
                    break;
                }
            }
            if ($isNew) {
                $roots[] = round($root, 4);
            }
        }
    }

    return $roots;
}

print_r(solve([-5, 5], 0.0001, 1, -1, -6)); // [-2, 3]
print_r(solve([-5, 5], 0.0001, 1, 0, 0, 0)); // [0]
?>