#version 120

/*- Depth Of Field Samples by AirLoocke42 -*/	

const float intensity = 1.0;

//- Uniforms And Sample Already Built-in For Testing Purposes -//

varying vec4 texture;

uniform sampler2D gcolor;
uniform sampler2D depthtex0;

//- Using this format so I’ll save up some space and time on typing -//

vec3 calcDepth(vec2 bias, float ten) { 
   return texture2D( gcolor, texture.st + (bias * intensity) * ten).rgb;
}

//- A Small Circle Offset / Shape For Our Depth Of Field -//

const vec2 offset[16] = vec2[16](vec2(-0.38571040f, -0.8171502f),
	vec2( 0.03329741f, -0.9189221f), 
	vec2(-0.82000770f, -0.5234867f),
	vec2(-0.07335605f, -0.2632172f), 
	vec2( 0.63416130f, -0.7207248f),
	vec2(-0.91615430f, -0.1177677f), 
	vec2( 0.90688350f, -0.2405542f),
	vec2( 0.40217040f, -0.1239841f), 
	vec2(-0.46321180f,  0.0583270f),
	vec2( 0.09567857f,  0.2931803f), 
	vec2( 0.86220510f,  0.1983728f),
	vec2( 0.50844260f,  0.6236060f), 
	vec2( 0.28920760f, -0.5152128f),
	vec2(-0.89606320f,  0.4230295f), 
	vec2(-0.43524040f,  0.8662457f),
	vec2(-0.03035933f,  0.9384609f));

void main() {

	vec3 sum = vec3( 0.0 ); int i = 0;

	float bias = min(abs(texture2D(depthtex0, texture.st).x - texture2D(depthtex0, vec2(0.5)).x) * 0.1, 0.5);

	//- While Loop Is Used -//

	while(i < 16) sum += calcDepth(offset[i], bias)/16.0, i++;

	gl_FragColor = vec4(sum.rgb, 1.0);
}
