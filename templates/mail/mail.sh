#!/usr/bin/env bash

me=`whoami`
NEW_MAIL=false
mbsync -Va
if ! ( notmuch new | grep "No new mail."); then
    NEW_MAIL=true
fi

if [ $NEW_MAIL = true ]; then
    if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
        /home/$me/.bin/windows-notify.sh "New mail."
    else
        notify-send "New mail"
    fi
fi
