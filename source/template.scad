module pjoint(){
    include<joint.scad>

}

module pthreads(){
    include<threads.scad>

}

module pfront(){
    include<front.scad>
}
module prear(){
    include<rear.scad>
}


//Functions below are replaced with the contents of matching part files.
//Above removed when minified. tempString
p=1;
include<header.scad>

pjoint();
pthreads();

if(p==1)  {prear();}
if(p==2)  {pfront();}
if(p==3)  {pcover();}
if(p==4)  {pplug();}



