extends Node3D

var red_score : int = 0
var blue_score : int = 0
var oyelly_score : int = 0

@onready var score_counter = $"../Player/ScoreCounter"
@onready var blue_goal_announce = $"BlueGoalAnnounce"
@onready var red_goal_announce = $"RedGoalAnnounce"
@onready var oyelly_goal_announce = $"OyellyGoalAnnounce"

func _on_blue_goal_body_entered(body):
	print("Blue goal entered.")
	blue_score += 1
	score_counter.set_score_blue(blue_score)
	blue_goal_announce.play()

func _on_red_goal_body_entered(body):
	print("Red goal entered.")
	red_score += 1
	score_counter.set_score_red(red_score)
	red_goal_announce.play()


func _on_oyelly_goal_body_entered(body):
	print("Oyelly Company goal entered.")
	oyelly_score += 1
	score_counter.set_score_oyelly(oyelly_score)
	oyelly_goal_announce.play()
