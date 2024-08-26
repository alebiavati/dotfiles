if test -e /opt/homebrew/opt/openjdk/bin
  set -g fish_user_paths /opt/homebrew/opt/openjdk/bin $fish_user_paths
end

if test -e /opt/homebrew/opt/openjdk/include
  set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk/include"
end

# Java Home
if test -e /usr/libexec/java_home
  set -x JAVA_HOME (/usr/libexec/java_home)
end
