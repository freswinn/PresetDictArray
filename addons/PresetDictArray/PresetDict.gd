@tool
class_name PresetDict extends Resource
## Creates a [Resource] that preserves a [Dictionary]'s structure.


#                                                         ░██
#                                                         ░██
#  ░███████  ░██    ░██ ░████████   ░███████  ░██░████ ░████████  ░███████
# ░██    ░██  ░██  ░██  ░██    ░██ ░██    ░██ ░███        ░██    ░██
# ░█████████   ░█████   ░██    ░██ ░██    ░██ ░██         ░██     ░███████
# ░██         ░██  ░██  ░███   ░██ ░██    ░██ ░██         ░██           ░██
#  ░███████  ░██    ░██ ░██░█████   ░███████  ░██          ░████  ░███████
#                       ░██
#                       ░██

## The dictionary that [PresetDict] holds. It is fully editable as long as [member keys_locked]
## is set to false; if it is set to true, then only the values can be changed.
@export var dict : Dictionary = {} :
	set(n):
		if !keys_locked:
			dict = n
		else:
			var prev = dict
			if dict.keys() != n.keys():
				dict = prev
			else:
				dict = n


## Locks the keys in [member dict], preventing them from being changed, added to, or removed.
## This does not prevent the editing of the values assigned to those keys.
@export var keys_locked : bool = false
