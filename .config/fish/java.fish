if test -e /opt/homebrew/opt/openjdk/bin
  set -g fish_user_paths /opt/homebrew/opt/openjdk/bin $fish_user_paths
end

if test -e /opt/homebrew/opt/openjdk/include
  set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk/include"
end

# Java Home
if test -e /usr/libexec/java_home
  set -gx JAVA_HOME (/usr/libexec/java_home)
end

set llvm_root (brew --prefix openssl)

if test -e $llvm_root
  set -g fish_user_paths $llvm_root/bin $fish_user_paths
  set -gx LDFLAGS "-L$llvm_root/lib"
  set -gx CPPFLAGS "-I$llvm_root/include"
  set -gx CC $llvm_root/bin/clang
  set -gx CXX $llvm_root/bin/clang++
end
