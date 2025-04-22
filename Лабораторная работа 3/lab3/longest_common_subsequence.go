package main

// Находит максимальную общую подпоследовательность
func findLongestCommonSubsequence(str1, str2 string) string {
	dp := make([][]int, len(str1)+1)
	prev := make([][][2]int, len(str1)+1)

	for i := range dp {
		dp[i] = make([]int, len(str2)+1)
		prev[i] = make([][2]int, len(str2)+1)
	}

	for i := 1; i <= len(str1); i++ {
		for j := 1; j <= len(str2); j++ {
			dp[i][j] = max(dp[i-1][j], dp[i][j-1])
			if str1[i-1] == str2[j-1] {
				dp[i][j] = max(dp[i-1][j-1]+1, dp[i][j])
				prev[i][j] = [2]int{i - 1, j - 1}
			} else if dp[i-1][j] > dp[i][j-1] {
				prev[i][j] = [2]int{i - 1, j}
			} else {
				prev[i][j] = [2]int{i, j - 1}
			}
		}
	}

	ans := ""
	for i, j := len(str1), len(str2); i > 0 && j > 0; {
		cur := prev[i][j]
		if cur[0] == i-1 && cur[1] == j-1 {

			ans = string(str1[i-1]) + ans
		}
		i, j = cur[0], cur[1]
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
