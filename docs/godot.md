Flipping x on nodes. This is needed since setting scale.x to -1 causes ambiguity in transforms.

```py
var flip_h: bool:
  set(value):
    if flip_h != value:
      # -x
      if value:
        scale.y = -1
        rotation_degrees = 180
      # +x
      else:
        scale.y = 1
        rotation_degrees = 0

    flip_h = value
```
