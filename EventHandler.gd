extends Node3D

var red_score : int = 0
var blue_score : int = 0

@onready var score_counter = $"../Player/ScoreCounter"

func _on_blue_goal_body_entered(body):
	print("Blue goal entered.")
	blue_score += 1
	score_counter.set_score_blue(blue_score)

func _on_red_goal_body_entered(body):
	print("Red goal entered.")
	red_score += 1
	score_counter.set_score_red(red_score)
