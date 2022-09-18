# Copyright 2021 Outfrost
# This work is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the LICENSE file for more details.

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
