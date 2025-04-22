package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func main() {
	str1 := readAndCleanFile("1.txt")
	str2 := readAndCleanFile("2.txt")
	str3 := readAndCleanFile("3.txt")

	result1 := findMinSpecificSequence(str1, str2)
	fmt.Println("Минимальная специфичная последовательность для (1), отсутствующая в (2):", result1)

	result2 := findMinSpecificSequence(str2, str1)
	fmt.Println("Минимальная специфичная последовательность для (2), отсутствующая в (1):", result2)

	result3 := findMinCommonSequence(str1, str2)
	fmt.Println("Минимальная общая последовательность для (1) и (2):", result3)

	result4 := findMinSpecificSequence(str1, str3+" "+str2)
	fmt.Println("Минимальная специфичная последовательность для (1), отсутствующая в (3) и (2):", result4)

	result5 := findMinSpecificSequence(str3, str1+" "+str2)
	fmt.Println("Минимальная специфичная последовательность для (3), отсутствующая в (1) и (2):", result5)

	result6 := findLongestCommonSubsequence(str1, str3)

	fmt.Println("Максимальная общая подпоследовательность для (1) и (3):", result6)
}

func readAndCleanFile(filename string) string {
	data, err := ioutil.ReadFile(filename)
	if err != nil {
		panic(err)
	}
	return cleanString(string(data))
}

func cleanString(s string) string {
	charsToRemove := []string{"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "\n", "\r", " "}
	for _, char := range charsToRemove {
		s = strings.ReplaceAll(s, char, "")
	}
	return s
}
