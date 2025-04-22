package main

import "strings"

// Находит минимальную общую последовательность
func findMinCommonSequence(str1, str2 string) string {
	ans := ""
	minLen := 1 << 30

	for i := 0; i < len(str1); i++ {
		for j := 1; j < minLen && j <= len(str1)-i; j++ {
			substr := str1[i : i+j]
			if strings.Contains(str2, substr) {
				minLen = j
				ans = substr
				break
			}
		}
	}
	return ans
}
