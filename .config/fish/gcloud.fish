# python for gcloud
set -x CLOUDSDK_PYTHON /usr/local/bin/python3

# The next line updates PATH for the Google Cloud SDK.
if status --is-interactive
  set gcloud_inc_file /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
  if [ -f $gcloud_inc_file ]
    source $gcloud_inc_file
  end

  # The next line enables shell command completion for gcloud.
  set gcloud_completion_inc_file /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.fish.inc
  if [ -f $gcloud_completion_inc_file ]
    source $gcloud_completion_inc_file
  end
end
