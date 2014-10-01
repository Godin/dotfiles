if [ -n "${GPG_AGENT_INFO}" ]; then
  kill $(echo ${GPG_AGENT_INFO} | cut -d':' -f 2) >/dev/null 2>&1
fi

if [ -n "${SSH_AGENT_PID}" ]; then
  eval "$(ssh-agent -s -k)"
fi
