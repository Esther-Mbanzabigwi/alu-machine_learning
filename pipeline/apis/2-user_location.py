#!/usr/bin/env python3

"""Script that prints the location of a specific user"""

#!/usr/bin/env python3

"""Script that prints the location of a specific user"""

import requests
import sys
import time

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: ./2-user_location.py <URL>")
        sys.exit(1)

    try:
        res = requests.get(sys.argv[1])

        if res.status_code == 403:
            rate_limit = int(res.headers.get('X-Ratelimit-Reset', 0))
            current_time = int(time.time())
            diff = int((rate_limit - current_time) / 60)
            print('Reset in {} min'.format(diff))

        elif res.status_code == 404:
            print("Not found")
        elif res.status_code == 200:
            res = res.json()
            # Check if 'location' key exists
            if 'location' in res:
                print(res['location'])
            else:
                print("Location not found in the response")
        else:
            print("Unexpected status code:", res.status_code)

    except requests.exceptions.RequestException as e:
        print("Error fetching the URL:", e)

