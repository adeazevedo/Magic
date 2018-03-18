
extends Node


func smooth_start_2 (x):
	return smooth_start_N(x, 2)

func smooth_end_2 (x):
	return smooth_end_N(x, 2)

func smooth_start_3 (x):
	return smooth_start_N(x, 3)

func smooth_end_3 (x):
	return smooth_end_N(x, 3)

func smooth_start_4 (x):
	return smooth_start_N(x, 4)

func smooth_end_4 (x):
	return smooth_end_N(x, 4)


# x ^ n
func smooth_start_N (x, n):
	return pow(x, n)

# 1 - (1 - x)^n
func smooth_end_N (x, n):
	return flip( pow(flip(x), n) )




# HELPERS FUNCS
func flip (x):
	return 1 - x

func square (x):
	return pow(x, 2)

func cubic (x):
	return pow(x, 3)

func quartic (x):
	return pow(x, 4)

func quintic (x):
	return pow(x, 5)

func mix (a, b, weight, x):
	return a.call_func(x) + weight*( b.call_func(x) - a.call_func(x) )

func crossfade (a, b, x):
	return a.call_func(x) + x * (b.call_func(x) - a.call_func(x))