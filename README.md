# Tyler
An OpenSCAD Library for Tiling Objects
___
This is a small OpenSCAD library for tiling 3D and 2D objects on the X and Y axis. It aims to be simple to use, while being helpful and productive in 3D modeling.

## Functionality
Each pattern function in the library has a set of modifiers to change the size, scale, and style of the shapes.

### Patterns
**Currently supported patterns:**
* Hex
* Grid
* Wave

**Patterns to be added:**
* Triangle ?
* Radial

### Function Table
| Pattern Name | Expanded Example                                                                                |
| ------------ | ----------------------------------------------------------------------------------------------- |
| Hexagon Tile | `hex(size=[5,5],style=[10,1],custom_extrude=false,center=false,echo_info=false);`               |
| Grid Tile    | `grid(size=[5,5],style=[10,1],custom_extrude=false,center=false,echo_info=false);`              |
| Wave Tile    | `wave(size=[20,2],style=[5,1],wave=[60,5,0],custom_extrude=false,center=false,echo_info=false)` |


## Installation
To install the library, you simply need to move `tyler.scad` to your OpenSCAD library folder.

* For Linux based systems, the file path is generally `~/.local/share/OpenSCAD/libraries/`
* For Windows, it's `C:\Users\YourUsername\AppData\Roaming\OpenSCAD\libraries\`

That's it!

## TODO
* Add more patterns lol
* Re-style the style modifiers
* Support for Z axis?

## Basic Documentation
### Getting Started!

To include the library in your openscad file, use the following:
```openscad
include <tyler.scad>
```

Now that the file is imported into your script, you can start tiling!

To create a tile pattern, chose a pattern from the `Function Table` section above, and add it to your script. Here is a simple example:
```openscad
include <tyler.scad>

hex();
```
This will create a hexagon tile pattern with the defult settings. 
We can adjust the size and style of the pattern with the options you see in the `Function Table`.

**Expanded Example:**
```openscad
hex(size=[2,10],style=[10,1],center=true);
```
**Compacted Example:**
```openscad
hex([2,7],[10,1],center=true);
```

- The `size` option will create a hexagon pattern with an X length of `2`, and a Y length of `7`.
- The `style` indicates that the generator should try to create a shape that is `10` wide, with a spacing of `1`.
- `center=true` will center the pattern

**NOTE: The spacing variable in the style option (`1` in this example) will only work with the defult shape. Adding a custom shape as a child to the function will cause the spacing variable to not take effect.**

### Function Extrusion
Ok, so what if you want to extrude a 2D object in the tile that differs depending on its X,Y position?
You can use the `custom_extrude` flag along with your own SCAD function to make tiles extrude differently from each other!

Lets take our previous example:
```openscad
hex(size=[2,10],style=[10,1],custom_extrude=true);
```

Here, we have added `custom_extrude=true` to the function, which tells the generator to extrude the shapes according to an external function.

Now you can add your own function. The function should be named accordingly: `<patterns_function_name>_extrude`, and contain `x`,`y` variables in the parentheses. Here is an example:

**Function Extrude Example:**
```openscad
function hex_extrude(x,y) = x*y+1;

hex(size=[10,10],style=[10,1],custom_extrude=true);
```

Yay! The pattern should look like an upward slope that increases height by 1. This is because the `x,y` variables from the tile generator are fed into the function on the generation of each shape. Here are some more examples!

**Function Extrude Examples:**
```openscad
function hex_extrude(x,y) = x*6+1; // Slope
function hex_extrude(x,y) = rands(1,20,1)[0]; // Random heights
function hex_extrude(x,y) = sin(x*+20)*20; // Simple sine wave
function hex_extrude(x,y) = sin(x*+20)*20 + sin(y*+20)*20; // Dual axis sine wave
```

### Shape input

You can also add your own shapes to the generators, by simply adding them as a *child*:

```openscad
hex(size=[5,5],style=[7,5]) square(5);
```

The shape `square(5)` acts as the child to the hex generator in this case, and it is tiled instead of the regular hexagon. This can be used to tile other shapes like triangles or circles:

**Shape Input Examples**
```openscad
hex(size=[5,5]) square(5); // Squares
hex(size=[5,5]) circle(d=8); // Circles
hex(size=[4,5]) circle(d=10,$fn=3); // Triangles (Restraining max vertices to create 3 sided circle)
```