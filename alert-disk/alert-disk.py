import shutil
import requests
import json


DIR_TO_CHECK = "/srv"
FREE_DISK_PERCENTAGE = 50
HEALTH_CHECK_URL = "https://hc-ping.com/"
SERVER_NAME = "My Awesome"
NOTIFICATIONS_URL = "https://notify.example.com"
NOTIFICATION_API_KEY = ""
NOTIFICATION_SUBJECT = f"Your server \"{SERVER_NAME}\" is running out of space!"
NOTIFICATION_FROM_EMAIL = "alert-disk@example.com"


def run():
    total, used, free = shutil.disk_usage(DIR_TO_CHECK)

    free_percent = free*100 / total

    if (free_percent < FREE_DISK_PERCENTAGE):

        headers = {
            'user-agent': 'alert-disk',
            'Content-Type': 'application/json',
            'X-Api-Key': NOTIFICATION_API_KEY
        }

        payload = {
            "handlers": [
                "email",
                "telegram"
            ],
            "emailFrom": NOTIFICATION_FROM_EMAIL,
            "subject": NOTIFICATION_SUBJECT,
            "message": f"The path \"{DIR_TO_CHECK}\" on your \"{SERVER_NAME}\" server has only {bytes_to_gigabytes(free)}GB free out of {bytes_to_gigabytes(total)}GB!"
        }

        res = requests.post(
            NOTIFICATIONS_URL,
            headers=headers,
            data=json.dumps(payload)
        )
        
        res_json = res.json()
        if(res_json["valid"] and res_json["oneSucceeded"]): 
            requests.get(HEALTH_CHECK_URL)
        else:
            requests.get(HEALTH_CHECK_URL + "/fail")
        


def bytes_to_gigabytes(num_of_bytes):
    return int(num_of_bytes / (1024*1024*1024))


if __name__ == '__main__':
    run()
