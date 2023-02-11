#!/usr/bin/env python3
import sys
import requests
from argparse import ArgumentParser

# TODO: Catch exceptions properly! (TypeError, KeyError, HTTP requests ...etc.)


def get_runners_basic_metadata(_token):
    """
    Retrieves runners basic metadata. All the other methods depend on the return of this method.
    """
    try:
        headers = {"PRIVATE-TOKEN": _token}
        r = requests.get(f"https://gitlab.com/api/v4/runners", headers=headers)
        runners_basic_metadata = r.json()

        return runners_basic_metadata

    except Exception as e:
        print(e)


def get_runners_full_metadata(_token):
    """
    Retrieves runners full metadata.
    """
    runner_full_metadata = []
    id_list = []

    try:
        headers = {"PRIVATE-TOKEN": _token}
        # Get basic runners data first
        runners_basic_data = get_runners_basic_metadata(_token)
        # Assemble a list of runners IDs
        for runner in runners_basic_data:
            id_list.append(runner['id'])

        # Find each runner's detailed metadata
        for runner_id in id_list:
            r = requests.get(f"https://gitlab.com/api/v4/runners/{runner_id}", headers=headers)
            runner_full_metadata.append(r.json())

        return runner_full_metadata

    except Exception as e:
        print(e)


def delete_runners(runner_id, _token):
    """
    Unregisters Gitlab project-scoped runner.
    """
    try:
        headers = {"PRIVATE-TOKEN": _token}
        r = requests.delete(f"https://gitlab.com/api/v4/runners/{runner_id}", headers=headers)
        if not r.ok:
            print("[error] ==> Encountered an error deleting runner:", r.json())

    except Exception as e:
        print(e)


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('-t', '--token', required=True, help="Gitlab API token")
    parser.add_argument('-n', '--hostname', required=False, help="Host where a runner is deployed. "
                                                                 "This corresponds to Gitlab runner tags since they are"
                                                                 "named after hostnames. Can't be used with --all.")
    parser.add_argument('--all', required=False, action='store_true', help="Deletes all runners on Gitlab. "
                                                                           "Can't be used with [-n] --hostname.")
    parser.add_argument('--dry-run', required=False, help="No actions. Only preview what could happen.")
    args = parser.parse_args()

    # Housekeeping first:
    if args.all and args.hostname:
        parser.error("Can't use both --all and --hostname [-n] arguments")
    if not (args.hostname or args.all):
        parser.error("Must supply either --all to delete all runners, "
                     "or --hostname [-n] to delete specific host's runners")

    # Get runners metadata
    full_metadata = get_runners_full_metadata(_token=args.token)
    if not full_metadata:
        print("[info] ==> There are no runners on this host, exiting.")
        sys.exit()

    if args.hostname:
        # Mapping each runner id with the hostname, 1 to 1 mapping of id:runner_tag (i.e. runner_id:hostname)
        runners_mapping = {}
        for i in full_metadata:
            runner_id = i['id']
            runner_tag = i['tag_list'][0]
            runners_mapping[runner_id] = runner_tag

        # Dict schema is {id: hostname}, for example: {21064565: 'galaxy'}
        for r_id, host in runners_mapping.items():
            if args.hostname == host:
                delete_runners(runner_id=r_id, _token=args.token)
                print(f"[delete-runner] ==> success on: {host}")
            else:
                print(f"[skip-host] ==> not a target: [{host}]")

    # TODO: Add delete_all functionality
