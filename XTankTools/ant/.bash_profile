export CLICOLOR=1

##
# Your previous /Users/fraser/.bash_profile file was backed up as /Users/fraser/.bash_profile.macports-saved_2014-03-31_at_20:55:54
##

# MacPorts Installer addition on 2014-03-31_at_20:55:54: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

alias ls="ls -F"
alias xtank-ant="cd /Users/fraser/xtank/client/XTankTools/ant"
alias xtank-tool="cd /Users/fraser/xtank/proto/script"
alias cplan="cd /Users/fraser/blitz/common/ant"
alias apache_restart="sudo apachectl restart"
alias cp="cp -i"

# See http://www.shellperson.net/using-sudo-with-an-alias/
alias sudo='sudo '
 
# This helps me edit files that my user isn't the owner of
alias edit='SUDO_EDITOR="open -FWne" sudo -e'
 
# The alias that takes me here - to editing these very aliases
alias edit_profile='open ~/.bash_profile'
 
# I do a lot of web development, so I need to edit these non-owned files fairly often
alias edit_hosts='edit /etc/hosts'
alias edit_httpd='edit /etc/apache2/httpd.conf'
alias edit_php='edit /etc/php.ini'
alias edit_vhosts='edit /etc/apache2/extra/httpd-vhosts.conf'
 
# This alias reloads this file
alias reload_profile='. ~/.profile'
 
# Mac get stuck very often and are extremely slow and unstable on shutdowns. This forces a shutdown.
#alias poweroff='sudo /sbin/shutdown -h now'