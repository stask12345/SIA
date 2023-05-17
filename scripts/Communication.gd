extends Node2D

@onready var system = get_node("/root/MainScene")
var animationComplete = false
var quotes = ["'You're not clueless any more. But you are still not in control of your body, just like a sleeping person'",
"'Person who just awakened from deep sleep is still disoriented and confused. Weakness from sleep still doesn't leaved their body. However those who awakened have the power to make decisions, they are no longer passive. You have started new day of your life.'",
"'One of the greates traits of Humanity is the ability to learn and adapt. You have started this process once again, you are slowly learning how to cultivate your body and mind. Each ability needs time to learn and you are making progress. '",
"'Expirience comes with time, it's powerfull tool - expirenced person can do tasks much more efficiently. You gained a lot of small fragments of knowlange, those details are key to success, together they can form profound whole.'",
"'What a lucky fellow, he can successed in every thing he do! - says everybody looking at you. They couldn't be more wrong. Luck? You are creating your own luck, through cunning and analizing you bend normal standards. Keep it up, be always on top in shadows, on the bottom in board light.'",
"'You have moved beyond normality. You are strong willed, sharp and domineering. You see the bigger picture then normal people or those who awakened. Looking from top on youself, you are able to analize yourself a lot better than ever before.'",
"'Unyielding will, heart of the demonic pathway. Immense amount of work and dedication are required to achieve those ideological goals. Your mind have become focused on your goals, you are realizing them with confidency, without hesitation. You are never giving up.'",
"'Magicians have wide range of varius tricks in their sleeve, so have you. Magicians never perform unprepared and so do you. Grand performens of Magicians are breach taking - and so are you actions, you are beding reality with your will and mind.'",
"'A lot of people think that they have their life in total control - but maybe they are dancing in your hand? Nobody fully control their life, but you do so much more then the other. Your influence can control will of those around you.'",
"'You have achived full control over both - your mind and body. Your mind became reliable tool, always sharp and working. Your body became much stronger and healthy. You are truly a master over yourself - now you must become master above others.'",
"'Others may call you that, but in truth those are just the effect of working harder then others. Your are not blind - only a handful of people are not, so they call you a genius. The smartest know how stupid they are, and so know you. Achieve success.'",
"'You are truly a Fool standing on the very peak of life. You choose to not simply enjoy life, but to become a fool and to fool others. With unyielding determitation you broken the limits and the limits broke you. What more is there to say? You know yourself the best. Was it worth it? Yes? Then live and have no regrets.'"]

func evolutionScreenOn():
	setUpEvolution()
	visible = true
	var t = create_tween()
	t.tween_property($ColorRect,"self_modulate",Color(1,1,1,0.9),0.3)
	$AnimationPlayer.play("idle")

func setUpEvolution():
	$UpContainer/SeqLabel.text = "Seq. " + str(system.rankNames.size() - system.stats.rank - 1)
	$DownContainer/evo1.text = system.rankNames[system.stats.rank]
	$DownContainer/evo2.text = system.rankNames[system.stats.rank+1]
	$Quote.text = quotes[system.stats.rank]
	
	%BottomMenu.visible = false

func completeAnimation():
	animationComplete = true

func hideManu():
	visible = false
	%BottomMenu.visible = true

func _on_touch_screen_button_pressed():
	if animationComplete:
		$AnimationPlayer.play("down")
