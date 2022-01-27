varying vec2 vUv;

// fake random function
float random(vec2 st)
{
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

// rotation function 
vec2 rotate(vec2 uv, float rotation, vec2 mid)
{
    return vec2(
      cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
      cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
    );
}

// CLASSIC PERLIN NOISE 

//  Classic Perlin 2D Noise 
//  by Stefan Gustavson
//
vec2 fade(vec2 t)
{
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}
vec4 permute(vec4 x)
{
    return mod(((x*34.0)+1.0)*x, 289.0);
}
float cnoise(vec2 P)
{
    vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
    vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
    Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation
    vec4 ix = Pi.xzxz;
    vec4 iy = Pi.yyww;
    vec4 fx = Pf.xzxz;
    vec4 fy = Pf.yyww;
    vec4 i = permute(permute(ix) + iy);
    vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
    vec4 gy = abs(gx) - 0.5;
    vec4 tx = floor(gx + 0.5);
    gx = gx - tx;
    vec2 g00 = vec2(gx.x,gy.x);
    vec2 g10 = vec2(gx.y,gy.y);
    vec2 g01 = vec2(gx.z,gy.z);
    vec2 g11 = vec2(gx.w,gy.w);
    vec4 norm = 1.79284291400159 - 0.85373472095314 * vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
    g00 *= norm.x;
    g01 *= norm.y;
    g10 *= norm.z;
    g11 *= norm.w;
    float n00 = dot(g00, vec2(fx.x, fy.x));
    float n10 = dot(g10, vec2(fx.y, fy.y));
    float n01 = dot(g01, vec2(fx.z, fy.z));
    float n11 = dot(g11, vec2(fx.w, fy.w));
    vec2 fade_xy = fade(Pf.xy);
    vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
    float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
    return 2.3 * n_xy;
}

// pi
#define PI 3.141592653589793238

void main()
{
    // Pattern gradient from black to white on x
    // float strength = vUv.x;
    
    // gl_FragColor = vec4(strength, strength, strength,1.0);

    // 

    // Pattern gradient from black to white on y 

    // float strength = vUv.y;
    
    // gl_FragColor = vec4(strength, strength, strength,1.0);

    // Pattern gradient from white to black on y

    // float strength = 1.0 - vUv.y;
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);

    // 

    //  Pattern gradient but "harder"

    // float strength = vUv.y *6.0;
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);

    // 
    
    // More than one gradient with module
    
    // float strength = mod(vUv.y * 10.0,1.0);
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);
    
    // 

    // Black and white stripes, we could've used if but it's better for performance to use the step function

    // float strength = mod(vUv.y * 10.0,1.0);
    // strength = step(0.5,strength);
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);

    // 

    // Changing the step function we can have thicker or thinner stripes

    // float strength = mod(vUv.y * 10.0,1.0);
    // strength = step(0.8,strength);
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);

    // 
    
    // We can have stripes on the x too

    // float strength = mod(vUv.x * 10.0,1.0);
    // strength = step(0.8,strength);
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);

    // 

    // we can combine both and have a grid

    // float strength = step(0.8,mod(vUv.y * 10.0,1.0)) + step(0.8,mod(vUv.x * 10.0,1.0));
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);
    
    // 
    // what if we make it the inverse?
    // we get squares

    // float strength = step(0.2,mod(vUv.y * 10.0,1.0)) + step(0.2,mod(vUv.x * 10.0,1.0));
    
    // gl_FragColor = vec4((1.0 -strength), (1.0 -strength), (1.0 -strength),1.0);

    // 
    // there is another way to make the same

    // float strength = step(0.8,mod(vUv.y * 10.0,1.0)) * step(0.8,mod(vUv.x * 10.0,1.0));
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);

    // what if we change some parameters?

    // float strength = step(0.8,mod(vUv.y * 10.0,1.0)) * step(0.2,mod(vUv.x * 10.0,1.0));
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);

    // we can also get weird shapes

    // float strength = step(0.8,mod(vUv.y * 10.0,1.0)) * step(0.2,mod(vUv.x * 10.0,1.0));
    // strength += step(0.2,mod(vUv.y * 10.0,1.0)) * step(0.8,mod(vUv.x * 10.0,1.0));
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);


    // we can move the bars and make crosses

    // float barX= step(0.8,mod(vUv.y * 10.0 +0.2,1.0)) * step(0.4,mod(vUv.x * 10.0  ,1.0));
    // float barY= step(0.4,mod(vUv.y * 10.0,1.0)) * step(0.8,mod(vUv.x * 10.0 +0.2,1.0));

    // float strength = barX + barY;
    
    // gl_FragColor = vec4((strength), (strength), (strength),1.0);


    // Abs gradient on x

    // float strength = abs(vUv.x - 0.5);

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // the minimum value gives interesting stuff
    // float strength = min(abs(vUv.x - 0.5) , abs(vUv.y - 0.5));

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // the same with the max

    // float strength = max(abs(vUv.x - 0.5) , abs(vUv.y - 0.5));

    // gl_FragColor = vec4(strength,strength,strength,1.0);


    // 

    // black square using max and step (frame)

    // float strength = step(0.25,max(abs(vUv.x - 0.5) , abs(vUv.y - 0.5)));

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // tiny frame

    // float squareBlack = step(0.2,max(abs(vUv.x - 0.5) , abs(vUv.y - 0.5)));
    // float squeareWhite = 1.0 -step(0.25,max(abs(vUv.x - 0.5) , abs(vUv.y - 0.5)));

    // float strength = squareBlack * squeareWhite;

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    

    // Low quality gradient

    // float strength = floor(vUv.x*10.0)/10.0;

    // gl_FragColor = vec4(strength,strength,strength,1.0);


    // Low quality gradient in both axis

    // float strength = floor(vUv.x*10.0)/10.0;
    // strength *= floor(vUv.y*10.0)/10.0;

    // gl_FragColor = vec4(strength,strength,strength,1.0);


    // Noise 
    // The problem is that in glsl we don't have math.random so we need a function that's unpredictable

    // float strength = random(vUv);

    // gl_FragColor = vec4(strength,strength,strength,1.0);


    //  big pixel noise

    // vec2 gradient = vec2(floor(vUv.x*10.0)/10.0, floor(vUv.y*10.0)/10.0);

    // float strength = random(gradient);

    // gl_FragColor = vec4(strength,strength *0.3,strength *0.2,1.0);


    // offset big pixelated noise

    // vec2 gradient = vec2(
    //     floor(vUv.x*10.0)/10.0,
    //     floor((vUv.y + vUv.x *0.5)*10.0)/10.0);

    // float strength = random(gradient);

    // gl_FragColor = vec4(strength,strength,strength ,1.0);


    // circular gradient from the corner

    // float strength = length(vUv);

    // gl_FragColor = vec4(strength,strength,strength ,1.0);

    // 

    // circular gradient from the middle

    // float strength = length(vUv-0.5);

    // gl_FragColor = vec4(strength,strength,strength ,1.0);

    // 

    // opposite gradient

    // float strength = 1.0- length(vUv-0.5);

    // gl_FragColor = vec4(strength,strength,strength ,1.0);

    // 

    // tunnelish pattern

    // float strength = 0.005/length(vUv-0.5);

    // gl_FragColor = vec4(strength,strength,strength ,1.0);

    // 

    // stretch tunnelish pattern

    // vec2 lightUv = vec2(
    //     vUv.x * 0.1+0.5,
    //     vUv.y *0.5 + 0.25
    // );

    // float strength = 0.015/distance(lightUv,vec2(0.5));

    // gl_FragColor = vec4(strength,strength,strength ,1.0);

    // 

    // diamond pattern tunnel

    // vec2 lightUvX = vec2(vUv.x * 0.1+0.45, vUv.y *0.5 + 0.25);
    // vec2 lightUvY = vec2(vUv.x*0.5 + 0.25, vUv.y * 0.1+0.45);
    // float lightX = 0.015/distance(lightUvX,vec2(0.5));
    // float lightY = 0.015/distance(lightUvY,vec2(0.5));

    // float strength = lightX * lightY;

    // gl_FragColor = vec4(strength,strength,strength ,1.0);

    // 

    // Rotation of the diamond pattern tunnel
    // to do it we will rotate the uv coordinate and we will use the rotate function

    // vec2 rotatedUv = rotate(vUv, PI*0.25,vec2(0.5));

    // vec2 lightUvX = vec2(rotatedUv.x * 0.1+0.45, rotatedUv.y *0.5 + 0.25);
    // vec2 lightUvY = vec2(rotatedUv.x*0.5 + 0.25, rotatedUv.y * 0.1+0.45);
    // float lightX = 0.015/distance(lightUvX,vec2(0.5));
    // float lightY = 0.015/distance(lightUvY,vec2(0.5));

    // float strength = lightX * lightY;

    // gl_FragColor = vec4(strength,strength,strength ,1.0);


    // 

    // Black circle in the middle

    // float strength = step(0.4,distance(vUv,vec2(0.5)));

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // Double Gradient circle 

    // float strength = abs(distance(vUv,vec2(0.5))-0.25);
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // Black ring

    // float strength = step(0.01,abs(distance(vUv,vec2(0.5))-0.25));
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // white ring


    // float strength = 1.0- step(0.01,abs(distance(vUv,vec2(0.5))-0.25));
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // deformed waved ring

    // vec2 sinUvX = vec2(sin(vUv.x * 6.0*PI),sin(vUv.y*6.0*PI));
    // the upper code makes multiple circles

    // vec2 wavedUV= vec2(
    //     vUv.x,
    //     vUv.y + sin(vUv.x*20.0)*0.1);

    // float strength = 1.0- step(0.01,abs(distance(wavedUV,vec2(0.5))-0.25));
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    //  Deformed circle with waves on x andy 

    // vec2 wavedUV= vec2(
    //     vUv.x + sin(vUv.y*30.0)*0.1,
    //     vUv.y + sin(vUv.x*30.0)*0.1);

    // // this one is really interesting to ANIMATE

    // float strength = 1.0- step(0.01,abs(distance(wavedUV,vec2(0.5))-0.25));
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // Deformed circle amplifying the angle

    // vec2 wavedUV= vec2(
    //     vUv.x + sin(vUv.y*100.0)*0.1,
    //     vUv.y + sin(vUv.x*100.0)*0.1);

    // float strength = 1.0- step(0.01,abs(distance(wavedUV,vec2(0.5))-0.25));
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);


    // 

    //  angle variation

    // float angle = atan(vUv.x, vUv.y);

    // float strength = angle;
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // offset angle variation to start on the center

    // float angle = atan(vUv.x -0.5, vUv.y-0.5);

    // float strength = angle;
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // full circle angle variation

    // float angle = atan(vUv.x -0.5, vUv.y-0.5);
    // angle /= PI*2.0;
    // angle+=0.5;

    // float strength = angle;

    // 

    // full circle gradiant angle variation

    // float angle = atan(vUv.x -0.5, vUv.y-0.5);
    // angle /= PI*2.0;
    // angle+=0.5;
    // angle*=20.0;

    // float strength = mod(angle,1.0);
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // full circle angle with sinus

    // float angle = atan(vUv.x -0.5, vUv.y-0.5);
    // angle /= PI*2.0;
    // angle+=0.5;
    // angle*=20.0;

    // float strength = sin(angle*20.0);
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);


    //  white circle with perturbation on radius following angle pattern


    // float angle = atan(vUv.x -0.5, vUv.y-0.5);
    // angle /= PI*2.0;
    // angle+=0.5;
    // float perturbation = sin(angle *100.0);

    // float radius = 0.25 + (perturbation)*0.02;

    // float perturbedCircle = 1.0- step(0.01, abs(distance(vUv,vec2(0.5)) -radius));

    // // float strength = whiteCircle * perturbation;
    // // the code above gives a circle made with bars 

    // float strength = perturbedCircle;
    

    // gl_FragColor = vec4(strength,strength,strength,1.0);


    // Perlin noise pattern
    
    
    // float strength = cnoise(vUv * 10.0);

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // Perlin noise pattern with step

    //  float strength = step(0.0,cnoise(vUv * 10.0));

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    //  perlin noise with abs

    // float strength = 1.0- abs(cnoise(vUv * 10.0));

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // sinusoidal perlin noise

    // float strength = sin(cnoise(vUv * 10.0)*20.0);

    // gl_FragColor = vec4(strength,strength,strength,1.0);

    // 

    // sharp sinusoidal perlin noise

    // float strength = step(0.9,sin(cnoise(vUv * 10.0)*20.0));

    // gl_FragColor = vec4(strength,strength,strength,1.0);


    ///////////////////////// 

    // to add color we are going to use the mix


    float strength = step(0.9,sin(cnoise(vUv * 10.0)*20.0));

    vec3 blackColor = vec3(0.0);

    vec3 uvColor = vec3(vUv,1.0);

    vec3 mixColor = mix(blackColor,uvColor, strength);
     gl_FragColor = vec4(mixColor,1.0);
    

    

}