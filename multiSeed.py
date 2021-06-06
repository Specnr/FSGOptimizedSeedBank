import os
import sys
import requests
import json
from multiprocessing import Process


def display_seed(verif_data, seed):
    print(f"Seed Found({verif_data['iso']}): {seed}")
    print(f"Temp Token: {verif_data}\n")


def run_seed(filter):
    seed = ""
    while seed == "":
        resp = requests.get(f"http://fsg.gel.webfactional.com?filter={filter}")
        res_json = resp.json()
        sseed = res_json.get("struct")
        sclass = res_json.get("class")
        randbiome = res_json.get("randbiome")
        pref = res_json.get("pref")  # village and/or shipwreck preference
        cmd = f'./bh {sseed} {sclass} {randbiome} {pref}'
        seed = os.popen(cmd).read().strip()
        if (seed == ""):
            print("Seed Timed Out\n")
    display_seed(res_json, seed)


def start_run():
    print("MultiSeed has started...\n")
    with open('settings.json') as filter_json:
        read_json = json.load(filter_json)
        filter = read_json["filter"]
        num_processes = read_json["thread_count"]
    processes = []
    for i in range(num_processes):
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
        if len(processes) < num_processes and sys.stdin.readline() == '\n':
            to_add = num_processes - len(processes)
            for j in range(to_add):
                processes.append(Process(target=run_seed, args=(filter,)))
                processes[-1].start()
        i = (i + 1) % num_processes


if __name__ == '__main__':
    start_run()
