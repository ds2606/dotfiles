# color palette for onedark-palenight custom highlighting
pn_colors () {
    if [[ $1 == '256' ]]; then
        declare -xA c=(
            [blue]=81
            [cyan]=14
            [darkpurp]=63
            [green]=120  # testing in place of 114
            [ice]=153
            [orange]=209
            [pink]=213
            [pnhighlight]=104  # 04 is good too
            [pnpurpblue]=111
            [pnpurple]=147
            [pnyellow]=214
            [purpink]=177
            [purple]=141
            [red]=211
            [softyellow]=180
            [tblue]=69  # terminal default blue
            [testval]=09
            [yellow]=221
        )
    elif [[ $1 == 'gui' ]]; then
        declare -xA c=(
            [blue]='#5fd7ff'
            [cyan]='#00ffff'
            [darkpurp]='#5f5fff'
            [green]='#87d787'
            [ice]='#afd7ff'
            [orange]='#ff875f'
            [pink]='#ff87ff'
            [pnhighlight]='#8787d7'  # 04 is good too
            [pnpurpblue]='#87afff'
            [pnpurple]='#afafff'
            [pnyellow]='#ffaf00'
            [purpink]='#d787ff'
            [purple]='#af87ff'
            [red]='#ff87af'
            [softyellow]='#d7af87'
            [tblue]='#5f87ff'  # terminal default blue
            [testval]='#ff0000'
            [yellow]='#ffd75f'
        )
    elif [[ $1 == '16' ]]; then
        echo '16 colors not yet implemented'
    else
        echo 'usage: pn_colors [256 | gui | 16]'
    fi
}
