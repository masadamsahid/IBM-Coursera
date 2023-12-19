from datetime import timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago


# DAG default args
default_args = {
    'owner': 'Adam',
    'start_date': days_ago(0),
    'email': ['masadamsahid@gmail.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# defining DAG
dag = DAG(
    'ETL_Server_Access_Log_Processing',
    default_args=default_args,
    description='Create a DAG practice',
    schedule_interval=timedelta(days=1)
)

# define tasks
download = BashOperator( # download the log file
    task_id='download',
    bash_command='wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt',
    dag=dag
)

extract = BashOperator( # extract two fields (timestamp/col-1 and visitorid/col-4) from the downloaded log file
    task_id='extract',
    bash_command='cut -d"#" -f1,4 web-server-access-log.txt > /home/project/airflow/dags/extracted.txt',
    dag=dag,
)

transform = BashOperator( # capitalize the visitorid
    task_id='transform',
    bash_command='tr [a-z] [A-Z] < /home/project/airflow/dags/extracted.txt > /home/project/airflow/dags/capitalized.txt',
    dag=dag
)

load = BashOperator( # load by compresing transformed data in a zip file
    task_id='load',
    bash_command='zip log.zip capitalized.txt',
    dag=dag
)


# define task pipeline
download >> extract >> transform >> load


