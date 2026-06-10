# PresetDictArray
Creates a new `Resource` class called `PresetDictArray` holding an `Array[Dictionary]` that can only hold `Dictionary` elements of a preset format.

## Compatibility
This has been tested on Godot 4.6, but would certainly work for several older 4.x versions of Godot.

This seems to conflict with the otherwise excellent plugin [Dictionary Inspector](https://github.com/don-tnowe/godot-dictionary-inspector).

## Installation
You can clone this repo, but you could also simply copy `/addons/PresetDictArray/PresetDictArray.gd` and put that file anywhere in your project's files and it would work.
Since this is just a script rather than a plugin, it will not appear in your Plugins menu.

### Uninstallation
Simply delete the file and/or folder.

# What It Does
`PresetDictArray` is a `Resource` that contains two variables: `standard_dict` (a dictionary) and `array` (an `Array[Dictionary]`). Any time you add a new element to `array`, that element becomes a copy of `standard_dict` automatically.

The idea is that you can create an exported variable in your script to more rapidly create sets of standardized Dictionaries quickly, especially through the inspector.
```
@export var array_dict : PresetDictArray
```

![After setting up the standard dictionary (standard_dict), every element added to the array becomes a duplicate of standard_dict](/img/PresetDictArray.png)

After creating new elements to the array, you can change the k/v pairs as you see fit in each element, including deleting and adding new keys. If you want to prevent the ability to add or remove keys, turn on `auto_standardize` under the **Standardize** inspector group (*Warning: see below*).

![The Standardize inspector group](/img/AutoStandardize.png)

## Auto-Standardize, and the Standardize Array tool button
You can also set `PresetDictArray` to automatically force current elements in the array to conform to `standard_dict`. To do this, set `auto_standardize` to true, or use the `standardize_array()` function. This is a destructive method, such that:
- Any key (and its value) that is in an element of `array` and not in `standard_dict` will be removed.
- Any key in `standard_dict` that has been changed will be counted as having been removed.
- Any key in `standard_dict` that is not in an element of `array` will be added with its default value.
- Changing the values in `standard_dict` does **not** change any currently-set value in `array`.

**Note:** Changes made by Auto-Standardize and the Standardize Array function/tool button do not immediately appear in the inspector. Click off of the node and then back onto it, and it should update.
