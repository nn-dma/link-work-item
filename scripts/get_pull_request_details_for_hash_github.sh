#!/bin/bash
#set -e

display_help() {
    echo "Usage: $0 -c <commit_hash> -t <github_token> -r <repo>" >&2
    exit 1
}

commit_hash=''
github_token=''
repo=''

while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--commit_hash)
      commit_hash="$2"
      shift # past argument
      shift # past value
      ;;
    -t|--github_token)
      github_token="$2"
      shift # past argument
      shift # past value
      ;;
    -r|--repo)
      repo="$2"
      shift # past argument
      shift # past value
      ;;
    -h|--help)
      display_help
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

#self_dir=$(dirname "$(realpath "$0")")
#echo "self directory: $self_dir"

#python_file="get_pull_request_details_for_hash_github.py"
#python_script_path="$self_dir/$python_file"
#echo "python script path: $python_script_path"

if [ `gh pr list --state closed | grep -E " - IT Change #[0-9]+$"` ]; then
  echo "IT Change title is compliant"
else
  echo "Couldn't any closed PR with IT Change title."
  echo "It should look like this: 'Release 1.0.0 - IT Change #1234'"
  exit 1
fi

#gh pr list --state closed | grep Release | grep -E -o "[0-9]*\.[0-9]*\.[0-9]* " | head -1 | grep -E -o "[0-9]* +$"
#pr=$(python3 "$python_script_path" --commit $commit_hash --token $github_token --repo $repo)
#echo "$pr"