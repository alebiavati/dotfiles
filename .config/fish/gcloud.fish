# python for gcloud
if test -e /opt/homebrew/bin/python3
  set -x CLOUDSDK_PYTHON /opt/homebrew/bin/python3
end

if test -e /usr/local/bin/python3
  set -x CLOUDSDK_PYTHON /usr/local/bin/python3
end

# Gcloud GKE plugin
set -x USE_GKE_GCLOUD_AUTH_PLUGIN True

# The next line updates PATH for the Google Cloud SDK.
if status --is-interactive
  set gcloud_inc_file_local /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
  if [ -f $gcloud_inc_file_local ]
    source $gcloud_inc_file_local
  end

  # The next line enables shell command completion for gcloud.
  set gcloud_completion_inc_file_local /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.fish.inc
  if [ -f $gcloud_completion_inc_file_local ]
    source $gcloud_completion_inc_file_local
  end

  set gcloud_inc_file /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
  if [ -f $gcloud_inc_file ]
    source $gcloud_inc_file
  end

  # The next line enables shell command completion for gcloud.
  set gcloud_completion_inc_file /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.fish.inc
  if [ -f $gcloud_completion_inc_file ]
    source $gcloud_completion_inc_file
  end
end
