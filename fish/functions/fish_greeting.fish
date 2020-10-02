function fish_greeting
    echo
    echo -n "Greetings "
    set_color --bold $fish_color_user
    echo -n $USER
    set_color --bold $fish_color_host
    echo -n "@"
    echo -n (hostname)
    set_color $fish_color_normal
    echo " at" (date)
    uname -v
    echo
end

