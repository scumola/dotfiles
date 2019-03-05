
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

if [ "${BASH-no}" != "no" ]; then
	[ -r /etc/bashrc ] && . /etc/bashrc
fi

export PATH=/usr/local/git/bin:${PATH}:/Users/stevenwebb/bin

for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend
export HISTFILESIZE=100000
export HISTSIZE=100000

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

alias irc="xaric swebb irc.dishonline.com"
alias twit="xaric scumola irc.twit.tv"

if [[ "$OSTYPE" =~ ^darwin ]]; then
	alias ls="command ls -G"
else
	alias ls="command ls --color"
	export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# IP addresses
alias ip2="curl ifconfig.me"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# OS X has no `md5sum`, so use `md5` as a fallback
type -t md5sum > /dev/null || alias md5sum="md5"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# File size
alias fs="stat -f \"%z bytes\""

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Appleâs System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

alias secpass="openssl rand -base64 24"
alias hexpass="openssl rand -hex 24"

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 10'"
alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"

alias less="less -R $*"

alias movies="cd /Users/stevenwebb/work_personal/google-movie-showtimes-parser ; ./movies.php | less -R"

alias check_open_dns_resolver="dig +short amiopen.openresolvers.org TXT"

export SSH_AUTH_SOCK=~/.ssh-socket

ssh-add -l >/dev/null 2>&1
if [ $? = 2 ]; then
   # No ssh-agent running
   rm -rf $SSH_AUTH_SOCK
   ssh-agent -a $SSH_AUTH_SOCK >/tmp/.ssh-script
   source /tmp/.ssh-script
   echo $SSH_AGENT_PID > ~/.ssh-agent-pid
   rm /tmp/.ssh-script
   ssh-add
   ssh-add ~/.ssh/deploycopy
   ssh-add ~/keys/DANY-default-2016.pem
#   ssh-add ~/keys/ghopperOnline.pem
   ssh-add ~/.ssh/monitordishonlinecom.pem
   ssh-add ~/keys/*.priv
   ssh-add ~/.ssh/dol-pk.pem
   ssh-add ~/.ssh/dishgit.pem
   ssh-add ~/Downloads/production-root.pem
#   ssh-add ~/.ssh/datalanche
#   ssh-add ~/keys/datalanche-deploy.pem
fi

source .nagios_commands.bash
source .todo/todo_completion

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

rvm use 1.8.7-p358

# android
PATH="${PATH}:/Users/stevenwebb/android/adt-bundle-mac-x86_64/sdk/tools:/Users/stevenwebb/android/adt-bundle-mac-x86_64/sdk/platform-tools"

# Setting PATH for JRuby 1.7.3
# The orginal version is saved in .bash_profile.jrubysave
PATH="${PATH}:/Library/Frameworks/JRuby.framework/Versions/Current/bin"
export PATH

function campfire() {
	# radical-bacin room
	curl -s -u a754fb1d851390d3880593489988c813775fca56:493ndk8gJQszkU5UUH48 -H 'Content-Type: application/json' -d '{"message":{"body":"['"`date \"+%Y-%m-%d %H:%M:%S\"`"'] (webb-bot) '"$@"'"}}' https://echostar1.campfirenow.com/room/522041/speak.json | /usr/local/bin/json_xs | grep body
}

# DSH aliases
alias dsh-staging-thin-restart="dsh -F 10 -g staging-radish -- 'sudo bash -c \"rvm use 2.1.5\@radish_0_1 ; /etc/init.d/thin restart\"'"
alias dsh-staging-uptime="dsh -F 10 -g staging-radish uptime"
alias dsh-prod-thin-restart="campfire 'radish and recents thin restarts (rolling; in chunks of ten at a time) - STARTED' ; dsh -F 10 -g prod-radish -- 'sudo bash -c \"rvm use 2.1.5\@radish_0_1 ; /etc/init.d/nginx stop ; /etc/init.d/thin restart ; /etc/init.d/nginx start\"' ; campfire 'radish and recents thin restarts (rolling; in chunks of ten at a time) - DONE' "
alias dsh-prod-thin-restart-odd="campfire 'radish and recents thin restarts (rolling, in chunks of ten at a time, odds only) - STARTED' ; dsh -F 10 -g prod-radish-odd -- 'sudo bash -c \"/usr/local/rvm/bin/rvm use 2.1.5\@radish_0_1 ; /etc/init.d/nginx stop ; /etc/init.d/thin restart ; /etc/init.d/nginx start\"' ; campfire 'radish and recents thin restarts (rolling, in chunks of ten at a time, odds only) - DONE' "
alias dsh-prod-radish-uptime="dsh -F 10 -g prod-radish 'uptime'"
alias dsh-prod-bacin-uptime="dsh -F 10 -g prod-bacin uptime"
alias dsh-prod-bacin-nginx-stop="campfire 'STOPPING nginx on prod-bacin-app servers' ; dsh -F 10 -g prod-bacin -- 'sudo bash -c \"/etc/init.d/nginx stop\"' ; campfire 'DONE'"
alias dsh-prod-bacin-nginx-start="dsh -F 10 -g prod-bacin -- 'sudo bash -c \"/etc/init.d/nginx start\"'"
alias dsh-prod-bacin-nginx-restart="dsh -F 10 -g prod-bacin -- 'sudo bash -c \"/etc/init.d/nginx restart\"'"
#alias dsh-prod-memcache-restart="campfire 'prod-radish-memcache RESTARTING (clearing)' ; dsh -F 10 -g prod-memcache -- 'sudo bash -c \"/etc/init.d/memcached restart\"' ; campfire 'DONE'"
#alias dsh-prod-memcache-uptime="dsh -F 10 -g prod-radish-memcache 'uptime'"
alias csshX-prod-radish-haproxy="csshX deploy@prod-radish01-app-haproxy.dishanywhere.com deploy@prod-radish01-app-haproxy[2-6].dishanywhere.com"
alias csshX-prod-bacin-haproxy="csshX deploy@prod-bacin-app-haproxy[2-3].dishanywhere.com"
alias csshX-prod-bacin-secure-haproxy="csshX deploy@prod-bacin-secure-haproxy[2-4].dishanywhere.com"
alias csshX-prod-bacin-haproxy="csshX deploy@prod-bacin-app-haproxy.dishanywhere.com deploy@prod-bacin-app-haproxy[2-3].dishanywhere.com"
alias csshX-beta-radish-haproxy="csshX deploy@beta-radish01-haproxy.dishonline.com deploy@beta-radish01-haproxy[20-39].dishonline.com"
alias mosh-grasshopper="mosh ec2-user@pgh-ops01.dishanywhere.com"
alias maillog="sudo log stream --predicate  '(process == "smtpd") || (process == "smtp")' --info"
alias mailfetch="fetchmail -d 30 -N"
alias weather="curl wttr.in"
alias bc="et steve@badcheese.com -c 'tmux -CC a || tmux -CC'"

# added by Anaconda 1.8.0 installer
#export PATH="/Users/stevenwebb/anaconda/bin:$PATH"

export PERL_LWP_SSL_VERIFY_HOSTNAME=0

transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
	tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

#task
