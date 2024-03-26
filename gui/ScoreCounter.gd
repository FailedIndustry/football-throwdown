extends Node2D

@onready var red_team_score = $RedTeamScore
@onready var blue_team_score = $BlueTeamScore
@onready var oyelly_team_score = $OyellyTeamScore

func set_score_red(new_score):
	red_team_score.text = str(new_score)
	
func set_score_blue(new_score):
	blue_team_score.text = str(new_score)

func set_score_oyelly(new_score):
	oyelly_team_score.text = str(new_score)
