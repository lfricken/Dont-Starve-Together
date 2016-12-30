name = "Scythestest"
description = "Scythe and GoldenScythe, nice!"
author = "Captain_M"
version = "2.3"

forumthread = " "

api_version = 10

all_clients_require_mod = true
dst_compatible = true
client_only_mod = false



icon_atlas = "scythe.xml"
icon = "scythe.tex"


configuration_options =
{
    {
        name = "picking_rate",
        label = "Picking Rate",
        hover = "You can choose how fast you want picking with scythes",
        options =
    {
        {description = "Crazy", data = "crazy", hover = "ya,you are crazy!"},
        {description = "Very fast", data = "veryfast", hover = "so fast that you cant see what happend"},
        {description = "Fast", data = "fast", hover = "oh,saving my time"},
        {description = "Normal", data = "normal", hover = "faster then usual picking"},
        {description = "Slow", data = "slow", hover = "little faster then usual picking"},
    },
        default = "fast"
    }

}
