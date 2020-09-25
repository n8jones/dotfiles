function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    # User
    #set_color $fish_color_user
    #echo -n $USER
    #set_color normal

    #echo -n '@'

    # Host
    if test -n "$SSH_CLIENT" 
      set_color $fish_color_host
      echo -n @(prompt_hostname)
      set_color normal

      echo -n ' '
    end

    # PWD
    set_color $fish_color_cwd
    echo -n (basename (pwd))
    set_color normal


    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n ') '
    set_color normal
end
