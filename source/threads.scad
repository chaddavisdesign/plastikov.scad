include<header.scad>
//T();
module T(){


//    m=30.16;//1-3/16in
    p=1.588;//16TPI
//    l=30;//length
//    t=.3;//tolerance
//    r=m/2; // radius = 15.08
//    h=sqrt(3)/2*p;  // height of thread = .40908
//    fn=120; // number of points per turn
//    fa=360/fn; // angle of each point
    n=2268;//n=max(fn+1,round(fn*l/p)+1); // total number of points
    q=.099;//q=min(p/16,t); // thread width adjusth
    
    //(r-5*h/8+t)=(30.16/2-5*sqrt(3)/2*1.588/8+.3)= 14.5204697867
    //p/fn = 1.588/120 = 0.01323333333
    //(r+t) = 30.16/2+.3 = 15.38
    function z(i,j,k) = (j==1?cos(i*3):sin(i*3))*(k==1?15.38:14.5205);
    i(){
        t(0,0,-4)
        polyhedron(
            points=concat(
                [for(i=[0:1:n-1])[z(i,1),   z(i),       i*p/120+q]],
                [for(i=[0:1:n-1])[z(i,1),   z(i),       i*p/120+p/4-q]],
                [for(i=[0:1:n-1])[z(i,1,1), z(i,0,1),   i*p/120+p/2+p/8-p/16-q]],
                [for(i=[0:1:n-1])[z(i,1,1), z(i,0,1),   i*p/120+p/2+p/8+p/16+q]],
                [for(i=[0:1:n-1])[z(i,1),   z(i),       i*p/120+p+q]],
                [[0,0,p/2],[0,0,n*p/120+p/2]]
                ),
            faces=concat(
                [for(i=[0:1:120-1])[n*5,i,i+1]],
                [[n*5,n,0],[n*5,n*2,n],[n*5,n*3,n*2],[n*5,n*4,n*3]],
                
                [for(j=[0:3])for(i=[0:1:n-2])[i+n*j,i+n*(j+1),i+1+n*j]],
                [for(j=[0:3])for(i=[0:1:n-2])[i+n*(j+1),i+n*(j+1)+1,i+1+n*j]],
                    
                [for(i=[0:1:120-1])[n*5+1,n*5-i-1,n*5-i-2]],
                [[n*5+1,n*4-1,n*5-1],[n*5+1,n*3-1,n*4-1],[n*5+1,n*2-1,n*3-1],[n*5+1,n-1,n*2-1]]
                ));
    }
    
}

//    Above based on code from ISOThread.scad by RevK   
//    https://www.thingiverse.com/thing:2158656
//
//    m=30.16;//1-3/16in
//    p=2.117;//12TPI
//    l=10;//length
//    t=.3;//tolerance
//    r=m/2; // radius
//    h=sqrt(3)/2*p;  // height of thread
//    fn=120; // number of points per turn
//    fa=360/fn; // angle of each point
//    n=max(fn+1,round(fn*l/p)+1); // total number of points
//    q=min(p/16,t); // thread width adjust
//    p1=[for(i=[0:1:n-1])[cos(i*fa)*(r-5*h/8+t),sin(i*fa)*(r-5*h/8+t),i*p/fn+q]];
//    p2=[for(i=[0:1:n-1])[cos(i*fa)*(r-5*h/8+t),sin(i*fa)*(r-5*h/8+t),i*p/fn+p/4-q]];
//    p3=[for(i=[0:1:n-1])[cos(i*fa)*(r+t),sin(i*fa)*(r+t),i*p/fn+p/2+p/8-p/16-q]];
//    p4=[for(i=[0:1:n-1])[cos(i*fa)*(r+t),sin(i*fa)*(r+t),i*p/fn+p/2+p/8+p/16+q]];
//    p5=[for(i=[0:1:n-1])[cos(i*fa)*(r-5*h/8+t),sin(i*fa)*(r-5*h/8+t),i*p/fn+p+q]];
//    p6=[[0,0,p/2],[0,0,n*p/fn+p/2]];
//    
//    t1=[for(i=[0:1:fn-1])[n*5,i,i+1]];
//    t2=[[n*5,n,0],[n*5,n*2,n],[n*5,n*3,n*2],[n*5,n*4,n*3]];
//    t3=[for(i=[0:1:n-2])[i,i+n,i+1]];
//    t4=[for(i=[0:1:n-2])[i+n,i+n+1,i+1]];
//    t5=[for(i=[0:1:n-2])[i+n,i+n*2,i+n+1]];
//    t6=[for(i=[0:1:n-2])[i+n*2,i+n*2+1,i+n+1]];
//    t7=[for(i=[0:1:n-2])[i+n*2,i+n*3,i+n*2+1]];
//    t8=[for(i=[0:1:n-2])[i+n*3,i+n*3+1,i+n*2+1]];
//    t9=[for(i=[0:1:n-2])[i+n*3,i+n*4,i+n*3+1]];
//    t10=[for(i=[0:1:n-2])[i+n*4,i+n*4+1,i+n*3+1]];
//    t11=[for(i=[0:1:fn-1])[n*5+1,n*5-i-1,n*5-i-2]];
//    t12=[[n*5+1,n*4-1,n*5-1],[n*5+1,n*3-1,n*4-1],[n*5+1,n*2-1,n*3-1],[n*5+1,n-1,n*2-1]];
//   
//    intersection()
//    {
//        translate([0,0,-p])
//        polyhedron(points=concat(p1,p2,p3,p4,p5,p6),
//        faces=concat(t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12));
//    }