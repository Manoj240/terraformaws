from flask import Flask
#from celery import Celery

app = Flask(__name__)

# Configure Celery to use Redis as the broker
# app.config['CELERY_BROKER_URL'] = 'redis://localhost:6379/0'
# app.config['CELERY_RESULT_BACKEND'] = 'redis://localhost:6379/0'
# app.config['DEBUG'] = True


# # Create Celery instance
# celery = Celery(app.name, broker=app.config['CELERY_BROKER_URL'])
# celery.conf.update(app.config)

@app.route("/")
def hello():
    return "Hello"

# Create a background task with Celery
# @celery.task
# def long_task():
#     import time
#     time.sleep(10)  # Simulate a long-running task
#     return "Task completed!"

# @app.route("/start-task")
# def start_task():
#     try:
#         task = long_task.apply_async()
#         return f"Task started with ID: {task.id}"
#     except Exception as e:
#         return f"Error occurred while starting the task: {str(e)}"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
