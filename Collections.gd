
extends Node

func map_array (array, func_ref):
	#if !(array is Array): return array
	if !(func_ref is FuncRef): return array

	var result = []

	for e in array:
		var v = func_ref.call_func(e)
		result.append(v)

	return result