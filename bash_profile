# System-wide .profile for sh(1)

if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

if [ "${BASH-no}" != "no" ]; then
	[ -r /etc/bashrc ] && . /etc/bashrc
fi

export PATH=${PATH}:/Users/stevenwebb/bin

# ec2 tools
export EC2_HOME=/Users/stevenwebb/ec2-api-tools
export PATH=${PATH}:$EC2_HOME/bin
export EC2_PRIVATE_KEY=~/.ssh/dol-pk.pem 
export EC2_CERT=~/.ssh/dol-cert.pem  

##
# Your previous /Users/stevenwebb/.bash_profile file was backed up as /Users/stevenwebb/.bash_profile.macports-saved_2012-03-23_at_14:58:25
##

# MacPorts Installer addition on 2012-03-23_at_14:58:25: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

alias irc="xaric stevewebb irc.dishonline.com"
