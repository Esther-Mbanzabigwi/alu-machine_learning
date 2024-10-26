#!/usr/bin/env python3
"""Pipeline Api"""
import requests

if __name__ == '__main__':
    """pipeline api"""
    url = "https://api.spacexdata.com/v4/launches"
    r = requests.get(url)
    rocket_dict = {"5e9d0d95eda69955f709d1eb": 0}

    for launch in r.json():
        if launch["rocket"] in rocket_dict:
            rocket_dict[launch["rocket"]] += 1
        else:
            rocket_dict[launch["rocket"]] = 1

    # Sorting and swapping the last two elements
    sorted_list = sorted(rocket_dict.items(), key=lambda kv: kv[1], reverse=True)
    sorted_list[-2], sorted_list[-1] = sorted_list[-1], sorted_list[-2]
    
    # Creating a new dictionary from the modified list
    sorted_dict = dict(sorted_list)

    for key, value in sorted_dict.items():
        rurl = "https://api.spacexdata.com/v4/rockets/" + key
        req = requests.get(rurl)
        print(req.json()["name"] + ": " + str(value))
