extends Particles2D


func _ready() -> void:
	emitting = true


func _process(_delta: float) -> void:
	if emitting == false:
		queue_free()