# ~/.bashrc: executed by bash(1) for non-login shells.
# This is actually just a stub to load different bashrc "modules" from ~/.bash.d aswell as /etc/bash.d
# So if you want to create a new entry, we recommend putting it into ~/.bash.d/your-entry
# ---
# We've made the decision to put this stub here, instead of into /etc/bashrc, so it works accross all systems
# that share the same $HOME

for d in "/etc/bash.d" "$HOME/.bash.d"; do
  if [ -d "$d" ]; then
    for f in $(dir "$d"); do
      . "$HOME/.bash.d/$f"
    done
  fi
done
