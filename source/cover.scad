include<header.scad>

d(){
    u(){
        d(){
            e(237.3)m([0,1,0])Z();
            m([0,1,0]){
                h(){
                    t(.19,0,.5)r([0,-40,0])e(.1)z([1.31,1])//39.57/(30.5-.19)
                    t(-.19,0)d(){
                        Y();
                        s(.19,90);
                    }
                    q(.19,17.73,1,0,0,.5);
                    t(0,0,42.63)e(1)Y();
                    t(0,0,43.13)e(1)X();
                }
                t(0,0,44.13)e(194)X();
                
                h(){
                    r([0,-37.05,0])e(.001)z([39.35,1])Z();//31.35/cos(37.05)
                    t(0,0,-1)e(1)Z();
                }
            }
        }
        //back
        m([0,1,0])h(){
            r([0,-37.05,0]){
                e(.001)z([1.255,1])Z();//(31.35/cos(37.05))/31.35
                t(0,0,-1)e(1){
                    offset(-1)z([1.255,1])Z();
                    s(37.4,1,1,0);
                }
            }
        }
    }
    //side cutout
    h(){
        m([0,1,0])for(i=[10.2,17.7]){
            l(.5,20,i,6.62);
        }
    }
       h(){
        r([-90,0,0])l(3,20.72,4.95,-100.72,0);
        q(1,20.72,145.77,-1,0,91.53);
        q(7.95,20.72,1,0,0,237.3);
    }
    r([-90,0,0])l(18,20.72,6.57,-169.44);
    q(24.57,20.72,100,0,0,169.44);
    h(){
        i(){
            r([-90,0,0])l(18,20.72,6.57,-169.44);
            h(){
                q(14.68,19.73,169.44);
                q(24.57,11.35,169.44);
            }
        }
        i(){
            r([-90,0,0])l(20,20.72,6.57,-169.44);
            h(){
                q(14.02,17.79,169.44);
                q(26.13,8.1,169.44);
            }
        }
    }
    ///back cutout
    h(){
        q(26.13,8.1,90,0,0,169.44);
        q(24.57,11.35,90,0,0,169.44);
    }
}