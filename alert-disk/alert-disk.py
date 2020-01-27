import shutil
import requests


DIR_TO_CHECK = "E:\Paolo Basso"
DISK_PERCENTAGE = 50
HEALTH_CHECK_URL = "https://hc-ping.com/"
SERVER_NAME="My Awesome"
NOTIFICATION_API_KEY = ""
NOTIFICATION_SUBJECT = f"Your server \"{SERVER_NAME}\" is running out of space!"
NOTIFICATION_FROM_EMAIL = "alert-disk@exaple.com"


def run():
    total, used, free = shutil.disk_usage(DIR_TO_CHECK)

    used_percent = used*100 / total

    if (used_percent > DISK_PERCENTAGE):

        headers = {
            'user-agent': 'alert-disk',
            'Content-Type': 'application/json',
            'X-Api-Key': NOTIFICATION_API_KEY
        }

        payload = {
            "handlers": {
                "email",
                "telegram"
            },
            "emailFrom": NOTIFICATION_FROM_EMAIL,
            "subject": NOTIFICATION_SUBJECT,
            "message": f"The path \"{DIR_TO_CHECK}\" on your \"{SERVER_NAME}\" server has only {bytes_to_gigabytes(free)}GB free out of {bytes_to_gigabytes(total)}GB!"
        }

        res = requests.post(
            NOTIFICATIONS_URL,
            headers=headers,
            data=json.dumps(payload)
        )

def bytes_to_gigabytes(num_of_bytes):
    return int(num_of_bytes / (1024*1024*1024))

if __name__ == '__main__':
    run()
