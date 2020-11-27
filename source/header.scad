////INTERSECTION MODULE////
//http://forum.openscad.org/intersection-children-0-children-1-does-a-union-instead-of-an-intersection-td8998.html
$fn=64;

module i(){
    intersection_for(i=[0:$children-1]){
        children(i);
    }
}

////UNION MODULE////
module u(){
    union(){
        children([0:$children-1]);
    }
}
///DIFFERENCE MODULE////
module d(){
    difference(){
        children(0);
        children([1:$children-1]);
    }
}
////HULL MODULE////
module h(){
    hull(){
        children([0:$children-1]);
    }
}
////LINEAR_EXRTRUDE MODULE////
module e(z,s){
    linear_extrude(z,scale=s)children();
}
////TRANSLATE MODULE////
module t(x,y,z){
    if(x==undef){children();}
    else{
        //if x is defined (we assume y is too) but not z we translate in 2D
        if(z==undef)translate([x,y])children();
        //If z is defined we translate in 3D
        else translate([x,y,z])children();
        }
}

//////CIRCLE MODULE////
module c(r,x,y){
    t(x,y)circle(r=r);
}

////SQUARE MODULE////
module s(h,w,x,y){
    t(x,y)square([h,w]);
}

////ROTATE MODULE////
module r(x){
    rotate(x)children();
}

////TORRUS MODULE////
module o(i,o,x,y,z){
    t(x,y,z) rotate_extrude()
    t(i+(o-i)/2,0,0)c((o-i)/2+.001);
}


////COPY-MIRROR MODULE////
module m(v){
    children();
    mirror(v)children();
}
////CUBE MODULE////
module q(h,w,l,x,y,z){
    t(x,y,z)cube([h,w,l]);
}

////CYLINDER MODULE////
module l(r,h,x,y,z){
    t(x,y,z)cylinder(r=r,h=h);
}

////Sphere
module p(r,x,y,z){
     t(x,y,z)sphere(r=r);
}

///cut an arc
module a(d){
    i(){
        children();
        rotate_extrude(angle=d,$fn=16)s(120,120);
    }
}

///Scale
module z(x,y,z){
    if(y==undef)scale(x)children();
    else scale([x,y,z])children();
}


module W(i){///fillet for front
    t(0,0,-2.5*sin(11.25*i)-1)e(1){offset(r=2.5-2.5*cos(11.25*i))scale([9.79,1,1])c(1.08);};
}

////profiles for cover
module X(){
    h(){
        s(14.09,17.73);
        s(1,1);
        i(){
            c(11.91,18.1,-.4);
            s(30,7.17);
        }
    }
}
module Y(){
    h(){
        s(14.09,17.73);
        s(1,1);
        i(){
            c(12.41,18.1,-.4);
            s(30.5,7.17);
        }
    }
}
module Z(){
    h(){
        c(8.5,22.86,2.72);
        s(14.09,20.72);
        s(31.35,1);
    }
}