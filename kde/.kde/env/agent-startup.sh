if [ -x /usr/bin/gpg-agent ]; then
  eval "$(/usr/bin/gpg-agent --daemon)"
fi

if [ -x /usr/bin/ssh-agent ]; then
  eval "$(/usr/bin/ssh-agent -s)"
fi
