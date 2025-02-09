from flask import Flask
from celery import Celery

app = Flask(__name__)

# Configure Celery to use RabbitMQ as the broker
app.config['CELERY_BROKER_URL'] = 'pyamqp://guest@localhost//'
app.config['CELERY_RESULT_BACKEND'] = 'rpc://'
app.config['DEBUG'] = True

# Create Celery instance
celery = Celery(app.name, broker=app.config['CELERY_BROKER_URL'])
celery.conf.update(app.config)

@app.route("/")
def hello():
    return "Hello"

# Create a background task with Celery
@celery.task
def long_task():
    import time
    time.sleep(20)  # Simulate a long-running task
    print ('test logging1')
    return "Task completed!"

# @celery.task
# def long_task2():
#     import time
#     time.sleep(10)  # Simulate a long-running task
#     print ('test logging2')
#     return "Task completed2!"

@app.route("/start-task")
def start_task():
    try:
        # Start the long task asynchronously
        task1 = long_task.apply_async()
        # task2 = long_task2.apply_async()
        print(f"Task started with ID: {task1.id}")
        # print(f"Task2 started with ID: {task2.id}")
        # return f"Tasks started successfully. Task IDs: {task1.id}, {task2.id}", 200
        return f"Tasks started successfully. Task IDs: {task1.id}"
    except Exception as e:
        return f"Error occurred while starting the task: {str(e)}"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
