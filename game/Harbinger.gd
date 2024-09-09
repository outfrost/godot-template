extends Node

var subs: Dictionary = {}

func subscribe(msg: String, receiver: Callable) -> void:
	var rx_list: Array[Callable] = subs.get(msg, [])
	rx_list.append(receiver)

func dispatch(msg: String) -> void:
	var rx_list: Array[Callable] = subs.get(msg, [])
	for rx in rx_list:
		rx.call()

func dispatch_deferred(msg: String) -> void:
	var rx_list: Array[Callable] = subs.get(msg, [])
	for rx in rx_list:
		rx.call_deferred()
