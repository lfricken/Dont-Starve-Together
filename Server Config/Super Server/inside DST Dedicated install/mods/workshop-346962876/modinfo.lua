name = "DST Freezer"
description = "Nice!"
author = "Afro1967"
version = "2.7"

forumthread = "19505-Modders-Your-new-friend-at-Klei!"

api_version = 10

priority = 0.346962876
all_clients_require_mod = true
dst_compatible = true
client_only_mod = false

icon_atlas = "freezer.xml"
icon = "freezer.tex"

configuration_options =
{
    {
        name = "f_recipe",
        label = "Difficulty",
        hover = "Here's where you to change your freezer's recipe",
        options =
    {
        {description = "Easy", data = "easy", hover = "5 Cut Stones 1 Gear and 1 Blue Gem"},
        {description = "Hard", data = "hard", hover = "10 Cut Stones 3 Gears and 3 Blue Gems"},
    },
        default = "easy"
    },

    {
        name = "blank",
        label = " ",
        hover = " ",
        options =
    {
            {description = " ", data = 0},
    },
        default = 0
    },    

    {
        name = "chilltime",
        label = "Perish Time",
        hover = "Here we change the spoilage time of our food.",
        options =
    {
		{description = "Fridge", data = .5, hover = "Makes the freezer the same as icebox"},
		{description = "25", data = .37, hover = "Gives you 25% more time than the icebox"},
		{description = "50", data = .25, hover = "Gives you 50% more time than the icebox"},
		{description = "75", data = .12, hover = "Gives you 75% more time than the icebox"},
		{description = "No Spoilage", data = .01, hover = "With this option slected you will have no spoilage of food."},
	},
		default = .25
    },    
   
}
