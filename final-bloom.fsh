#version 120

/*- Basic Bloom sample Modified by AirLoocke42... Credits To The Real Owner Of This Bloom -*/	

float bloom_amount = 0.15;

//- Uniforms And Sample Already Built-in For Testing Purposes -//

varying vec4 texture;

uniform sampler2D gcolor;

void main() {

	vec4 sum = vec4(0), add = vec4(0), val = texture2D(gcolor, texture.st);
  
   for( int i = -4 ; i < 4; i++) {
        for ( int j = -4; j < 4; j++) {

            add += texture2D(gcolor, texture.st + vec2(j, i)*0.002) * bloom_amount;

        }
   }

	if (val.r < 0.3) { sum = add*add*0.012 + val; } else 
	if (val.r < 0.5) { sum = add*add*0.009 + val; } else {
      sum = add*add*0.0075 + val;
  }

	gl_FragColor = vec4(sum.rgb, 1.0);
}
