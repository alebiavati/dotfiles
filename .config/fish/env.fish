function load_dotenv
  set -f envfile "$argv"
  if test -f "$envfile"
    while read line
      if not string match -qr '^#|^$' "$line"
        set item (string split -m 1 '=' $line)
        set -gx $item[1] $item[2]
      end
    end < "$envfile"
  end
end

# load env
load_dotenv $HOME/.config/fish/.env
