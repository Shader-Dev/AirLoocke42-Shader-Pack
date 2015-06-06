#version 120

/*- Basic Bloom sample by AirLoocke42. GLSL Format -*/	

float bloom_amount = 1.5;

//- Uniforms And Sample Already Built-in For Testing Purposes -//

varying vec4 texture;

uniform sampler2D gcolor;

void main() {

	vec3 sum = texture2D(gcolor, texture.st).rgb;

	float rad = 0.001, sc = 20.0, blm_amount = 0.02*bloom_amount;
	int i = 0, samples = 1; vec4 clr = vec4(0.0);
	
	for (i = -8; i < 8; i++) {
	vec2 d = vec2(-i, i), e = vec2(0, i), f = texture.st;

	clr += texture2D(gcolor, f+( d.yy )*rad)*sc;
	clr += texture2D(gcolor, f+( d.yx )*rad)*sc;
	clr += texture2D(gcolor, f+( d.xy )*rad)*sc;
	clr += texture2D(gcolor, f+( d.xx )*rad)*sc;

	clr += texture2D(gcolor, f+( e.xy )*rad)*sc;
	clr += texture2D(gcolor, f+(-e.yx )*rad)*sc;
	clr += texture2D(gcolor, f+(-e.xy )*rad)*sc;
	clr += texture2D(gcolor, f+( e.yx )*rad)*sc;

	++samples;
	sc = sc - 1.0;
	}
	clr = (clr/8.0)/samples; sum.rgb += clr.rgb*blm_amount;

	gl_FragColor = vec4(sum.rgb, 1.0);
}
