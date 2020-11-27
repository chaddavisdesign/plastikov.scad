# plastikov.scad


**Why?**
To create a source file for a 3D printed firearm that could be printed in plain text on a t-shirt; a tradition to demonstrate the absurdity of attempting to outlaw code. Previously this was done with the [Defence Distrbuted Liberator](https://github.com/chaddavisdesign/liberator.scad). The Deterence Dipenced Plastikov v2 is a  

|<figure><img src="https://upload.wikimedia.org/wikipedia/commons/9/96/Munitions_T-shirt_%28front%29.jpg" height="400"/><figcaption>Munitions T-shirt created by Dr. Adam Back during the <a href="">Crypto Wars</a></figcaption></figure>|<figure><img src="https://i.imgur.com/DCF7odu.jpg" height="400"/><figcaption>[DeCSS](https://en.wikipedia.org/wiki/DeCSS) shirt depicting code to decrypt DVDs</figcaption></figure>|
|--|--|

**The result was a 9057 character script**
<figure>
<img src="https://i.imgur.com/hMqSCFF.png"/>
</figure>

**Shameless plug**
The [plastikov.scad T-Shirt](http://teespring.com/plastikov) and other similar designs can be purchased at the [cantstopthesignal Teespring shop](https://cantstopthesignal.myteespring.co/)

**Why OpenSCAD?**
The files typically shared for 3D-printable objects, STLs, are a collection of coordinates points on triangles arranged to cover the surface of an object. When every point on a "curved" surface is mapped (and each coordinate is repeated for each facet that intersects the point) it becomes quite a large amount of text.

**Example:** A sphere with a radius of 36.24 center on point 36.24,36.24,36.24

STL markup >600,000 character in >28,000 lines

    solid sphere
      facet normal 0 0 1
        outer loop
          vertex 38.0097 36.4143 72.4363
          vertex 38.0097 36.0657 72.4363
          vertex 38.0182 36.24 72.4363
        endloop
      endfacet
      facet normal 0 0 1
        outer loop
          vertex 37.984 36.5869 72.4363
          vertex 38.0097 36.0657 72.4363
          vertex 38.0097 36.4143 72.4363
        endloop
      endfacet
    
    //////~28,000 lines omitted////////
    
      facet normal 0 0 -1
        outer loop
          vertex 34.4703 36.0657 0.0436527
          vertex 34.4703 36.4143 0.0436527
          vertex 34.496 36.5869 0.0436527
        endloop
      endfacet
      facet normal 0 -0 -1
        outer loop
          vertex 34.4703 36.4143 0.0436527
          vertex 34.4703 36.0657 0.0436527
          vertex 34.4618 36.24 0.0436527
        endloop
      endfacet
    endsolid sphere
    
And if we want another sphere it would take roughly double the space.

**OpenSCAD**

    translate([36.24,36.24,36.24])sphere(r=36.24,$fn=64);

Further, OpenSCAD allows you to use variables, so this line can be reduced to:

    a=36.24;
    translate([a,a,a])sphere(r=a,$fn=64);

The more times a number is used, the more characters are saved by making it a variable.

Also, rather than typing "sphere" over and over again to describe complex shape made of many spheres, you can use a module. And let's go ahead and ad a second sphere centered at -36.24,-36.24,-36.24.

    module s(r){
        sphere(r=r,$fn=64);
    }
    a=36.24;
    translate([a,a,a])s(a);
    translate([-a,-a,-a])s(a);


We're almost always translating the sphere so why not that into the module too? 

    module s(r,x,y,z){
        translate([x,y,z])sphere(r=r,$fn=64);
    }
    s(a,a,a,a);
    s(a,-a,-a,-a);

And OpenSCAD functions with no line breaks or (most) whistespace, which use up valuable t-shirt space.

    module s(r,x,y,z){translate([x,y,z])sphere(r=r,$fn=64)}s(a,a,a,a);s(a,-a,-a,-a);

Two spheres for the price of a tiny fraction of these spheres in an STL.

**Why the Liberator and not a more modern 3d printed design?**
Becuase it is almost entirely 3D printed, because it was first, and because the geometry seemed a bit more straight forward than the FGC-9 that had been released shortly before I got serious about creating this.

## Files

**source/header.scad** contains all the modules used in the part files.
**source/template.scad** The structure all the parts are copied to.
**source/*.scad** The parts. Contains an include for header.scad so each file will compile that part on it's own.
**minify<span>.</span>pl** Perl script to remove whitespace,line breaks,and comments; combine all the files; extract and identify was values sould be replaced by variable to save the most space; and replace the variables. Only tested on Linux. For my first iteration that I released this did not exist and I did it all by hand.
**liberator.scad** The output of minify.pl

## Part Index

|1.Rear Receiver<br/>2.Front Receiver<br/>3.Cover<br/>4.Anti-Rotation Plug|![Demo Animation](https://github.com/chaddavisdesign/plastikov.scad/blob/main/render/plastikov.gif?raw=true)|
|--|--|

## Creating STLs
OpenSCAD natively exports STLs. My focus was short scripts, not optimising the speed of the compiler, so some of the parts take a bit to create.

**OpenSCAD GUI**
Open liberator.scad in OpenSCAD. Change p=1 to part number to generate. Click STL button on Toolbar.

Note: Part 1 (the frame) generates a warning, but the stl does seem to be watertight according to MeasLab. There is a fix commented in the header file in the torus module.

**Command Line (Linux):**
Change output file name and part number accordingly.

    openscad -o output_file.stl -D p=1 plasticov.scad

Or all the files at once:

    for i in {1..4}; do  openscad -o $i.stl -D p=$i plastikov.scad; done 
    
## Want to minify your own project with minify.<span>pl?

It's not a generalized script, but it may work if the project is similar enough. You would need to change the @parts array to match your part file names and have matching functions in template.scad. If you use any variables in the global scope you'll need to remove them from $variableList and the list order may need adjusted to so variables aren't inserted that conlict with local variables in and in any functions or modules.

The values to be replaced are chosen by first finding all the vectors and putting them in an array, @allVariables. The vectors are removed before searching for the rest of the values to keep the values from ending up in the list twice. The rest of the values are push to the array.

The unique values in @allVariables end up in the first column of a 2D array @variables. The second colum is the count. The third is the length of the value string. The fourth is a calculation of how many character would be saved by replacing it with a variable. (count - 1) * (valLength - 1) - 3

Then @variables is sorted by the charSavings column and truncated to the length of variableList. The remaining values are replaced with the variables in $variableList.

I rarely use perl for anything more than a couple lines for some regex (though, that is primarily what this is). I'm sure the script deserves a lot of critique.

## License
```
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
```











