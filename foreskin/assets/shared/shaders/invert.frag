#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

uniform sampler2D maskTex;
void main() {
    vec4 sceneColor = texture2D(bitmap, openfl_TextureCoordv);
    vec4 maskColor = texture2D(maskTex, openfl_TextureCoordv);
    vec3 invertedRGB = 1.0 - sceneColor.rgb;
    vec3 finalRGB = mix(sceneColor.rgb, invertedRGB, maskColor.a);

    gl_FragColor = vec4(finalRGB, sceneColor.a);
}