import os
import sys
import requests


def get_runners_metadata():
    """
    params: none.
    returns: a list of dicts which contains runners' basic metadata.
    """
    try:
        _TOKEN = os.environ['GITLAB_AUTH_TOKEN']
        headers = {"PRIVATE-TOKEN": _TOKEN}
        r = requests.get(f"https://gitlab.com/api/v4/runners", headers=headers)
        runners_metadata = r.json()

        return runners_metadata

    except (TypeError, NameError, KeyError) as e:
        print("\nGitlab token environment variable is not accessible in this shell\n"
              "You need to export GITLAB_AUTH_TOKEN=<token>\n", e)
    except requests.exceptions.RequestException as g:
        print("\nError in sending request to Gitlab API.\n"
              "Possible causes: multiple-redirects, auth, or a timeout\n", g)


def unregister_runner(metadata, dry_run=False):
    """
    Unregister a Gitlab project-scoped runner.
    returns: none.
    params: none.
    exit: 0 if metadata is empty.
    """
    try:
        _TOKEN = os.environ['GITLAB_AUTH_TOKEN']
        headers = {"PRIVATE-TOKEN": _TOKEN}

        # exit 0 if there are no runners in the Gitlab project
        if not metadata:
            print("No runners to work on, exiting.")
            sys.exit()

        for runner in metadata:
            if dry_run:
                print(f"[dry-run] delete runner => ID: {runner['id']}, desc: '{runner['description']}', "
                      f"active: {runner['active']}, status: {runner['status']}")
            else:
                r = requests.delete(f"https://gitlab.com/api/v4/runners/{runner['id']}", headers=headers)
                if not r.ok:
                    print("Encountered an error deleting runner:", r.json() )
                else:
                    print(f"deleted runner {runner['id']}")

    except (TypeError, NameError, KeyError) as e:
        print("\nGitlab token environment variable is not accessible in this shell\n", e)
    except requests.exceptions.RequestException as g:
        print("\nError in sending request to Gitlab API. Possible causes: mltiple-redircts, auth, timeouts\n", g)


if __name__ == '__main__':
    print('Starting...')
    metadata = get_runners_metadata()
    unregister_runner(metadata=metadata)
