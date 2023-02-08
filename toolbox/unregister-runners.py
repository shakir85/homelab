import os
import requests


def get_runners_ids():
    """
    Returns a list of all runners IDs regardless of the runners status
    """
    try:
        _TOKEN = os.environ['GITLAB_AUTH_TOKEN']
        headers = {"PRIVATE-TOKEN": _TOKEN}
        runners = []


        # Get all runners
        r = requests.get(f"https://gitlab.com/api/v4/runners", headers=headers)
        runners_data = r.json()
        for runner in runners_data:
            runners.append(runner['id'])

        # Pull each runner's metadata
        for runner_id in runners:
            r = requests.get(f"https://gitlab.com/api/v4/runners/{runner_id}", headers=headers)
            runner_metadata = r.json()

        return runner_metadata

    except (TypeError, NameError, KeyError) as e:
        print("\nGitlab token environment variable is not accessible in this shell\n", e)
    except requests.exceptions.RequestException as g:
        print("\nError in sending request to Gitlab API. Possible causes: mltiple-redircts, auth, timeouts\n", g)

def unregister_runner(metadata):
    """
    Unregister Gitlab project-scoped runner.
    """
    try:
        _TOKEN = os.environ['GITLAB_AUTH_TOKEN']
        headers = {"PRIVATE-TOKEN": _TOKEN}

        for runner_id in ids:
            r = requests.get(f"https://gitlab.com/api/v4/runners/{runner_id}", headers=headers)
            runner_data = r.json()

        print(runner_data)

        # r = requests.delete(f"https://gitlab.com/api/v4/runners/{runner_id}", headers=headers)
        # if not r.ok:
        #     print("Encountered an error deleting runner:", r.json() )


    except (TypeError, NameError, KeyError) as e:
        print("\nGitlab token environment variable is not accessible in this shell\n", e)
    except requests.exceptions.RequestException as g:
        print("\nError in sending request to Gitlab API. Possible causes: mltiple-redircts, auth, timeouts\n", g)

if __name__ == '__main__':
    print('starting...')
    runners = get_runners_ids()
    print(runners)

# runners metadata >> delete runners
