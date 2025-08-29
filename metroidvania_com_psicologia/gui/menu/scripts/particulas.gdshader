shader_type canvas_item;

uniform vec2 direction;
uniform float speed : hint_range(0.0, 3.0, 0.05);
uniform float transparency : hint_range(0.0, 1.0, 0.05) = 0.0;

void fragment() {
	vec2 scroll = vec2(TIME * direction.x * speed, TIME * direction.y * speed);
	vec4 pixelColor = texture(TEXTURE, UV  + scroll);
	pixelColor.a -= transparency;
	COLOR = pixelColor;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
