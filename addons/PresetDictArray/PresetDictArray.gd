@tool
class_name PresetDictArray extends Resource
## Creates a typed [Array] for containing [Dictionary] elements such that every
## new entry to the [Array] has the same [Dictionary].

#                                                         ░██
#                                                         ░██
#  ░███████  ░██    ░██ ░████████   ░███████  ░██░████ ░████████  ░███████
# ░██    ░██  ░██  ░██  ░██    ░██ ░██    ░██ ░███        ░██    ░██
# ░█████████   ░█████   ░██    ░██ ░██    ░██ ░██         ░██     ░███████
# ░██         ░██  ░██  ░███   ░██ ░██    ░██ ░██         ░██           ░██
#  ░███████  ░██    ░██ ░██░█████   ░███████  ░██          ░████  ░███████
#                       ░██
#                       ░██

## Array containing dictionaries. New elements in the array will be copies of
## [member standard_dict], found under the [b]Standardization[/b] group.
@export var array : Array[Dictionary] = [] :
	set(n):
		var prev = array
		if n.size() > prev.size():
			prev.append(standard_dict)
			array = prev
		else:
			array = n
		if auto_standardize:
			standardize_array()


@export_group("Standardization")

## This is the [Dictionary] that is appended to [member array] whenever you add
## a new element to the [Array] through the inspector. Values set in the
## dictionary will be the default values applied to the respective keys.[br]
## Changes made to [member standard_dict] do not automatically affect
## [member array] unless [member auto_standardize] is set to true. You can
## also use [method standardize_array] to change [method array] to rigidly fit
## the standard dictionary format.
@export var standard_dict : Dictionary = {} :
	set(n):
		standard_dict = n
		if auto_standardize:
			standardize_array()


## When set to true, changes to [member standard_dict] will automatically change
## [member array] via [method standardize_array].[br]
## Note: [method standardize_array] is destructive; if there is data stored in
## your array that you want to keep, you should copy it out first. See [method
## standardize_array] for more information.
@export var auto_standardize : bool = false :
	set(n):
		auto_standardize = n
		if auto_standardize:
			standardize_array()


## Calls the [method standardize_array] function:[br]
## Changes the [Dictionary] elements in [member array] to fit the format of
## [member standard_dict]. This is destructive; if you currently have data you
## wish to keep that is stored in [member array], you should copy it out
## first.[br]
## - Any key (and its value) that is in an element of [member array] and not in
## [member standard_dict] will be removed.[br]
## - Any key in [member standard_dict] that has been changed will be counted as
## having been removed.[br]
## - Changing the values in [member standard_dict] does [b]not[/b] change any
## currently-set value in [member array].
@export_tool_button("Standardize Array") var standardize_tool : Callable = standardize_array

#                               ░██    ░██                          ░██
#                               ░██    ░██                          ░██
# ░█████████████   ░███████  ░████████ ░████████   ░███████   ░████████  ░███████
# ░██   ░██   ░██ ░██    ░██    ░██    ░██    ░██ ░██    ░██ ░██    ░██ ░██
# ░██   ░██   ░██ ░█████████    ░██    ░██    ░██ ░██    ░██ ░██    ░██  ░███████
# ░██   ░██   ░██ ░██           ░██    ░██    ░██ ░██    ░██ ░██   ░███        ░██
# ░██   ░██   ░██  ░███████      ░████ ░██    ░██  ░███████   ░█████░██  ░███████


## Changes the [Dictionary] elements in [member array] to fit the format of
## [member standard_dict]. This is destructive; if you currently have data you
## wish to keep that is stored in [member array], you should copy it out
## first.[br]
## - Any key (and its value) that is in an element of [member array] and not in
## [member standard_dict] will be removed.[br]
## - Any key in [member standard_dict] that has been changed will be counted as
## having been removed.[br]
## - Changing the values in [member standard_dict] does [b]not[/b] change any
## currently-set value in [member array].
func standardize_array() -> void:
	for i in array:
		for k in i.keys():
			if !k in standard_dict.keys():
				i.erase(k)
		for k in standard_dict.keys():
			i.get_or_add(k, standard_dict[k])
