import os
import sys
import requests
import json
from multiprocessing import Process


def display_seed(verif_data, seed):
    if (seed == ""):
        print("Seed Timed Out\n")
    else:
        print(f"Seed Found({verif_data['iso']}): {seed}")
        print(f"Temp Token: {verif_data}\n")


def run_seed(filter):
    resp = requests.get(f"http://fsg.gel.webfactional.com?filter={filter}")
    res_json = resp.json()
    sseed = res_json.get("struct")
    sclass = res_json.get("class")
    randbiome = res_json.get("randbiome")
    pref = res_json.get("pref")  # village and/or shipwreck preference
    cmd = f'./bh {sseed} {sclass} {randbiome} {pref}'
    seed = os.popen(cmd).read().strip()
    display_seed(res_json, seed)


def start_run(max_processes):
	print("MultiSeed has started...\n")
    with open('filter.json') as filter_json:
        filter = json.load(filter_json)["filter"]
    processes = []
    for i in range(max_processes):
        processes.append(Process(target=run_seed, args=(filter,)))
        processes[-1].start()
    i = 0
    while True:
        to_remove = []
        for j in range(len(processes)):
            if not processes[j].is_alive():
                to_remove.append(j)
        for j in range(len(to_remove)):
            processes.pop(to_remove[j] - j)
        if len(processes) < max_processes and sys.stdin.readline() == '\n':
            to_add = max_processes - len(processes)
            for j in range(to_add):
                processes.append(Process(target=run_seed, args=(filter,)))
                processes[-1].start()
        i = (i + 1) % max_processes


if __name__ == '__main__':
    PROCESSES_COUNT = int(sys.argv[1]) if len(sys.argv) >= 2 else 4
    start_run(PROCESSES_COUNT)
